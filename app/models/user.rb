class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :assignment, dependent: :destroy
  has_many :boards, through: :assignment

  before_destroy :must_destroy_last_one_user

  private
  def must_destroy_last_one_user
    current_user.boards.each do |board|
      if board.users.count == 1
        boards.destroy
      end
    end
  end
end
