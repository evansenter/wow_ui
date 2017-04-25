--[[
	Author: Darcey@AllForTheCode.co.uk
--]]

-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
-- function log(arg1)
--     print(tostring(arg1))
-- end
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
function toChat(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


-- http://wowprogramming.com/docs/widgets/FontInstance/SetFont
-- Fonts\\FRIZQT__.TTF - Friz Quadrata, used by default for player names and most UI text
-- Fonts\\ARIALN.TTF - Arial Narrow, used by default for chat windows, action button numbers, etc.
-- Fonts\\skurri.ttf - Skurri, used by default for incoming damage/parry/miss/etc indicators on the Player and Pet frames
-- Fonts\\MORPHEUS.ttf - Morpheus, used by default for quest title headers, mail, and readable in-game objects.
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
function getSystemDefaultFont()
	return "Fonts\\FRIZQT__.TTF"
end
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #










-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
function invertBoolean(bool)
    if (bool == true) then
        return false;
    else
        return true;
    end
end
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #





-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
function createButton(name,frameContainer,label,width,x,y,clickHandler)
	local btn = CreateFrame("button",name, frameContainer, "UIPanelButtonTemplate")
	btn:SetHeight(22)
	btn:SetWidth(width)
	btn:SetPoint("TOPLEFT", frameContainer, "TOPLEFT", x, y)
	btn:SetText(label)
	btn:SetScript("OnClick", clickHandler)
	return btn;
end
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #




-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
function createLabel(name,frameContainer,text,size,r,g,b,a,justify,x,y)
	local txt = frameContainer:CreateFontString(name, "OVERLAY");
	txt:SetFont("Fonts\\FRIZQT__.TTF",size,"OUTLINE");
	txt:SetTextColor(r,g,b,a);
	txt:SetPoint("TOPLEFT", frameContainer, "TOPLEFT", x, y);
	txt:SetText(text);
	txt:SetJustifyH(justify);
	return txt;
end
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #





-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
function roundTo(val,decimalPrecision)
	if (val == nil) then
		val = 0;
	end
	
	local precision = "%.".. decimalPrecision .."f";
	local newVal = string.format(precision, val);
	return newVal;
end
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #