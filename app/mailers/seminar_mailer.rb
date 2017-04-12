class SeminarMailer < ApplicationMailer
  
  def seminar_assigned_as_student(user, seminar)
    @user = user
    @course = seminar.course
    @teacher = seminar.teacher
    @url  = Rails.application.routes.url_helpers.classes_url(host: ENV["HOST"])
    email = email_to_use(@user)
    mail(to: email, subject: "#{@course.code}: Student Request Confirmed")
  end

  def seminar_assigned_as_teacher(user, seminar)
    @user = user
    @course = seminar.course
    @students_as_string = seminar.students.map{|student| "#{student.full_name} (#{student.email})"}.to_sentence
    @url  = Rails.application.routes.url_helpers.classes_url(host: ENV["HOST"])
    email = email_to_use(@user)
    mail(to: email, subject: "#{@course.code}: Teacher Request Confirmed")
  end

end