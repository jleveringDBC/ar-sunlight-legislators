require_relative '../config'

# this is where you should use an ActiveRecord migration to 

class CreatePoliticians < ActiveRecord::Migration
  def change
    # HINT: checkout ActiveRecord::Migration.create_table
    # first_name,last_name,gender,birthday,email,phone
    create_table :politicians do |t|
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :gender
      t.date   :birthdate
      t.string :website
      t.string :twitter
      t.string :webform
      t.string :phone
      t.string :fax
      t.string :state
      t.string :party
      t.boolean :active
      t.boolean :senator
      t.boolean :rep
      #automatically makes created_at, updated_at
      t.timestamps
    end
  end
end
