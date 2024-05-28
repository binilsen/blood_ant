# frozen_string_literal: true

class User < ApplicationRecord
  include Rodauth::Rails.model
  include Identifiable

  enum :status, unverified: 1, verified: 2, closed: 3
  enum category: { one: 0, two: 1 }
  enum gender: { male: 0, female: 1, other: 2 }

  has_many :logs, dependent: :destroy
  has_many :doses, dependent: :destroy

  validates :name, presence: true
  after_create :create_initial_dose

  def active_dose
    doses.active.first
  end

  private

  def create_initial_dose; end
end
