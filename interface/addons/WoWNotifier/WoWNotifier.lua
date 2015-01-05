function WoWNotifier_OnEvent(self, event, arg1, ...)		
	if event == "ADDON_LOADED" and arg1 == "WoWNotifier" then	
		WoWNotifier_OnLoad(self);		
		myCheckButton:SetChecked(IsNotifying);
		myCheckButton2:SetChecked(IsBattlePetNotifying);
		myCheckButton3:SetChecked(IsPVPNotifying);
	end
		
	if event == "LFG_PROPOSAL_SHOW" then
		proposalExists, id, typeID, subtypeID, name, texture, role, hasResponded, nonsenseValue, completedEncounters, numMembers, isLeader, isSomethingElse, totalEncounters = GetLFGProposal();
		if proposalExists and IsNotifying then
			print("WoWNotifier detected a LFG/LFR/Scenario pop. Sending notification...")
			TakeScreenshot();		
			if (IsgxRestarting) then
				ConsoleExec("gxRestart");
			end
		end
	end
	
	if event == "UPDATE_BATTLEFIELD_STATUS" then		
		for i=1, 3 do
			status, mapName, instanceID = GetBattlefieldStatus(i)			
			if status == "confirm" then
				if IsPVPNotifying then
					print("WoWNotifier detected a PvP pop. Sending notification...")
					TakeScreenshot();		
					if (IsgxRestarting) then
						ConsoleExec("gxRestart");					
					end
				end
			end
		end		
	end
	
	if event == "PET_BATTLE_QUEUE_PROPOSE_MATCH" then		
		if IsBattlePetNotifying then
			print("WoWNotifier detected a pet battle pop. Sending notification...");					
			TakeScreenshot();				
			if (IsgxRestarting) then
				ConsoleExec("gxRestart");
			end
		end
	end
end

function WoWNotifier_OnLoad(panel)
	panel.name = "WoW Notifier"
	InterfaceOptions_AddCategory(panel);
	
	header = panel:CreateFontString("headerText" , "ARTWORK", "GameFontNormal");
	
	header:SetPoint("TOPLEFT", 15, -20);
	headerText:SetText("WoW Notifier Options");
	
	myCheckButton = CreateFrame("CheckButton", "myCheckButton_GlobalName", panel, "ChatConfigCheckButtonTemplate")
	myCheckButton:SetPoint("TOPLEFT", 10, -65)
	myCheckButton_GlobalNameText:SetText("  Enable LFG/LFR/Scenario Notifications")
	myCheckButton.tooltip = "Click to toggle notifications on or off."
	myCheckButton:SetScript("PostClick", 
	  function(self)		
		if self:GetChecked() then			
			IsNotifying = true
		else			
			IsNotifying = false
		end
	  end
	)
	
	myCheckButton2 = CreateFrame("CheckButton", "myCheckButton2_GlobalName", panel, "ChatConfigCheckButtonTemplate")
	myCheckButton2:SetPoint("TOPLEFT", 10, -105)
	myCheckButton2_GlobalNameText:SetText("  Enable Pet Battle Notifications")
	myCheckButton2.tooltip = "Click to toggle pet battle notifications on or off."
	myCheckButton2:SetScript("PostClick", 
	  function(self)		
		if self:GetChecked() then			
			IsBattlePetNotifying = true
		else			
			IsBattlePetNotifying = false
		end
	  end
	)
	
	myCheckButton3 = CreateFrame("CheckButton", "myCheckButton3_GlobalName", panel, "ChatConfigCheckButtonTemplate")
	myCheckButton3:SetPoint("TOPLEFT", 10, -145)
	myCheckButton3_GlobalNameText:SetText("  Enable PvP Notifications")
	myCheckButton3.tooltip = "Click to toggle PvP notifications on or off."
	myCheckButton3:SetScript("PostClick", 
	  function(self)		
		if self:GetChecked() then			
			IsPVPNotifying = true
		else			
			IsPVPNotifying = false
		end
	  end
	)
	
	myCheckButton4 = CreateFrame("CheckButton", "myCheckButton4_GlobalName", panel, "ChatConfigCheckButtonTemplate")
	myCheckButton4:SetPoint("TOPLEFT", 10, -185)
	myCheckButton4_GlobalNameText:SetText("  Enable gxRestart on Notification")
	myCheckButton4.tooltip = "Click to toggle gxRestart for notifications on or off."
	myCheckButton4:SetScript("PostClick", 
	  function(self)		
		if self:GetChecked() then			
			IsgxRestarting = true
		else			
			IsgxRestarting = false
		end
	  end
	)
