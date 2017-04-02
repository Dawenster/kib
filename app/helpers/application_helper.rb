module ApplicationHelper

  def link_to_list_of_users(users, with_assignment_ratio = false)
    links = []
    users.each do |user|
      link = link_to(user.full_name, rails_admin.show_path(model_name: "user", id: user.id))
      link += " (#{user.assignment_ratio_for_display})" if with_assignment_ratio
      links << link
    end
    links.to_sentence.html_safe
  end

end
