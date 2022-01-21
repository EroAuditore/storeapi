class Ticket < ApplicationRecord
    belongs_to :sales
    belongs_to :product
end
