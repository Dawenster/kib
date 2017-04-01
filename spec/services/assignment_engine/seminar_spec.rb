require 'rails_helper'

describe AssignmentEngine::Seminar do

  let(:course) { create(:course) }
  let(:teacher) { create(:user) }

  before do
    @args = {
      course: course,
      teacher: teacher
    }
    @ae_seminar = AssignmentEngine::Seminar.new(@args)
  end

  context "#initialize" do


    it "sets course" do
      expect(@ae_seminar.course).to eq(course)
    end

    it "sets teacher" do
      expect(@ae_seminar.teacher).to eq(teacher)
    end

  end

  context "#create_seminar_with_default_duration" do

    it "creates seminar object" do
      expect(@ae_seminar.seminar.present?).to be false
      @ae_seminar.create_seminar_with_default_duration
      expect(@ae_seminar.seminar.present?).to be true
      expect(@ae_seminar.seminar.duration_in_min).to eq(Seminar::DEFAULT_DURATION_IN_MIN)
    end

  end

  context "#assign_teacher" do

    before do
      @ae_seminar.create_seminar_with_default_duration
      create(:request, course: course, teacher: teacher, seminar: @ae_seminar.seminar)
    end

    it "sets teacher on seminar" do
      expect(teacher.assigned_seminars_as_teacher.count).to eq(0)
      @ae_seminar.assign_teacher
      teacher.reload
      expect(teacher.assigned_seminars_as_teacher.count).to eq(1)
    end

  end

  context "student methods" do

    before do
      @ae_seminar.create_seminar_with_default_duration
      create(:request, course: course, teacher: teacher, seminar: @ae_seminar.seminar)
      @ae_seminar.assign_teacher

      (AssignmentEngine::Seminar::MAX_STUDENTS_ALLOWED_IN_SEMINAR + 1).times do
        student = create(:user)
        create(:request, course: course, student: student)
      end
    end

    context "#assign_students" do

      before do
        @ae_seminar.assign_students
      end

      it "assigns only up to the max num allowed" do
        expect(@ae_seminar.course.assigned_requesting_students.count).to eq(AssignmentEngine::Seminar::MAX_STUDENTS_ALLOWED_IN_SEMINAR)
      end

    end

    context "#assign_student" do

      it "sets seminar on request" do
        @student = @ae_seminar.course.unassigned_requesting_students.first
        @ae_seminar.assign_student(@student)
        @request = @student.student_requests.assigned.where(course: @ae_seminar.course).first
        expect(@request.seminar).to eq(@ae_seminar.seminar)
      end

      it "sets assigned to true" do
        @student = @ae_seminar.course.unassigned_requesting_students.first
        @ae_seminar.assign_student(@student)
        @request = @student.student_requests.assigned.where(course: @ae_seminar.course).first
        expect(@request.assigned).to be true
      end

    end

  end

end