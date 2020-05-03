defmodule SimpleWeather.PresenterTest do
  use ExUnit.Case, async: true

  alias SimpleWeather.Presenter
  alias SimpleWeather.Types.Condition
  alias SimpleWeather.Types.Today

  describe "to_machine/1" do
    test "when weather is good" do
      till_dark = 8
      temperature = 8
      wind = 0
      precipitation_probability = 0.0

      assert "YES" ==
               Presenter.to_machine(%Today{
                 weather: %Condition{
                   temperature: temperature,
                   wind: wind,
                   precipitation_probability: precipitation_probability
                 },
                 hours_till_dark: till_dark
               })
    end

    test "weather is bad" do
      till_dark = 2
      temperature = 1
      wind = 10
      precipitation_probability = 0.9

      assert "NO" ==
               Presenter.to_machine(%Today{
                 weather: %Condition{
                   temperature: temperature,
                   wind: wind,
                   precipitation_probability: precipitation_probability
                 },
                 hours_till_dark: till_dark
               })
    end
  end
end
