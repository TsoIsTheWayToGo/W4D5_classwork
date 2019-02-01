require 'rails_helper'
require 'spec_helper'
RSpec.describe User, type: :model do
  subject(:user) do
    FactoryBot.create(:user, username: 'eric', password: 'password')
  end
  it 'creates a session token before validation' do
    user.valid?
    expect(user.session_token).to_not be_nil
  end  
  describe 'validations' do
    it {should validate_presence_of(:username)}
    it {should validate_uniqueness_of(:username)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_length_of(:password).is_at_least(6)}
  end
  
  describe 'password setter' do
    it 'encrypts the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password')
      User.new(username: 'louis', password: 'password')
    end
    User.destroy_all
  end

  # describe 'associations' do
  #   it { should }
  # end
  
  describe 'User::find_by_credentials' do
    eric = User.create(  username: 'eric', password: 'password')
    it 'finds the user by username' do
      user = User.find_by_credentials('eric', 'password')
      expect(user).to_not be_nil
    end

    it 'returns nil if user not found' do
      user = User.find_by_credentials( 'Carly', 'whatever')
      expect(user).to be_nil
    end

  end
  User.destroy_all

  
end
