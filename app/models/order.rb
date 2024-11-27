class Order < ApplicationRecord
  belongs_to :participation
  belongs_to :options
end
