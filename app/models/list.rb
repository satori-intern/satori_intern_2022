class List < ApplicationRecord
    belongs_to :board
    has_many :items, dependent: :destroy

    validates :board_id, numericality: true
    validates :name, presence: true, allow_blank: true, length: { maximum: 255 }
end
