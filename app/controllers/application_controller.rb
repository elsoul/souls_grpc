class ApplicationController < ActionController::Base
  def ok
    render json:
      {
        status: "running!",
        env: Rails.env,
        time: Time.now
      }
  end

  def db_test
    render json:
      {
        success: true,
        status: "connected!",
        user: User.first.username
      }
  end
end
