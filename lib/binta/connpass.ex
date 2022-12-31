defmodule Binta.Connpass do
  @moduledoc false

  def event_now do
    utc_today = Date.utc_today()

    ym =
      "#{utc_today.year}#{utc_today.month |> Integer.to_string() |> String.pad_leading(2, "0")}"

    %{ym: ym, series_id: 11144}
    |> run()
    |> handle_response()
    |> Enum.filter(fn %{"started_at" => started_at, "ended_at" => ended_at} ->
      {:ok, start, _} = DateTime.from_iso8601(started_at)
      {:ok, ending, _} = DateTime.from_iso8601(ended_at)
      utc_now = DateTime.utc_now()

      DateTime.compare(start, utc_now) in [:lt, :eq] and
        DateTime.compare(utc_now, ending) in [:lt, :eq]
    end)
    |> Enum.at(0)
  end

  def run(query) do
    Req.get("https://connpass.com/api/v1/event/?#{URI.encode_query(query)}")
  end

  defp handle_response({:error, _}), do: []

  defp handle_response({:ok, %{body: %{"events" => events}}}), do: events
end
