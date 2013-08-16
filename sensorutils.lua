function toJSON(object)
  local s = ""

  if (object == nil) then
    return "null" 
	end
		
  if (type(object) == "table") then
    s = s .. "{"
    local firstElement = true

    for k, v in pairs(object) do
      if (firstElement) then
        s = s .. "\"" .. k .. "\" : " .. toJSON(v)
        firstElement = false
      else
        s = s .. ", \"" ..  k .. "\" : " .. toJSON(v)
      end
    end

    s = s .. "}"
  elseif (type(object) == "string") then
    s = s .. "\"" .. tostring(object) .. "\""
  else
    s = s .. tostring(object)
  end

  return s
end

function toFile(s, filename)

  local file = io.open(filename, "a")
  file:write(s)
  file:flush()
  file:close()

end

function sensorDataToFile(filename)

  os.loadAPI("ocs/apis/sensor")
  local m = sensor.wrap("right")
  local t = m.getTargets()

  toFile("{", filename)

  local firstElement = true

  for k,v in pairs(t) do
    if (firstElement) then 
      toFile("\"" .. k .. "\" : " .. toJSON(m.getTargetDetails(k)), filename)
      firstElement = false
    else
      toFile(" , \"" .. k .. "\" : " .. toJSON(m.getTargetDetails(k)), filename)
    end
  end

  toFile("}", filename)

end