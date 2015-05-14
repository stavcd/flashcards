class SorceryCore < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :email
      t.remove :password
      t.string :email, :null => false
      t.string :crypted_password
      t.string :salt

    end

    add_index :users, :email, unique: true
  end
end