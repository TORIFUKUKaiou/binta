defmodule Binta.Inoki do
  @moduledoc false
  # TODO 将来猪木さんAI

  @messages [
    "闘魂とは己に打ち克つこと、そして闘いを通じて己の魂を磨いていくことだとおもいます",
    "元氣ですかーーーーッ！！！　元氣があればなんでもできる！",
    "イーチ、ニィー、サン、ぁッ ダー！！！"
  ]

  def build_message do
    message = Enum.random(@messages)
    ":fire::toukon: *#{message}* :inoki: :toukon::fire:"
  end
end
