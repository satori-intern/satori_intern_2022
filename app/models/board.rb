class Board < ApplicationRecord
    has_many :lists, dependent: :destroy
    has_many :users, through: :assignments
    has_many :assignments
    accepts_nested_attributes_for :assignments
end
