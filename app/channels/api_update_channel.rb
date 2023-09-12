class ApiUpdateChannel < ApplicationCable::Channel
  def subscribed
    stream_from "To_User"
  end
end
