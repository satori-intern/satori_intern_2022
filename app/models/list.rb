class List < ApplicationRecord
    validates :board_id, numericality: true
end
