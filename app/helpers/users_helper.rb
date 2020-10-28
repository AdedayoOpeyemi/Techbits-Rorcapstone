module UsersHelper
  def signed_in_edit(user)
    link_to 'Edit', edit_user_path(user) if user == logged_user
  end

  def signed_in_logout(user)
    link_to 'Logout', logout_path, method: :post if user == logged_user
  end

  def suggestion
    no_suggest = logged_user.followeds + [logged_user]
    User.where.not(id: no_suggest).order(created_at: :desc).limit(5)
  end

  def followed_by
    if @user == logged_user
      User.where(id: logged_user.followers).order(created_at: :desc).limit(5)
    else
      suggest = @user.followers - logged_user.followeds
      User.where(id: suggest).order(created_at: :desc).limit(5)
    end
  end

  def feed_home
    User.include(:techbits).where(id: logged_user.followeds)
  end

  def already_following
    logged_user.followeds.exists?(@user.id)
  end
end
