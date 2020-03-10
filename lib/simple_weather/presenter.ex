defmodule SimpleWeather.Presenter do
  defp presenter() do
    Application.get_env(:simple_weather, :machine_readable_presenter)
  end

  def result do
    SimpleWeather.WeatherReceiver.today
    |> to_machine_readable_representation
  end


  defp to_machine_readable_representation({:ok, forecast, _headers}) do
    presenter().convert(forecast)
  end
end
