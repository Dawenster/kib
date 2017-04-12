module ServerMethods

  extend ActiveSupport::Concern

  def kib_production?
    ENV["KIB_ENVIRONMENT"] == "production"
  end

end