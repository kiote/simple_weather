defmodule SimpleWeather.Presenter do
  defp presenter() do
    Application.get_env(:simple_weather, :machine_readable_presenter)
  end

  def result do
    today() <> yesterday() <> the_day_before_yesterday() <> two_days_before_yesterday()
  end

  defp to_machine_readable_representation({:ok, forecast, _headers}) do
    presenter().convert(forecast)
  end

  defp today() do
    # it must be next two hours + two hours after 7 hours from now
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
