get '/' do
  if params.has_key? 'name'
    redirect "/#{params[:name]}"
  else
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
  fotolog = Fotolog.new(@name)
  @photos = fotolog.photos
end
