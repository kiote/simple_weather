defmodule SimpleWeather.Facade do
  def human_readable do
    to_human_readable(
      today: SimpleWeather.Abstraction.today(implementation()),
      yesterday: SimpleWeather.Abstraction.days_ago(days: 1, implementation: implementation())
    )
  end

  def machine_readable do
    to_machine_readable(
      today: SimpleWeather.Abstraction.today(implementation()),
      yesterday: SimpleWeather.Abstraction.days_ago(days: 1, implementation: implementation())
    )
  end

  # private
  defp implementation, do: Application.get_env(:simple_weather, :implementation)

  defp to_human_readable(_params) do
    "hi"
  end

  defp to_machine_readable(_params) do
    "hi"
  end
end
