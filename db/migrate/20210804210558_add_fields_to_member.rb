class AddFieldsToMember < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :successfully_aggregated_at, :string
    add_column :members, :is_being_aggregated, :boolean
  end
end
