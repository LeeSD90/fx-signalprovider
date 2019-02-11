class Plan < ApplicationRecord
  has_many :subscriptions, :dependent => :destroy
  
  NON_VALIDATABLE_ATTRS = ["id", "created_at", "updated_at"]
  VALIDATABLE_ATTRS = Plan.attribute_names.reject{|attr| NON_VALIDATABLE_ATTRS.include?(attr)}

  validates_presence_of VALIDATABLE_ATTRS

  def name_with_price
    "#{name} - " + currency_symbol + "#{price}"
  end

  def currency_symbol
    case currency
    when "EUR"
      "€"
    when "GBP"
      "£"
    when "USD"
      "$"
    else "Undefined Currency"
    end
  end
end
