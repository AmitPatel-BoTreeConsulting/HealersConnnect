require 'spec_helper'

describe User do
  it 'has a valid factory' do
    FactoryGirl.create(:user).should be_valid
  end

  it { should respond_to(:member_id) }

  # ========== Validations ==========
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should allow_value('abc@example.com' ).for(:email) }
  it { should_not allow_value('abc', 'abc@.').for(:email) }
  it { should allow_value('12345678' ).for(:password) }
  it { should_not allow_value('1234567').for(:password) }
end
