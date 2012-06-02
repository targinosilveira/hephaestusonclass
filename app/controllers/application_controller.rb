class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  #System constants
  #Actualy system version
  HEPHAESTUS_VERSION = "0.01"

end
