class Addtobolts < ActiveRecord::Migration
  def change
    create_table :bolts do |t|
      t.string :address
      t.string :description

      t.timestamps
    end
  end
end
