class CatRentalRequest < ApplicationRecord
  validates :status, inclusion: {
    in: %w[APPROVED DENIED],
    message: 'You can only switch between APPROVED or DENIED.'
  }
  validate :does_not_overlap_approved_request

  belongs_to :cat,
    foreign_key: :cat_id,
    class_name: :Cat

  def approve!
    self.transaction do
      self.status = "APPROVED"
      self.save!

      overlapping_requests.each do |request|
        deny! if request.pending?
      end
    end
  end

  def pending?
    self.status == "PENDING"
  end

  private

  def deny!
    self.status = "DENIED"
    self.save!
  end

  def does_not_overlap_approved_request
    if overlapping_approved_requests.exists?
      errors[:overlap] << "this rental request overlaps with previous requests!"
    end
  end

  def overlapping_requests
    # get all the CatRentalRequests that overlap with the one we are trying to validate.
    cats_start_date = self.start_date
    cats_end_date = self.end_date
    current_cat_id = self.cat_id

    CatRentalRequest
      .where.not(id: self.id)
      .where(cat_id: current_cat_id)
      .where.not("? > end_date OR ? < start_date", cats_start_date, cats_end_date)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end
end
