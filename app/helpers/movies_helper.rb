module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def clicked(sym)
    params[:order] == sym.to_s ? 'hilite' : ''
  end
end
