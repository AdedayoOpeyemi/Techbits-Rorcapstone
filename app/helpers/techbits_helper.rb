module TechbitsHelper
  def home_feed
    Techbit.includes(:author).where(author_id: logged_user.followeds).or(Techbit.includes(:author).where(author_id: logged_user))
  end

  def profile_bits(user)
    user.techbits.all
  end
end
