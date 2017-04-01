require 'rails_helper'

describe AssignmentEngine::Student do

  let(:course) { create(:course) }
  let(:seminar1) { create(:seminar, :complete) }
  let(:seminar2) { create(:seminar, :complete) }
  let(:seminar3) { create(:seminar, :complete) }
  let(:seminar4) { create(:seminar, :complete) }
  let(:seminar5) { create(:seminar, :complete) }
  let(:seminar6) { create(:seminar, :complete) }
  let(:student1) { create(:user) }
  let(:student2) { create(:user) }
  let(:student3) { create(:user) }
  let(:student4) { create(:user) }

  context "self#ordered_by_classes_taught" do

    before do
      create(:request, course: course, student: student1)
      create(:request, course: course, student: student2)
      create(:request, course: course, student: student3)
      create(:request, :assigned, course: course, student: student4)
      create(:request, :assigned, seminar: seminar1, course: course, student: student1)
      create(:request, :assigned, seminar: seminar2, course: course, student: student1)
      create(:request, :assigned, seminar: seminar3, course: course, student: student2)
      create(:request, :assigned, seminar: seminar4, course: course, student: student2)
      create(:request, :assigned, seminar: seminar5, course: course, student: student2)
      create(:request, :assigned, seminar: seminar6, course: course, student: student3)
    end

    it "returns only unassigned students to this course" do
      expect(AssignmentEngine::Student.ordered_by_classes_taken(course)).to_not include(student4)
    end

    it "orders by completed seminars" do
      expect(AssignmentEngine::Student.ordered_by_classes_taken(course)).to eq([student3, student1, student2])
    end

  end

end