---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- created at [24/05/2021 10:02]
---

RageUI = {};

---@class RageUIMenus
RageUIMenus = setmetatable({}, RageUIMenus)

---@return boolean
RageUIMenus.__call = function()
    return true
end

RageUIMenus.__index = RageUIMenus

RageUI.CurrentMenu = nil

RageUI.NextMenu = nil

RageUI.Options = 0

RageUI.ItemOffset = 0

RageUI.StatisticPanelCount = 0

RageUI.PoolMenus = RageUI.PoolMenus or {
    Timer = 0,
    Name = nil,
};

---@class Settings
RageUI.Settings = {
    Debug = false,
    Controls = {
        Up = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 172 },
                { 1, 172 },
                { 2, 172 },
                { 0, 241 },
                { 1, 241 },
                { 2, 241 },
            },
        },
        Down = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 173 },
                { 1, 173 },
                { 2, 173 },
                { 0, 242 },
                { 1, 242 },
                { 2, 242 },
            },
        },
        Left = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        Right = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        SliderLeft = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        SliderRight = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        Select = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 201 },
                { 1, 201 },
                { 2, 201 },
            },
        },
        Back = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 177 },
                { 1, 177 },
                { 2, 177 },
                { 0, 199 },
                { 1, 199 },
                { 2, 199 },
            },
        },
        Click = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 24 },
            },
        },
        Enabled = {
            Controller = {
                { 0, 2 }, -- Look Up and Down
                { 0, 1 }, -- Look Left and Right
                { 0, 25 }, -- Aim
                { 0, 24 }, -- Attack
            },
            Keyboard = {
                { 0, 201 }, -- Select
                { 0, 195 }, -- X axis
                { 0, 196 }, -- Y axis
                { 0, 187 }, -- Down
                { 0, 188 }, -- Up
                { 0, 189 }, -- Left
                { 0, 190 }, -- Right
                { 0, 202 }, -- Back
                { 0, 217 }, -- Select
                { 0, 242 }, -- Scroll down
                { 0, 241 }, -- Scroll up
                { 0, 239 }, -- Cursor X
                { 0, 240 }, -- Cursor Y
                { 0, 31 }, -- Move Up and Down
                { 0, 30 }, -- Move Left and Right
                { 0, 21 }, -- Sprint
                { 0, 22 }, -- Jump
                { 0, 23 }, -- Enter
                { 0, 75 }, -- Exit Vehicle
                { 0, 71 }, -- Accelerate Vehicle
                { 0, 72 }, -- Vehicle Brake
                { 0, 59 }, -- Move Vehicle Left and Right
                { 0, 89 }, -- Fly Yaw Left
                { 0, 9 }, -- Fly Left and Right
                { 0, 8 }, -- Fly Up and Down
                { 0, 90 }, -- Fly Yaw Right
                { 0, 76 }, -- Vehicle Handbrake
            },
        },
    },
    Audio = {
        Id = nil,
        UpDown = {
            audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
            audioRef = "NAV_UP_DOWN",
        },
        LeftRight = {
            audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
            audioRef = "NAV_LEFT_RIGHT",
        },
        Select = {
            audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
            audioRef = "SELECT",
        },
        Back = {
            audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
            audioRef = "BACK",
        },
        Error = {
            audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
            audioRef = "ERROR",
        },
        Slider = {
            audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
            audioRef = "CONTINUOUS_SLIDER",
            Id = nil
        },
    },
    Items = {
        Title = {
            Background = { Width = 431, Height = 107 },
            Text = { X = 215, Y = 20, Scale = 1.15 },
        },
        Subtitle = {
            Background = { Width = 431, Height = 37 },
            Text = { X = 8, Y = 3, Scale = 0.35 },
            PreText = { X = 425, Y = 3, Scale = 0.35 },
        },
        Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 0, Width = 431 },
        Navigation = {
            Rectangle = { Width = 431, Height = 18 },
            Offset = 5,
            Arrows = { Dictionary = "commonmenu", Texture = "shop_arrows_upanddown", X = 190, Y = -6, Width = 50, Height = 50 },
        },
        Description = {
            Bar = { Y = 4, Width = 431, Height = 4 },
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 30 },
            Text = { X = 8, Y = 10, Scale = 0.35 },
        },
    },
    Panels = {
        Grid = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 275 },
            Grid = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "nose_grid", X = 115.5, Y = 47.5, Width = 200, Height = 200 },
            Circle = { Dictionary = "mpinventory", Texture = "in_world_circle", X = 115.5, Y = 47.5, Width = 20, Height = 20 },
            Text = {
                Top = { X = 215.5, Y = 15, Scale = 0.35 },
                Bottom = { X = 215.5, Y = 250, Scale = 0.35 },
                Left = { X = 57.75, Y = 130, Scale = 0.35 },
                Right = { X = 373.25, Y = 130, Scale = 0.35 },
            },
        },
        Percentage = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 76 },
            Bar = { X = 9, Y = 50, Width = 413, Height = 10 },
            Text = {
                Left = { X = 25, Y = 15, Scale = 0.35 },
                Middle = { X = 215.5, Y = 15, Scale = 0.35 },
                Right = { X = 398, Y = 15, Scale = 0.35 },
            },
        },
    },
}

