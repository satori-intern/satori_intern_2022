class List < ApplicationRecord
    belongs_to :board
    has_many :items, dependent: :destroy
end
