class SearchesController < ApplicationController
  before_filter :authenticate, :only => [:find_microposts, :find_users]

  def find_microposts
    @title = "Searching microposts"
    @searches = Micropost.search( params[:q] ).paginate( :page => params[:page] )
    @key_word = params[:q]
    @params_of_coding = params[:utf8]
  end

  def find_users
    @title = "Searching users"
    @searches = User.search( params[:q] ).paginate( :page => params[:page] )
    @key_word = params[:q]
    @params_of_coding = params[:utf8]
  end
end
