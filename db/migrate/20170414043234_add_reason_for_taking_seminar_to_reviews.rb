class AddReasonForTakingSeminarToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :reason_for_taking_seminar, :string
  end
end
