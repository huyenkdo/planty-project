class Renting < ApplicationRecord
  belongs_to :plant
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_cannot_be_in_the_past
  validate :end_date_cannot_be_before_start_date
  validates :status, presence: true, inclusion: { in: ['Demande en attente', 'Demande acceptée', 'Demande refusée'] }

  def start_date_cannot_be_in_the_past
    errors.add(:start_date, "ne peut pas être dans le passé") if
      !start_date.blank? && start_date < Date.today
  end

  def end_date_cannot_be_before_start_date
    errors.add(:end_date, "ne peut pas être avant la date de début de location") if
      end_date < start_date
  end
end
