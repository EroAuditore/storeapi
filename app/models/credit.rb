class Credit < ApplicationRecord
    has_many :sales
    belongs_to :client
    scope :client_credit, ->(id) { where('client_id = ?', id) }
end
