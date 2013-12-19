class AddRouteIdToBolt < ActiveRecord::Migration
  def change
    add_column :bolts, :routeid, :string
  end
end
