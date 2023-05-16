class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :user

  after_create :attendance_send

  def attendance_send
    UserMail.attendance_email(event.admin).deliver_now
  end
end
