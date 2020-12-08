class CreateMySchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :my_schedules do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.boolean :gone, default: false

      t.timestamps
    end
  end
end
