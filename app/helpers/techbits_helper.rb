module TechbitsHelper
  def home_feed
    # feed = logged_user.followeds + [logged_user]
    Techbit.includes(:author).where(author_id: logged_user.followeds).or(Techbit.includes(:author).where(author_id: logged_user))
    Techbit.includes(:author).where('author_id in (?)', (logged_user.followeds.id + [@user.id]))
  end

  def profile_bits(user)
    user.techbits.all
  end
end
