class Notice < ApplicationRecord
  scope :current, -> { where("start_date <= ? AND end_date >= ?",DateTime.now,DateTime.now)}
end
