get '/' do
  if params.has_key? 'name'
    redirect "/#{params[:name]}"
  else  
    @recent_users = recent_users
    haml :index
  end
end

get '/:name' do
  retrieve_photos
  haml :index
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
  add_fotolog_to_cache @name
  add_user_to_cache @name
  @photos = cache.get "#{@name}"
end

def cache
  @@cache = Cache.open
end

def recent_users
  if cache.get('recent_users').nil?
    cache.set('recent_users', [])
  end  
  cache.get('recent_users')  
end

def add_fotolog_to_cache name
  cache.set("#{name}", Fotolog.new(@name).photos) if cache.get("#{name}").nil?
end

def add_user_to_cache user 
  unless recent_users.include? user
    recent_users.push(user)
    cache.set('recent_users', recent_users)
  end
end

