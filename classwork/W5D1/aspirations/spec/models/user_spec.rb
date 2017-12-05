require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:valid_user) { FactoryBot.build(:user) }
  
  describe "attribute validations" do
    it { should validate_presence_of :username}
    it { should validate_presence_of :password_digest}
    it { should validate_presence_of :session_token}    
  end
  
  describe "password validation" do
    it {should validate_length_of(:password).is_at_least(6)}
  end

  describe "#ensure_session_token" do
    it "has a session token" do
      expect(valid_user.session_token).to be_present 
    end
  end
  
  describe "#reset_session_token!" do
    it "resets the users session token" do
      old_token = valid_user.session_token
      new_token = valid_user.reset_session_token!
      expect(old_token).to_not eq(new_token)
    end
  end
  
  describe "#password=" do
    it "sets a password_digest" do
      expect(valid_user.password_digest).to be_present
    end
  end
  
  describe "#is_password?" do
    let(:user_with_valid_password) { FactoryBot.build(:user_with_valid_password) }
    
    it "returns true when given the user's correct password" do
      expect(user_with_valid_password.is_password?('valid_password')).to be_truthy
    end
    
    it "returns false when given the incorrect password" do
      expect(user_with_valid_password.is_password?('invalid_password')).to be_falsy
    end
  end
  
  describe "associations" do
    it { should have_many :goals}
  end
  
  context "class methods" do
    let(:user_with_valid_password) { FactoryBot.create(:user_with_valid_password) }

    describe "::find_by_credentials" do
      it "should return the user if valid password" do
        user_with_valid_password
        expect(User.find_by_credentials('jerry', 'valid_password')).to eq(user_with_valid_password)
      end
      it "should return nil if username doesn't exist" do
        user_with_valid_password
        expect(User.find_by_credentials('joey', 'valid_password')).to be_nil
      end
      it "should return nil if correct username but invalid password" do 
        user_with_valid_password
        expect(User.find_by_credentials('jerry', 'invalid_password')).to be_nil
      end
    end
  end
  
  
end
