class AppController < ApplicationController

  layout '_distribution'

  def applist
    @applist = App.all
  end
end
