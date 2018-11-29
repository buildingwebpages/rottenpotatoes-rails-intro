module MoviesHelper
  
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def clicked(sym)
    (params[:order] || session[:order]) == sym.to_s ? 'hilite' : ''
  end

  def set_ratings
    @all_ratings = Movie.select(:rating).distinct.map(&:rating).sort
    
    if params[:ratings]
      session.delete(:ratings)
      session.delete(:order)
      
      @ratings = params[:ratings].keys
      session[:ratings] = params[:ratings]
    elsif session[:ratings]
      @ratings = session[:ratings].keys
    else
      @ratings = @all_ratings
    end
  end
  
  def set_movies
    if params[:order]
      session.delete(:order)
      
      @movies = Movie.where({rating: @ratings}).order(params[:order])
      session[:order] = params[:order]
    elsif session[:order]
      @movies = Movie.where({rating: @ratings}).order(session[:order])
    else
      @movies = Movie.where({rating: @ratings})
    end    
  end
  
  def redirect_if_params_missing
    flash.keep
    
    unless (params[:order] && params[:ratings])
      if (session[:order] && session[:ratings])
        redirect_to movies_path(:order => session[:order], :ratings => session[:ratings])
        return
      end
    end
    
    unless (params[:order])
      if (session[:order])
        redirect_to movies_path(:order => session[:order], :ratings => params[:ratings])
        return
      end
    end
    
    unless (params[:ratings])
      if (session[:ratings])
        redirect_to movies_path(:order => params[:order], :ratings => session[:ratings])
        return
      end
    end
  end
  
end
