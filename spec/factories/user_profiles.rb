FactoryGirl.define do
  factory :user_profile do
    address      'Gandhinagar'
    birth_date   '1/1/1991'
    mobile       '9898989898'
    education    'B.Sc'
    occupation   'C.E'
    first_name   'John'
    middle_name  'Foo'
    last_name    'Doe'
    email        'hardik.joshi@beaverlogic.com'
    married      false
    telephone    '079-23232323'
    gender       'M'
  end
end
