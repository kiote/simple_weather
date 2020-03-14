Application.ensure_all_started(:simple_weather)
ExUnit.start()

Mox.defmock(SimpleWeather.DarkSkyxAdapterMock, for: SimpleWeather.AdapterBehaviour)
