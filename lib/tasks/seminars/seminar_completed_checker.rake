namespace :seminars do
  desc "Ask teachers if classes are completed"
  task ask_teachers_if_classes_are_completed: :environment do
    Email::Seminars.ask_teachers_if_seminars_completed
  end
end