class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :visitors, through: :messages, source: :user
  validates :name, presence: true
end
