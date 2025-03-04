class Item < ApplicationRecord
    belongs_to :list
    
    validates :name, presence: true, allow_blank: true, length: { maximum: 255 }
    validates :detail, presence: true, allow_blank: true, length: { maximum: 512 }
end
