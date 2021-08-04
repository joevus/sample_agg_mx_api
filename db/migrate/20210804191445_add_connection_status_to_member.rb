class AddConnectionStatusToMember < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :connection_status, :string
  end
end
