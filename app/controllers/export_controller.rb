# Disclaimer: this code is taken from Bernardo Farah's blog:
# https://www.bernardo.me/blog/2017/06/28/streaming-csv-with-rails/

require 'csv'

class ExportController < ApplicationController
  def export
    # Tell Rack to stream the content
    headers.delete("Content-Length")
    # Don't cache anything from this generated endpoint
    headers["Cache-Control"] = "no-cache"
    # Tell the browser this is a CSV file
    headers["Content-Type"] = "text/csv"
    # Make the file download with a specific filename
    headers["Content-Disposition"] = "attachment; filename=\"example.csv\""
    # Don't buffer when going through proxy servers
    headers["X-Accel-Buffering"] = "no"
    # Set an Enumerator as the body
    self.response_body = body
    # Set the status to success
    response.status = 200
  end

  private

  def body
    Enumerator.new do |yielder|
      # build your csv here line by line:
      20.times do |num|
        sleep 0.05
        yielder << CSV.generate_line([num, 'yay'])
      end
    end
  end
end