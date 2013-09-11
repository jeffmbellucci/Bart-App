class ApplicationController < ActionController::Base
  include StationsHelper
  include StaticPagesHelper
  include SessionsHelper
  protect_from_forgery
end
