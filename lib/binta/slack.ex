defmodule Binta.Slack do
  @moduledoc false
  require Logger

  def post(message) do
    post_result = Req.post(url(), json: %{text: message}) |> IO.inspect()
    Logger.info(inspect(post_result))
  end

  defp url, do: Application.get_env(:binta, :slack_incoming_webhook_url)
end
