#!/usr/bin/lua
-- load the http socket module
http = require("socket.http")
-- load the json module
json = require("json")

api_url = "https://api.openweathermap.org/data/2.5/weather?"

-- http://openweathermap.org/help/city_list.txt , http://openweathermap.org/find
cityName = "Milan"

-- metric or imperial
cf = "metric"

-- get an open weather map api key: http://openweathermap.org/appid
apikey = "561d8a25973a0ff4248c909551dc5ce8"

-- measure is °C if metric and °F if imperial
measure = '°' .. (cf == 'metric' and 'C' or 'F')
wind_units = (cf == 'metric' and 'kph' or 'mph')

currenttime = os.date("!%Y%m%d%H%M%S")

file_exists = function (name)
    f=io.open(name,"r")
    if f~=nil then
        io.close(f)
        return true
    else
        return false
    end
end

if file_exists("weather.json") then
    cache = io.open("weather.json","r")
    data = json.decode(cache:read())
    cache.close(cache)
    timepassed = os.difftime(currenttime, data.timestamp)
else
    timepassed = 6000
end

makecache = function (s)
    cache = io.open("weather.json", "w+")
    s.timestamp = currenttime
    save = json.encode(s)
    cache:write(save)
    cache.close(cache)
end

if timepassed < 3600 then
    response = data
else
    url = ("%sq=%s&units=%s&appid=%s"):format(api_url, cityName, cf, apikey)
    weather = http.request(url)
    if weather then
        response = json.decode(weather)
        makecache(response)
    else
        response = data
    end
end

math.round = function (n)
    return math.floor(n + 0.5)
end

degrees_to_direction = function (d)
    val = math.round(d/22.5)
    directions={"N","NNE","NE","ENE",
                "E","ESE", "SE", "SSE",
                "S","SSW","SW","WSW",
                "W","WNW","NW","NNW"}
    return directions[val % 16]
end

temp = response.main.temp
conditions = response.weather[1].description
icon = response.weather[1].id
humidity = response.main.humidity
wind = response.wind.speed
deg = degrees_to_direction(response.wind.deg)
sunrise = os.date("%H:%M %p", response.sys.sunrise)
sunset = os.date("%H:%M %p", response.sys.sunset)

conky_text = [[
${image ~/.config/conky/icons/%s.png -p 60,170 -s 80x80}${color1}${font :size=20} ${offset 50}${voffset 22}%s${font}${voffset -8}%s${color}
${alignc}${voffset 28} %s
${voffset 10}${alignc}Humidity: ${color1}%s%%${color}
${alignc}    Wind:  ${color1}%s%s %s${color}
${voffset 10}${alignc}${image ~/.config/conky/icons/sunrise.png -p 15,325 -s 32x32}      %s         ${image ~/.config/conky/icons/sunset.png -p 135,325 -s 32x32}%s
]]

io.write((conky_text):format(icon,
                             math.round(temp),
                             measure,
                             conditions,
                             humidity,
                             math.round(wind),
                             wind_units,
                             deg,
                             sunrise,
                              sunset)
)
