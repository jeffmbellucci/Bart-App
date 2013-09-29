class ApplicationController < ActionController::Base
  include StationsHelper
  include SessionsHelper
  include RemindersHelper
  include ClosestStationsHelper
  protect_from_forgery
end
