require 'rails_helper'

describe StudentsController do
  describe 'logged out' do
    it 'redirects to sign in page if not authenticated' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'logged in' do
    before :each do
      create :school
      user = create :user
      create :exam

      allow(controller).to receive(:authenticate_user!).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
      sign_in user
    end

    it 'renders a page when authenticated' do
      get :index
      expect(response).to render_template :index
    end

    it 'should pass with all values set' do
      file = fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-image.png'))
      params = {student: {first_name: 'Test', middle_name: 'Test', last_name: 'test',
                          declaration: file,
                          exams: [Exam.first.id],
                          school: School.first.id}}

      post :create, :params => params

      expect(response).to redirect_to :action => :index
    end

    it 'should fail with no exams' do
      params = {student: {first_name: 'Test', middle_name: 'Test', last_name: 'test',
                          exams: [],
                          school: School.first.id}}
      post :create, :params => params

      expect(response).to render_template(:new)
    end
  end
end