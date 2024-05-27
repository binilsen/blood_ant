# frozen_string_literal: true

class Log < ApplicationRecord
  include Evaluatable
  belongs_to :user
  belongs_to :dose, optional: true

  enum session: { immediate: 0, fasting: 1, morning: 2, afternoon: 3, evening: 4, night: 5,
                  early: 6 }
  enum tag: { default: 0, bookmark: 1 }
  enum result: { normal: 0, low: 1, high: 2 }

  validate :log_entry, unless: :immediate?

  scope :active, -> { where(created_at: Time.zone.today.all_day) }

  before_create :enable_log_dose

  private

  def enable_log_dose
    return if user.active_dose.blank?

    self.dose_id = user.active_dose.id
  end

  def log_entry
    errors.add(:base, 'Log exist!') if user.logs.active.where(session:).present?
  end
end
