--[[
	Author: Darcey@AllForTheCode.co.uk
--]]
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
local initRunOnce = false;
local DMouseMainContainer = null;
local DMouseCircle1 = null;
local DMouseCircle2 = null;
local DMouseCircle3 = null;
local DMouseCircle4 = null;

local tx = 0;
local ty = 0;
local uiScale = UIParent:GetEffectiveScale();
local resX = GetScreenWidth();
local resY = GetScreenHeight();
local screenW = resX * uiScale;
local screenH = resY * uiScale;
local xDif = resX - screenW;
local yDif = resY - screenH;

local scrWidthStep = 100 / screenW;
local scrHeightStep = 100 / screenH;
local xp = 0;
local resWidthStep = resX / 100;
local yp = 0;
local resHeightStep = resY / 100;

local mainContainerSize = 64;
local innerContainerSize = 64;

local t = 0;
local t1 = 0.2;
local t2 = 0.4;
local t3 = 0.6;
local t4 = 0.8;

local updateDelay = 0.3;
local scaleStep = 0.03;
local alphaOffset = 0;

local xOffset = 0 - (mainContainerSize/2);
local yOffset = 0 - (mainContainerSize/2);

local inCombat = false;
local alwaysOn = false;

if ( not DMouseDB ) then 
	DMouseDB = {};
    DMouseDB["enabled"] = true;
end

local function playClick()
	--PlaySound("igMainMenuOption");
end


-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
function dmlog(arg1)
    print(tostring(arg1))
end
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
function init()
    if (initRunOnce == true) then
        return;
    end
    initRunOnce = true;
        
    DMouseMainContainer = CreateFrame("Frame", "DMouse", UIParent)
    DMouseMainContainer:SetFrameStrata("HIGH");
    --DMouseMainContainer:SetFrameStrata("BACKGROUND")
    DMouseMainContainer:SetWidth(mainContainerSize)
    DMouseMainContainer:SetHeight(mainContainerSize)
    DMouseMainContainer:SetMovable(true);
    --[[
    local t = DMouseMainContainer:CreateTexture(nil,"BACKGROUND")
    t:SetTexture("Interface\\AddOns\\DMouse\\images\\pointer2.tga")
    t:SetAllPoints(DMouseMainContainer)
    DMouseMainContainer.texture = t
    --]]
    --DMouseMainContainer:SetPoint("CENTER",0,0)
    DMouseMainContainer:Show()


    -- local f=CreateFrame("Frame");
    -- local msg;
    -- f:SetScript("OnEvent",function(self,event)
    --     if event=="PLAYER_ENTERING_WORLD" then
    --         msg = "entering the world";
    --         DEFAULT_CHAT_FRAME:AddMessage(msg);
    --         inCombat = false;
    --     elseif event=="PLAYER_REGEN_DISABLED" then
    --         msg = "entering combat";
    --         DEFAULT_CHAT_FRAME:AddMessage(msg);
    --         inCombat = true;
    --     elseif event=="PLAYER_REGEN_ENABLED" then
    --         msg = "leaving combat";
    --         DEFAULT_CHAT_FRAME:AddMessage(msg);
    --         inCombat = false;
    --     end
    -- end)
    -- f:RegisterEvent("PLAYER_ENTERING_WORLD")
    -- f:RegisterEvent("PLAYER_REGEN_DISABLED")
    -- f:RegisterEvent("PLAYER_REGEN_ENABLED")



    -- Circle 1
    DMouseCircle1 = CreateFrame("Frame", "DMouseCircleFrame",DMouseMainContainer)
    DMouseCircle1:SetWidth(innerContainerSize)
    DMouseCircle1:SetHeight(innerContainerSize)

    local tex1 = DMouseCircle1:CreateTexture(nil,"BACKGROUND")
    tex1:SetTexture("Interface\\AddOns\\DMouse\\images\\cBlack.tga")
    tex1:SetAllPoints(DMouseCircle1)

    DMouseCircle1.texture = tex1
    DMouseCircle1:SetPoint("CENTER",0,0)
    DMouseCircle1:Show()
    
    -- Circle 2
    DMouseCircle2 = CreateFrame("Frame", "DMouseCircleFrame",DMouseMainContainer)
    DMouseCircle2:SetWidth(innerContainerSize)
    DMouseCircle2:SetHeight(innerContainerSize)

    local tex2 = DMouseCircle2:CreateTexture(nil,"BACKGROUND")
    tex2:SetTexture("Interface\\AddOns\\DMouse\\images\\cWhite.tga")
    tex2:SetAllPoints(DMouseCircle2)

    DMouseCircle2.texture = tex2
    DMouseCircle2:SetPoint("CENTER",0,0)
    DMouseCircle2:Show()

    -- Circle 3
    DMouseCircle3 = CreateFrame("Frame", "DMouseCircleFrame",DMouseMainContainer)
    DMouseCircle3:SetWidth(innerContainerSize)
    DMouseCircle3:SetHeight(innerContainerSize)

    local tex3 = DMouseCircle3:CreateTexture(nil,"BACKGROUND")
    tex3:SetTexture("Interface\\AddOns\\DMouse\\images\\cBlack.tga")
    tex3:SetAllPoints(DMouseCircle3)

    DMouseCircle3.texture = tex3
    DMouseCircle3:SetPoint("CENTER",0,0)
    DMouseCircle3:Show()
    
    -- Circle 4
    DMouseCircle4 = CreateFrame("Frame", "DMouseCircleFrame",DMouseMainContainer)
    DMouseCircle4:SetWidth(innerContainerSize)
    DMouseCircle4:SetHeight(innerContainerSize)

    local tex4 = DMouseCircle4:CreateTexture(nil,"BACKGROUND")
    tex4:SetTexture("Interface\\AddOns\\DMouse\\images\\cWhite.tga")
    tex4:SetAllPoints(DMouseCircle4)

    DMouseCircle4.texture = tex4
    DMouseCircle4:SetPoint("CENTER",0,0)
    DMouseCircle4:Show()
    DMouseCircle4:SetScript("OnUpdate", animate );
    
    -- Setup slash commands
    SlashCmdList["DMouseCOMMAND"] = DMouseSlashCommandHandler;
    SLASH_DMouseCOMMAND1 = "/dm";
    
    -- initial state
    --if (DMouseDB["enabled"] == true and inCombat == true) then
    if (DMouseDB["enabled"] == true) then
        DMouseMainContainer:Show()
    else 
        DMouseMainContainer:Hide()
    end
    
    
    
