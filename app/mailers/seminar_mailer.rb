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

  def ask_if_seminar_complete(user, seminar)
    @user = user
    @course = seminar.course
    @url  = Rails.application.routes.url_helpers.edit_class_url(seminar_id: seminar.id, host: ENV["HOST"])
    @scheduled_at = I18n.l(seminar.scheduled_at, format: :date_and_time)
    email = email_to_use(@user)
    mail(to: email, subject: "Have you completed teaching #{@course.code}?")
  end

  def ask_student_for_review(user, seminar)
    @user = user
    @course = seminar.course
    @teacher = seminar.teacher
    @url  = Rails.application.routes.url_helpers.review_seminar_url(id: seminar.id, host: ENV["HOST"])
    email = email_to_use(@user)
    mail(to: email, subject: "Please review #{@course.code}")
  end

end