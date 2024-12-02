class Order < ApplicationRecord
  belongs_to :participation
  belongs_to :option
end
