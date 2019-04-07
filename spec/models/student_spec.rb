require 'rails_helper'

describe Student do
  subject {
    Student.new first_name: 'Test1', middle_name: 'Test2', last_name: 'Test3',
                review: 'Test', is_approved: false, exams: [Exam.new(name: 'Exam', held_in: DateTime.now)],
                school: School.new
  }

  it 'should be valid with the default subject' do
    expect(subject).to be_valid
  end

  it 'should not be valid without a school' do
    subject.school = nil
    expect(subject).to_not be_valid
  end

  it 'should not be valid without any exams' do
    subject.exams = []
    expect(subject).to_not be_valid
  end

  it 'should not be valid without a name' do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it 'should have a valid full name' do
    subject.full_name.should eq "#{subject.first_name} #{subject.middle_name} #{subject.last_name}"
  end
end