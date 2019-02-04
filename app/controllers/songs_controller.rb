class SongsController < ApplicationController

  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    @artists = Artist.all
    erb :'songs/new'
  end

  post '/songs' do
    @artist = Artist.find_by(name: params[:song][:existing_artist])
    if @artist == nil
      @artist = Artist.create(name: params[:song][:artist_name])
    end
    @genres = []
    params[:genres].each do |genre_name|
    Genre.find_by(name: params[:genres])
    @song = Song.new(name: params[:song][:song_name])
    @song.artist = @artist
    @song.genres << @genres
    @song.save
    flash[:message] = "Successfully created song."
    # binding.pry
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

end
