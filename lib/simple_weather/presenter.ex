defmodule SimpleWeather.Presenter do
  use EnumType

  require Logger

  defp presenter() do
    Application.get_env(:simple_weather, :machine_readable_presenter)
  end

  def result do
    "#{right_now()}#{hours_from_now(:two_hours_from_now)}#{hours_from_now(:seven_hours_from_now)}#{
      yesterday()
    }#{the_day_before_yesterday()}#{two_days_before_yesterday()}"
  end

  defp to_machine_readable_representation(response, time_slot \\ :now)

  defp to_machine_readable_representation({:ok, forecast, _headers}, time_slot) do
    presenter().convert(forecast, time_slot)
  end

  defp to_machine_readable_representation(error, _something) do
    Logger.error(error)
    "9"
  end

  defp for_hours_from_now({:ok, forecast, headers}, _hours) do
    {:ok, forecast, headers}
  end

  defp hours_from_now(hours) do
    SimpleWeather.WeatherReceiver.today()
    |> for_hours_from_now(hours)
    |> to_machine_readable_representation(hours)
  end

  defp right_now() do
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
