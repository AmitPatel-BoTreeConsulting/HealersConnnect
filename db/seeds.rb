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
roles = [ {name: 'Super Admin', alias: Role::SUPER_ADMIN},
          {name: 'Center Admin', alias: Role::CENTER_ADMIN},
          {name: 'Teacher', alias: Role::TEACHER},
          {name: 'Healer', alias: Role::HEALER} ]

puts '------------Seeding Roles------------'
roles.each { |role| create_or_update_by_alias(Role, role)}
puts '-------------------------------------'

# CourseCategory
course_categories = [ {name: 'Healing & Protection', alias: 'healing_protection'},
                      {name: 'Prosperity & Abundance', alias: 'prosperity_abundance'},
                      {name: 'Spirituality', alias: 'spirituality'} ]

puts '--------Seeding CourseCategory-------'
course_categories.each { |category| create_or_update_by_alias(CourseCategory, category)}
puts '-------------------------------------'

#================================================Create Default Users===================================================

def admin_user_attrs
  {
      email: 'admin@healersconnect.com',
      password: Settings.default_password,
  }
end

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

admin_user = find_or_create_user(admin_user_attrs)
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