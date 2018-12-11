class GenresController < ApplicationController
  before_action :authenticate_user!


  def show
  	@random_artists = []
  	@index = []
    @cover = []
@genre = Genre.all[params[:id].to_i]
    @popular = Genre.all[params[:id].to_i].artists.sort_by{ |t| t.popularity }.reverse
  	@artists = Artist.all
  	RSpotify::authenticate("2fc8c7db0a584ecc97c8789e10b1ba14", "3e31ba14f979474ab69880fafd410829")
    
    10.times do |i|
      if RSpotify::Artist.find("#{@popular[i].spotify_id}").images != []
        @cover << RSpotify::Artist.find("#{@popular[i].spotify_id}").images[0]['url']
      end
    end

  end
end
