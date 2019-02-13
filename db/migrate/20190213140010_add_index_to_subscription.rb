class AddIndexToSubscription < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :paypal_recurring_profile_token, :string unless column_exists? :subscriptions, :paypal_recurring_profile_token
    add_index :subscriptions, :paypal_recurring_profile_token, unique: true
  end
end
