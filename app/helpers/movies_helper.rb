module MoviesHelper
  @@counter = 1
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def clicked(sym)
    params[:order] == sym.to_s ? 'hilite' : ''
  end
  
  def clear_session_first_run
    if @@counter == 1
      session.clear
      @@counter += 1
    end
  end
end
