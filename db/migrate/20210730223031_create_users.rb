class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|

      t.timestamps
      t.string :email
      t.string :guid
      t.string :mx_id
    end
  end
end
