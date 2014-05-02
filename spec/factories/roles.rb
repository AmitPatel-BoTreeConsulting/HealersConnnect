FactoryGirl.define do
  factory :foundation_admin, class: 'Role' do
    name 'Foundation Admin'
  end

  factory :super_admin, class: 'Role' do
    name 'Super Admin'
  end

  factory :center_admin, class: 'Role' do
    name 'Center Admin'
  end

  factory :instructor, class: 'Role' do
    name 'Instructor'
  end

  factory :healer, class: 'Role' do
    name 'Healer'
  end

  factory :accountant, class: 'Role' do
    name 'Accountant'
  end
end
