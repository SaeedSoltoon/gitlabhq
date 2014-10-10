module ProfileHelper
  def oauth_active_class provider
    if current_user.provider == provider.to_s
      'active'
    end
  end

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
    enabled_social_providers.any? && !current_user.ldap_user? && !current_user.shibboleth_user?
  end

  def show_profile_remove_tab?
    gitlab_config.signup_enabled && !current_user.ldap_user? && !current_user.shibboleth_user?
  end

  def show_profile_password_tab?
    !current_user.ldap_user? && !current_user.shibboleth_user?
  end
end
