defmodule SimpleWeather.Presenter do
  defp presenter() do
    Application.get_env(:simple_weather, :machine_readable_presenter)
  end

  def result do
    hours_from_now(2) <> hours_from_now(7) <> today() <> yesterday() <> the_day_before_yesterday() <> two_days_before_yesterday()
  end

  defp to_machine_readable_representation({:ok, forecast, _headers}) do
    presenter().convert(forecast)
  end

  defp for_hours_from_now({:ok, forecast, headers}, _hours) do
    {:ok, forecast, headers}
  end

  defp hours_from_now(hours) do
    SimpleWeather.WeatherReceiver.today()
    |> for_hours_from_now(hours)
    |> to_machine_readable_representation()
  end

  defp today() do
    SimpleWeather.WeatherReceiver.today()
    |> to_machine_readable_representation()
  end

  defp yesterday() do
    SimpleWeather.WeatherReceiver.yesterday()
    |> to_machine_readable_representation()
  end

  defp the_day_before_yesterday() do
    SimpleWeather.WeatherReceiver.the_day_before_yesterday()
    |> to_machine_readable_representation()
  end

  defp two_days_before_yesterday() do
    SimpleWeather.WeatherReceiver.two_days_before_yesterday()
    |> to_machine_readable_representation()
  end
end
