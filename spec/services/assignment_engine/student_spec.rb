require 'rails_helper'

describe AssignmentEngine::Student do

  let(:course1) { create(:course) }
  let(:course2) { create(:course) }
  let(:seminar1) { create(:seminar, :complete) }
  let(:seminar2) { create(:seminar, :complete) }
  let(:seminar3) { create(:seminar, :complete) }
  let(:seminar4) { create(:seminar, :complete) }
  let(:seminar5) { create(:seminar, :complete) }
  let(:seminar6) { create(:seminar, :complete) }
  let(:seminar7) { create(:seminar, :complete) }
  let(:student1) { create(:user) }
  let(:student2) { create(:user) }
  let(:student3) { create(:user) }
  let(:student4) { create(:user) }

  context "self#ordered_by_classes_taught" do

    before do
      # Need to be above request ratio
      create(:request, course: course2, teacher: student1)
      create(:request, course: course2, teacher: student2)
      create(:request, course: course2, teacher: student2)
      create(:request, course: course2, teacher: student3)

      # Need to be above assignment ratio
      create(:request, :assigned, seminar: seminar7, course: course2, teacher: student1)
      create(:request, :assigned, seminar: seminar7, course: course2, teacher: student2)
      create(:request, :assigned, seminar: seminar7, course: course2, teacher: student2)
      create(:request, :assigned, seminar: seminar7, course: course2, teacher: student3)
      create(:request, :assigned, seminar: seminar7, course: course2, teacher: student4)

      # Actual requests for test
      create(:request, course: course1, student: student1)
      create(:request, course: course1, student: student2)
      create(:request, course: course1, student: student3)
      create(:request, :assigned, course: course1, student: student4)
      create(:request, :assigned, seminar: seminar1, course: course1, student: student1)
      create(:request, :assigned, seminar: seminar2, course: course1, student: student1)
      create(:request, :assigned, seminar: seminar3, course: course1, student: student2)
      create(:request, :assigned, seminar: seminar4, course: course1, student: student2)
      create(:request, :assigned, seminar: seminar5, course: course1, student: student2)
      create(:request, :assigned, seminar: seminar6, course: course1, student: student3)
    end

    it "returns only unassigned students to this course" do
      expect(AssignmentEngine::Student.ordered_by_classes_taken(course1)).to_not include(student4)
    end

    it "orders by completed seminars" do
      expect(AssignmentEngine::Student.ordered_by_classes_taken(course1)).to eq([student3, student1, student2])
    end

  end

end