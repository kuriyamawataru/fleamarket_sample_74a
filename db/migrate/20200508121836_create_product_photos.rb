class CreateProductPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :product_photos do |t|
      t.string :photo, null: false
      t.integer :product_id,foreign_key: true, null: false
      t.timestamps
    end
  end
end
