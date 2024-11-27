require "administrate/base_dashboard"

class DonationDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    payment: Field::BelongsTo,
    id: Field::Number,
    first_name: Field::String,
    last_name: Field::String,
    address: Field::String,
    postal_code: Field::String,
    amount: Field::Number.with_options(prefix: "€", decimals: 2),
    currency: Field::String,
    status: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    first_name
    last_name
    amount
    status
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    payment
    first_name
    last_name
    address
    postal_code
    amount
    currency
    status
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    payment
    first_name
    last_name
    address
    postal_code
    amount
    currency
    status
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
