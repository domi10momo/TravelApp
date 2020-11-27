class CreateMySchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :my_schedules do |t|
      t.references :user, null: false, foreign_key: true
      t.time :date
      t.boolean :gone

      t.timestamps
    end
  end
end
