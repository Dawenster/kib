module ApplicationHelper

  def link_to_list_of_users(users, with_assignment_ratio = false)
    links = []
    users.each do |user|
      link = "<div>"
      link += link_to(user.full_name, rails_admin.show_path(model_name: "user", id: user.id))
      link += " (#{user.assignment_ratio_for_display})" if with_assignment_ratio
      link += "</div>"
      links << link
    end
    links.join("").html_safe
  end

  def mail_to_list_of_users(users)
    links = []
    users.each do |user|
      link = "<div>"
      link += mail_to(user.email, user.full_name)
      link += "</div>"
      links << link
    end
    links.join("").html_safe
  end

end
