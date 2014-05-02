require 'spec_helper'

describe Registration do
  it { should respond_to(:fresher) }
  it { should respond_to(:cheque_no) }
  it { should respond_to(:bank_name) }
  it { should respond_to(:cheque_date) }
  it { should respond_to(:payment_type_id) }
  it { should respond_to(:registration_date) }
  it { should respond_to(:active) }
  it { should respond_to(:user_id) }
  it { should respond_to(:workshop_id) }
  it { should respond_to(:past_workshops) }
  it { should respond_to(:certified) }
  it { should respond_to(:certificate_number) }

  it { should allow_mass_assignment_of(:payment_type_id) }
  it { should allow_mass_assignment_of(:fresher) }
  it { should allow_mass_assignment_of(:cheque_no) }
  it { should allow_mass_assignment_of(:workshop_id) }
  it { should allow_mass_assignment_of(:bank_name) }
  it { should allow_mass_assignment_of(:cheque_date) }
  it { should allow_mass_assignment_of(:registration_date) }
  it { should allow_mass_assignment_of(:past_workshops) }

  it { should belong_to(:payment_type) }
  it { should belong_to(:user) }
  it { should belong_to(:workshop) }
  it { should have_one(:user_profile) }

  it { should accept_nested_attributes_for(:user_profile) }
  it { should serialize(:past_workshops).as(Hash) }

  it { should allow_value('06/13 136', '12/13 12547').for(:certificate_number) }
  it { should_not allow_value('12/13 12avc', '2/13 1234', '2 13 1234').for(:certificate_number) }
end
