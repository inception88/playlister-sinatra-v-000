class SongsController < ApplicationController

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
    @genre = Genre.find_by(name: params[:song][:existing_genre])
    @song = Song.new(name: params[:song][:song_name])
    @song.artist = @artist
    @song.genres << @genre
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
