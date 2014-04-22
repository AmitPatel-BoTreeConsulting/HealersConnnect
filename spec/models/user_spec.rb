require 'spec_helper'

describe User do
  it 'has a valid factory' do
    FactoryGirl.create(:user).should be_valid
  end

  # ========== Validations ==========
  it 'is invalid without an email' do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it 'is invalid if email does not have @' do
    FactoryGirl.build(:user, email: 'hardik.joshi.com').should_not be_valid
  end

  it 'is invalid without a password' do
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end

  it 'is invalid if password is not 8 characters long' do
    FactoryGirl.build(:user, password: 1234567).should_not be_valid
  end

  # ========== Methods ==========
  describe '#is_foundation_admin?' do
    it 'returns true for user with role foundation_admin' do
      user = FactoryGirl.create(:user_with_role,
        role_name: :foundation_admin)
      user.is_foundation_admin?.should be_true
    end
    it 'returns false for user not having role foundation_admin' do
      FactoryGirl.create(:user).is_foundation_admin?.should_not be_true
    end
  end

  describe '#is_super_admin?' do
    it 'returns true for user with role super_admin' do
      user = FactoryGirl.create(:user_with_role,
        role_name: :super_admin)
      user.is_super_admin?.should be_true
    end
    it 'returns false for user not having role super_admin' do
      FactoryGirl.create(:user).is_super_admin?.should_not be_true
    end
  end

  describe '#is_accountant?' do
    it 'returns true for user with role accountant' do
      user = FactoryGirl.create(:user_with_role,
        role_name: :accountant)
      user.is_accountant?.should be_true
    end
    it 'returns false for user not having role accountant' do
      FactoryGirl.create(:user).is_accountant?.should_not be_true
    end
  end

  describe '#is_center_admin?' do
    it 'returns true for user with role center_admin' do
      user = FactoryGirl.create(:user_with_role,
        role_name: :center_admin)
      user.is_center_admin?.should be_true
    end
    it 'returns false for user not having role center_admin' do
      FactoryGirl.create(:user).is_center_admin?.should_not be_true
    end
  end

  describe '#is_instructor?' do
    it 'returns true for user with role instructor' do
      user = FactoryGirl.create(:user_with_role,
        role_name: :instructor)
      user.is_instructor?.should be_true
    end
    it 'returns false for user not having role instructor' do
      FactoryGirl.create(:user).is_instructor?.should_not be_true
    end
  end
end
