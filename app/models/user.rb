class User < ApplicationRecord
  has_secure_password(validations: false)
  has_many :messages, dependent: :destroy
  has_and_belongs_to_many :subscriptions,
    join_table: "chatroom_subscriptions",
    class_name: "Chatroom"

  has_many :acquaintanceships, foreign_key: "person_id", dependent: :destroy
  has_many :acquaintances, through: :acquaintanceships

  has_many :friendships, -> {where(friend: true)}, class_name: "Acquaintanceship", foreign_key: "person_id"
  has_many :friends, through: :friendships, source: "acquaintance"


  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, unless: :guest?
  validates :password, confirmation: true, unless: :guest?
  validates :password_confirmation, presence: true, unless: :guest?
  validates :role, presence: true, inclusion: { in: %w[guest user] }

  before_validation :ensure_role_set, on: [:create]
  before_validation :ensure_unique_name_for_guest

  def guest?
    self.role == 'guest'
  end

  def self.available_username(username)
    !User.exists?(username: username)
  end

  def add_acquaintance(user, friend=false)
    acq1 = self.acquaintanceships.new(acquaintance: user, friend: friend)
    acq2 = user.acquaintanceships.new(acquaintance: self)
    Acquaintanceship.transaction do
      acq1.save
      acq2.save
    end
    acq1
  end

  def add_or_get_acquaintance(user)
    acquaintanceship = self.acquaintanceships.find_by(acquaintance_id: user.id)
    acquaintanceship || self.add_acquaintance(user)
  end

  # def self.create_guest(username)
  #   guest_username = username;
  #   while (!self.available_username(guest_username)) do
  #     guest_username = username + (1_000_000 + Random.rand(9_999_999 - 1_000_000)).to_s
  #   end
  #   User.create(username: guest_username, role: 'guest')
  # end

  protected
    def ensure_role_set
      if self.role.blank?
        if self.password.present? || self.password_confirmation.present?
          self.role = 'user'
        else
          self.role = 'guest'
        end
      end
    end

    def ensure_unique_name_for_guest
      if self.guest?
        guest_username = self.username
        while (!User.available_username(guest_username)) do
          guest_username = username + (1_000_000 + Random.rand(9_999_999 - 1_000_000)).to_s
        end
        self.username = guest_username
      end
    end
end
