class ApplicationController < ActionController::Base
    include SessionsHelper
    include PasswordResetsHelper
end
