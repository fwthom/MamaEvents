class Payment < ApplicationRecord
  belongs_to :payable, polymorphic: true, optional: true
end
