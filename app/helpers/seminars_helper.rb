module SeminarsHelper
  
  def duration_display(seminar)
    "#{seminar.duration_in_min} #{'minute'.pluralize(seminar.duration_in_min)}"
  end

end