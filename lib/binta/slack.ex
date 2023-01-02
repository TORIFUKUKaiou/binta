defmodule Binta.Slack do
  @moduledoc false

  def post(message) do
    Req.post(url(), json: %{text: message}) |> IO.inspect()
  end

  defp url, do: Application.get_env(:binta, :slack_incoming_webhook_url)
end
