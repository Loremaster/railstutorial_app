class SearchesController < ApplicationController
  def index
    @title = "Searching"
    @searches = User.search( params[:q] ).paginate( :page => params[:page] )
    @key_word = params[:q]
  end
end
