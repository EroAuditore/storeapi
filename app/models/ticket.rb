class Ticket < ApplicationRecord
    belongs_to :sale
    belongs_to :product
    alias_attribute :_id, :product_id
end
