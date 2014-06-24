class AddCertificateNumberAndCertifiedToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :certificate_number, :string
    add_column :registrations, :certified, :boolean
  end
end
