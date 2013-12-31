class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.string :image
      t.boolean :publised

      t.timestamps
    end
  end
end
