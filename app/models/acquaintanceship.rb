class Acquaintanceship < ApplicationRecord
  belongs_to :person, class_name: "User", foreign_key: "person_id"
  belongs_to :acquaintance, class_name: "User", foreign_key: "acquaintance_id"
  belongs_to :chatroom, dependent: :destroy

  validates :person, :acquaintance, :chatroom, presence: true

  after_initialize :set_defaults
  before_validation :ensure_chatroom_set, on: [:create]
  after_validation :set_chatroom_params


  private
    def ensure_chatroom_set
      existing_acquaintanceship = self.acquaintance.acquaintanceships.find_by(
        acquaintance_id: self.person.id
      )
      self.chatroom = existing_acquaintanceship.try(:chatroom) || Chatroom.new(room_type: 'private', one_to_one: true)
    end

    def set_chatroom_params
      self.chatroom.name ||= "#{person.username}_#{acquaintance.username}"
      self.chatroom.description ||= "One to one chatroom between #{person.username} and #{acquaintance.username}"
    end

    def set_defaults
      self.friend = self.friend.nil? ? false : self.friend;
    end
end
