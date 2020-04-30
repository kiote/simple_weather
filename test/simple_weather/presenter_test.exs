defmodule SimpleWeather.PresenterTest do
  use ExUnit.Case, async: true

  alias SimpleWeather.Presenter
  alias SimpleWeather.Types.Condition
  alias SimpleWeather.Types.Today

  describe "to_machine/1" do
    test "when weather is good" do
      till_dark = -8
      temperature_morning = 8
      temperature_evening = 8
      wind_morning = 0
      wind_evening = 0
      precipitation_probability_morning = 0.0
      precipitation_probability_evening = 0.0

      assert "YES" ==
               Presenter.to_machine(%Today{
                 from_now: %Condition{
                   temperature: temperature_morning,
                   wind: wind_morning,
                   precipitation_probability: precipitation_probability_morning
                 },
                 in_evening: %Condition{
                   temperature: temperature_evening,
                   wind: wind_evening,
                   precipitation_probability: precipitation_probability_evening
                 },
                 till_dark: till_dark
               })
    end

    test "weather is bad" do
      till_dark = 2
      temperature_morning = 1
      temperature_evening = 1
      wind_morning = 10
      wind_evening = 10
      precipitation_probability_morning = 0.9
      precipitation_probability_evening = 0.9

      assert "NO" ==
               Presenter.to_machine(%Today{
                 from_now: %Condition{
                   temperature: temperature_morning,
                   wind: wind_morning,
                   precipitation_probability: precipitation_probability_morning
                 },
                 in_evening: %Condition{
                   temperature: temperature_evening,
                   wind: wind_evening,
                   precipitation_probability: precipitation_probability_evening
                 },
                 till_dark: till_dark
               })
    end
  end
end
