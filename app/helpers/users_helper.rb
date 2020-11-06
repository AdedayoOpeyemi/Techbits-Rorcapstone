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

  def bit_form(user)
    return if user != logged_user
      
    render 'techbits/form', techbit: @techbit
  end

  def awesome(techbit)
    return if techbit.author != logged_user

  	link_to techbit, method: :delete, data: { confirm: "Are you sure you want to delete this bit?" } do
  	  ('<span class="icon"><i class="fa fa-trash-o" aria-hidden="true"></i></span>').html_safe
    end
  end

  def follow_option(user)
    return if user == logged_user

    if already_following
      link_to unfollow_user_path(user),  method: :post, class: "navbar-item" do
        ('<span class="material-icons text-dark">remove_circle</span>').html_safe
      end
    else
      link_to follow_user_path(user),  method: :post, class: "navbar-item" do
        ('<span class="material-icons text-dark">add_circle_outline</span>').html_safe
      end
    end
  end

  def notice_list(notice)
    if flash[notice]
  		('<div><p class="notice">"<%= notice %>"</p></div>').html_safe
    end
  end

  def alert_list(alert)
    if flash[alert]
  		('div class="">
  			<p class="alert">"<%= alert %>"</p>
  		</div>').html_safe
    end
  end
end
