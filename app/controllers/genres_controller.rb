class GenresController < ApplicationController
  before_action :authenticate_user!

  def show
  	@reco = []
    @cover = []
    @genre = Genre.find(params[:id])
    @popular = @genre.artists.sort_by{ |t| t[:popularity]}.reverse
  	@artists = Artist.all

  	RSpotify::authenticate(Rails.application.credentials.spotify_client_id, Rails.application.credentials.spotify_client_secret)
    
    10.times do |i|
      @image = RSpotify::Artist.find("#{@popular[i].spotify_id}")
      if @image.images == []
        @cover << nil
      else
        @cover << @image.images[0]['url']
      end
    end
    @popular.each_with_index do |artist, i|
      artist.genres.each do |genre|
        @reco << genre.id
      end
      break if i == 5
    end
    @freq = @reco.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  end

end
