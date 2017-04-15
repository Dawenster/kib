class Requests::Controller

  def self.auto_request_as_teacher(seminar)
    request = Request.new(
      teacher: seminar.teacher,
      course: seminar.course
    )
    request.save
  end

end