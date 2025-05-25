defmodule CustomerDashboard.MessagePublisher do
  @moduledoc """
  Publishes messages to RabbitMQ when a new application is created.
  """

  alias AMQP.{Connection, Channel, Basic}
  require Logger

  @queue "applications_created"

  def publish_application_created(application) do
    # Open a connection (using default guest credentials on localhost)
    with {:ok, connection} <- Connection.open("amqp://guest:guest@localhost"),
         {:ok, channel} <- Channel.open(connection),
         {:ok, _} <- AMQP.Queue.declare(channel, @queue, durable: true) do
      payload = Jason.encode!(application)

      # Publish to the default exchange with the queue name as the routing key.
      result = Basic.publish(channel, "", @queue, payload)
      IO.inspect(result, label: "RabbitMQ Publish Result")

      Logger.info("Published application data to RabbitMQ: #{payload}")

      # Clean up by closing the channel and connection.
      Channel.close(channel)
      Connection.close(connection)

      :ok
    else
      error ->
        Logger.error("Failed to publish message: #{inspect(error)}")
        error
    end
  end
end
