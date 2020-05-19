require 'json'
require 'net/http'

namespace :nclc do
  #noinspection RubyInstanceMethodNamingConvention
  MonSchool =
      Class.new do
        attr_accessor :schoolid, :schName, :schType, :ekatte, :obl

        def []=(name, value)
          instance_variable_set("@#{name}", value)
        end
      end

  def get_schools
    api_url = URI('https://reg.mon.bg/Schools/Backend')

    response = Net::HTTP.post_form(api_url, 'action' => 'searchSchool')

    JSON.parse(response.body, object_class: MonSchool)
  end

  desc "Import schools from MoES API"
  task :import_regions => :environment do
    get_schools.map.uniq(&:obl).map { |s| Region.find_or_create_by(:name => s.obl) }
  end

  task :import_cities => :environment do
    regions = Region.select(%w(id name))
    get_schools.map.uniq { |s| "#{s.ekatte}-#{s.obl}" }.each { |s| City.find_or_create_by(:name => s.ekatte, :region_id => regions.detect { |r| s.obl == r.name }.id) }
  end

  task :import_schools => :environment do
    regions = Region.select(%w(id name))
    cities = City.select(%w(id name region_id))


    get_schools.each { |s| School.find_or_create_by(
        :admin_id => s.schoolid,
        :name => s.schName,
        :city => cities.detect { |c| s.ekatte == c.name && c.region_id == regions.detect { |r| s.obl == r.name }.id },
    ) }
  end
end
