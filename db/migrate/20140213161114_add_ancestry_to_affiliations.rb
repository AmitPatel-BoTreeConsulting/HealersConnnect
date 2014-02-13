class AddAncestryToAffiliations < ActiveRecord::Migration
  def change
    add_column :affiliations, :ancestry, :string
  end

  def up
    add_index :affiliations, :ancestry
  end

  def down
    remove_index :affiliations, :ancestry
  end
end
