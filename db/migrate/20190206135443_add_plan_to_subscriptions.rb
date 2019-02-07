class AddPlanToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_reference :subscriptions, :plans, foreign_key: true
  end
end
