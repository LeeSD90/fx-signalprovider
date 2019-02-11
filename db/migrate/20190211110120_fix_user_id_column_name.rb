class FixUserIdColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :subscriptions, :plans_id, :plan_id
  end
end
