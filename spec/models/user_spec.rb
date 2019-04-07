require 'rails_helper'

describe User do
  subject {
    User.new first_name: 'Test', last_name: 'Test',
      email: 'test@test.test', phone: '0888888888'
  }

  it 'should have a valid full name' do
    subject.full_name.should eq "#{subject.first_name} #{subject.last_name}"
  end

  it 'is valid with all required attributes' do
    expect(subject).to be_valid
  end

  it 'is valid with a home phone' do
    subject.phone = '028008080'
    expect(subject).to be_valid
  end

  it 'is not valid without phone number' do
    subject.phone = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with a malformed phone number' do
    subject.phone = '123123123'
    expect(subject).to_not be_valid
  end

  it 'is not valid with a short phone number' do
    subject.phone = '088123'
    expect(subject).to_not be_valid
  end

  it 'is not valid with a business-paid phone number' do
    subject.phone = '0800808080'
    expect(subject).to_not be_valid
  end

  it 'is not valid with a client-paid phone number' do
    subject.phone = '0700808080'
    expect(subject).to_not be_valid
  end
end