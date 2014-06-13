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
          { name: 'Foundation Admin', alias: Role::FOUNDATION_ADMIN },
          { name: 'Registrar', alias: Role::REGISTRAR_ADMIN} ]

puts '------------Seeding Roles------------'
roles.each { |role| create_or_update_by_alias(Role, role)}
puts '-------------------------------------'

# CourseCategory
healing_protection_alias = 'healing_protection'
prosperity_abundance_alias = 'prosperity_abundance'
spirituality_alias = 'spirituality'

course_categories = [
  { name: 'Healing & Protection', alias: healing_protection_alias },
  { name: 'Prosperity & Abundance', alias: prosperity_abundance_alias },
  { name: 'Spirituality', alias: spirituality_alias }
]

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
instructor = find_or_create_user({ email: 'instructor@healersconnect.com', password: Settings.default_password })
healer = find_or_create_user({ email: 'healer@healersconnect.com', password: Settings.default_password })
registrar = find_or_create_user({email: 'registrar@healersconnect.com', password: Settings.default_password})
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
instructor_role = Role.instructor
registrar_role = Role.registrar

user_role_for_super_admin = find_or_create_user_role(admin_user, application_admin_role)
user_role_for_accountant = find_or_create_user_role(accountant, account_role)
user_role_for_foundation_admin = find_or_create_user_role(foundation_admin, foundation_admin_role)
user_role_for_center_admin = find_or_create_user_role(center_admin, center_admin_role)
user_role_for_instructor_role = find_or_create_user_role(instructor, instructor_role)
user_role_for_registrar = find_or_create_user_role(registrar, registrar_role)
# =========================Create cources=========================

# Find course categories:
healing_protection_id = CourseCategory.find_by_alias(healing_protection_alias).id
prosperity_abundance_id = CourseCategory.find_by_alias(prosperity_abundance_alias).id
spirituality_id = CourseCategory.find_by_alias(spirituality_alias).id

cources_arr = [
{ name: 'Basic Pranic Healing', alias: 'BPH',
  eligibility: '16+', course_category_id: healing_protection_id },
{ name: 'Advanced Pranic Healing', alias: 'APH',
  eligibility: 'BPH', course_category_id: healing_protection_id },
{ name: 'Pranic Psychotherapy', alias: 'PPT',
  eligibility: 'APH', course_category_id: healing_protection_id },
{ name: 'Pranic Crystal Healing', alias: 'PCH',
  eligibility: 'PPT', course_category_id: healing_protection_id },
{ name: 'Psychic Self-Defense', alias: 'PSD',
  eligibility: 'PPT', course_category_id: healing_protection_id },
{ name: 'Super Brain Yoga', alias: 'SBY',
  eligibility: 'BPH', course_category_id: healing_protection_id },
{ name: 'Pranic Facial Rejuvenation', alias: 'PFR',
  eligibility: 'PPT,PCH', course_category_id: healing_protection_id },
{ name: 'Pranic Face Lift and Pranic Body Sculpting', alias: 'PFL_PBS',
  eligibility: 'PPT,PCH', course_category_id: healing_protection_id  },

{ name: 'Achieving Oneness with the Higher Soul', alias: 'AOHS',
  eligibility: '16+', course_category_id: spirituality_id },
{ name: 'Arhatic Yoga', alias: 'AYP',
  eligibility: 'PPT,AOHS', course_category_id: spirituality_id },
{ name: 'Spiritual Essence of Man', alias: 'SEOM',
  eligibility: 'BPH', course_category_id: spirituality_id },
{ name: 'Spiritual Business Management', alias: 'SBM',
  eligibility: 'BPH', course_category_id: spirituality_id },
{ name: 'Universal and Kabbalistic Meditation on Lord’s Prayer', alias: 'UKMLP',
  eligibility: 'BPH', course_category_id: spirituality_id },
{ name: 'Inner Teachings of Buddhism Revealed', alias: 'ITBR',
  eligibility: 'BPH', course_category_id: spirituality_id },
{ name: 'Inner Teachings of Christianity Revealed', alias: 'ITCR',
  eligibility: 'BPH', course_category_id: spirituality_id },
{ name: 'Inner Teachings of Hinduism Revealed', alias: 'ITHR',
  eligibility: 'BPH', course_category_id: spirituality_id },
{ name: 'Om Mani Pad Me Hum', alias: 'OMPH',
  eligibility: 'BPH', course_category_id: spirituality_id },

{ name: 'Kriyashakti', alias: 'KS',
  eligibility: 'AYP', course_category_id: prosperity_abundance_id },
{ name: 'Pranic Feng Shui', alias: 'PFS',
  eligibility: 'PPT', course_category_id: prosperity_abundance_id }
]

puts '------------Seeding Courses------------'
cources_arr.each{ |cource_map|
  create_or_update_by_alias(Course, cource_map)
}
puts '---------------------------------------'

# Event Category
activity = 'activity'
special_mediation = 'special_mediation'
nurturing_session = 'nurturing_session'
event_categories = [
    { name: 'Activity', alias: activity },
    { name: 'Special Mediation', alias: special_mediation },
    { name: 'Nurturing Session', alias: nurturing_session }
]

puts '--------Seeding EventCategory-------'
event_categories.each { |event_category| create_or_update_by_alias(EventCategory, event_category)}
puts '-------------------------------------'
