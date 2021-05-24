---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- created at [24/05/2021 10:02]
---

local MainMenu = RageUI.CreateMenu("Title", "SUBTITLE");
MainMenu.EnableMouse = true;

local Checked = false;

local GridX, GridY = 0, 0

function RageUI.PoolMenus:Example()
	MainMenu:IsVisible(function(Items)
		Items:Heritage(1, 2)
		Items:AddButton("Hello world", "Hello world.", { IsDisable = false }, function(onSelected, onHovered, onActive)

		end)
		Items:AddSeparator("Separator")
		Items:CheckBox("Hello", "Descriptions", Checked, { Style = 1 }, function(onSelected, IsChecked, onHovered)
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
end

Keys.Register("E", "E", "Test", function()
	RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
end)
