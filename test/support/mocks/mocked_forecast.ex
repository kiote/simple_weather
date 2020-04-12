defmodule Support.MockedForecast do
  def mocked_forecast do
    %{
      latitude: 42.3601,
      longitude: -71.0589,
      currently: %{
        time: 1_509_993_277,
        summary: "Drizzle",
        nearestStormDistance: 0,
        precipIntensity: 0.0089,
        precipIntensityError: 0.0046,
        precipProbability: 0.9,
        precipType: "rain",
        temperature: 66.1,
        apparentTemperature: 66.31,
        dewPoint: 60.77,
        humidity: 0.83,
        pressure: 1010.34,
        windSpeed: 5.59,
        windGust: 12.03,
        windBearing: 246,
        cloudCover: 0.7,
        uvIndex: 1,
        visibility: 9.84,
        ozone: 267.44
      },
      hourly: %{
        summary: "Rain starting later this afternoon, continuing until this evening.",
        icon: "rain",
        data: [
          %{
            time: 1_509_991_200,
            summary: "Mostly Cloudy",
            icon: "partly-cloudy-day",
            precipIntensity: 0.0007,
            precipProbability: 0.1,
            precipType: "rain",
            temperature: 65.76,
            apparentTemperature: 66.01,
            dewPoint: 60.99,
            humidity: 0.85,
            pressure: 1010.57,
            windSpeed: 4.23,
            windGust: 9.52,
            windBearing: 230,
            cloudCover: 0.62,
            uvIndex: 1,
            visibility: 9.32,
            ozone: 268.95
          },
          %{
            time: 1_509_991_300,
            summary: "Mostly Cloudy",
            icon: "partly-cloudy-day",
            precipIntensity: 0.0007,
            precipProbability: 0.1,
            precipType: "rain",
            temperature: 65.76,
            apparentTemperature: 66.01,
            dewPoint: 60.99,
            humidity: 0.85,
            pressure: 1010.57,
            windSpeed: 4.23,
            windGust: 9.52,
            windBearing: 230,
            cloudCover: 0.62,
            uvIndex: 1,
            visibility: 9.32,
            ozone: 268.95
          }
        ]
      }
    }
  end
end
