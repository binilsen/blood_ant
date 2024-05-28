# frozen_string_literal: true

class Dose < ApplicationRecord
  enum status: { inactive: 0, active: 1 }
  belongs_to :user
  has_many :logs, dependent: :nullify

  before_save :validate_active_doses
  after_save :enable_default_dose

  private

  def validate_active_doses
    user.doses.active.update(status: 'inactive') if active? && id.present?
  end

  def enable_default_dose
    user.doses.last.active! if user.active_dose.blank?
  end
end
