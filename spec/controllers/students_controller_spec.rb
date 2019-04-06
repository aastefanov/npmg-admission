# require 'rails_helper'
#
# describe StudentsController do
#   describe 'Logged out' do
#     it 'redirects to sign in page if not authenticated' do
#       get :index
#       expect(response).to redirect_to new_user_session_path
#     end
#   end
#
#   describe 'logged in' do
#     before do
#       user = User.new
#       allow(controller).to receive(:authenticate_user!).and_return(true)
#       allow(controller).to receive(:current_user).and_return(user)
#     end
#
#     it 'renders a page when authenticated' do
#
#       get :index
#       expect(response).to render_template(:index)
#     end
#
#     it 'should pass with all values set' do
#       sign_in User.new
#
#       file = fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-image.png'))
#       params = {student: {first_name: 'Test', middle_name: 'Test', last_name: 'test',
#                           declaration: file,
#                           exam_ids: [Exam.new(id: 1, name: 'Exam', held_in: DateTime.now).id],
#                           school_id: School.new.id}}
#
#       post :create, :params => params
#
#       assigns(:params).errors.wont_be_empty
#       expect(response).to render_template(:index)
#     end
#
#
#     it 'should fail with no exams' do
#       sign_in User.new
#       params = {student: {first_name: 'Test', middle_name: 'Test', last_name: 'test',
#                           exam_ids: [],
#                           school_id: School.new.id}}
#       post :create, :params => params
#
#       expect(response).to render_template(:new)
#     end
#   end
# end