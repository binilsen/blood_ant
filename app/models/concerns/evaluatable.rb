# frozen_string_literal: true

module Evaluatable
  extend ActiveSupport::Concern

  included do
    before_create :calculate
  end

  def calculate
    self.result = 'normal' if value < 110 && fasting?
    self.result = 'normal' if value > 100 && value < 180
    self.result = 'low' if value < 100 && !fasting?
    self.result = 'high' if value > 180
  end
end
