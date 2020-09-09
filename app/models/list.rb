class List < ApplicationRecord
    belongs_to :board
    has_many :items, dependent: :destroy

    validates :board_id, numericality: true
end