end

SLASH_WOWNOTIFIER1, SLASH_WOWNOTIFIER2 = '/wn', '/wownotifier'

SlashCmdList["WOWNOTIFIER"] = function(msg)		
	if msg == 'help' then
		print([[WoW Notifier Help:
/wn /wownotifier - Displays the current notification status.
/wn (on/off) - Disable or enable all notifications.
/wn (lfg/lfr/scenario) - Disable or enable LFG/LFR/Scenario notifications.
/wn pet - Disable or enable Pet Battle notifications.
/wn pvp - Disable or enable Player versus Player notifications
/wn help - Show this message.
/wn gx - Disable or enable calling gxRestart for notifications.]]);
		return;
	end
		
	if msg == 'lfr' or msg == 'lfg' or msg == 'scenario' or msg == 'LFR' or msg == 'LFG' or msg == 'Senario' then
		if myCheckButton:GetChecked() then
			IsNotifying = false
			myCheckButton:SetChecked(IsNotifying);
			print("LFG/LFR/Scenario Notifications disabled.");		
		else
			IsNotifying = true
			myCheckButton:SetChecked(IsNotifying);
			print("LFG/LFR/Scenario Notifications enabled.");
		end
		return;
	end
	if msg == 'pet' or msg == 'Pet' or msg == 'pets' or msg == 'Pets' or msg == 'petbattles' or msg == 'PetBattles' then
		if myCheckButton2:GetChecked() then
			IsBattlePetNotifying = false
			myCheckButton2:SetChecked(IsBattlePetNotifying);
			print("Pet Battle Notifications disabled.");		
		else
			IsBattlePetNotifying = true
			myCheckButton2:SetChecked(IsBattlePetNotifying);
			print("Pet Battle Notifications enabled.");
		end
		return;
	end
	if msg == 'off' then
		IsNotifying = false
		myCheckButton:SetChecked(IsNotifying);
		IsBattlePetNotifying = false
		myCheckButton2:SetChecked(IsBattlePetNotifying);
		IsPVPNotifying = false
		myCheckButton3:SetChecked(IsPVPNotifying);		
		print('All notifications disabled.');
		return;
	end
	if msg == 'on' then
		IsNotifying = true
		myCheckButton:SetChecked(IsNotifying);
		IsBattlePetNotifying = true
		myCheckButton2:SetChecked(IsBattlePetNotifying);
		IsPVPNotifying = true
		myCheckButton3:SetChecked(IsPVPNotifying);
		print('All notifications enabled.');
		return;
	end
	if msg == 'pvp' or msg == 'PVP' or msg == 'PvP' then
		if myCheckButton3:GetChecked() then
			IsPVPNotifying = false
			myCheckButton3:SetChecked(IsPVPNotifying);
			print("PvP Notifications disabled.");		
		else
			IsPVPNotifying = true
			myCheckButton3:SetChecked(IsPVPNotifying);
			print("PvP Notifications enabled.");
		end
		return;
	end
	
	if msg == 'gx' or msg == 'GX' or msg == 'Gx' then
		if myCheckButton3:GetChecked() then
			IsgxRestarting = false
			myCheckButton4:SetChecked(IsPVPNotifying);
			print("PvP Notifications disabled.");		
		else
			IsgxRestarting = true
			myCheckButton4:SetChecked(IsPVPNotifying);
			print("PvP Notifications enabled.");
		end
		return;
	end
	
	if IsNotifying then
		print ("LFG/LFR/Scenario Notificaions are currently enabled. Type /wn lfg to disable.");
	else
		print ("LFG/LFR/Scenario Notificaions are currently disabled. Type /wn lfg to enable.");
	end
	if IsBattlePetNotifying then
		print ("Pet Battle Notificaions are currently enabled. Type /wn pet to disable.");
	else
		print ("Pet Battle Notificaions are currently disabled. Type /wn pet to enable.");
	end
	if IsPVPNotifying then
		print ("PvP Notificaions are currently enabled. Type /wn pvp to disable.");
	else
		print ("PvP Notificaions are currently disabled. Type /wn pvp to enable.");
	end
	return true;
end