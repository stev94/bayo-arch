#!/usr/bin/lua
https = require("ssl.https")
json = require("json")

-- To use edit variables below for your timezone and location then add the next line to your conky config, uncommented
-- ${alignc}${execpi 3600 ~/.config/conky/moonphase.lua}

-- Change to your timezone offset
tz = "-0"

-- Change to the lattitude and longitude you want to use
lat = "51.5"
long = "-0.116667"

curdate = os.date("!%Y%m%d")
curtime = os.date("!%Y%m%d%H%M%S")

api_url = ("https://api.solunar.org/solunar/%s,%s,%s,%s"):format(lat,long,curdate,tz)

moon = {
  ["New Moon"] = "🌑",
  ["Waxing Crescent"] = "🌒",
  ["First Quarter"] = "🌓",
  ["Waxing Gibbous"] = "🌔",
  ["Full moon"] = "🌕",
  ["Waning Gibbous"] = "🌖",
  ["Third Quarter"] = "🌗",
  ["Waning Crescent"] = "🌘"
}

file_exists = function (name)
    f=io.open(name,"r")
    if f~=nil then
        f:close()
        return true
    else
        return false
    end
end

if file_exists("moonphase.json") then
    cache = io.open("moonphase.json","r")
    data = json.decode(cache:read())
    cache:close()
    timepassed = os.difftime(curtime, data.timestamp)
else
    timepassed = 6000
end
makecache = function (s)
    cache = io.open("moonphase.json", "w+")
    s.timestamp = curtime
    save = json.encode(s)
    cache:write(save)
    cache:close()
end

if timepassed < 3600 then
    response = data
else
    mooninfo = https.request(api_url)
    if mooninfo then
        response = json.decode(mooninfo)
        makecache(response)
    else
        response = data
    end
end

phase = response.moonPhase

conky_text = [[${font Symbola:size=20}%s${font} %s]]

io.write((conky_text):format(moon[phase], phase))
