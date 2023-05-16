class Event < ApplicationRecord
  validate :start_date_valid?

  def start_date_valid?
    if start_date.blank? || start_date < Time.current
      errors.add(:start_date, "must be present and after or equal to the current date")
    end
  end

  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0, divisible_by: 5 }
  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
  validates :location, presence: true

  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'
  has_many :attendances
  has_many :attendants, through: :attendances, source: :user

  before_save :calculate_end_date

  def calculate_end_date
    self.end_date = start_date + duration.minutes
  end
end
