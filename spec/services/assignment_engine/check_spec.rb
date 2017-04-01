require 'rails_helper'

describe AssignmentEngine::Check do

  let(:course) { create(:course) }

  context "#initialize" do

    before do
      @ae_check = AssignmentEngine::Check.new(course.id)
    end

    it "finds course" do
      expect(@ae_check.course).to eq(course)
    end

  end
  
  context "#seminar_creation" do
  end

  context "#can_schedule?" do
  end

  context "#enough_teachers?" do
  end

  context "#enough_students?" do
  end

end