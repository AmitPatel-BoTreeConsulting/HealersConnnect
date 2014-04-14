# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140411103355) do

  create_table "centers", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.float    "lat"
    t.float    "long"
    t.string   "address"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "mobile"
    t.string   "email"
    t.integer  "foundation_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "centers", ["foundation_id"], :name => "index_centers_on_foundation_id"

  create_table "course_categories", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "course_instructors", :force => true do |t|
    t.integer  "instructor_id"
    t.integer  "course_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "course_instructors", ["course_id"], :name => "index_course_instructors_on_course_id"
  add_index "course_instructors", ["instructor_id", "course_id"], :name => "index_course_instructors_on_instructor_id_and_course_id", :unique => true
  add_index "course_instructors", ["instructor_id"], :name => "index_course_instructors_on_instructor_id"

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.string   "eligibility"
    t.text     "description"
    t.integer  "course_category_id"
    t.integer  "donation"
    t.integer  "review_donation"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "status",              :default => true
  end

  add_index "courses", ["course_category_id"], :name => "index_courses_on_course_category_id"

  create_table "foundations", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "ancestry"
  end

  create_table "instructors", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "mobile"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payment_types", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "registrations", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.date     "birth_date"
    t.string   "gender"
    t.boolean  "married"
    t.string   "education"
    t.string   "occupation"
    t.text     "address"
    t.string   "mobile"
    t.string   "telephone"
    t.string   "email"
    t.string   "location"
    t.float    "lat"
    t.float    "long"
    t.string   "workshop_place"
    t.string   "workshop_dated"
    t.string   "workshop_instructor"
    t.boolean  "fresher",             :default => true
    t.string   "cheque_no"
    t.string   "bank_name"
    t.date     "cheque_date"
    t.integer  "payment_type_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.date     "registration_date"
    t.boolean  "active",              :default => true
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.integer  "center_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_roles", ["center_id"], :name => "index_user_roles_on_center_id"
  add_index "user_roles", ["role_id", "user_id", "center_id"], :name => "index_user_roles_on_role_id_and_user_id_and_center_id", :unique => true
  add_index "user_roles", ["role_id"], :name => "index_user_roles_on_role_id"
  add_index "user_roles", ["user_id"], :name => "index_user_roles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
