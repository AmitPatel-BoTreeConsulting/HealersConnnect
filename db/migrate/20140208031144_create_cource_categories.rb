class CreateCourceCategories < ActiveRecord::Migration
  def change
    create_table :cource_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
