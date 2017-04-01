require 'rails_helper'

describe AssignmentEngine::Teacher do

  let(:course) { create(:course) }
  let(:seminar1) { create(:seminar, :completed) }
  let(:seminar2) { create(:seminar, :completed) }
  let(:seminar3) { create(:seminar, :completed) }
  let(:seminar4) { create(:seminar, :completed) }
  let(:seminar5) { create(:seminar, :completed) }
  let(:seminar6) { create(:seminar, :completed) }
  let(:teacher1) { create(:user) }
  let(:teacher2) { create(:user) }
  let(:teacher3) { create(:user) }
  let(:teacher4) { create(:user) }

  context "self#ordered_by_classes_taught" do

    before do
      create(:request, course: course, teacher: teacher1)
      create(:request, course: course, teacher: teacher2)
      create(:request, course: course, teacher: teacher3)
      create(:request, :assigned, course: course, teacher: teacher4)
      create(:request, :assigned, seminar: seminar1, course: course, teacher: teacher1)
      create(:request, :assigned, seminar: seminar2, course: course, teacher: teacher1)
      create(:request, :assigned, seminar: seminar3, course: course, teacher: teacher2)
      create(:request, :assigned, seminar: seminar4, course: course, teacher: teacher2)
      create(:request, :assigned, seminar: seminar5, course: course, teacher: teacher2)
      create(:request, :assigned, seminar: seminar6, course: course, teacher: teacher3)
    end

    it "returns only unassigned teachers to this course" do
      expect(AssignmentEngine::Teacher.ordered_by_classes_taught(course)).to_not include(teacher4)
    end

    it "orders by completed seminars" do
      expect(AssignmentEngine::Teacher.ordered_by_classes_taught(course)).to eq([teacher3, teacher1, teacher2])
    end

  end

end