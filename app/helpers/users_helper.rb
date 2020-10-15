module UsersHelper
  def signed_in_edit(user)
    link_to 'Edit', edit_user_path(user) if user == logged_user
  end

  def signed_in_logout(user)
    link_to 'Logout', logout_path, method: :post if user == logged_user
  end

  def suggestion
    # logged_user.follower
    # Users.where()
    # followings.where(followed_id: user.id).exists?
    # Users.where(user_id logged_user.followed)

    # User.all - logged_user.followeds - [logged_user]
    # User.where("user.id != ?", logged_user.followeds)
    # User.where('id NOT IN (?)', logged_user.followeds)
    User.where.not(id: logged_user.followeds) - [logged_user]
  end

  def followed_by
    # @user.followers.where(logged_user.followeds.exist?(follower_id))
    # User.where(@user.followeds.exists?(@user.id))
    # User.where(followeds.exist?(@user.id) AND followers.exist?(logged_user.id) )

    # @user.followers - logged_user.followeds - [logged_user]
    # User.all
    @user.followers - logged_user.followeds
  end

  def recommended
    recommend = User.all - logged_user.followeds
  end

  def feed_home
    User.include(:techbits).where(id: logged_user.followeds)
  end

  def already_following
    logged_user.followeds.exists?(@user.id)
  end
end
