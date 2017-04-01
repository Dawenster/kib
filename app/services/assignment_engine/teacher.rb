class AssignmentEngine::Teacher

  def self.ordered_by_classes_taught(course)
    course.teachers_who_can_be_assigned.sort_by do |teacher|
      teacher.assigned_seminars_as_teacher.complete.count
    end
  end

end