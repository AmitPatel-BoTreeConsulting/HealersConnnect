# Read about factories at https://github.com/thoughtbot/factory_girl
include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :event do
    event_category_id 1
    name 'Test-name Introduction to Pranic Healing'
    description 'Test-description Inflammatio denego necessitatibus caelestis autus illum.'
    avatar { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'), 'image/png') }
  end
end
