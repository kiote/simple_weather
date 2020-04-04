# SimpleWeather

[![codecov](https://codecov.io/gh/kiote/simple_weather/branch/master/graph/badge.svg)](https://codecov.io/gh/kiote/simple_weather)

Goes to weather provider and gets weather data for today + historical data.
Suppose to provide data to IoT device with answers "is it safe to go bike riding today" question.

# Result

Open [`localhost:4000/api`](http:localhost:4000/api)

# Interpretation of result

There are 6 numbers in a row with possible values 0, 4, 8 for each.

0 - very good conditions, temperature > +5 and no preciptions
4 - moderate conditions, either too cold or probable rain
8 - severe conditions, both too cold and preciptions

1st number: now
2nd: 2 hours from now
3rd: 7 hours from now
4th: yesterday
5th: the day before yesterday
6th: two days before

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

# Darkskyx

`export DARKSKY_API_KEY=<api_key>`

# Build a new version

```
docker build --tag simple-wather:1.0 .
docker save -o ~/Sandbox/simple_weather/out.tar simple-wather:1.0
scp out.tar pi@raspberry
# on raspberry
docker load -i out.tar
docker run simple_weather:1.0
```
