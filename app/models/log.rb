# frozen_string_literal: true

class Log < ApplicationRecord
  include Evaluatable
  belongs_to :user

  enum session: { immediate: 0, fasting: 1, morning: 2, afternoon: 3, evening: 4, night: 5,
                  early: 6 }
  enum tag: { default: 0, bookmark: 1 }
  enum result: { normal: 0, low: 1, high: 2 }

  scope :active, -> { where(created_at: Time.zone.today.all_day) }
end
