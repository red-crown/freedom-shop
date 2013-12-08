class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :name
      t.string :filename
      t.string :extension
      t.string :type
      t.text :comment

      t.timestamps
    end
  end
end
