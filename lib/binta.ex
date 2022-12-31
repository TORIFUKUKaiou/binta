defmodule Binta do
  @moduledoc """
  Documentation for `Binta`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Binta.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  post https://autoracex.connpass.com/ event to #autoracex channel on elixir.jp Slack

  """
  def run do
    event_now()
    |> build_message()
    |> post_message()
  end

  defp post_message(:error), do: :error

  defp post_message(message) do
    Binta.Slack.post(message)
  end

  defp build_message(:error), do: :error

  defp build_message(event_now) do
    Binta.Inoki.build_message()
    |> Kernel.<>("\n\n\n")
    |> Kernel.<>(event_now)
    |> Kernel.<>(
      "\n\nThis bot is https://github.com/TORIFUKUKaiou/binta .\nThanks for GitHub Actions workflows & William Henry \"Bill\" Gates III."
    )
  end

  defp event_now do
    case Binta.Connpass.event_now() do
      %{
        "title" => title,
        "event_url" => event_url,
        "accepted" => accepted,
        "started_at" => started_at,
        "ended_at" => ended_at
      } ->
        """
        *#{title}*
        #{started_at} 〜 #{ended_at}
        参加人数: #{accepted}人

        #{event_url}
        """

      _ ->
        :error
    end
  end
end
