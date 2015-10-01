module ProfileHelper
  def show_profile_name?
    !current_user.shibboleth_user?
  end

  def show_profile_email?
    !current_user.shibboleth_user?
  end

  def show_profile_username_tab?
    current_user.can_change_username? && !current_user.shibboleth_user?
  end

  def show_profile_social_tab?
    enabled_social_providers.any? && !current_user.shibboleth_user?
  end

  def show_profile_remove_tab?
    signup_enabled? && !current_user.shibboleth_user?
  end

  def show_profile_password_tab?
    !current_user.shibboleth_user?
  end
end
