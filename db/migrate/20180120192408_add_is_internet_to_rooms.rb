class AddIsInternetToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :is_internet, :boolean
  end
end
