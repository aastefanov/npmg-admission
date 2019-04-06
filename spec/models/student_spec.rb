require 'rails_helper'

describe Student do
  subject {
    Student.new first_name: 'Test', middle_name: 'Test', last_name: 'test',
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
end