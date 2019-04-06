require 'rails_helper'

describe Api::RegionsController do
  before :each do
    # regions = [Region.new(name: "Test1", cities: [
    #     City.new(name: "Test1City1", schools: [School.new(name: "Test1City1School1")])
    # ])]
    #
    create(:school)

    # cities = [City.new(name: "Test1City1", region: regions[0])]
    #
    # schools = [School.new(name: "Test1City1School1", city: cities[0])]

    # regions.each(&:save)
    # cities.each {|c| City.create c }
    # schools.each {|s| School.create s }
  end

  it 'returns all regions' do
    get :index
    result = JSON.parse(response.body)
    result_casted = result.map {|r| Region.new r}

    expect(result_casted.length).to eq 1
    expect(result_casted[0].name).to eq Region.order(:name).first.name
  end

  it 'returns all cities in a region' do
    region = Region.first
    get :cities_in_region, :params => {:id => City.where(region_id: region.id).order(:name).first.id}
    result = JSON.parse(response.body)
    result_casted = result.map {|r| City.new r}

    expect(result_casted.length).to eq 1
    expect(result_casted[0].name).to eq City.where(region_id: region.id).order(:name).first.name
  end

  it 'returns all schools in a city' do
    city = City.first
    get :schools_in_city, :params => {:id => School.where(city_id: city.id).order(:name).first.id}
    result = JSON.parse(response.body)
    result_casted = result.map {|r| School.new r}

    expect(result_casted.length).to eq 1
    expect(result_casted[0].name).to eq School.where(city_id: city.id).order(:name).first.name
  end

  it 'returns a region by id' do
    region = Region.first
    get :show, :params => {:id => region.id}

    result = JSON.parse(response.body)
    result_casted = Region.new result
    expect(result_casted.name).to eq region.name
  end
  it 'returns a city by id' do
    city = City.first
    get :city, :params => {:id => city.id}

    result = JSON.parse(response.body)
    result_casted = City.new result
    expect(result_casted.name).to eq City.name
  end
  it 'returns a school by id' do
    school = School.first
    get :school, :params => {:id => school.id}

    result = JSON.parse(response.body)
    result_casted = School.new result
    expect(result_casted.name).to eq school.name
  end
end