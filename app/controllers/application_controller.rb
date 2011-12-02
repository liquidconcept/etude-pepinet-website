class ApplicationController < ActionController::Base
  protect_from_forgery

  layout lambda {|controller| controller.request.headers['X-PJAX'] ? false : 'application' }

  before_filter do
    I18n.locale = :fr
  end
end
