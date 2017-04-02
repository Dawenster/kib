class AssignmentEngine::Controller

  def self.assign_all_outstanding_requests
    courses_with_unassigned_requests = Course.active.where(id: Request.unassigned.pluck(:course_id).uniq)
    courses_with_unassigned_requests.each do |course|
      assign_requests_for_course(course.id)
    end
  end

  def self.assign_requests_for_course(course_id)
    course = Course.find(course_id)
    return if course.nil? || course.inactive?
    
    teachers = AssignmentEngine::Teacher.ordered_by_classes_taught(course)
    teachers.each do |teacher|
      seminar_creation_check = AssignmentEngine::Check.new(course).seminar_creation
      if seminar_creation_check.pass
        args = {
          course: course,
          teacher: teacher
        }
        AssignmentEngine::Seminar.new(args).create
      end
    end
  end

end