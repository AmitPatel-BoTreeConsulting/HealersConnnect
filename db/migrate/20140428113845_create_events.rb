class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :event_category_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
