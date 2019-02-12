##################################################################################
# Error handling:
# --------------
# Every Request is wrapped by the `error_handler_wrapper` method.
# This ensures that if an exception is raised anywhare during the request processing, an error logged and.

##################################################################################
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  around_action :error_handler_wrapper

  def index
    render file: 'public/index.html', layout: false
  end


  def robots
    user_agents = '*'
    disallow = '/'
    res = ''
    if ENV['BLOCK_BOTS']
      res = [
        "User-agent: #{user_agents} # we don't like those bots",
        "Disallow: #{disallow} # block bots access to those paths"
      ].join("\n")
    end
    render plain: res, layout: false, content_type: 'text/plain'
  end

  def error_handler_wrapper
    yield
  rescue StandardError => e
    logger.error "\n\nEXCEPTION: #{e.message}" unless Rails.env.test?
    logger.error e.backtrace.join("\n") unless Rails.env.test?
    EventLog.err("#{params['controller']}##{params['action']}", e.message)
    raise e
  end
end
