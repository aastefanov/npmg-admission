require 'rails_helper'

describe School do
  before :each do
    create :school
  end
  it 'should have a region' do
    school = School.first

    school.region.should eq Region.first
  end

  it 'should have a region id' do
    school = School.first

    school.region_id.should eq Region.first.id
  end
end