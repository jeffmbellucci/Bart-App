class ApplicationController < ActionController::Base
  include StationsHelper
  include StaticPagesHelper
  protect_from_forgery
end
