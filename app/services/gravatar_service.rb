class GravatarService
  include Gitlab::CurrentSettings

  def execute(email, size = nil)
    size = 40 if size.nil? || size <= 0
    if current_application_settings.gravatar_enabled? && email.present?
      sprintf gravatar_url,
        hash: Digest::MD5.hexdigest(email.strip.downcase),
        size: size,
        email: email.strip
    elsif custom_avatar_config.enabled && email.present?
      email.strip.downcase!

      if @user = User.find_by_email(email)
        sprintf custom_avatar_url,
	  user: @user[custom_avatar_config.user_field],
	  size: size
      end
    end
  end

  def gitlab_config
    Gitlab.config.gitlab
  end

  def gravatar_config
    Gitlab.config.gravatar
  end

  def custom_avatar_config
    Gitlab.config.custom_avatar
  end

  def gravatar_url
    if gitlab_config.https
      gravatar_config.ssl_url
    else
      gravatar_config.plain_url
    end
  end

  def custom_avatar_url
    if gitlab_config.https
      custom_avatar_config.ssl_url
    else
      custom_avatar_config.plain_url
    end
  end
end
