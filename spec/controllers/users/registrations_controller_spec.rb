require 'rails_helper'

describe Users::RegistrationsController do
  it 'should sanitize sign up params' do
    @request.env["devise.mapping"] = Devise.mappings[:user]

    post :create, :params => {first_name: 'Test', last_name: 'Test', phone: '0888888888'}

    expect(response).to be_successful
  end

  it 'should be valid with the sign up params' do
    @request.env["devise.mapping"] = Devise.mappings[:user]

    post :create, :params => {first_name: 'Test', last_name: 'Test', phone: '0888888888',
                              password: 'test', password_confirmation: 'test'}
    expect(response).to be_successful
  end
end