function RageUI.GetSafeZoneBounds()
    local SafeSize = GetSafeZoneSize()
    SafeSize = math.round(SafeSize, 2)
    SafeSize = (SafeSize * 100) - 90
    SafeSize = 10 - SafeSize

    local W, H = GetActiveScreenResolution()

    return { X = math.round(SafeSize * ((W / H) * 5.4)), Y = math.round(SafeSize * 5.4) }
end

function RageUI.Visible(Menu, Value)
    if Menu ~= nil and Menu() then
        if Value == true or Value == false then
            if Value then
                if RageUI.CurrentMenu ~= nil then
                    if RageUI.CurrentMenu.Closed ~= nil then
                        RageUI.CurrentMenu.Closed()
                    end
                    RageUI.CurrentMenu.Open = not Value
                    Menu:UpdateInstructionalButtons(Value);
                end
                RageUI.CurrentMenu = Menu
            else
                RageUI.CurrentMenu = nil
            end
            Menu.Open = Value
            RageUI.Options = 0
            RageUI.ItemOffset = 0
            RageUI.LastControl = false
        else
            return Menu.Open
        end
    end
end

function RageUI.CloseAll()
    if RageUI.CurrentMenu ~= nil then
        local parent = RageUI.CurrentMenu.Parent
        while parent ~= nil do
            parent.Index = 1
            parent.Pagination.Minimum = 1
            parent.Pagination.Maximum = parent.Pagination.Total
            parent = parent.Parent
        end
        RageUI.CurrentMenu.Index = 1
        RageUI.CurrentMenu.Pagination.Minimum = 1
        RageUI.CurrentMenu.Pagination.Maximum = RageUI.CurrentMenu.Pagination.Total
        RageUI.CurrentMenu.Open = false
        RageUI.CurrentMenu = nil
    end
    RageUI.Options = 0
    RageUI.ItemOffset = 0
    ResetScriptGfxAlign()
end

function RageUI.Banner()
    local CurrentMenu = RageUI.CurrentMenu
    if (CurrentMenu.Display.Header) then
        RageUI.ItemsSafeZone(CurrentMenu)
        if CurrentMenu.Sprite ~= nil then
            if CurrentMenu.Sprite.Dictionary ~= nil then
                if CurrentMenu.Sprite.Dictionary == "commonmenu" then
                    Graphics.Sprite(CurrentMenu.Sprite.Dictionary, CurrentMenu.Sprite.Texture, CurrentMenu.X, CurrentMenu.Y, RageUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, RageUI.Settings.Items.Title.Background.Height, CurrentMenu.Sprite.Color.R, CurrentMenu.Sprite.Color.G, CurrentMenu.Sprite.Color.B, CurrentMenu.Sprite.Color.A)
                else
                    Graphics.Sprite(CurrentMenu.Sprite.Dictionary, CurrentMenu.Sprite.Texture, CurrentMenu.X, CurrentMenu.Y, RageUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, RageUI.Settings.Items.Title.Background.Height, nil)
                end
            else
                Graphics.Rectangle(CurrentMenu.X, CurrentMenu.Y, RageUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, RageUI.Settings.Items.Title.Background.Height, CurrentMenu.Rectangle.R, CurrentMenu.Rectangle.G, CurrentMenu.Rectangle.B, CurrentMenu.Rectangle.A)
            end
        else
            Graphics.Rectangle(CurrentMenu.X, CurrentMenu.Y, RageUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, RageUI.Settings.Items.Title.Background.Height, CurrentMenu.Rectangle.R, CurrentMenu.Rectangle.G, CurrentMenu.Rectangle.B, CurrentMenu.Rectangle.A)
        end
        Graphics.Text(CurrentMenu.Title, CurrentMenu.X + RageUI.Settings.Items.Title.Text.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Items.Title.Text.Y, CurrentMenu.TitleFont, CurrentMenu.TitleScale, 255, 255, 255, 255, 1)
        RageUI.ItemOffset = RageUI.ItemOffset + RageUI.Settings.Items.Title.Background.Height
    end
