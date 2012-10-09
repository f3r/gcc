module UsersHelper
  def full_name(user)
    # name = [user['first_name'], user['last_name']].join(' ')
    #     name.titleize unless name.eql?(' ')
    user.full_name
  end

  def nickname(user)
    nick = 'no username yet'
    nick = "#{user['first_name'][0]}#{user['last_name']}" unless user['first_name'].nil? && user['last_name'].nil?
  end

  def date_convert(date)
    new_date = date.to_date.strftime("%d %B %Y")
    new_date unless date.blank?
  end

  def profile_picture_url(uid, type)
    if type == "facebook"
      avatar = "https://graph.facebook.com/#{uid}/picture"
    elsif type == "twitter"
      user = RestClient.get("https://api.twitter.com/1/users/show.json?user_id=#{uid}")
      user_info = JSON.parse(user)
      avatar = user_info['profile_image_url']
    end
    avatar
  end

  def avatar_image(user)
    # TODO: Remove backward compatibility
    src = asset_path "missing_userpic.png"
    if user
      if user.kind_of?(User)
        src = user.avatar.url(:thumb) if user.avatar?
      elsif user['avatar']
        # Backward compatibility
        src = user['avatar']
      end
    end

    image_tag src, :style => "width:60px; height:60px;"
  end

  def user_gender(user)
    return if user.gender.blank?
    t("users.gender_#{user.gender}")
  end

  def avatar_image_by_id(user_id)
    user = User.find(user_id)
    avatar_image(user)
  end
end
