class CreateImpressions < ActiveRecord::Migration[6.0]
  def change
    create_table :impressions do |t|
      t.references :my_schedule, null: false, foreign_key: true
      t.references :spot, null: false, foreign_key: true
      t.string :text, null: false
      t.string :image

      t.timestamps
    end
  end
end
