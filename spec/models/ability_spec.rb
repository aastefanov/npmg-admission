require 'rails_helper'

describe Ability do
  describe 'admin' do
    subject(:ability) {Ability.new user}
    let(:user) {create :admin}

    it 'should be able to delete users' do
      is_expected.to be_able_to :destroy, User.new
    end

  end
  describe 'normal user' do
    subject(:ability) {Ability.new user}
    let(:user) {create :user}

    it 'should not be able to delete users' do
      is_expected.to_not be_able_to :destroy, User.new
    end

    it 'should be able to add own students' do
      is_expected.to be_able_to :create, Student.new(:user_id => user.id)
    end

    it 'should not be able to add other students' do
      is_expected.to_not be_able_to :create, Student.new
    end

    it 'should not be able to manage exams' do
      is_expected.to_not be_able_to :manage, Exam.new
    end

    it 'should not be able to manage regions, cities, schools' do
      is_expected.to_not be_able_to :manage, Region.new
      is_expected.to_not be_able_to :manage, City.new
      is_expected.to_not be_able_to :manage, School.new
    end

    it 'should be able to read exams, regions, cities, schools' do
      is_expected.to be_able_to :read, Exam.new
      is_expected.to be_able_to :read, Region.new
      is_expected.to be_able_to :read, City.new
      is_expected.to be_able_to :read, School.new
    end
  end
end