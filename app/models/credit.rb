class Credit < ApplicationRecord
    has_many :sales
    has_many :tickets, through: :sales
    belongs_to :client
    scope :client_credit, ->(id) { where('client_id = ?', id) }
    scope :client_credit_unpaid, ->(id) { where('client_id = ? and paid = false', id) }
end
