require 'rails_helper'

describe AssignmentEngine::Seminar do

  let(:course) { create(:course) }

  context "#initialize" do

    it "finds course" do
      @ae_seminar = AssignmentEngine::Seminar.new(course.id)
      expect(@ae_seminar.course).to eq(course)
    end

  end

  context "#create" do

    it "" do
    end

  end

end