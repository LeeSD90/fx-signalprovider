class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one :subscription, :dependent => :destroy

  def subscribed?
    !self.subscription.nil?
  end

  def after_database_authentication
    self.subscription.check_expiry if self.subscribed?
  end

end
