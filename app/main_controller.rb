get '/' do
  if params.has_key? 'username'
    redirect "/#{params[:username]}"
  else
    haml :index
  end
end

get '/:name' do
  @name = params[:name]
  fotolog = Fotolog.new(@name)
  @photos = fotolog.years.map { |year| (1..12).map { |month| fotolog.photos_for_month year, month}}.flatten
  haml :index
end

