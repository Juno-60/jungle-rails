require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Checks for Validity of the user' do
    it 'confirms that a user with all required fields set will save succesfully' do
      @user = User.create(
        name: "George", 
        email: "george@george.com", 
        password: "beefcake", 
        password_confirmation: "beefcake"
      )
      expect(@user).to be_valid
    end
    it 'returns an error for a user with an invalid name field' do
      @user = User.create(
        name: nil, 
        email: "george@george.com", 
        password: "beefcake", 
        password_confirmation: "beefcake"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end
    it 'has a matching password and confirmation field' do
      @user = User.create(
        name: "George", 
        email: "george@george.com", 
        password: "beefcake", 
        password_confirmation: "beefcake"
      )
      expect(@user).to be_valid
      expect(@user.password).to eql(@user.password_confirmation)
    end
    it 'returns an error if password and confirmation field do not match' do
      @user = User.create(
        name: "George", 
        email: "george@george.com", 
        password: "beefcake", 
        password_confirmation: "beefcake1"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'requires a unique email address and returns an error if already exists in db' do
      @user1 = User.create(
        name: "George", 
        email: "GeOrge@george.com", 
        password: "beefcake", 
        password_confirmation: "beefcake"
      )
      @user2 = User.create(
        name: "George", 
        email: "george@george.com", 
        password: "beefcake", 
        password_confirmation: "beefcake"
      )
      expect(@user2).to be_invalid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    it 'requires a minimum password length of 6 characters and throws an error otherwise' do
      @user = User.create(
        name: "George", 
        email: "george@george.com", 
        password: "beef", 
        password_confirmation: "beef"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'returns an instance of the user if succesfully authenticated' do
      @user = User.create(
        name: "George", 
        email: "george@george.com", 
        password: "beefer1", 
        password_confirmation: "beefer1"
      )
      expect(User.authenticate_with_credentials("george@george.com", "beefer1")).to be_eql(@user)
    end
    it 'returns nil if the user is unsucessful in their authentication' do
      @user = User.create(
        name: "George", 
        email: "george@george.com", 
        password: "beefer1", 
        password_confirmation: "beefer1"
      )
      expect(User.authenticate_with_credentials(@user.email, "horsemeat")).to be(nil)
    end
    it 'returns a valid user instance even if the user types their email in the wrong case' do
      @user = User.create(
        name: "George", 
        email: "george@george.com", 
        password: "beefer1", 
        password_confirmation: "beefer1"
      )
      expect(User.authenticate_with_credentials("GeoRge@GEORGe.coM", "beefer1")).to be_eql(@user)
    end
    it 'returns a valid user even if there are spaces before and after the email address' do
      @user = User.create(
        name: "George", 
        email: "george@george.com", 
        password: "beefer1", 
        password_confirmation: "beefer1"
      )
      expect(User.authenticate_with_credentials("   george@george.com ", "beefer1")).to be_eql(@user)
    end
  end
end