end
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
function alignToMouse(self)
    local x, y = GetCursorPosition();
    --print( "MX:" .. tostring(x) );
    --self.f:SetPoint("CENTER",x,y);
    --print(tostring(self.f));
    -- 100% = screenW, mouse is also based on this
    -- find % on x mouse is and find that % of resX
    -- local scrWidthStep = 100 / screenW; -- Moved out of function to improve performance
    xp = scrWidthStep * x;
    --local resWidthStep = resX / 100; -- Moved out of function to improve performance
    tx = resWidthStep * xp;
    tx = tx + xOffset;
    
    --local scrHeightStep = 100 / screenH; -- Moved out of function to improve performance
    yp = scrHeightStep * y;
    --local resHeightStep = resY / 100; -- Moved out of function to improve performance
    ty = resHeightStep * yp;
    ty = ty + yOffset;
    
    local msg = "" ..
                "MX:" .. tostring( roundTo(x,1) ) ..
                "    MY:" .. tostring( roundTo(y,1) ) ..
                "    screenW:" .. tostring( roundTo(screenW,1) ) .. 
                "    resX:" .. tostring( roundTo(resX,1) ) .. 
                "    xDif:" .. tostring( roundTo(xDif,1) ) ..
                "    tx:" .. tostring( roundTo(tx,1) ) ..
                "    ty:" .. tostring( roundTo(ty,1) )
                --"    tx:" .. tostring( roundTo(tx,1) ) .. "    ty:" .. tostring( roundTo(ty,1) )
    --print( msg );
    --print( "tx:" .. tostring( roundTo(tx,1) ) .. "    ty:" .. tostring( roundTo(ty,1) ) );
    --print("----");
    
    --DMouseMainContainer:ClearAllPoints();
    DMouseMainContainer:SetPoint("BOTTOMLEFT",tx,ty);
    DMouseMainContainer:SetPoint("BOTTOMLEFT",tx,ty);
    DMouseMainContainer:SetPoint("BOTTOMLEFT",tx,ty);
    DMouseMainContainer:SetPoint("BOTTOMLEFT",tx,ty);
    
end
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #






-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
function animate(self)
    if (DMouseDB["enabled"] == false) then
        return;
    end
    
    
    if (DMouseMainContainer == nil) then
        dmlog("DMouseMainContainer: NOT FOUND!")
        return;
    end

    -- Throttle updates
    t = t+0.1;
    if (t < updateDelay) then
        return;
    else 
        t = 0;
    end


    
    
    t1 = t1 + scaleStep;
    if (t1 >= 1) then
        t1 = 0.01;
    end
    DMouseCircle1:SetScale(t1);
    DMouseCircle1:SetAlpha(1-(t1+alphaOffset));
    
    
    t2 = t2 + scaleStep;
    if (t2 >= 1) then
        t2 = 0.01;
    end
    DMouseCircle2:SetScale(t2);
    DMouseCircle2:SetAlpha(1-(t2+alphaOffset));
    
    
    t3 = t3 + scaleStep;
    if (t3 >= 1) then
        t3 = 0.01;
    end
    DMouseCircle3:SetScale(t3);
    DMouseCircle3:SetAlpha(1-(t3+alphaOffset));
    
    
    t4 = t4 + scaleStep;
    if (t4 >= 1) then
        t4 = 0.01;
    end
    DMouseCircle4:SetScale(t4);
    DMouseCircle4:SetAlpha(1-(t4+alphaOffset));

    
    
    
    
    alignToMouse();
end
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #









-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
function DMouseSlashCommandHandler(cmd)
	dmlog("DMouseSlashCommandHandler(): " .. cmd);
	
	if (cmd == nil or cmd == "" or string.find(cmd, "help") ~= nil) then
		dmlog(" ");
		dmlog("DMouse slash commands:");
		dmlog("  /DM on");
		dmlog("  /DM off");
		return;
	end
    		
	if (cmd == "off") then
		DMouseDB["enabled"] = false;
        if(DMouseMainContainer ~= nil) then
            DMouseMainContainer:Hide()
        end
		return;
	end
	
	if (cmd == "on") then
		DMouseDB["enabled"] = true;
        if(DMouseMainContainer ~= nil) then
            DMouseMainContainer:Show()
        end
		return;
	end


	
end
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #




-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

init();

-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
-- # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #










