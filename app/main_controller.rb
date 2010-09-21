get '/:name' do
  fotolog = Fotolog.new(params[:name])
  @photos = fotolog.years.map { |year| (1..12).map { |month| fotolog.photos_for_month year, month}}.flatten
  haml :index
end

