# SimpleWeather

[![codecov](https://codecov.io/gh/kiote/simple_weather/branch/master/graph/badge.svg)](https://codecov.io/gh/kiote/simple_weather)

Goes to weather provider and gets weather data for today + historical data for last week.
Suppose to provide data to IoT device with answers "is it safe to go bike riding today" question.

# Result

Open [`localhost:4000/api`](http:localhost:4000/api)

# Interpretation of result

```
000 0 0 0
 |  | | |
 |  | | --- weather in 7h from now
 |  | |     0 : no rain, no wind, sunny
 |  | |     2 : no rain, windy or cloudy
 |  | |     6 : no rain, extreme wind
 |  | |     10: little rain
 |  | |     20: medium rain
 |  | |     40: heavy rain or any other type of rain above with wind
 |  | |
 |  | ----- weather in 1h from now
 |  |       (same possible values as for 7h above)
 |  |
 |  ------- weather yesterday
 |          0: no rain
 |          2: small rain
 |          4: heavy rain
 |
 ---------- weather current week
            000: temperature during every night was +5 or more
            100: temperature yesterday night was less than +5
            50:  two nights ago it was less than +5 during the night
            20:  three nights ago temperature was less than +5
```

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
