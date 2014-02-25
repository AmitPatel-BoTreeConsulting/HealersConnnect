class AddAncestryToFoundations < ActiveRecord::Migration
  def change
    add_column :foundations, :ancestry, :string
  end

  def up
    add_index :foundations, :ancestry
  end

  def down
    remove_index :foundations, :ancestry
  end
end
