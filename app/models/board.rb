class Board < ApplicationRecord
    has_many :lists, dependent: :destroy
    has_many :assignments, dependent: :destroy
    accepts_nested_attributes_for :assignments
    has_many :users, through: :assignments
end
