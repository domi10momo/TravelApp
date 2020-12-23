class RemovecolumnsFromMyTravelCourses < ActiveRecord::Migration[6.0]
  def change
    remove_column :my_travel_courses, :impression, :string
    remove_column :my_travel_courses, :gone, :boolean
    remove_column :my_travel_courses, :image, :string
  end
end
