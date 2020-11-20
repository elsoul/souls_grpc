class ApplicationController < ActionController::Base
  def ok
    render json:
      {
        status: "running!",
        env: Rails.env,
        time: Time.now
      }
  end
end
