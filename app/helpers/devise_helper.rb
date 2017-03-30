module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    messages = error_display_as_sentence(resource.errors)
    sentence = I18n.t("errors.messages.not_saved", :count => resource.errors.count, :resource => resource.class.model_name.human.downcase)

    flash.now[:alert] = messages.html_safe
    return ""
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end