class AppController < ApplicationController

  layout '_distribution'

  def applist
    @applist = App.all
    @back_uri = nil
    @navigation_title = 'Install Apps'
  end

  def version_detail
  end

  def more_version
  end
end
