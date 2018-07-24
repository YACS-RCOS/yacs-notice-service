class Notice < ApplicationRecord
  validates :alert_type, :message, :start_date, :end_date, presence: true
  validates :alert_type, inclusion: { in: %w(success info warning danger),
    message: "%{value} is not a valid notice alert type" }
  validate :start_and_end_dates_validation

  def start_and_end_dates_validation
    if self.start_date >= self.end_date
      errors.add(:start_date, "must be before end date")
    end
  end

  scope :current, -> { where("start_date <= ? AND end_date >= ?", DateTime.now, DateTime.now)}
end
