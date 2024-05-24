# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  generates_token_for :email_verification, expires_in: 2.days do
    email
  end
  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  enum category: { one: 0, two: 1 }
  enum gender: { male: 0, female: 1, other: 2 }

  has_many :sessions, dependent: :destroy
  has_many :logs, dependent: :destroy
  has_many :doses, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :password, allow_nil: true, length: { minimum: 8 }

  normalizes :email, with: -> { _1.strip.downcase }

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  after_create :create_initial_dose

  def active_dose
    doses.active.first
  end

  private

  def create_initial_dose
    doses.create!(status: 'active')
  end
end
