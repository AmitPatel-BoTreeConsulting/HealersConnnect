require 'spec_helper'

describe Event do
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:event_category_id) }
  it { should respond_to(:avatar_file_name) }
  it { should respond_to(:avatar_content_type) }
  it { should respond_to(:avatar_file_size) }
  it { should respond_to(:avatar_updated_at) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:event_category_id) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:event_category) }

end
