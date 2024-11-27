require "administrate/base_dashboard"

class PaymentDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    payable: Field::Polymorphic,
    id: Field::Number,
    payment_reference: Field::String,
    amount: Field::Number.with_options(prefix: "€", decimals: 2),
    currency: Field::String,
    status: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    payment_reference
    amount
    status
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    payable
    payment_reference
    amount
    currency
    status
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    payable
    payment_reference
    amount
    currency
    status
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
