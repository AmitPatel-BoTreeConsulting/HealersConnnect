def find_or_create_instance class_name, instance_name
  instance  = class_name.where(name: instance_name)
  if instance.blank?
    instance = class_name.create(name: instance_name)
    puts "#{instance_name} #{class_name} added."
  else
    puts "#{instance_name} #{class_name} exists, hence not added it."
  end
  instance
end

# ============== Seed Roles
roles = [ Role::SUPER_ADMIN_ROLE_TYPE, Role::CENTER_ADMIN_ROLE_TYPE, Role::TEACHER_ROLE_TYPE,
         Role::HEALER_ROLE_TYPE ]

roles.each { |role_name| find_or_create_instance Role, role_name }

# ============== Seed CourceCategory
cource_categories = [ 'Healing & Protection', 'Prosperity & Abundance', 'Spirituality' ]

cource_categories.each { |category_name| find_or_create_instance CourceCategory, category_name }
