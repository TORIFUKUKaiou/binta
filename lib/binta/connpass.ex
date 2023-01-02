defmodule Binta.Connpass do
  @moduledoc false

  def event_now do
    utc_today = Date.utc_today()

    ym = ym(utc_today.year, utc_today.month)

    events =
      %{ym: ym, series_id: 11144}
      |> run()
      |> handle_response()

    before_year = if utc_today.month == 1, do: utc_today.year - 1, else: utc_today.year

    before_month =
      Enum.zip(1..12, [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
      |> Map.new()
      |> Map.get(utc_today.month)

    before_ym = ym(before_year, before_month)

    %{ym: before_ym, series_id: 11144}
    |> run()
    |> handle_response()
    |> Kernel.++(events)
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

  defp ym(year, month) do
    "#{year}#{month |> Integer.to_string() |> String.pad_leading(2, "0")}"
  end

  defp handle_response({:error, _}), do: []

  defp handle_response({:ok, %{body: %{"events" => events}}}), do: events
end
