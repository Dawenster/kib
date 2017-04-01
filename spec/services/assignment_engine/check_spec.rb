require 'rails_helper'

describe AssignmentEngine::Check do

  let(:course) { create(:course) }

  context "#initialize" do

    let(:teacher) { create(:user) }
    let(:student) { create(:user) }

    before do
      @teacher_request = create(:request, course: course, teacher: teacher)
      @student_request = create(:request, course: course, student: student)
    end

    it "finds course" do
      @ae_check = AssignmentEngine::Check.new(course.id)
      expect(@ae_check.course).to eq(course)
    end

    it "has correct teacher_requests" do
      @ae_check = AssignmentEngine::Check.new(course.id)
      expect(@ae_check.teacher_requests).to eq(Request.where(id: @teacher_request.id))
    end

    it "has correct student_requests" do
      @ae_check = AssignmentEngine::Check.new(course.id)
      expect(@ae_check.student_requests).to eq(Request.where(id: @student_request.id))
    end

    context "assignable" do

      before do
        [teacher, student].each { |user| user.update(assignable: true) }
      end

      it "has correct num_teachers_that_can_take_course" do
        @ae_check = AssignmentEngine::Check.new(course.id)
        expect(@ae_check.num_teachers_that_can_take_course).to eq(1)
      end

      it "has correct num_students_that_can_take_course" do
        @ae_check = AssignmentEngine::Check.new(course.id)
        expect(@ae_check.num_students_that_can_take_course).to eq(1)
      end

    end

    context "unassignable" do

      before do
        [teacher, student].each { |user| user.update(assignable: false) }
      end

      it "has correct num_teachers_that_can_take_course" do
        @ae_check = AssignmentEngine::Check.new(course.id)
        expect(@ae_check.num_teachers_that_can_take_course).to eq(0)
      end

      it "has correct num_students_that_can_take_course" do
        @ae_check = AssignmentEngine::Check.new(course.id)
        expect(@ae_check.num_students_that_can_take_course).to eq(0)
      end

    end

    it "pass is false" do
      @ae_check = AssignmentEngine::Check.new(course.id)
      expect(@ae_check.pass).to be false
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