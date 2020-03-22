Application.ensure_all_started(:simple_weather)
ExUnit.start()

Mox.defmock(SimpleWeather.DarkskyxAdapterMock, for: SimpleWeather.AdapterBehaviour)
Mox.defmock(SimpleWeather.DarkskyxMock, for: SimpleWeather.DarkskyxBehaviour)
