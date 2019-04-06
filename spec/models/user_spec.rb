require 'rails_helper'

describe User do
  subject {
    User.new first_name: 'Test', last_name: 'Test',
      email: 'test@test.test', phone: '0888888888'
  }

  it 'is valid with all required attributes' do
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
end