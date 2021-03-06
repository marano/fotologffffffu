get '/' do
  if params.has_key? 'name'
    redirect "/#{params[:name]}"
  else
    @recent_users = Fotolog.new.recent_users
    haml :index
  end
end

get '/:name' do
  correct_path = "/#{params[:name].downcase}"
  if request.fullpath != correct_path
    redirect correct_path
  end
  fotolog = Fotolog.new params[:name]
  if retrieve_photos
    haml :wall
  else
    raise Sinatra::NotFound
  end
end

not_found do
  redirect "/"
end

get '/:name/slide' do
  @name = params[:name]
  haml :slide
end

get '/:name/feed' do
  retrieve_photos
  haml :feed, :layout => false
end

def retrieve_photos
  @name = params[:name]
  fotolog = Fotolog.new(@name)
  @photos = fotolog.retrieve_photos
end

def cache
  Cache.instance
end

