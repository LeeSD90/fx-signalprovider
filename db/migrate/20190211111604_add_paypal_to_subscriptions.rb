class AddPaypalToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :paypal_customer_token, :string
    add_column :subscriptions, :paypal_recurring_profile_token, :string
  end
end
