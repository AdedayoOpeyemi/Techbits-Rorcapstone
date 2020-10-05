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

        User.all - logged_user.followeds - [logged_user]
      end
end

