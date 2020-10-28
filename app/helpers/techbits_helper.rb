module TechbitsHelper
  def home_feed
    # feed = logged_user.followeds + [logged_user]
    Techbit.includes(:author).where(author_id: logged_user.followeds).or(Techbit.includes(:author).where(author_id: logged_user))
  end

  def profile_bits(user)
    user.techbits.all
  end
end
