require 'rails_helper'

describe School do
  before :each do
    create :school
  end
  it 'should have a region' do
    school = School.first

    expect(school.region).to eq Region.first
  end

  it 'should have a region id' do
    school = School.first

    expect(school.region_id).to eq Region.first.id
  end
end