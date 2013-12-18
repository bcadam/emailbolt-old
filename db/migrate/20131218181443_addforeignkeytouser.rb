class Addforeignkeytouser < ActiveRecord::Migration
  def change
  	add_column :bolts, :user_id, :int
  end
end
