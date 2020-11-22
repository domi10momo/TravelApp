class CreateWants < ActiveRecord::Migration[6.0]
  def change
    create_table :wants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
