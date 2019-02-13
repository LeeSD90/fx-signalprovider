class AddNextBillingDateToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :next_billing_date, :date
  end
end
