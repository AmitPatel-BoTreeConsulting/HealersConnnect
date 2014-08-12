class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :content
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
