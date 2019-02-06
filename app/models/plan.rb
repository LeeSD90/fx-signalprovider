class Plan < ApplicationRecord
  NON_VALIDATABLE_ATTRS = ["id", "created_at", "updated_at"]
  VALIDATABLE_ATTRS = Plan.attribute_names.reject{|attr| NON_VALIDATABLE_ATTRS.include?(attr)}

  validates_presence_of VALIDATABLE_ATTRS
end
