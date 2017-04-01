require 'rails_helper'

describe AssignmentEngine::Check do

  let(:course) { create(:course) }
  let(:seminar) { create(:seminar, :complete) }

  context "#initialize" do

    let(:teacher) { create(:user) }
    let(:student) { create(:user) }

    before do
      @teacher_request = create(:request, course: course, teacher: teacher)
      @student_request = create(:request, course: course, student: student)
    end

    it "finds course" do
      @ae_check = AssignmentEngine::Check.new(course)
      expect(@ae_check.course).to eq(course)
    end

    context "assignable" do

      before do
        [teacher, student].each { |user| user.update(assignable: true) }
      end

      it "has correct num_teachers_that_can_take_course" do
        @ae_check = AssignmentEngine::Check.new(course)
        expect(@ae_check.num_teachers_that_can_take_course).to eq(1)
      end

      it "has correct num_students_that_can_take_course" do
        @ae_check = AssignmentEngine::Check.new(course)
        expect(@ae_check.num_students_that_can_take_course).to eq(1)
      end

    end

    context "unassignable" do

      before do
        [teacher, student].each { |user| user.update(assignable: false) }
      end

      it "has correct num_teachers_that_can_take_course" do
        @ae_check = AssignmentEngine::Check.new(course)
        expect(@ae_check.num_teachers_that_can_take_course).to eq(0)
      end

      it "has correct num_students_that_can_take_course" do
        @ae_check = AssignmentEngine::Check.new(course)
        expect(@ae_check.num_students_that_can_take_course).to eq(0)
      end

    end

    context "within assignment ratio" do

      before do
        create(:request, :assigned, seminar: seminar, course: course, teacher: student)
      end

      it "has correct num_students_that_can_take_course" do
        @ae_check = AssignmentEngine::Check.new(course)
        expect(@ae_check.num_students_that_can_take_course).to eq(1)
      end

    end

    context "outside assignment ratio" do

      before do
        create(:request, :assigned, seminar: seminar, course: course, student: student)
      end

      it "has correct num_students_that_can_take_course" do
        @ae_check = AssignmentEngine::Check.new(course)
        expect(@ae_check.num_students_that_can_take_course).to eq(0)
      end

    end

    it "pass is false" do
      @ae_check = AssignmentEngine::Check.new(course)
      expect(@ae_check.pass).to be false
    end

  end

  context "#enough_teachers?" do

    context "enough" do

      before do
        AssignmentEngine::Check::MIN_REQUIRED_TEACHERS.times do
          teacher = create(:user)
          create(:request, course: course, teacher: teacher)
        end
      end

      it "returns true" do
        @ae_check = AssignmentEngine::Check.new(course)
        expect(@ae_check.enough_teachers?).to be true
      end

    end

    context "not enough" do

      it "returns false" do
        @ae_check = AssignmentEngine::Check.new(course)
        expect(@ae_check.enough_teachers?).to be false
      end

    end

  end

  context "#enough_students?" do

    context "enough" do

      before do
        AssignmentEngine::Check::MIN_REQUIRED_STUDENTS.times do
          student = create(:user)
          create(:request, course: course, student: student)
        end
      end

      it "returns true" do
        @ae_check = AssignmentEngine::Check.new(course)
        expect(@ae_check.enough_students?).to be true
      end

    end

    context "not enough" do

      it "returns false" do
        @ae_check = AssignmentEngine::Check.new(course)
        expect(@ae_check.enough_students?).to be false
      end

    end

  end

end