module TechbitsHelper

  def awesome(techbit)
    return if techbit.author != logged_user

  	link_to techbit, method: :delete, data: { confirm: "Are you sure you want to delete this bit?" } do
  	  ('<span class="icon"><i class="fa fa-trash-o" aria-hidden="true"></i></span>').html_safe
    end
  end
end
