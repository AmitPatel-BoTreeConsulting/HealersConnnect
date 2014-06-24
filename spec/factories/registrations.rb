FactoryGirl.define do
  factory :registration do
    fresher true
    active  true

    user_profile
  end
end
