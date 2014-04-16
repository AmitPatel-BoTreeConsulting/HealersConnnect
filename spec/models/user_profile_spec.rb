require 'spec_helper'

describe UserProfile do
  it 'has a valid factory' do
    FactoryGirl.create(:user_profile).should be_valid
  end

  # ========== Validations ==========
  it 'is invalid without an address' do
    FactoryGirl.build(:user_profile, address: nil).should_not be_valid
  end

  it 'is invalid without a birth_date' do
    FactoryGirl.build(:user_profile, birth_date: nil).should_not be_valid
  end

  it 'is invalid without an education' do
    FactoryGirl.build(:user_profile, education: nil).should_not be_valid
  end

  it 'is invalid without an occupation' do
    FactoryGirl.build(:user_profile, occupation: nil).should_not be_valid
  end

  it 'is invalid without a first_name' do
    FactoryGirl.build(:user_profile, first_name: nil).should_not be_valid
  end

  it 'is invalid without a middle_name' do
    FactoryGirl.build(:user_profile, middle_name: nil).should_not be_valid
  end

  it 'is invalid without a last_name' do
    FactoryGirl.build(:user_profile, last_name: nil).should_not be_valid
  end

  it 'is invalid without a email' do
    FactoryGirl.build(:user_profile, email: nil).should_not be_valid
  end

  # ========== Methods ==========
  it 'returns a full name as a string' do
    FactoryGirl.create(:user_profile, first_name: 'John', middle_name: 'Foo', last_name: 'Doe').name.should == "John Foo Doe"
  end
end
