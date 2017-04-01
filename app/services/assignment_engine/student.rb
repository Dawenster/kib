class AssignmentEngine::Student

  def self.ordered_by_classes_taken(course)
    course.students_who_can_be_assigned.sort_by do |student|
      student.assigned_seminars_as_student.completed.count
    end
  end

end