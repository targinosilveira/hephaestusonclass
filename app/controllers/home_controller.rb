class HomeController < ApplicationController

  def index
  	@version = ApplicationController::HEPHAESTUS_VERSION
  end

  def history
  	@version = ApplicationController::HEPHAESTUS_VERSION
  end
end
