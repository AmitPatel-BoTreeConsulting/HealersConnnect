class CreateWorkshopSessions < ActiveRecord::Migration
  def change
    create_table :workshop_sessions do |t|
      t.integer :workshop_id
      t.datetime :session_start
      t.datetime :session_end

      t.timestamps
    end
  end
end
