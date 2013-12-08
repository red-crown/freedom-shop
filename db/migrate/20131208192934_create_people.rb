class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name, :salt, :encrypted_password
      t.timestamps
    end
  end
end
