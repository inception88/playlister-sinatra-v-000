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
    @artist = Artist.find_by(name: params[:song][:artist_name])
    # binding.pry
    if @artist == nil
      @artist = Artist.create(name: params[:song][:artist_name])
    end
    @genres = []
    params[:genres].each do |genre_name|
      if Genre.find_by(name: genre_name) != nil
        @genres << Genre.find_by(name: genre_name)
      end
    end
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

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    if params[:song][:artist_name] != ""
      @artist = Artist.create(name: params[:song][:artist_name])
      @song.update(artist: @artist)
    end
    @genres = [params[:genres][0]]
    @genres << Genre.find_by(name: genre_name)
    @song.save
    binding.pry
    flash[:message] = "Successfully updated song."
    redirect "/songs/#{@song.slug}"
  end

end
