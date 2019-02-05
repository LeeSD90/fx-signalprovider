class RemoveSubscribedFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :subscribed, :boolean
  end
end
