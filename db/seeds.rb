def find_or_create_instance(class_name, instance_name)
  instance  = class_name.where(name: instance_name)
  if instance.blank?
    instance = class_name.create(name: instance_name)
    puts "#{instance_name} #{class_name} added."
  else
    puts "#{instance_name} #{class_name} exists, hence not added it."
  end
  instance
end

def create_or_update_by_alias(class_name, row)
  instance  = class_name.find_by_alias(row[:alias])
  if instance.blank?
    class_name.create!(row)
    puts "#{row[:name]}  added."
  else
    instance.update_attributes(row)
    puts "#{row[:name]} updated."
  end
  instance
end


# Roles
roles = [ { name: 'Super Admin', alias: Role::SUPER_ADMIN },
          { name: 'Center Admin', alias: Role::CENTER_ADMIN },
          { name: 'Instructor', alias: Role::INSTRUCTOR },
          { name: 'Healer', alias: Role::HEALER },
          { name: 'Accountant', alias: Role::ACCOUNTANT },
          { name: 'Foundation Admin', alias: Role::FOUNDATION_ADMIN } ]

puts '------------Seeding Roles------------'
roles.each { |role| create_or_update_by_alias(Role, role)}
puts '-------------------------------------'

# CourseCategory
course_categories = [ { name: 'Healing & Protection', alias: 'healing_protection' },
                      { name: 'Prosperity & Abundance', alias: 'prosperity_abundance' },
                      { name: 'Spirituality', alias: 'spirituality' } ]

puts '--------Seeding CourseCategory-------'
course_categories.each { |category| create_or_update_by_alias(CourseCategory, category)}
puts '-------------------------------------'

#================================================Create Default Users===================================================

def find_or_create_user(user_attrs)
  email = user_attrs[:email]
  user = User.find_by_email(email)

  if user.nil?
    user = User.create(user_attrs)
    puts "Created user having email #{email}"
  else
    puts "User having email #{email} already exists, thus not created"
  end
  user
end

admin_user = find_or_create_user({ email: 'admin@healersconnect.com', password: Settings.default_password })
accountant = find_or_create_user({ email: 'accountant@healersconnect.com', password: Settings.default_password })
foundation_admin = find_or_create_user({ email: 'foundation@healersconnect.com', password: Settings.default_password })
center_admin = find_or_create_user({ email: 'center@healersconnect.com', password: Settings.default_password })
puts '-------------------------------------'

#==================================================Create Foundations===================================================
foundations = [
    {name: 'Institute of Inner Studies Inc', alias: 'IISI'},
    {name: 'WPH Foundation Inc, Philippines', alias: 'WPHFP', ancestry: 'IISI'},
    {name: 'WPH Foundation India', alias: 'WPHFI', ancestry: 'WPHFP'},
    {name: 'YVPHF of Maharashtra', alias: 'YVPHFH', ancestry: 'WPHFI'}
]

def find_or_create_foundation(foundation_attrs)
  alias1 = foundation_attrs[:alias]
  foundation_attrs.delete(:ancestry)
  foundation = Foundation.find_by_alias(alias1)
  parent = Foundation.find_by_alias(foundation_attrs[:ancestry])
  foundation_attrs[:parent] = parent
  if foundation.nil?
    foundation = Foundation.create(foundation_attrs)
    puts "Created foundation having alias #{alias1}"
  else
    foundation.update_attributes(foundation_attrs)
    puts "Updating foundation having alias #{alias1}"
  end
  foundation
end

foundations.each { |foundation| find_or_create_foundation(foundation)}
puts '-------------------------------------'

#==================================================Create PaymentTypes===================================================
payment_types = [
    { name: 'Cash', alias: 'cash' }, { name: 'Cheque', alias: 'cheque' }, { name: 'DD', alias: 'dd' },
    { name: 'Net Banking', alias: 'net_banking' }
]

def find_or_create_payment_type(payment_type_attrs)
  alias1 = payment_type_attrs[:alias]
  payment_type = PaymentType.find_by_alias(alias1)
  if payment_type.nil?
    payment_type = PaymentType.create(payment_type_attrs)
    puts "Created payment_type having alias #{alias1}"
  else
    payment_type.update_attributes(payment_type_attrs)
    puts "Updating payment_type having alias #{alias1}"
  end
  payment_type
end

payment_types.each { |payment_type| find_or_create_payment_type(payment_type)}

def find_or_create_user_role(user, role)
  unless user.roles.present?
    UserRole.create(role_id: role.id, user_id: user.id)
    puts "Created user roles for #{user.email}"
  else
    puts "User roles for #{user.email} already exists, thus not created"
  end
end

# Set role for Super Admin, Accountant, Foundation Admin, Center Admin
application_admin_role = Role.super_admin
account_role = Role.accountant
foundation_admin_role = Role.foundation_admin
center_admin_role = Role.center_admin

user_role_for_super_admin = find_or_create_user_role(admin_user, application_admin_role)
user_role_for_accountant = find_or_create_user_role(accountant, account_role)
user_role_for_foundation_admin = find_or_create_user_role(foundation_admin, foundation_admin_role)
user_role_for_center_admin = find_or_create_user_role(center_admin, center_admin_role)
