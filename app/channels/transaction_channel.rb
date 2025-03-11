# filepath: app/channels/transaction_channel.rb
class TransactionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "transaction_channel_#{params[:user_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
