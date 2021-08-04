class AddAggregatedAtToMember < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :aggregated_at, :string
  end
end
