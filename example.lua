---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- created at [24/05/2021 10:02]
---

local MainMenu = RageUI.CreateMenu("RageUI-RedM", "Hello, it's baphomet");
MainMenu.EnableMouse = false;

local SubMenu = RageUI.CreateSubMenu(MainMenu, "Weather", "WEATHER")

local CAMERA_NOCLIP = nil;

local NOCLIP_ENABLED = false;

local NOCLIP_SPEED = 1.0

local Ped = PlayerPedId()

local function SetWeatherType(weatherHash, p1, p2, overrideNetwork, transitionTime, p5)
    Citizen.InvokeNative(0x59174F1AFE095B5A, weatherHash, true, false, true, transitionTime, false)
end

local function ToggleNoClip(bool)
    if (bool) then
        if (CAMERA_NOCLIP == nil) then
            CAMERA_NOCLIP = CreateCamera(GetHashKey("DEFAULT_SCRIPTED_CAMERA"), true)
        end
        SetCamActive(CAMERA_NOCLIP, true)
        SetCamCoord(CAMERA_NOCLIP, GetEntityCoords(Ped))
        RenderScriptCams(true, false, 0, true, true)
        FreezeEntityPosition(Ped, true)
        SetEntityInvincible(Ped, true)
        SetEntityVisible(Ped, false)
        NOCLIP_ENABLED = true
    else
        local CAM_COORD = GetCamCoord(CAMERA_NOCLIP)
        DestroyCam(CAMERA_NOCLIP)
        RenderScriptCams(false, false, 0, false, false)
        FreezeEntityPosition(Ped, false)
        SetEntityCoords(Ped, CAM_COORD.x, CAM_COORD.y, CAM_COORD.z)
        SetEntityInvincible(Ped, false)
        SetEntityVisible(Ped, true)
        CAMERA_NOCLIP = nil;
        NOCLIP_ENABLED = false;
    end
end

local WEATHER_LIST = {
    "BLIZZARD",
    "MISTY",
    "SUNNY",
    "HIGHPRESSURE",
    "CLEARING",
    "SLEET",
    "DRIZZLE",
    "SHOWER",
    "SNOWCLEARING",
    "OVERCASTDARK",
    "THUNDERSTORM",
    "SANDSTORM",
    "SNOW",
}

function RageUI.PoolMenus:Example()
    MainMenu:IsVisible(function(Items)
        Items:AddButton("Hello world", "Sub Menuub Menuub Menuub Menuub Menuub Menuub Menuub Menuub Menu", { IsDisabled = false }, function(onSelected)
            if (onSelected) then

            end
        end)
        Items:CheckBox("No-Clip", nil, NOCLIP_ENABLED, {}, function(onSelected, IsChecked)
            if (onSelected) then
                NOCLIP_ENABLED = IsChecked
                ToggleNoClip(IsChecked)
            end
        end)
        Items:AddButton("Weather control.", "Sub Menuub Menuub Menuub Menuub Menuub Menuub Menuub Menuub Menu", { IsDisabled = false }, function(onSelected)

        end, SubMenu)
    end, function(Panels)

    end)

    SubMenu:IsVisible(function(Items)
        -- Items

        for i, v in pairs(WEATHER_LIST) do
            Items:AddButton(v, "Hello world.", { IsDisabled = false }, function(onSelected)
                if (onSelected) then
                    SetWeatherType(GetHashKey(v), true, false, true, 50000, false)
                end
            end)
        end
    end, function()
        -- Panels
    end)
end

local function RotationToDirection(rotation)
    local adjustedRotation =
    {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction =
    {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

Citizen.CreateThread(function()
    local Global = 0;
    while true do
        Citizen.Wait(1)
        local cGameTimer = GetGameTimer()

        if (IsControlJustPressed(0, 0xCEFD9220)) then
            RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
        end
        if (Global + 300 < cGameTimer) then
            Global = cGameTimer
            Ped = PlayerPedId()
        end

        if (NOCLIP_ENABLED) then


            local camCoords = GetCamCoord(CAMERA_NOCLIP)
            SetEntityRotation(Ped, GetCamRot(CAMERA_NOCLIP))
            if IsControlPressed(1, 0x8FD015D8) then
                local newCamPos = camCoords + GetEntityForwardVector(Ped) * 1.0
                SetCamCoord(CAMERA_NOCLIP, newCamPos.x, newCamPos.y, newCamPos.z)
                SetEntityCoords(Ped, newCamPos.x, newCamPos.y, newCamPos.z)
            end

            if IsControlPressed(0, 0xF1F9CD26) then
                if (NOCLIP_SPEED - 0.1 >= 0.1) then
                    NOCLIP_SPEED = NOCLIP_SPEED - 0.1
                end
            end
            if IsControlPressed(0, 0x2B981F4F) then
                if (NOCLIP_SPEED + 0.1 >= 0.1) then
                    NOCLIP_SPEED = NOCLIP_SPEED + 0.1
                end
            end

            local xMagnitude = GetDisabledControlNormal(0, 0xA987235F)
            local yMagnitude = GetDisabledControlNormal(0, 0xD2047988)
            local camRot = GetCamRot(CAMERA_NOCLIP)
            local x = camRot.x - yMagnitude * 10
            local y = camRot.y
            local z = camRot.z - xMagnitude * 10
            if x < -75.0 then
                x = -75.0
            end
            if x > 100.0 then
                x = 100.0
            end
            SetCamRot(CAMERA_NOCLIP, x, y, z)
        end

    end
end)
