---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- File created at [24/05/2021 00:00]
---

local function StringToArray(str)
    local charCount = #str
    local strCount = math.ceil(charCount / 99)
    local strings = {}

    for i = 1, strCount do
        local start = (i - 1) * 99 + 1
        local clamp = math.clamp(#string.sub(str, start), 0, 99)
        local finish = ((i ~= 1) and (start - 1) or 0) + clamp

        strings[i] = string.sub(str, start, finish)
    end

    return strings
end

local function AddText(str)
    local str = tostring(str)
    local charCount = #str

    if charCount < 100 then
        AddTextComponentSubstringPlayerName(str)
    else
        local strings = StringToArray(str)
        for s = 1, #strings do
            AddTextComponentSubstringPlayerName(strings[s])
        end
    end
end

local function RText(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    local Text, X, Y = text, (x or 0) / 1920, (y or 0) / 1080
    SetTextFont(font or 0)
    SetTextScale(1.0, scale or 0)
    SetTextColour(r or 255, g or 255, b or 255, a or 255)
    if dropShadow then
        SetTextDropShadow()
    end
    if outline then
        SetTextOutline()
    end
    if alignment ~= nil then
        if alignment == 1 or alignment == "Center" or alignment == "Centre" then
            SetTextCentre(true)
        elseif alignment == 2 or alignment == "Right" then
            SetTextRightJustify(true)
        end
    end
    if wordWrap and wordWrap ~= 0 then
        if alignment == 1 or alignment == "Center" or alignment == "Centre" then
            SetTextWrap(X - ((wordWrap / 1920) / 2), X + ((wordWrap / 1920) / 2))
        elseif alignment == 2 or alignment == "Right" then
            SetTextWrap(0, X)
        else
            SetTextWrap(X, X + (wordWrap / 1920))
        end
    else
        if alignment == 2 or alignment == "Right" then
            SetTextWrap(0, X)
        end
    end
    return Text, X, Y
end

Graphics = {};

function Graphics.MeasureStringWidth(str, font, scale)
    BeginTextCommandGetWidth("CELL_EMAIL_BCON")
    AddTextComponentSubstringPlayerName(str)
    SetTextFont(font or 0)
    SetTextScale(1.0, scale or 0)
    return EndTextCommandGetWidth(true) * 1920
end

function Graphics.Rectangle(x, y, width, height, r, g, b, a)
    local X, Y, Width, Height = (x or 0) / 1920, (y or 0) / 1080, (width or 0) / 1920, (height or 0) / 1080
    DrawRect(X + Width * 0.5, Y + Height * 0.5, Width, Height, r or 255, g or 255, b or 255, a or 255)
end

function Graphics.Sprite(dictionary, name, x, y, width, height, heading, r, g, b, a)
    local X, Y, Width, Height = (x or 0) / 1920, (y or 0) / 1080, (width or 0) / 1920, (height or 0) / 1080

    if not HasStreamedTextureDictLoaded(dictionary) then
        RequestStreamedTextureDict(dictionary, true)
    end

    DrawSprite(dictionary, name, X + Width * 0.5, Y + Height * 0.5, Width, Height, heading or 0, r or 255, g or 255, b or 255, a or 255)
end

function Graphics.GetLineCount(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    local Text, X, Y = RText(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    BeginTextCommandLineCount("CELL_EMAIL_BCON")
    AddText(Text)
    return EndTextCommandLineCount(X, Y)
end

function Graphics.Text(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    local Text, X, Y = RText(text, x, y, font, scale, r, g, b, a, alignment, dropShadow, outline, wordWrap)
    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    AddText(Text)
    EndTextCommandDisplayText(X, Y)
end

function Graphics.IsMouseInBounds(X, Y, Width, Height)
    local MX, MY = math.round(GetControlNormal(2, 239) * 1920) / 1920, math.round(GetControlNormal(2, 240) * 1080) / 1080
    X, Y = X / 1920, Y / 1080
    Width, Height = Width / 1920, Height / 1080
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

function Graphics.ConvertToPixel(x, y)
    return (x * 1920), (y * 1080)
end

function Graphics.ScreenToWorld(distance, flags)
    local camRot = GetGameplayCamRot(0)
    local camPos = GetGameplayCamCoord()
    local mouse = vector2(GetControlNormal(2, 239), GetControlNormal(2, 240))
    local cam3DPos, forwardDir = Graphics.ScreenRelToWorld(camPos, camRot, mouse)
    local direction = camPos + forwardDir * distance
    local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(cam3DPos, direction, flags, 0, 0)
    local _, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    return (hit == 1 and true or false), endCoords, surfaceNormal, entityHit, (entityHit >= 1 and GetEntityType(entityHit) or 0), direction, mouse
end

function Graphics.ScreenRelToWorld(camPos, camRot, cursor)
    local camForward = Graphics.RotationToDirection(camRot)
    local rotUp = vector3(camRot.x + 1.0, camRot.y, camRot.z)
    local rotDown = vector3(camRot.x - 1.0, camRot.y, camRot.z)
    local rotLeft = vector3(camRot.x, camRot.y, camRot.z - 1.0)
    local rotRight = vector3(camRot.x, camRot.y, camRot.z + 1.0)
    local camRight = Graphics.RotationToDirection(rotRight) - Graphics.RotationToDirection(rotLeft)
    local camUp = Graphics.RotationToDirection(rotUp) - Graphics.RotationToDirection(rotDown)
    local rollRad = -(camRot.y * math.pi / 180.0)
    local camRightRoll = camRight * math.cos(rollRad) - camUp * math.sin(rollRad)
    local camUpRoll = camRight * math.sin(rollRad) + camUp * math.cos(rollRad)
    local point3DZero = camPos + camForward * 1.0
    local point3D = point3DZero + camRightRoll + camUpRoll
    local point2D = Graphics.World3DToScreen2D(point3D)
    local point2DZero = Graphics.World3DToScreen2D(point3DZero)
    local scaleX = (cursor.x - point2DZero.x) / (point2D.x - point2DZero.x)
    local scaleY = (cursor.y - point2DZero.y) / (point2D.y - point2DZero.y)
    local point3Dret = point3DZero + camRightRoll * scaleX + camUpRoll * scaleY
    local forwardDir = camForward + camRightRoll * scaleX + camUpRoll * scaleY
    return point3Dret, forwardDir
end

function Graphics.RotationToDirection(rotation)
    local x, z = (rotation.x * math.pi / 180.0), (rotation.z * math.pi / 180.0)
    local num = math.abs(math.cos(x))
    return vector3((-math.sin(z) * num), (math.cos(z) * num), math.sin(x))
end

function Graphics.World3DToScreen2D(pos)
    local _, sX, sY = GetScreenCoordFromWorldCoord(pos.x, pos.y, pos.z)
    return vector2(sX, sY)
end