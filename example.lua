---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- created at [24/05/2021 10:02]
---

local MainMenu = RageUI.CreateMenu("Title", "SUBTITLE");

local Checked = false;

function RageUI.PoolMenus:Example()
	MainMenu:IsVisible(function(Items)
		Items:AddButton("Hello world", "Hello world.", {}, function(onSelected, onHovered, onActive)

		end)
		Items:AddSeparator("Separator")
		Items:CheckBox("Hello", "Descriptions", Checked, { Style = 1 }, function(onSelected, IsChecked, onHovered)
			if (onSelected) then
				Checked = IsChecked
			end
		end)

	end, function(Panels)

	end)
end

Keys.Register("E", "E", "Test", function()
	RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
end)
