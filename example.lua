---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- created at [24/05/2021 10:02]
---

local MainMenu = RageUI.CreateMenu("Title", "SUBTITLE");

local Checked = false;
local ListIndex = 1;

function RageUI.PoolMenus:Example()
	MainMenu:IsVisible(function(Items)
		Items:Heritage(1, 2)
		Items:AddButton("Hello world", "Hello world.", { IsDisabled = false }, function(onSelected, onHovered, onActive)

		end)
		Items:AddList("List", { 1, 2, 3 }, ListIndex, nil, {}, function(Index, onSelected, onListChange, onHovered, onActive)
			if (onListChange) then
				ListIndex = Index;
			end
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
