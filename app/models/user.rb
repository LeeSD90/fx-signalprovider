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
    if self.subscribed?
      self.subscription.expire if Date.today > self.subscription.expires
    end
  end

end
