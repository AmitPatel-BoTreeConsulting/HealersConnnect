FactoryGirl.define do
  factory :user do
    email     'hardik.joshi@beaverlogic.com'
    password  'Pleasechangeme1'
  end

  # To create a user with foundation_admin role use folowing
  # FactoryGirl.create(:user_with_role, role_name: :foundation_admin)
  factory :user_with_role, parent: :user do
    ignore do
      role_name :super_admin
    end
    roles {[FactoryGirl.create(role_name, :alias => role_name.to_s)]}
  end
end
