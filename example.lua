---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- created at [24/05/2021 10:02]
---

local MainMenu = RageUI.CreateMenu("Title", "SUBTITLE");
MainMenu.EnableMouse = true;

local SubMenu = RageUI.CreateSubMenu(MainMenu, "Title", "SubTitle")

local Checked = false;
local ListIndex = 1;

local GridX, GridY = 0, 0

function RageUI.PoolMenus:Example()
	MainMenu:IsVisible(function(Items)
		Items:Heritage(1, 2)
		Items:AddButton("Sub Menu", "Sub Menu", { IsDisabled = false }, function(onSelected)
	
		end, SubMenu)
		Items:AddButton("Hello world", "Hello world.", { IsDisabled = false }, function(onSelected)

		end)
		Items:AddList("List", { 1, 2, 3 }, ListIndex, nil, { IsDisabled = false }, function(Index, onSelected, onListChange)
			if (onListChange) then
				ListIndex = Index;
			end
		end)
		Items:AddSeparator("Separator")
		Items:CheckBox("Hello", "Descriptions", Checked, { Style = 1 }, function(onSelected, IsChecked)
			if (onSelected) then
				Checked = IsChecked
			end
		end)


	end, function(Panels)
		Panels:Grid(GridX, GridY, "Top", "Bottom", "Left", "Right", function(X, Y, CharacterX, CharacterY)
			GridX = X;
			GridY = Y;
		end, 1)
	end)

	SubMenu:IsVisible(function(Items)
		-- Items
		Items:AddButton("Hello world", "Hello world.", { IsDisabled = false }, function(onSelected)

		end)
	end, function()
		-- Panels
	end)
end

Keys.Register("E", "E", "Test", function()
	RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
end)