end

function RageUI.Subtitle()
    local CurrentMenu = RageUI.CurrentMenu
    if (CurrentMenu.Display.Subtitle) then
        RageUI.ItemsSafeZone(CurrentMenu)
        if CurrentMenu.Subtitle ~= "" then
            Graphics.Rectangle(CurrentMenu.X, CurrentMenu.Y + RageUI.ItemOffset, RageUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset, RageUI.Settings.Items.Subtitle.Background.Height + CurrentMenu.SubtitleHeight, 0, 0, 0, 255)
            Graphics.Text(CurrentMenu.PageCounterColour .. CurrentMenu.Subtitle, CurrentMenu.X + RageUI.Settings.Items.Subtitle.Text.X, CurrentMenu.Y + RageUI.Settings.Items.Subtitle.Text.Y + RageUI.ItemOffset, 0, RageUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, RageUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset)
            if CurrentMenu.Index > CurrentMenu.Options or CurrentMenu.Index < 0 then
                CurrentMenu.Index = 1
            end
            if (CurrentMenu ~= nil) then
                if (CurrentMenu.Index > CurrentMenu.Pagination.Total) then
                    local offset = CurrentMenu.Index - CurrentMenu.Pagination.Total
                    CurrentMenu.Pagination.Minimum = 1 + offset
                    CurrentMenu.Pagination.Maximum = CurrentMenu.Pagination.Total + offset
                else
                    CurrentMenu.Pagination.Minimum = 1
                    CurrentMenu.Pagination.Maximum = CurrentMenu.Pagination.Total
                end
            end

            if CurrentMenu.Display.PageCounter then
                if CurrentMenu.PageCounter == nil then
                    Graphics.Text(CurrentMenu.PageCounterColour .. CurrentMenu.Index .. " / " .. CurrentMenu.Options, CurrentMenu.X + RageUI.Settings.Items.Subtitle.PreText.X + CurrentMenu.WidthOffset, CurrentMenu.Y + RageUI.Settings.Items.Subtitle.PreText.Y + RageUI.ItemOffset, 0, RageUI.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                else
                    Graphics.Text(CurrentMenu.PageCounter, CurrentMenu.X + RageUI.Settings.Items.Subtitle.PreText.X + CurrentMenu.WidthOffset, CurrentMenu.Y + RageUI.Settings.Items.Subtitle.PreText.Y + RageUI.ItemOffset, 0, RageUI.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                end
            end
            RageUI.ItemOffset = RageUI.ItemOffset + RageUI.Settings.Items.Subtitle.Background.Height
        end
    end
end

function RageUI.Background()
    local CurrentMenu = RageUI.CurrentMenu;
    if (CurrentMenu.Display.Background) then
        RageUI.ItemsSafeZone(CurrentMenu)
        SetScriptGfxDrawOrder(0)
        Graphics.Sprite(RageUI.Settings.Items.Background.Dictionary, RageUI.Settings.Items.Background.Texture, CurrentMenu.X, CurrentMenu.Y + RageUI.Settings.Items.Background.Y + CurrentMenu.SubtitleHeight, RageUI.Settings.Items.Background.Width + CurrentMenu.WidthOffset, RageUI.ItemOffset, 0, 0, 0, 0, 255)
        SetScriptGfxDrawOrder(1)
    end
end

function RageUI.Description()
    local CurrentMenu = RageUI.CurrentMenu;
    local Description = RageUI.Settings.Items.Description;
    if CurrentMenu.Description ~= nil then
        RageUI.ItemsSafeZone(CurrentMenu)
        Graphics.Rectangle(CurrentMenu.X, CurrentMenu.Y + Description.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Description.Bar.Width + CurrentMenu.WidthOffset, Description.Bar.Height, 0, 0, 0, 255)
        Graphics.Sprite(Description.Background.Dictionary, Description.Background.Texture, CurrentMenu.X, CurrentMenu.Y + Description.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Description.Background.Width + CurrentMenu.WidthOffset, CurrentMenu.DescriptionHeight, 0, 0, 0, 255)
        Graphics.Text(CurrentMenu.Description, CurrentMenu.X + Description.Text.X, CurrentMenu.Y + Description.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Description.Text.Scale, 255, 255, 255, 255, nil, false, false, Description.Background.Width + CurrentMenu.WidthOffset - 8.0)
        RageUI.ItemOffset = RageUI.ItemOffset + CurrentMenu.DescriptionHeight + Description.Bar.Y
    end
end

function RageUI.Render()
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu.Safezone then
        ResetScriptGfxAlign()
    end

    if (CurrentMenu.Display.InstructionalButton) then
        if not CurrentMenu.InitScaleform then
            CurrentMenu:UpdateInstructionalButtons(true)
            CurrentMenu.InitScaleform = true
        end
        DrawScaleformMovieFullscreen(CurrentMenu.InstructionalScaleform, 255, 255, 255, 255, 0)
    end
    CurrentMenu.Options = RageUI.Options
    CurrentMenu.SafeZoneSize = nil
    RageUI.Controls()
    RageUI.Options = 0
    RageUI.StatisticPanelCount = 0
    RageUI.ItemOffset = 0
    if CurrentMenu.Controls.Back.Enabled then
        if CurrentMenu.Controls.Back.Pressed and CurrentMenu.Closable then
            CurrentMenu.Controls.Back.Pressed = false

            Audio.PlaySound(RageUI.Settings.Audio.Back.audioName, RageUI.Settings.Audio.Back.audioRef)

            if CurrentMenu.Closed ~= nil then
                collectgarbage()
                CurrentMenu.Closed()
            end

            if CurrentMenu.Parent ~= nil then
                if CurrentMenu.Parent() then
                    RageUI.NextMenu = CurrentMenu.Parent
                else
                    RageUI.NextMenu = nil
                    RageUI.Visible(CurrentMenu, false)
                end
            else
                RageUI.NextMenu = nil
                RageUI.Visible(CurrentMenu, false)
            end
        elseif CurrentMenu.Controls.Back.Pressed and not CurrentMenu.Closable then
            CurrentMenu.Controls.Back.Pressed = false
        end
    end
    if RageUI.NextMenu ~= nil then
        if RageUI.NextMenu() then
            RageUI.Visible(CurrentMenu, false)
            RageUI.Visible(RageUI.NextMenu, true)
            CurrentMenu.Controls.Select.Active = false
            RageUI.NextMenu = nil
            RageUI.LastControl = false
        end
    end
end

function RageUI.ItemsDescription(Description)
    local CurrentMenu = RageUI.CurrentMenu;
    if Description ~= "" or Description ~= nil then
        if CurrentMenu.Description ~= Description then
            CurrentMenu.Description = Description or nil;
            local SettingsDescription = RageUI.Settings.Items.Description;
            local DescriptionLineCount = Graphics.GetLineCount(CurrentMenu.Description, CurrentMenu.X + SettingsDescription.Text.X, CurrentMenu.Y + SettingsDescription.Text.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, SettingsDescription.Text.Scale, 255, 255, 255, 255, nil, false, false, SettingsDescription.Background.Width + (CurrentMenu.WidthOffset - 5.0))
            if DescriptionLineCount > 1 then
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height * DescriptionLineCount
            else
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height + 7
            end
        end
    else
        CurrentMenu.Description = nil;
    end
end

function RageUI.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton)
    local Hovered = false
    Hovered = Graphics.IsMouseInBounds(CurrentMenu.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height)
    if Hovered and not Selected then
        Graphics.Rectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height, 255, 255, 255, 20)
        if CurrentMenu.Controls.Click.Active then
            CurrentMenu.Index = Option

            Audio.PlaySound(RageUI.Settings.Audio.UpDown.audioName, RageUI.Settings.Audio.UpDown.audioRef)
        end
    end
    return Hovered;
end

function RageUI.ItemsSafeZone(CurrentMenu)
    if not CurrentMenu.SafeZoneSize then
        CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }
        if CurrentMenu.Safezone then
            CurrentMenu.SafeZoneSize = RageUI.GetSafeZoneBounds()
            SetScriptGfxAlign(76, 84)
            SetScriptGfxAlignParams(0, 0, 0, 0)
        end
    end
end

function RageUI.Pool()
    for name, callback in pairs(RageUI.PoolMenus) do
        if type(callback) == "function" and name ~= RageUI.PoolMenus.Name then
            callback()
            if RageUI.PoolMenus.Timer == 1 then
                RageUI.PoolMenus.Name = name
                return
            end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        RageUI.PoolMenus.Timer = 250
        if RageUI.PoolMenus.Name ~= nil then
            RageUI.PoolMenus[RageUI.PoolMenus.Name]()
        end
        Citizen.Wait(RageUI.PoolMenus.Timer)
        if RageUI.PoolMenus.Timer == 250 then
            RageUI.PoolMenus.Name = nil
            RageUI.Pool();
        end
    end
end)
