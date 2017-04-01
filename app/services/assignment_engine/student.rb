class AssignmentEngine::Student

  def self.ordered_by_classes_taken(course)
    course.unassigned_requesting_students.sort_by do |student|
      student.assigned_seminars_as_student.complete.count
    end
  end

end