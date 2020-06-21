# SimpleWeather

[![codecov](https://codecov.io/gh/kiote/simple_weather/branch/master/graph/badge.svg)](https://codecov.io/gh/kiote/simple_weather)

Goes to weather provider and gets weather data for today.
Suppose to provide data to IoT device with answers "is it safe to go bike riding today" question.

# Result

Open [`localhost:4000/api`](http:localhost:4000/api)

# Running

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

# Darkskyx

`export DARKSKY_API_KEY=<api_key>`

# Build a new version

API KEY needs to be exported before building a release

```
MIX_ENV=prod mix release prod
_build/prod/rel/prod/bin/prod start
# or
(exec  _build/prod/rel/prod/bin/prod start &> /tmp/logs &)
```
