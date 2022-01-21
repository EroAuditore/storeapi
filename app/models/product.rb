class Product < ApplicationRecord
    belongs_to :sales
    belongs_to :tickets
end
