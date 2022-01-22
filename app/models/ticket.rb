class Ticket < ApplicationRecord
    belongs_to :sales
    belongs_to :product
    alias_attribute :_id, :product_id
end
