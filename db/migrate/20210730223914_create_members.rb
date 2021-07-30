class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.belongs_to :user
      t.string :mx_id
      t.string :institution_code
      t.string :name
      t.timestamps
    end
  end
end
