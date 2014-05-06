require 'spec_helper'

describe Workshop do
  it { should respond_to(:assistant_instructor_id) }
  it { should respond_to(:center_id) }
  it { should respond_to(:course_id) }
  it { should respond_to(:instructor_id) }
  it { should respond_to(:end_date) }
  it { should respond_to(:start_date) }
  it { should respond_to(:fees_after_session) }
  it { should respond_to(:fees_before_session) }
  it { should respond_to(:fees_on_session) }
  it { should respond_to(:fees_on_rejoining) }
  it { should respond_to(:fees_date) }
  it { should respond_to(:location) }
  it { should respond_to(:lat) }
  it { should respond_to(:long) }
  it { should respond_to(:contact) }

  it { should allow_mass_assignment_of(:assistant_instructor_id) }
  it { should allow_mass_assignment_of(:center_id) }
  it { should allow_mass_assignment_of(:course_id) }
  it { should allow_mass_assignment_of(:instructor_id) }
  it { should allow_mass_assignment_of(:end_date) }
  it { should allow_mass_assignment_of(:start_date) }
  it { should allow_mass_assignment_of(:fees_after_session) }
  it { should allow_mass_assignment_of(:fees_before_session) }
  it { should allow_mass_assignment_of(:fees_on_session) }
  it { should allow_mass_assignment_of(:fees_on_rejoining) }
  it { should allow_mass_assignment_of(:fees_date) }
  it { should allow_mass_assignment_of(:location) }
  it { should allow_mass_assignment_of(:lat) }
  it { should allow_mass_assignment_of(:long) }
  it { should allow_mass_assignment_of(:contact) }

  it { should belong_to(:course) }
  it { should belong_to(:instructor) }
  it { should belong_to(:assistant_instructor).class_name('Instructor') }
  it { should belong_to(:center) }
  it { should have_many(:registrations) }
  it { should have_many(:workshop_sessions).dependent(:destroy) }

  it { should accept_nested_attributes_for(:workshop_sessions).allow_destroy(true) }

  it { should validate_presence_of(:center_id) }
  it { should validate_presence_of(:course_id) }
  it { should validate_presence_of(:instructor_id) }
  it { should validate_presence_of(:fees_date) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:contact) }
  it { should validate_presence_of(:fees_before_session) }
  it { should validate_presence_of(:fees_after_session) }
  it { should validate_presence_of(:fees_on_session) }
  it { should validate_presence_of(:fees_on_rejoining) }
end
