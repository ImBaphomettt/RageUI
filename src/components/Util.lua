---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- File created at [24/05/2021 09:57]
---

function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end