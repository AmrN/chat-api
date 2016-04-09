class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :visitors, through: :messages, source: :user
  has_many :acquaintanceships
  has_and_belongs_to_many :subscribers,
    join_table: "chatroom_subscriptions",
    class_name: "User"
  # has_one :acquaintanceship

  validates :name, :room_type, presence: true
  validates :one_to_one, inclusion: { in: [true, false] }
  validates :room_type, inclusion: { in: %w[ public private ] }
  validate  :ensure_valid_room_type

  after_initialize :set_defaults

  private
    def ensure_valid_room_type
      if self.one_to_one? && self.room_type != 'private'
        self.errors.add :room_type, "one to one chatrooms must be private"
      end
    end

    def set_defaults
      self.room_type ||= 'public'
      self.one_to_one = self.one_to_one.nil? ? false : self.one_to_one
    end
end
