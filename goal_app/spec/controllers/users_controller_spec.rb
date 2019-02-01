require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
    it 'renders the new user template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      
      it 'logs in user' do
        post :create, params: { user: FactoryBot.attributes_for(:user) }
        expect(session[:session_token]).to eq(User.last.session_token)
      end

      it 'puts a new user in the database' do
        last_user = User.last
        post :create, params: { user: FactoryBot.attributes_for(:user) }
        expect(User.last).to_not eq(last_user)
      end


      
    end

    context 'with invalid credentials' do
      it 'doesnt create and new user' do
        last_user = User.last
        post :create, params: {username: 'eric', password: '1'} 
        expect(User.last).to eq(last_user)
      end
    end
  end

  it 'validates the presence of the user\'s username and password' do
    post :create, params: { user: { username: 'jack_bruce', password: '' } }
    expect(response).to render_template('new')
    expect(flash[:errors]).to be_present
  end

  it 'validates that the password is at least 6 characters long' do
    post :create, params: { user: { username: 'jack_bruce', password: 'short' } }
    expect(response).to render_template('new')
    expect(flash[:errors]).to be_present
  end


  describe "GET #edit" do
    it 'renders the user edit form' do
      patch :edit
      expect(response).to render_template(:edit) 
    end
  end


end
