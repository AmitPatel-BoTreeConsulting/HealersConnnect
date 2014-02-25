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
    class_name.update_attributes(row)
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

