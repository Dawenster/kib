class AssignmentEngine::Teacher

  def self.ordered_by_classes_taught(course_id)
    @course.unassigned_requesting_teachers.sort_by do |teacher|
      teacher.assigned_seminars_as_teacher.complete.count
    end
  end

end