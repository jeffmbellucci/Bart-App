class ApplicationController < ActionController::Base
  include StationsHelper
  include StaticPagesHelper
  include SessionsHelper
  include RemindersHelper
  protect_from_forgery
end
