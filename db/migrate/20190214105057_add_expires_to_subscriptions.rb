class AddExpiresToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :expires, :date
  end
end
