# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_schedule do
    event_id 1
    center_id 1
    lat 1.5
    long 1.5
    start_date "2014-04-29 16:26:08"
    end_date "2014-04-29 16:26:08"
    contact "MyString"
    donation 1
    notes "MyText"
  end
end
