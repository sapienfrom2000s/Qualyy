class ApiUpdateChannel < ApplicationCable::Channel
  def subscribed
    stream_from "To_User"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
