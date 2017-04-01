require 'rails_helper'

describe AssignmentEngine::Seminar do

  let(:course) { create(:course) }
  let(:teacher) { create(:user) }

  context "#initialize" do

    before do
      @args = {
        course: course,
        teacher: teacher
      }
    end

    it "finds course" do
      @ae_seminar = AssignmentEngine::Seminar.new(@args)
      expect(@ae_seminar.course).to eq(course)
    end

  end

  context "#create" do

    it "" do
    end

  end

end