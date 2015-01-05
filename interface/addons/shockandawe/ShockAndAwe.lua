--[[

Version 2.0 - Initial release of WotLK Branch to WowAce SVN

New Author : Levva of EU Khadgar - by kind Permission of Disquette

Renamed to ShockAndAwe (based on orginal DisqoDice by Disquette)

Completely overhauled for WotLK.
 - Updated to use Ace3
 - Removed totem twisting as not available in WotLK
 - Added bar for Maelstrom Weapon stacks
 - revamped bar timings so that talents taken into account
    - now uses Imp.SS talent to reduce SS cooldown
    - still manual config of 4 piece Arena bonus (on TODO list to automate this)
    - uses Maelstrom talents to determine whether to show maelstrom bar
    - now honors talents in Reverberation to adjust cooldown timer on Shock bar
    - added initial start at config window on blizzard config panel (well it has an about so far!!)

Version 2.01 -
	Enabled the /dqd & /disqodice config options 
	Added confirmation text when an option was used
	
Version 2.02 -
	Fixed display and moving bars options not showing frames after moved
	Fixed turning maelstrom on and off not comming back on
	
Version 2.10 - 
	Decided to change addon name to ShockAndAwe
	Added drycoded support for Lava Burst timer bar
	Refreshed WS code to be Shield code - added text support for Shields
	Added text support for Wind Shock
	Added check for Shamanistic Focus up
	Fixed respeccing issue
	Changed Maelstrom to show 15 sec cooldown - now hidden out of combat, pale in combat and lights up with 5 charges.
	Added text indicator on Maelstrom bar to show how many stacks
	Added text on shield indicator to show how many orbs
	Added icon to shock bar to show if Shamanistic Focus buff present - not working
	Fixed typo preventing SavedVariables actually saving between sessions
	Added text on shock bar to show if Shamanistic Focus has procced
	Altered bar height so that if you choose to show less bars then the spacing changes - eliminates gaps for non shown bars
        - this may need code to check if spacing is still valid if user turns on or off showing a bar during session
	
Version 2.11
	Changed width of SS to be full frame width and adjusted Shock & WFProc to proportional widths
	Fixed issue of maelstrom bar not showing after having moved frame
	
Version 2.12
	Added config tab for Uptime 
	Radical overhaul of the shield frame so that it consistently updates after zoning/reloading etc.
	
Version 2.13 
	Added version info
	Added Uptime Frame 
	Changed display to moveframes and updated background when in moving mode to make it more obvious
	Uptime Frames now show initial attempt at uptimes of various buffs - lots of testing still required
		- session time bars displaying 
		- last fight ones go wrong after second fight though - TODO
		- no icons displaying - TODO
		
Version 2.14 
	Fixed icon files for uptime frames and Shamanistic Focus
	Fixed last fight uptimes showing >100%
	Added tooptip to uptime frame
	
Version 2.15
	added startup to disable addon if not a shaman
	
Version 2.20 
	Removed Shamanistic Focus icon as build 8926 has it as passive ability 
	Added earth shock/flame shock rotation display icon
	Added wind shock threat threshold warning - tested with help from Isbeorn on Coldarra beta server
	Fixed issue with lastfight buff times being summed incorrectly (was a cut n paste error)
	Lots and lots of tweaking of config options for bars - still needs idiot proof testing though
	TODO - Reset option - make sure it resets all bar values
	
Version 2.21 
	Fixed debug info for windshear spamming chat when in a party
	Added config option to disable showing of uptime frame
	Added config option to disable showing text on bars
	Fixed Maelstrom weapon & Imp SS talents which had moved in build 8970
	
Version 2.22
	Localised more strings
	
Version 2.30
	Added Lava Lash CD bar
	Added Lava Burst CD bar
	Changed check for Flame Shock on target to check that its mine
	Added AceGUI-3.0 dependency
	
Version 2.40
	Fixed Wind Shock colour to dark gray similar to WS icon
	Added icon on Maelstrom Weapon bar to show LB or LvB depending on 
	etc.
	Added temp fix for Maelstrom Talents not being seen on login
	
Version 2.41
	Upped Windshock alpha so its easier to see
	
Version 2.50 
	Added support for SharedMedia
	
Version 2.51
	Fixed Lava Lash not showing bug
	
Version 2.52 
	Updated MW cooldown time to 30 sec as per build 9014
	Fixed bug if bar was not showing on load it would display in wrong place when activated during game
	
Version 2.60 
	Added Options to pick your own colour scheme for all the bars
	
Version 2.61
	Removed Lava Burst icon display from 5 stack of MW
	
Version 2.62
	Finally worked out syntax to have project work on new Curseforge.com SVN so revision now uses CF revision numbers
	this also means I can simply tag a version as release and it automatically appears on Curse.com website.
	
Version 2.63 
	Swapped order of Shock and Lava Lash bar so order is Shield, MW, SS, Shock, LL - which pretty much matches priority queue
	Added option to hide shield bar if its active - so that you only see it if it needs refreshing.
	
Version 2.64
	Added no-lib stripping and optionaldeps

Version 2.70 
	Added option to set border textures
	Added option to set font on frames
	Moved various options around and re-ordered the menus
	Massive overhaul of the Uptime frame - fixed a couple of memory leaks - should run a lot faster and a lot less memory
	Added option to configure uptime frame colours
	
Version 2.71
	Added German translations thanks to Bekeon on wowinterface.com
	Fixed rescaling issue
	
Version 2.80
	Added a global cooldown bar which auto-adjusts for any haste effects

Version 2.81
	Fixed spark point to no longer be offset by its width on GCD bar
	
Version 2.82 
	Fixed GCD bar visible by default on entering world
	Fixed missing French localisation entries (still needing translation)
	
Version 2.90 
	Added optional sound to play when 5 stacks of Maelstrom Weapon are achieved
	Uses any sound registered with SharedMediaLib
	Add option to flash Maelstrom Weapon frame when you get 5 stacks
	
Version 2.91
	Fixed lava lash bar bug when you turn the option on
	Added additional sound options
	Added option to play sound on 4 stacks of MW
	Added option to vary time between sounds of 5 MW stacks
	
Version 2.92
	Fixed some French translations thanks to Phops Illidan(EU) 
	Should now fully work on French Client
	
Version 2.93
	Fixed bug with turning on and off MW4 sound option
	
Version 3.00
	Remove Lava Burst bar
	Tidy up command line config menus and add a help message to direct to Blizzard config options
	Clarified how scaling works by updating help message
	Fixed typo in setting bar textures
	Split options, uptime & stats off into separate lua files for easier maintenance
	Add support for recording WF & SS total dmg and displaying in Scrolling Combat Text (if installed)
	
Version 3.01
	Fixed sparkpoint for gcdbar being wrong place if bar width changed
	Fix width of bar frame when bar width changed
	
Version 3.02 
	Stopped mw5 stack sound playing if you are no longer in combat
	Removed rotation and maelstrom weapon icons options
	
Version 3.10
	Add priority frame
	Added options to select priorities - doesnt actually get used yet
	Using fixed MW5_LB, SS, ES, LL rotation hardcoded at present
	Changed GCD bar to narrower one so its easier to see how its timeout relates to other bars
	Fixed Maelstrom bar not showing sometimes after LB cast at 5 stacks
	Fixed Alpha of Maelstrom bar wrong after 5 stacks if you have flashing on
	Added option to disable Windfury bar
	Added display of Windshock icon in priority if threat is above threshold 
	Moved Windshock option & threat option to priority section
	
Version 3.11
	Added option to control when priority shows ie: within X seconds of cooldown expiry
	Allow priority to show when time left on cooldown is less than the user set cooldown period
	The priority options menu now works - you can now set your own priorities
	
Version 3.20
	Added option to keybind Watershield and Lightning Shield
	
Version 3.21
	Priority frame does actually hide now if you choose to disable it
	Priority frame now hides when out of combat
	Fixed an issue with DE translations that would have crashed the addon on using config options
	Added options to warn if shield or weapon imbues are down
	NB. Anyone asking for Rockbiter to be included will have their name added to the list of people the addon will refuse to work for
	Fixed issue with DE & FR localisations where Stormstrike, Lava Lash, Earth Shock & Flame Shock were listed twice in 
		localisation file once in local language and once in English - thus random as to whether which it used and if it broke
	Fixed bug on priority frame if it couldn't understand spell name now forces none to prevent error messages
	Fixed chain lightning priority to check if it is off cooldown
	Fixed show of uptime & priority frames for moving and rehiding when using /saa moveframes
	Added option to rebuff weapons with selected main hand/off hand buffs (still needs work - disabled in release version for now)
	Added options for warnings if shield down or weapon buffs expire - code not implemented yet
	
Version 3.30beta1
	Added sound for shield expiry - needs proper testing and more sounds
	Added keybinds for mh & oh enchants
	Added option to change font effects
	Added option to hide priority frame title
	Added msg frame to use for wf combos if no sct installed - not working but does print in chat for now
	Added command to display paper doll stats for export to EnhSim 
		- very early version - no cut n paste yet - limited data - no warnings about buffs 
	Added News frame to show important changes from one version to another.
		- first news article is only Hello World
	Fixed moving frames showing priority and uptime frames despite option to disable them
	Since the msg frame isn't working the loss of a weapon buff only reports to chat at present
	Warning when enchants expire - not working
	Warning when enter combat without weapon buffs not working
	
Version 3.30beta2
	Fixed export routine to export EnhSim data (first pass at this - I need to know of problems)
	Added warning if you have active buffs that MIGHT affect stats and thus the sim
	
Version 3.30beta3
	Fixed MW stacks sometimes not showing
	
Version 3.30
	Added Russian Localisations
	Fixed Weapon Rebuffs keybindings - still asks for confirmation if you overwrite one though
	Fixed playing sound if shield expires
	Added a few more sound choices
	Fixed Warning of missing weapon buff on entering combat 
	Fixed Message Frame - now visible and moveable
	Added options to set timeout for text on for message frame
	Added option to set colour for text on message frame
	
Version 3.31
	Fixed msgFrame not being movable using the moveframes option
	Added option to hide timer bars out of combat
	Export to EnhSim now adds the 1% heroic presence buff if you are Draenai to save you having to remember
	Fixed having accidentally undone the MW not showing after 5 fix
	Replaced code dealing with trinkets & totems to use an itemID lookup to get string - fixes localised names
	
Version 3.40
	Removed leftover debug code from export routine
	Fixed error msg bug if you clicked Accept on export 
	New option to show Shamanistic Rage icon when mana below a configurable percentage (10% by default)
	Added option to show Windshock icon for World Bosses only
	Updated Export routine to include Spirit, Max_mana, MP5, race, and weapon type - for sim v1.4.2 onwards
	Removed bonus on export stats if player alliance as sim now handles this
	Added command /saa config to open graphical config window
	
Version 3.41
	Fixed localisation issues with Russian and French locale files thanks to cranium_dc and Phops - Illidan (EU)
		- can users who use locale's outside enUS please check these files so that I know they work, thanks.
		- I am unable to check them myself because I have no non english client and I wouldn't understand the 
		- language anyway. Je m' comprende le Francaise peu t'etre. 
		- (I know thats probably wrongly spelt my French is limited to spoken, and a limited vocabulary at that.) 
	Fixed bug that priority wouldn't show Maelstrom weapon if the maelstrom weapon bar was switched off
	
Version 3.50
	Fixed priority bug where Wind Shock & Shamanistic Rage showed even when on cooldown
	Fixed export bug where MP5 value was not exporting as an integer
	Added detection for meta gems in export routine
	Added detection for weapon dps using LibGratuity in export routine
	Added a combo point frame to the Priority point frame to show MW stacks
	Priorty Frame shows blue border if Feral Spirits available
	
Version 3.60
	Fixed export missing out unrelenting storm
	Fixed weapon rebuff warning that buff has expired when rebuffing weapon
	Added option to display an icon on each bar to make it easier to work out which bar is which
	Added button to uptime frame to reset session values
	Fixed bug with uptime frame crashing if you reset its position
	Added a Wall of Text to the news frame 
	
Version 3.61
	Added Scrollbar to News frame so it should be visible even on the most pathetic of screen resolutions
	-  Seriously folks tick the box in video settings called Use UI Scale and move the bar towards low end.
	-  You are significantly penalising your screen size by not doing this
	
Version 3.62
	Removed testing setup which always showed News Frame
	Fixed icons always showing on timer bars
	
Version 3.63	
	News frame now closes on pressing ESC
	Weapon DPS export will now give zero if it doesn't find a numeric match - should fix localisation issues
	Added glyph detection to Export routine
	
Version 3.64
	Modified DPS check for German & French clients to use 100,3 dps instead of 100.3 dps (ie: comma not dot)
	Added extra checks to priority display to check if player has Wind Shock, Shamanistic Rage & Feral Spirit
	
Version 3.65
	Added a check to GCD bar to ensure that being unable to find Lightning Shield doesn't throw error
	
Version 3.70
	Added a Feral Spirit Bar with dual cooldowns - 3 min CD for ability and 45 second CD for wolves being out
	
Version 3.71
	Added a check on all priorities to catch situation where player has added an item to priority but hasn't
	learned that skill!!
	
Version 3.72
	Small fix to initialise Export routine & check for missing glyphs
	Leave Feral Spirit active bar visible outside combat if they are still active.	
	
Version 3.80
	Added readme.txt file as cut n paste of news.
	New features coded but not working 
	-	Added totem as option to priority list
	-	It will show generic totem icon if you select totem and time left < configured time (default 20 sec) and have no totems active
	-	Otherwise it will show icon of last totem dropped for that element
	-	Added macros for weapon rebuffing instead of just casting buff. Trying to get rid of "do you want to replace" messages
	Forced MsgFrame to be background should fix non click through issue
	Added explicit check when weapon enchant event fires to check the enchant status to prevent supurious expiry messages
	Fixed export routine's weapon dps bug - in doing so removed dependency on LibGratuity-3.0
	Updated export routine to match trinkets/totems/metagems/enchants used in EnhSim v1.4.8
	Fixed Shamanistic Rage option setting which was just crashing if you attempted to change the default
	
Version 3.81
	Fixed the tooltip help message displayed when setting Maelstrom Alpha & Full Alpha 
	Showing Shamanistic Rage or Wind Shock icon should no longer "lock" in place even when mana returned or threat reduced
	
Version 3.82
	Added Spanish Localisation provided by roMZell
	
Version 3.83
	Added Traditional Chinese Localisation provided by aletheia301 on Curse.com
	
Version 3.90
	Added Earth Shock only if Stormstrike debuff on target priority option 
	- Exisiting users will need to change their settings to include this option. New default is set to mw5_lb, es_ss, ss, es, ll
	
Version 3.91 
	Added out of range/too far away warning
	removed single use local variables for spell names
	added DebugPrint function
	
Version 4.00
	Welcomed Wraithan as a contributor to the project he will be assisting in fixing known issues and adding new features
	Please make sure you add any new feature requests using the ticketing system on Curse.com
	Incorporated Wraithan's code for priority warnings for healing wave, watershield & lightning shield
	Incorporated Wraithan's code for localisations which should remove the requirement to localise spell names
	Fix to prevent errors if for some unexplicable reason you are dense enough to have the addon turned on when you are not on a shaman
	Fixed missing sounds/priorities if maelstrom bar hidden - needs testing if this fixes missing priorities for other bars hidden
	Added Earthliving Weapon & none to imbue choices
	Change defaults on Healing wave/water shield recommendation/shamanistic rage recommendation to realistic levels
	Alter max shield orbs to 9 - should really use Static Shock Talent Wind Shock Glyph values for max
	Fix Shield priority logic - not convinced its right. Why recommend water shield at 70% when LS is more dmg. Also even if 10% if mana 
		regen from SR at 5% is available soon and would take you back to 100% should only recommend water shield if regen rate needs boost
		have set default to zero for now until better logic can be established
	Fixed bug where SR priority wouldn't show if it recommended something else immediately before mana went low
	Fixed bug where MH & OH bindings weren't updated after a config change
	
Version 4.01
	Fixed missing Priority reset locale string
	Fixed flickering MW 5 bar even when disabled
	
Version 4.02
	Added sound option when weapon buffs expire
	Fixed disabling of MW Flash giving error
	Fixed using priority reset option will now reset priorities to default as well as resetting priority frame
	Moved the priority update code to be attached to the priority frame so if the bars frames are all disabled then the priorities should still work
	
Version 4.10
	Fix for localised Uptime bars
	Add support for patch 3.1 talent tree
          Added support for mw4 stack priority options
	 Fix priority for searing & magma totems so it only recommends if there is a GCD available
	 Fix for priority combo points it will now always check how many combo points you have when displaying the bar
	 
Version 4.11
	Dropped LibAboutPanel as since it moved to GIT my SVN client does nothing but complain it cant update this library.
	
Version 4.12
	Added an enable/disable option
	Added a keybind for enable/disable option
	Added a popup box to ask when you swap specs if you want to enable/disable ShockAndAwe (box not displaying properly in this version)
	Fixed an issue with moving priority frame in combat was disabling the priority frame display this is due to the fact that 
		Blizzard prevents addons updating scripts when in combat - it will still be disabled whilst you are in combat when you move it
		However it will start working again when you exit combat and re-enter.
		
Version 4.13
	Added function to force Feral Spirits Pet tab to be visible - useful for seeing what damage they do
	
Version 4.20
	Updated toc for patch 3.1
	
Version 4.21
	Remove tests for patch 3.1 as 3.1 is now live
	Fix stormstrike length
	Change Arena set bonus to 2 seconds for SS
	
Version 4.22
	Disable spec change question until I get it working right its firing entering combat = wrong.
	
Version 4.30
	Fix shield bar showing when disable out of combat selected
	Fix for MW Bar disappearing after flashing when 5 stacks. This was due to Blizzard bug in the code to disable flash frames. 
		In patch 3.0 disabling flash frames always made sure the frame was enabled in 3.1 the frame can end in a random state.
	Fixed timeout of shockbar not observing Reverberation setting, priority was bar wasn't.
	Fixed offhand weapon imbue warning when you didn't have an off hand weapon equipped - needs locale checked for DE, FR, TW, RU
	Updated haste to melee_haste & spell_haste in EnhSim export
	Updated all trinkets, totems and metagems in EnhSim export to use id's so should work for any item if EnhSim supports it
	Should now correctly export to EnhSim v1.6.8 and above everything bar EnhSim buffs
	
Version 4.31
	Added Magma totem bar
	
Version 4.32
	Added Export to EnhSim config_source flag
	
Version 4.33
	Fixed Shield & Magma bar not showing in combat if hide out of combat ticked
	Added Feral Spirits to priority option list
	Fixed totemic call not zeroing magma bar timeout
	
Version 4.34
	Fixed Magma bar - now disappears if destroyed or removed by right click on totem icon (player portrait)
	
Version 4.35
	Fixed end tree elemental talents in export to EnhSim
	
Version 4.36
	Fixed disabled Shield bar out of combat
	
Version 4.37
	Updated toc for patch 3.2
	ES_SS Priority no longer activates based on other people's Stormstrike debuffs
	
Version 4.40
	Add support for disabling priority frame and bars when in vehicle
	Fixed SS, ES, LL not showing in priorities bug introduced in v4.37
	
Version 4.41
	Fix for Spanish locale not having weapon entry and missing magma options
	Fix for inaccurate weapon speed exports when hasted
	Added time left on Magma Bar if showing text on bars
	Added separate Windshear bar - default is off
	GCD bar now has option to show it as a full width bar
	
Version 4.42
	Fix for Vehicle Exiting disabling priority frame
	
Version 4.43
	Fix for bindings taint bug
	
Version 4.50
	Added warning option if your grounding totem grounds a spell 
	Added warning option if you purge a spell
	Added warning option if you interrupt a spell
	Added spell casting icon to priority frame to show you when an enemy is casting a spell that might be interrupted
	Added purge icon to priority frame to show you when the enemy has a purgeable buff
	
Version 5.00
	Expanded priorities to have 16 options
	Renamed all occurrences of Wind Shock to Wind Shear
	Added red border to interrupt frame if Wind Shear on cooldown - thanks to Naxino of EU Khadgar for assisting testing
	Added LL_QE to priority options
	Added option to show cooldown "clock" on priority frame - excellent suggestion by Aramis on MMO-Champion forums
		Recommend turning GCD bar off and using cooldown clock and setting priority cooldown time to 0.5 seconds up from 0.25
	Fixed incorrect speed export to EnhSim
	Added check for missing Priority in case priority list gets corrupted
	Moved default location of priority frame to avoid icon overlaps
	Added optional Flameshock dot bar
	Fixed priority when target changing
	
Version 5.01
	Made Flameshot dot an independent bar and put it above stormstrike
	Shortened WF messages output to Scrolling Combat Text
	Turning off Purge or Interrupt frames now actually hides the frame
	Added belt and braces check for Flameshock and Stormstike buffs being players and no one elses
	Fixed bug where priority frame was disappearing if ANYONE in party went into a vehicle during a fight. 
		Now correctly disappears if PLAYER enters vehicle (as you can't use your own abilities in vehicle)
		
Version 5.10
	Added MW3_LB, MW3_CL priorities to the possiblities.
	Also added Fire Nova (FN) and Fire Elemental (FE) priorities
	Searing Totem, Magma Totem & Fire Elemental Totem now share a fire totem bar
	Altered default priority list
	Added test for fire totem being destroyed early removing the fire totem bar - thanks to Holls on Brill EU PTR for testing
	Fixed export of Feral Spirits glyph not showing in EnhSim Export
	Fix for feral spirit icon sometimes remaining visible outside combat
	
Version 5.20
	Fixed Russian Localisation
	Added extra localisations from Curseforge localisation setup
	Changed all localisations to use Curseforge.com automated localisations
	Added feature to hide spells from the priority list that the target is immune to
	Added option to turn hide immunity on and off
	Added SS_0 option to use SS if no debuff on target
	Added FS_Boss option to only use Feral Spirits on Boss
	Added priority frame scaling
	Fixed bar scaling
	
Version 5.21
	Updated Localisations on Curseforge.com should fix muliple locale errors from missing locale values in v5.20
	
Version 5.22
	Fixed typo in "Stormstrike if no debuff"
	
Version 5.23
	Force update to Curse.com
	
Version 5.24
	Force all non English localisations to use English phrases if no localisation has been added to the site 
	at http://wow.curseforge.com/addons/shockandawe/localization/ for that phrase
	
Version 5.25
	Default options now are patch 3.2 vs patch 3.3 aware so it doesnt turn on patch 3.3 versions when running on patch 3.2
	Added Booming Echoes shortens Flame Shock & Frost Shock bar length
	Shield bar now changes colour when shield orbs reach the minimum user selected level

Version 5.30
	You can now set up to five different priority sets for use in different circumstances
	Added five possible key bindings for selecting five possible priority groups
	
Version 5.40
	Added export support for necrotic touch (Black Bruise's proc) and mixology if you are an alchemist
	Fix for altering bar width causing crash
	Add dual spec support - now asks if you want to enable/disable addon on switching specs.
	
Version 5.41
	Added FE_boss option to only recommend Fire Elemental when on a boss
	Added query about enabling/disabling addon based on spec when addon initialises (eg: to turn off if login in Resto spec after a DC)
	
Version 5.42
	Added set number display above priority box if text shown
	Fix for setting priorities not sticking between reloads
	Added default AoE priority list
	Fix for trying to scale or set width whilst moving frames
	
Version 5.50
	Added support for Fire Nova bar
	
Version 5.51
	Fixed problem where default options were reset on relog
	
Version 5.52
	Fixed missing locale value when changing priorities
	Added Stormstrike debuff count on bar if showing bar text
	Added extra locale values
	
Version 5.53
	Added check if options are empty to warn user
	Reworked Maelstrom weapon bar display to hopefully fix issue with the alpha being zero after a flash
	
Version 5.60
	Added additional checks on loading options if options are empty to warn user
	Added option to output to MikScrollingBattleText if installed. This requires selecting an output frame in the warnings options section
	Refactored Fire totems to check if other fire totem is down before recommending new one.
	Force load of priority options on zoning to ensure that options aren't lost
	
Version 5.61
	Added FlameShock on Boss option
	Default prioirty options were not getting set for clean install
	Added feature to refresh Magma totem X ticks before it expires
	FS Dot bar should no longer require Shock bar to be visible
	Renamed locales that had Magma Bar to Fire Bar
	
Version 5.62
	Missed a locale setting for Magma Bar -> Fire Bar
	
Version 5.63
	Make priority for refreshing Magma totem no longer reliant on showing Fire totem bar
	
Version 5.70
	Added Improved Fire Nova to EnhSim export
	Added Ashen verdict ring proc to EnhSim export
	Added glove & cloak enchants to EnhSim export
	Added SR & SR_Boss priorities to work with T10 set bonus
	Added set bonuses to EnhSim export
	
Version 5.71
	Added LS_0 and MT_0
	
Version 5.72
	Fixed missing localisation for LS_0
	added check when showing purge & interrupt frames that the frames have been created
	
Version 5.73
	Added check to see if player is level 60 or higher before asking to disable addon
	Added check to stop displaying priority frame if addon disabled
	Added option verification check to replace nils with "none"
	Priority Frame should no longer be moveable in combat
	
Version 5.80
	Fix fire totem timer bars for duration of magma totem being not quite exactly 20 seconds 
	Add text if barstext on to FlameShock Dot Bar
	Affect FlameShock Dot Bar by haste
	Remove Unleashed Rage uptime as its now a 100% aura
	Properly Implemented FSTicksLeft option now advises to refresh FS if less than X ticks lefts
	Altered single target priority defaults
	
Version 5.81
	Fix big lag when lighting shield expires out of combat
	Fix magma totem priority if dropped via Call of the XXXX
	
Version 5.82
	Fix TOC file to 30300 from 30303 as that wasn't being recognised as up to date
	
Version 5.83
	fixed priority options not saving on exit 
		- make sure you have the very latest Ace3DB addon and don't have multiple copies of old Ace3DB libraries
		- ie: search your addons folders for any version of Ace3DB dated before March 2010.
		- latest version is r917 at time of writing
	fixed height of uptime frame now that Unleashed Rage is 100% uptime
	Updated default priority options to match new EJ BiS list
	
Version 5.90
	Fix for textures stretching rather than revealing
	Option to disable warning about changing spec
	Stop showing two enable/disable buttons in config
	
Version 5.91
	replaced getglobal with _G syntax in preparation for cataclysm
	replaced use of this: to self: in preparation for cataclysm
	added local arg1, arg2 usage in preparation for cataclysm
	
Version 5.92
	fixed bug in Export dialog introduced in v5.91
	moved Export dialog box to show beneath the warning frame.
	
Version 5.93
	add possible fix for magma totem dropping sometimes suggesting dropping another magma totem
		thanks to Nith9 from curseforge.com for analysis of solution
		
Version 6.00
	Started work on new spell IDs and reworking for Cataclysm
	Fixed Fire Nova only to work off certain fire totems
	Fixed flash cancel when maelstrom weapon bar flashes at 5 stacks
	Added warning if using addon v6.00+ in patch 3.3.5
	Removed stormstrike debuffs text
	Fixed Pet tab available to check your wolves stats
	Added support for FS_UEF, LL_SFx priorities, changed default priorities for single target
	Changed Lava Lash CD to 10 seconds
	
Version 6.01
	Removed some of the checking for patch 3.3.5
	
Version 6.02
	Fixed buffing OH weapon with flametongue weapon no longer drops flametongue totem :)
	Updated default priorities
	
Version 6.03
	Disabled option for pet frame show by default

Version 6.04
	Added back in SS_0 priority by request
	Added stats support for export function 
	Added talent support for export function
	
Version 6.10
	Fixed export of MW & Imp.LL
	Added 6% melee hit from dual wield to export function
	Ashen Verdict Ring enchants and Glove & Cloak enchants for engineers don't work
	Fixed export of hit rating if Draenei
	Fixed export of glyphs & armour type
	Added support for weapon types (needs localisation)
	Fix shield bar sometimes not showing in combat if hide ooc selected
	Fix unleash flame was checking for debuff when its a buff
	Added number of SF stacks on current target to Fire totem bar if searing totem down
	Added option to set number of searing stacks to clip for Searing totem
	
Version 6.11
	Fix typo in Export
	
Version 6.20
	Remove Minor Glyphs from EnhSim export
	Add initial patch 4.2 compatibility
	Patch 4.1 changes - wasn't playing at time so didn't do them until now
		Changed Fire Nova length to 4 sec
		Changed Magma totem length to 60 sec
	Add initial test code for Unleash Elements bar
	Fix bug when changing colour of Fire Totem Bar
	Casting Unleash Elements now shows bar
	Feral Spirits summon bar has a bug with duration and cooldowns
	
Version 6.30
	Patch 4.3
	
Version 6.40
	Fixes for patch 5.04
	Added new spells for patch 5.04
	Revised the priority queue for single target damage
	Deactivated the export function because there is currently no working EnhSim
	Removed Elemental Devastation from the Uptime Box because the talent no longer exists
--]]

if select(2, UnitClass('player')) ~= "SHAMAN" then
	DisableAddOn("ShockAndAwe")
	return
end

local L = LibStub("AceLocale-3.0"):GetLocale("ShockAndAwe")
local AceAddon = LibStub("AceAddon-3.0")
local media = LibStub:GetLibrary("LibSharedMedia-3.0")
ShockAndAwe = AceAddon:NewAddon("ShockAndAwe", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local SCT = SCT
local REVISION = tonumber(("$Revision: 393 $"):match("%d+"))
local _, _, _, clientVersion = GetBuildInfo()
local queryDisable = false

ShockAndAwe.frames = {}

ShockAndAwe.BaseFrame = CreateFrame("Frame","ShockAndAweBase",UIParent)
ShockAndAwe.frames["Maelstrom"] = CreateFrame("Frame","SAA_Bar1_Status", ShockAndAwe.BaseFrame) 
ShockAndAwe.frames["Maelstrom"].icon = CreateFrame("Frame","SAA_Bar1_StatusIcon",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["fireTotem"] = CreateFrame("Frame","SAA_Bar9_Status", ShockAndAwe.BaseFrame) 
ShockAndAwe.frames["fireTotem"].icon = CreateFrame("Frame","SAA_Bar9_StatusIcon",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Stormstrike"] = CreateFrame("Frame","SAA_Bar2_Status",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Stormstrike"].icon = CreateFrame("Frame","SAA_Bar2_StatusIcon",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Stormblast"] = CreateFrame("Frame","SAA_Bar2a_Status",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Stormblast"].icon = CreateFrame("Frame","SAA_Bar2a_StatusIcon",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Shock"] = CreateFrame("Frame","SAA_Bar3_Status",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Shock"].icon = CreateFrame("Frame","SAA_Bar3_StatusIcon",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Shear"] = CreateFrame("Frame","SAA_Bar3a_Status",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Shear"].icon = CreateFrame("Frame","SAA_Bar3a_StatusIcon",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Windfury"] = CreateFrame("Frame","SAA_Bar4_Status",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Windfury"].icon = CreateFrame("Frame","SAA_Bar4_StatusIcon",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Shield"] = CreateFrame("Frame","SAA_Bar5_Status",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Shield"].icon = CreateFrame("Frame","SAA_Bar5_StatusIcon",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["LavaLash"] = CreateFrame("Frame","SAA_Bar6_Status",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["LavaLash"].icon = CreateFrame("Frame","SAA_Bar6_StatusIcon",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["FeralSpirit"] = CreateFrame("Frame","SAA_Bar7_Status",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["FeralSpiritCD"] = CreateFrame("Frame","SAA_Bar7a_Status",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["FeralSpirit"].icon = CreateFrame("Frame","SAA_Bar7_StatusIcon",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["GCD"] = CreateFrame("Frame", "SAA_Bar8_Status", ShockAndAwe.BaseFrame)
ShockAndAwe.frames["FS_DOT"] = CreateFrame("Frame", "SAA_Bar9_Status", ShockAndAwe.BaseFrame)
ShockAndAwe.frames["FS_DOT"].icon = CreateFrame("Frame", "SAA_Bar9_StatusIcon", ShockAndAwe.BaseFrame)
ShockAndAwe.frames["FireNova"] = CreateFrame("Frame", "SAA_Bar10_Status", ShockAndAwe.BaseFrame)
ShockAndAwe.frames["FireNova"].icon = CreateFrame("Frame", "SAA_Bar10_StatusIcon", ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Unleash"] = CreateFrame("Frame", "SAA_Bar11_Status", ShockAndAwe.BaseFrame)
ShockAndAwe.frames["Unleash"].icon = CreateFrame("Frame", "SAA_Bar11_StatusIcon", ShockAndAwe.BaseFrame)
ShockAndAwe.frames["StoneBulwark"] = CreateFrame("Frame", "SAA_Bar12_Status",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["StoneBulwark"].icon = CreateFrame("Frame","SAA_Bar12_StatusIcon",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["ElementalBlast"] = CreateFrame("Frame", "SAA_Bar13_Status",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["ElementalBlast"].icon = CreateFrame("Frame","SAA_Bar13_StatusIcon",ShockAndAwe.BaseFrame)
ShockAndAwe.frames["ElementalBlastBuff"] = CreateFrame("Frame", "SAA_Bar13a_Status",ShockAndAwe.BaseFrame)
ShockAndAwe.msgFrame = CreateFrame("MessageFrame","ShockAndAweMsg",UIParent)
ShockAndAwe.questionFrame = CreateFrame("Frame","ShockAndAweQuestion",UIParent)

ShockAndAwe.textures = {}
ShockAndAwe.borders = {}
ShockAndAwe.fonts = {}
ShockAndAwe.sounds = {}
ShockAndAwe.barBackdrop = {
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 12,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	}
ShockAndAwe.frameBackdrop ={
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		--edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 12,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	}
ShockAndAwe.GCDMin = 0
ShockAndAwe.GCDMax = 0
ShockAndAwe.GCDWidth = 0
	
local SSmin, SBmin, SSmax, SBmax, ShockMin, ShockMax, ShearMin, ShearMax, WFPMin, WFPMax, ShieldMin, ShieldMax, MaelstromMin, MaelstromMax
local LLMin, LLMax, UEMin, UEMax, FSMin, FSMax, FSCDMin, FSCDMax, FireTotemMin, FireTotemMax, GCDPercent, FSDotTime, FNmin, FNmax
local EBMin, EBMax, EBBuffMin, EBBuffMax
local updateActiveSS = false
local updateActiveSB = false
local updateActiveFireTotem = false
local updateActiveMaelstrom = false
local updateActiveLavaLash = false
local updateActiveUnleash = false
local updateActiveElementalBlast = false
local updateActiveShock = false
local updateActiveFSDot = false
local updateActiveShear = false
local updateActiveShamanistic = false
local updateActiveWFProc = false
local updateActiveShield = false
local updateActiveFeralSpiritCD = false
local updateActiveGCD = false
local updateActiveFN = false
local WFProcTime = 0
local SSTime = 0
local SBTime = 0
local FireTotemTime = 0
local FNTime = 0
local GCDTime = 0
local LLTime = 0
local UETime = 0
local EBTime = 0
local EBBuffTime = 0
local FSTime = 0
local FSCDTime = 0
local ShockTime = 0
local FSDotTime = 0
local ShearTime = 0
local ShieldTime = 0
local lastSound = 0
local mw4played = false
local mwflashing = false
local fireTotemGUID = 0
local searingTotem = false

--local Variables for Stone Bulwark Totem support
local StoneBulwarkTime = 0
local StoneBulwarkCD = 60
local StoneBulwarkGUID = 0
local StoneBulwarkInitial = true
local StoneBulwarkActive = false

-----------------------------------------
-- Initialisation & Startup Routines
-----------------------------------------

function ShockAndAwe:OnInitialize()
	local AceConfigReg = LibStub("AceConfigRegistry-3.0")
	local AceConfigDialog = LibStub("AceConfigDialog-3.0")
	self:SetConstants()
	self:SetBindings()
	self:SetDefaultOptions()
	
	ShockAndAwe.db = LibStub("AceDB-3.0"):New("ShockAndAweDBPC", ShockAndAwe.defaults, "char")
	self:SetPriorityTable()
	self:GetMSBTAreaDefaults()
	LibStub("AceConfig-3.0"):RegisterOptionsTable("ShockAndAwe", self:GetOptions(), {"shockandawe", "saa"} )
	media.RegisterCallback(self, "LibSharedMedia_Registered")
	
	-- Add the options to blizzard frame (add them backwards so they show up in the proper order
	self.optionsFrame = AceConfigDialog:AddToBlizOptions("ShockAndAwe", "ShockAndAwe")
	ShockAndAwe.db:RegisterDefaults(ShockAndAwe.defaults)
	if not ShockAndAwe.db.char.immuneTargets then
		ShockAndAwe.db.char.immuneTargets = {}
	end
	self:InitialiseUptime()
	self:InitialiseBindings()
	self:CreateUptimeFrame()
	self:CreatePriorityFrame()
	self:CreateMsgFrame()
	self:News()
	self:VerifyOptions()
	local version = GetAddOnMetadata("ShockAndAwe","Version")
	self.version = ("ShockAndAwe v%s (r%s)"):format(version, REVISION)
	self:Print(self.version.." Loaded.")
end

function ShockAndAwe:SetConstants()
	ShockAndAwe.constants = {}
	ShockAndAwe.SpellID = {}
	local C = ShockAndAwe.constants

	ShockAndAwe.constants["Stormstrike"], _, ShockAndAwe.constants["Stormstrike Icon"] = GetSpellInfo(17364)
	ShockAndAwe.constants["Frost Shock"], _, ShockAndAwe.constants["Frost Shock Icon"] = GetSpellInfo(8056)
	ShockAndAwe.constants["Earth Shock"], _, ShockAndAwe.constants["Earth Shock Icon"] = GetSpellInfo(8042)
	ShockAndAwe.constants["Flame Shock"], _, ShockAndAwe.constants["Flame Shock Icon"] = GetSpellInfo(8050)
	ShockAndAwe.constants["Wind Shear"], _, ShockAndAwe.constants["Wind Shear Icon"] = GetSpellInfo(57994)
	ShockAndAwe.constants["Water Shield"], _, ShockAndAwe.constants["Water Shield Icon"] = GetSpellInfo(52127)
	ShockAndAwe.constants["Windfury Weapon"], _, ShockAndAwe.constants["Windfury Weapon Icon"] = GetSpellInfo(8232)
	ShockAndAwe.constants["Frostbrand Weapon"], _, ShockAndAwe.constants["Frostbrand Weapon Icon"] = GetSpellInfo(8033)
	ShockAndAwe.constants["Flametongue Weapon"], _, ShockAndAwe.constants["Flametongue Weapon Icon"] = GetSpellInfo(8024)
	ShockAndAwe.constants["Earthliving Weapon"], _, ShockAndAwe.constants["Earthliving Weapon Icon"] = GetSpellInfo(51730)
	ShockAndAwe.constants["Lightning Shield"], _, ShockAndAwe.constants["Lightning Shield Icon"] = GetSpellInfo(324)
	ShockAndAwe.constants["Maelstrom Weapon"], _, ShockAndAwe.constants["Maelstrom Weapon Icon"] = GetSpellInfo(53817)
	ShockAndAwe.constants["Earth Shield"], _, ShockAndAwe.constants["Earth Shield Icon"] = GetSpellInfo(974)
	ShockAndAwe.constants["Lava Lash"], _, ShockAndAwe.constants["Lava Lash Icon"] = GetSpellInfo(60103)
	ShockAndAwe.constants["Flurry"], _, ShockAndAwe.constants["Flurry Icon"] = GetSpellInfo(16278)
	ShockAndAwe.constants["Lightning Bolt"], _, ShockAndAwe.constants["Lightning Bolt Icon"] = GetSpellInfo(403)
	ShockAndAwe.constants["Chain Lightning"], _, ShockAndAwe.constants["Chain Lightning Icon"] = GetSpellInfo(421)
	ShockAndAwe.constants["Grounding Totem"], _, _ = GetSpellInfo(8177)
	ShockAndAwe.constants["Flametongue Totem"], _, ShockAndAwe.constants["Flametongue Totem Icon"] = GetSpellInfo(8227)
	ShockAndAwe.constants["Searing Totem"], _, ShockAndAwe.constants["Searing Totem Icon"] = GetSpellInfo(3599)
	ShockAndAwe.constants["Magma Totem"], _, ShockAndAwe.constants["Magma Totem Icon"] = GetSpellInfo(8190)
	ShockAndAwe.constants["Fire Elemental Totem"], _, ShockAndAwe.constants["Fire Elemental Totem Icon"] = GetSpellInfo(2894)	
	ShockAndAwe.constants["Earth Elemental Totem"], _, ShockAndAwe.constants["Earth Elemental Totem Icon"] = GetSpellInfo(2062)	
	ShockAndAwe.constants["Shamanistic Rage"], _, ShockAndAwe.constants["Shamanistic Rage Icon"] = GetSpellInfo(30823)
	ShockAndAwe.constants["Feral Spirit"], _, ShockAndAwe.constants["Feral Spirit Icon"] = GetSpellInfo(51533)
	ShockAndAwe.constants["Unleash Elements"], _, ShockAndAwe.constants["Unleash Elements Icon"] = GetSpellInfo(73680)
	ShockAndAwe.constants["Unleash Flame"], _, ShockAndAwe.constants["Unleash Flame Icon"] = GetSpellInfo(73683)
	ShockAndAwe.constants["Heroic Presence"], _, _ = GetSpellInfo(28878)
	ShockAndAwe.constants["Champion of the Kirin Tor"], _, _ = GetSpellInfo(57821)
	ShockAndAwe.constants["Healing Surge"], _, ShockAndAwe.constants["Healing Surge Icon"] = GetSpellInfo(8004)
	ShockAndAwe.constants["Chain Heal"], _, ShockAndAwe.constants["Chain Heal Icon"] = GetSpellInfo(1064)
	ShockAndAwe.constants["Totemic Recall"], _, ShockAndAwe.constants["Totemic Recall Icon"] = GetSpellInfo(36936)
	ShockAndAwe.constants["Volcanic Fury"], _, ShockAndAwe.constants["Volcanic Fury"] = GetSpellInfo(67391)
	ShockAndAwe.constants["Windfury Attack"], _, ShockAndAwe.constants["Windfury Attack Icon"] = GetSpellInfo(25504)
	ShockAndAwe.constants["Unleashed Fury"], _, ShockAndAwe.constants["Unleashed Fury Icon"] = GetSpellInfo(117012)
	ShockAndAwe.constants["Elemental Blast"], _, ShockAndAwe.constants["Elemental Blast Icon"] = GetSpellInfo(117014)
	ShockAndAwe.constants["Ancestral Swiftness"], _, ShockAndAwe.constants["Ancestral Swiftness Icon"] = GetSpellInfo(16188)	
	ShockAndAwe.constants["Searing Flames"], _, ShockAndAwe.constants["Searing Flames Icon"] = GetSpellInfo(77661)
	ShockAndAwe.constants["Purge"], _, ShockAndAwe.constants["Purge Icon"] = GetSpellInfo(8012)
	ShockAndAwe.constants["Fire Nova"], _, ShockAndAwe.constants["Fire Nova Icon"] = GetSpellInfo(1535)
	ShockAndAwe.constants["Stormlash Totem"], _, ShockAndAwe.constants["Stormlash Totem Icon"] = GetSpellInfo(120668)
	ShockAndAwe.constants["Elemental Mastery"], _, ShockAndAwe.constants["Elemental Mastery Icon"] = GetSpellInfo(16166)
	ShockAndAwe.constants["Ascendance"], _, ShockAndAwe.constants["Ascendance Icon"] = GetSpellInfo(114049)
	ShockAndAwe.constants["Stormblast"], _, ShockAndAwe.constants["Stormblast Icon"] = GetSpellInfo(115356)
	
	ShockAndAwe.SpellID["Stone Bulwark Totem"] = 108270
	ShockAndAwe.constants["Stone Bulwark Totem"], _, ShockAndAwe.constants["Stone Bulwark Totem Icon"] = GetSpellInfo(108270)	
end

function ShockAndAwe:OnDisable()
    -- Called when the addon is disabled
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent("PLAYER_LOGIN")
	self:UnregisterEvent("PLAYER_ALIVE")
	self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:UnregisterEvent("UNIT_AURA")
	self:UnregisterEvent("UNIT_MANA")
	self:UnregisterEvent("CHARACTER_POINTS_CHANGED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("PLAYER_TARGET_CHANGED")
	self:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
	self:UnregisterEvent("UPDATE_BINDINGS")
	self:UnregisterEvent("UI_ERROR_MESSAGE")
-- we must still look out for talent changes to fire change of spec to re-enable
--	self:UnregisterEvent("PLAYER_TALENT_UPDATE")
--	self:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	self:UnregisterEvent("UNIT_EXITED_VEHICLE")
	self:UnregisterEvent("UNIT_ENTERED_VEHICLE")
end

function ShockAndAwe:OnEnable()
	self:LibSharedMedia_Registered()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("PLAYER_ALIVE")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("UNIT_POWER")
	self:RegisterEvent("CHARACTER_POINTS_CHANGED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	self:RegisterEvent("UPDATE_BINDINGS")
	self:RegisterEvent("UI_ERROR_MESSAGE")
	self:RegisterEvent("PLAYER_TALENT_UPDATE")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	self:RegisterEvent("UNIT_ENTERED_VEHICLE")
	self:RegisterEvent("UNIT_EXITED_VEHICLE")
	
	if ShockAndAwe.db.char.disabled then
        self:OnDisable()
    end
end

function ShockAndAwe:LibSharedMedia_Registered()
	media:Register("sound", "SAA Maelstrom 1", "Sound\\Spells\\ShootWandLaunchLightning.wav")
	media:Register("sound", "SAA Maelstrom 2", "Sound\\Spells\\DynamiteExplode.wav")
	media:Register("sound", "SAA Maelstrom 3", "Sound\\Spells\\ArmorKitBuffSound.wav")
	media:Register("sound", "SAA Maelstrom 4", "Sound\\Spells\\Fizzle\\FizzleShadowA.wav")
	media:Register("sound", "SAA Maelstrom 5", "Sound\\Spells\\LevelUp.wav")
	media:Register("sound", "SAA Maelstrom 6", "Sound\\Spells\\Tradeskills\\FishBite.wav")
	media:Register("sound", "SAA Maelstrom 7", "Sound\\Spells\\Tradeskills\\MiningHitA.wav")
	media:Register("sound", "SAA Maelstrom 8", "Sound\\Spells\\AspectofTheSnake.wav")
	media:Register("sound", "SAA Maelstrom 9", "Sound\\Spells\\bind2_Impact_Base.wav")
	media:Register("sound", "SAA Shield 1", "Sound\\Doodad\\BellowIn.wav")
	media:Register("sound", "SAA Shield 2", "Sound\\Doodad\\BellowOut.wav")
	media:Register("sound", "SAA Shield 3", "Sound\\Doodad\\PVP_Lordaeron_Door_Open.wav")
	media:Register("sound", "SAA Shield 4", "Sound\\Spells\\ShaysBell.wav")

	for k, v in pairs(media:List("statusbar")) do
		self.textures[v] = v
	end
	for k, v in pairs(media:List("border")) do
		self.borders[v] = v
	end
	for k, v in pairs(media:List("font")) do
		self.fonts[v] = v
	end
	for k, v in pairs(media:List("sound")) do
		self.sounds[v] = v
	end
end

----------------------
-- Event Routines
----------------------

function ShockAndAwe:UNIT_ENTERED_VEHICLE()
	if UnitInVehicle("player") then
		self:TidyUpAfterCombat() -- on entering vehicle treat as if out of combat ie: disable incombat displays
	end
end

function ShockAndAwe:UNIT_EXITED_VEHICLE()
	if not UnitInVehicle("player") and InCombatLockdown() then
		self:EnteredCombat()  -- if in combat when exit vehichle enable ShockAndAwe combat effects
	end
end

function ShockAndAwe:UNIT_POWER()
	self:UpdateShieldBar()
end

function ShockAndAwe:PLAYER_ENTERING_WORLD()
	self:SetBorderTexture(nil, ShockAndAwe.db.char.border)
	self:SetBarBorderTexture(nil, ShockAndAwe.db.char.barborder)
	self:SetTalentEffects()
	self:RedrawFrames()
	self:UpdateBindings()
	ShockAndAwe.db.char.priority.prOption = ShockAndAwe.db.char.priority.prOptions[ShockAndAwe.db.char.priority.groupnumber]
end

function ShockAndAwe:PLAYER_LOGIN()
	self:SetBorderTexture(nil, ShockAndAwe.db.char.border)
	self:SetBarBorderTexture(nil, ShockAndAwe.db.char.barborder)
	queryDisable = false -- when player first logs in set test for talents in Enh Spec to false
end

function ShockAndAwe:PLAYER_ALIVE()
	self:SetTalentEffects()
	self:RedrawFrames()
	self:UpdateBindings()
	if not queryDisable then -- only ask if not in Enh and addon active if this is fired immediately after first login
		self:QueryDisableAddon()
		queryDisable = true
	end
end

function ShockAndAwe:UNIT_AURA(_, ...)
	local arg1 = select(1,...) or ""
	if (arg1 == "player") then
		self:UpdateShieldBar()
		if GetSpecialization() == 2 then
			updateActiveMaelstrom = true
			ShockAndAwe.db.char.msstacks = self:GetMaelstromInfo()
			if ShockAndAwe.db.char.barstext and ShockAndAwe.db.char.msshow then
				self.frames["Maelstrom"].text:SetText(ShockAndAwe.db.char.msstacks.." stacks")
			else 
				self.frames["Maelstrom"].text:SetText("")
			end
			self:MaelstromBar()
		end
	end
end

function ShockAndAwe:CHAT_MSG_SPELL_SELF_DAMAGE(_, ...)
	if ShockAndAwe.db.char.wfshow then
		local arg1 = select(1,...) or ""
		if strfind(arg1, L["WF_Attack"]) then
			self:WFProcBar()
		end
	end
end

function ShockAndAwe:UI_ERROR_MESSAGE(_, ...)
	if ShockAndAwe.db.char.warning.range then
		local arg1 = select(1,...) or ""
		if strfind(arg1, L["Out of range"]) or strfind(arg1, L["too far away"]) then
			self:PrintMsg(arg1, ShockAndAwe.db.char.warning.colour, 0.5)
		end
	end
end

function ShockAndAwe:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
	if sourceGUID == UnitGUID("player") then
		local spellID = select(1,...) or 0
		if spellID == self.combat.wf_mh or spellID == self.combat.wf_oh then 
			if ShockAndAwe.db.char.wfshow then
				self:WFProcBar()
			end
		end
		if ShockAndAwe.db.char.stats.wfcalc then
			if event == "SWING_DAMAGE" then
				self:WFCalc("melee", select(1,...), select(7,...), event, dstName, destFlags, destGUID)
			elseif event == "SWING_MISSED" then
				self:WFCalc("melee", select(5,...), nil, event)
			elseif event == "SPELL_DAMAGE" then
				self:WFCalc(spellID, select(4,...), select(10,...), event, dstName, destFlags, destGUID)
			elseif event == "SPELL_MISSED" then
				self:WFCalc(spellID, select(5,...), nil, event, dstName, destFlags, destGUID)
			end
		end
		if event == "SPELL_AURA_REMOVED" then
			if GetSpellInfo(spellID) == ShockAndAwe.constants["Lightning Shield"] or GetSpellInfo(spellID) == ShockAndAwe.constants["Water Shield"] then
				if ShockAndAwe.db.char.warning.shield then
					self:PrintMsg(GetSpellInfo(spellID).." "..L["Expired"], ShockAndAwe.db.char.warning.colour, ShockAndAwe.db.char.warning.duration)
					PlaySoundFile(ShockAndAwe.db.char.shieldsound)
				end
			end
			if GetSpellInfo(spellID) == ShockAndAwe.constants["Ascendance"] then
			  	if ShockAndAwe.db.char.ssshow then
					-- self.frames["Stormstrike"]:Show()
					self.frames["Stormblast"]:Hide()
					-- self.frames["Stormstrike"].icon:Show()
					self.frames["Stormblast"].icon:Hide()
				end
			end
		end
		if ShockAndAwe.db.char.fsdotshow and (event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REFRESH") then
			if GetSpellInfo(spellID) == ShockAndAwe.constants["Flame Shock"] then
				self:FlameShockDotBar(true) -- debuff applied so setup bar
			end
		end
		if ShockAndAwe.db.char.warning.interrupt and event == "SPELL_INTERRUPT" then
			local spellName = select(5,...)
			if spellName then
				self:PrintMsg(L["Interrupted: "] .. spellName, ShockAndAwe.db.char.warning.colour, ShockAndAwe.db.char.warning.duration)
			end
		end
		if ShockAndAwe.db.char.warning.purge and event == "SPELL_DISPEL"  and (spellID == 370 or spellID == 8012) then
			local spellName = select(5,...)
			if spellName then
				self:PrintMsg(L["Purged: "] .. spellName, ShockAndAwe.db.char.warning.colour, ShockAndAwe.db.char.warning.duration)
			end
		end
		if event == "SPELL_SUMMON" and self:IsFireTotem(spellID) then
			fireTotemGUID = destGUID
		end
		if event == "SPELL_MISSED" then
			local missType = select(4, ...) or ""
			if missType == "IMMUNE" then
				local spellName = select(2, ...) or ""
				ShockAndAwe.db.char.immuneTargets[destName.."_"..spellName] = true
			end
		end
		if event == "SPELL_DAMAGE" then
			local spellName = select(2, ...) or ""
			if ShockAndAwe.db.char.immuneTargets[destName.."_"..spellName] then
				-- clear immunity if we managed to damage target with this spell - ie: it was a temporary immunity
				ShockAndAwe.db.char.immuneTargets[destName.."_"..spellName] = nil
			end
		end
		if event == "SPELL_SUMMON" and spellID == ShockAndAwe.SpellID["Stone Bulwark Totem"] then			
			StoneBulwarkInitial = true
			StoneBulwarkActive = true
			StoneBulwarkGUID = destGUID
		end
	else -- here its not the player who cast the spell so we are looking at grounding totem doing its job
		if ShockAndAwe.db.char.warning.grounding then
			if math.fmod(destFlags,65536) == 8465 and destName == ShockAndAwe.constants["Grounding Totem"] then
				local spellname = select(2,...)
				local damage = select(4,...) or "0"
				if spellname and damage ~= "0" then
					self:DebugPrint("grounded "..spellname.." damage:"..damage)
					self:PrintMsg(L["Grounded: "] .. spellname .. string.format(" (%s)",strlower(damage)), ShockAndAwe.db.char.warning.colour, ShockAndAwe.db.char.warning.duration)
				end
			end
		end
	end
	if destGUID == UnitGUID("player") and ShockAndAwe.db.char.warning.weapon and not ShockAndAwe.db.char.castweaponrebuff then
		if event == "ENCHANT_REMOVED" then
			if self:MainHandBuffMissing() or self:OffHandBuffMissing() then
				self:PrintMsg(L["Weapon Buff Expired"], ShockAndAwe.db.char.warning.colour, ShockAndAwe.db.char.warning.duration)
				PlaySoundFile(ShockAndAwe.db.char.weaponsound)
			end
		end
	end
	if event == "UNIT_DIED" and destGUID == fireTotemGUID then
		self.frames["fireTotem"]:Hide()
		self.frames["fireTotem"].icon:Hide()
		FireTotemTime = GetTime()
		ShockAndAwe.db.char.priority.firetotemtime = FireTotemTime
	end
	
	-- Stone Bulwark Shield Apply/Refresh
	if sourceGUID == StoneBulwarkGUID and 
	   destGUID == UnitGUID("player") then
	   
	   	if event == "SPELL_AURA_APPLIED" or 
	   	   event == "SPELL_AURA_REFRESH" then
	
			self:StoneBulwarkApply(true)
		
		elseif event == "SPELL_AURA_REMOVED" then
		
			self:StoneBulwarkApply(false)
		end
	end
	
	-- Totem Died
	if event == "UNIT_DIED" then
		if destGUID == StoneBulwarkGUID then
		
			StoneBulwarkActive = false

		end
	end
	
	-- Totem Recalled
	if event == "UNIT_DESTROYED" then
		if destGUID == StoneBulwarkGUID then
		
			StoneBulwarkActive = false

		end
	end
end

function ShockAndAwe:SPELL_UPDATE_COOLDOWN()
	if ShockAndAwe.db.char.gcdshow then
		self:GCDBar()
	end
end

function ShockAndAwe:UNIT_SPELLCAST_SUCCEEDED(_, ...)
	local arg1 = select(1,...) or ""
	local arg2 = select(2,...) or ""
	if arg1 == "player" then -- skip if someone else casting
		if ShockAndAwe.db.char.ssshow then
			if arg2 == ShockAndAwe.constants["Stormstrike"] then
				self:StormstrikeBar()
			end
			if arg2 == ShockAndAwe.constants["Stormblast"] then
				self:StormblastBar()
			end
		end
		
		if arg2 == ShockAndAwe.constants["Ascendance"] then
			if ShockAndAwe.db.char.ssshow then
				self.frames["Stormstrike"]:Hide()
				-- self.frames["Stormblast"]:Show()
				self.frames["Stormstrike"].icon:Hide()
				-- self.frames["Stormblast"].icon:Show()
			end
		end	
		
		if ShockAndAwe.db.char.fnshow then
			if arg2 == ShockAndAwe.constants["Fire Nova"] then
				self:FireNovaBar()
			end
		end
		
		if ShockAndAwe.db.char.shieldshow then
			self:SetShieldType(arg2)
			self:UpdateShieldBar()
		end	
		
		if arg2 == ShockAndAwe.constants["Earth Shock"] then
			local colours = ShockAndAwe.db.char.colours.earthshock
			ShockAndAwe.db.char.lastshock = ShockAndAwe.constants["Earth Shock"]
			self:SetBarIcon(self.frames["Shock"].icon, 8042)
			if ShockAndAwe.db.char.shockshow then
				self:ShockBar(colours)
			end
		elseif arg2 == ShockAndAwe.constants["Flame Shock"] then
			local colours = ShockAndAwe.db.char.colours.flameshock
			ShockAndAwe.db.char.lastshock = ShockAndAwe.constants["Flame Shock"]
			self:SetBarIcon(self.frames["Shock"].icon, 8050)
			if ShockAndAwe.db.char.shockshow then
				self:ShockBar(colours)
			end
		elseif arg2 == ShockAndAwe.constants["Frost Shock"] then
			local colours = ShockAndAwe.db.char.colours.frostshock
			ShockAndAwe.db.char.lastshock = ShockAndAwe.constants["Frost Shock"]
			self:SetBarIcon(self.frames["Shock"].icon, 8056)
			if ShockAndAwe.db.char.shockshow then
				self:ShockBar(colours)
			end
		end
		
		if ShockAndAwe.db.char.shearshow and arg2 == ShockAndAwe.constants["Wind Shear"] then
				self:SetBarIcon(self.frames["Shear"].icon, 57994)
				self:ShearBar()
		end
		
		if arg2 == ShockAndAwe.constants["Magma Totem"] or arg2 == ShockAndAwe.constants["Searing Totem"] or 
		   arg2 == ShockAndAwe.constants["Fire Elemental Totem"]  or arg2 == ShockAndAwe.constants["Frost Resistance Totem"]  or arg2 == ShockAndAwe.constants["Flametongue Totem"] then 
			self:FireTotemBar(arg2)
		end
		
		if arg2 == ShockAndAwe.constants["Totemic Recall"] then
			FireTotemTime = GetTime()
			ShockAndAwe.db.char.priority.firetotemtime = FireTotemTime
		end
		
		if ShockAndAwe.db.char.llshow then
			if arg2 == ShockAndAwe.constants["Lava Lash"] then 
				self:LavaLashBar()
			end
		end
		
		if ShockAndAwe.db.char.fsshow then
			if arg2 == ShockAndAwe.constants["Feral Spirit"] then 
				self:FeralSpiritBar()
			end
		end
		
		if ShockAndAwe.db.char.unleashelementsshow then
			if arg2 == ShockAndAwe.constants["Unleash Elements"] then 
				self:UnleashBar()
			end
		end
		
		if ShockAndAwe.db.char.ElementalBlastShow then
			if arg2 == ShockAndAwe.constants["Elemental Blast"] then 
				self:ElementalBlastBar()
			end
		end
		
		if arg2 == ShockAndAwe.constants["Windfury Weapon"] or arg2 == ShockAndAwe.constants["Flametongue Weapon"] or arg2 == ShockAndAwe.constants["Frostbrand Weapon"] or arg2 == ShockAndAwe.constants["Earthliving Weapon"] then
			ShockAndAwe.db.char.castweaponrebuff = true
		else
			ShockAndAwe.db.char.castweaponrebuff = false
		end
		if ShockAndAwe.db.char.sbtshow and self:StoneBulwarkKnown() then
			if arg2 == ShockAndAwe.constants["Stone Bulwark Totem"] then 
				self:StoneBulwarkBar()
			end
		end
	end
end

function ShockAndAwe:CHARACTER_POINTS_CHANGED()
	self:SetTalentEffects()
	self:CreateBaseFrame()
end

function ShockAndAwe:PLAYER_REGEN_DISABLED() -- Entering Combat
	self:EnteredCombat()
end

function ShockAndAwe:PLAYER_REGEN_ENABLED() -- Leaving Combat
	self:TidyUpAfterCombat()
end

function ShockAndAwe:PLAYER_TARGET_CHANGED()
	if ShockAndAwe.db.char.priority.show and InCombatLockdown() then
		self:FlameShockDotBar(false) -- force update on FS dot bar after target change
		self:SetNextPriority()
	end
end

function ShockAndAwe:UPDATE_BINDINGS()
	if not InCombatLockdown() then
		self:UpdateBindings()
	end
end

function ShockAndAwe:PLAYER_TALENT_UPDATE()
	self:SetTalentEffects()
	self:RedrawFrames()
end

function ShockAndAwe:ACTIVE_TALENT_GROUP_CHANGED(index)
	self:QuerySpecChanged()
end

----------------------------
-- Combat start and stop
----------------------------

function ShockAndAwe:EnteredCombat()
	if UnitInVehicle("player") then -- don't enable priorities & bars if we enter combat in a vehicle
		return
	end
	if ShockAndAwe.db.char.disablebars then
		self.BaseFrame:Show()
	end
	if ShockAndAwe.db.char.msshow then
		self:SetMaelstromAlpha(ShockAndAwe.db.char.colours.msalpha) -- set maelstrom frame to in combat alpha
	end
	if ShockAndAwe.db.char.fsshow then
		FSMin, FSMax = self.frames["FeralSpirit"].statusbar:GetMinMaxValues()
		updateActiveFeralSpirit = true -- forces an update to check if puppies still available on re-entering combat
		self:FeralSpiritCDBar()
	end
	if ShockAndAwe.db.char.uptime.show then
		if not self.uptime.incombat then
			self.uptime.incombat = true
			-- reset last fight data on entering combat
			self:InitialiseUptimeBuffs(self.uptime.lastfight)
			self.uptime.currentTime = GetTime()
			self:UpdateUptime()
			self:UpdateUptimeFrames(true)
			self.uptime.TimerEvent = self:ScheduleRepeatingTimer("UpdateUptime", 0.1, nil);
		end
	end
	if GetSpecialization() ~= 2 then -- check MW talents again to counter Player_Entering_World bug
		self:SetTalentEffects()
		self:CreateBaseFrame()
	end
	if ShockAndAwe.db.char.priority.show and not ShockAndAwe.db.char.disabled then
		ShockAndAwe.db.char.priority.next = "none"
		self:SetPriorityIcon(ShockAndAwe.db.char.priority.next)
		self.updatePriority = true
		self.PriorityFrame:Show()
	end
	if ShockAndAwe.db.char.warning.weapon then
		if self:MainHandBuffMissing() or self:OffHandBuffMissing() then
			self:PrintMsg(L["Missing Weapon Buffs"], ShockAndAwe.db.char.warning.colour, ShockAndAwe.db.char.warning.duration)
			PlaySoundFile(ShockAndAwe.db.char.weaponsound)
		end
	end
	lastshock = ""
end

function ShockAndAwe:TidyUpAfterCombat()
	self.frames["Maelstrom"]:Hide()
	self.frames["Maelstrom"].icon:Hide()
	self.frames["Shield"].icon:Hide()
	-- self.frames["Shock"].icon:Hide()
	-- self.frames["Shear"].icon:Hide()
	-- self.frames["Stormstrike"].icon:Hide()
	-- self.frames["Stormblast"].icon:Hide()
	-- self.frames["LavaLash"].icon:Hide()
	-- self.frames["Unleash"].icon:Hide()
	self:SetPriorityIcon("none")
	self.updatePriority = false
	self.PriorityFrame:Hide()
	if ShockAndAwe.db.char.uptime.show then
		if self.uptime.incombat then
			self:UpdateUptime()
			self.uptime.incombat = false
			self:UpdateUptimeFrames(true)
			self:CancelTimer(self.uptime.TimerEvent , false)
		end
	end
	if ShockAndAwe.db.char.fsshow then
		self.frames["FeralSpirit"].icon:Hide() 
		self.frames["FeralSpiritCD"]:Hide()
	end
	if ShockAndAwe.db.char.disablebars then
		self.BaseFrame:Hide()
	end
	if not ShockAndAwe.db.char.binding.macroset then
		-- call update Bindings to set macro keys if we were in combat when addon initialised
		self:UpdateBindings()
	end
	--collectgarbage()
end

----------------------------
-- Question box handler
----------------------------

function ShockAndAwe:QuerySpecChanged()
	if ShockAndAwe.db.char.specchangewarning then
		if GetSpecialization() ~= 2 and not ShockAndAwe.db.char.disabled then
			-- addon is enabled but we have changed to a non Enhance Spec ask if we should disable addon
			self:DisplayQuestionFrame(false, true)
		elseif GetSpecialization() == 2 and ShockAndAwe.db.char.disabled then
			-- addon is disabled and we have changed to an Enhance Spec ask if we should enable addon
			self:DisplayQuestionFrame(true, true)
		end
	end
end

function ShockAndAwe:QueryDisableAddon()
	if GetSpecialization() ~= 2 then -- check MW talents again to counter Player_Entering_World bug
		self:SetTalentEffects()
	end
	if UnitLevel("player") >= 60 then -- don't bother asking to disable addon if player under level 60.
		if GetSpecialization() ~= 2 and not ShockAndAwe.db.char.disabled then
			-- addon is enabled but we have changed to a non Enhance Spec ask if we should disable addon
			self:DisplayQuestionFrame(false, false)
		elseif GetSpecialization() == 2 and ShockAndAwe.db.char.disabled then
			-- addon is disabled and we have changed to an Enhance Spec ask if we should enable addon
			self:DisplayQuestionFrame(true, false)
		end
	end
end

StaticPopupDialogs["SAA_QUESTION_FRAME"] = {
	text = L["You have changed to a new talent spec do you want to enable ShockAndAwe?"],
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		ShockAndAwe:EnableDisable()
	end,
	timeout = 0,
	hideOnEscape = 1,
}

function ShockAndAwe:DisplayQuestionFrame(enable, spec)
	if spec then
		if enable then 
			StaticPopupDialogs["SAA_QUESTION_FRAME"].text = L["You have changed to a new talent spec do you want to enable ShockAndAwe?"]
		else
			StaticPopupDialogs["SAA_QUESTION_FRAME"].text = L["You have changed to a new talent spec do you want to disable ShockAndAwe?"]
		end
	else
		if enable then 
			StaticPopupDialogs["SAA_QUESTION_FRAME"].text = L["You are in Enhancement spec do you want to enable ShockAndAwe?"]
		else
			StaticPopupDialogs["SAA_QUESTION_FRAME"].text = L["You are NOT in Enhancement spec do you want to disable ShockAndAwe?"]
		end
	end
	self:DebugPrint("entered DisplayQuestionFrame, text is :"..StaticPopupDialogs["SAA_QUESTION_FRAME"].text)
	StaticPopup_Show("SAA_QUESTION_FRAME")
end
	
-------------------------
-- Shield bar routines
-------------------------

function ShockAndAwe:GetShieldInfo()
	local index = 1
	ShieldTime = 0
	while UnitBuff("PLAYER", index) do
		local name, _, _, count, _, _, shieldExpires = UnitBuff("PLAYER", index)
		ShieldTime = shieldExpires
		if self:SetShieldType(name) then
		    if name == ShockAndAwe.constants["Water Shield"] then
				count = 1 -- water shield no longer has charges so always return 1. Lightning Shield also doesn't have charges for Enhancement, but the charges might be interesting for Elemental Shaman
			end
		
			return count, name, shieldExpires
		end
		index = index + 1
	end
	return 0, "", 0
end

function ShockAndAwe:SetShieldType(name)
	local colours = ShockAndAwe.db.char.colours;
	if name == ShockAndAwe.constants["Water Shield"] then
		self:ShieldBar(colours.watershield.r, colours.watershield.g, colours.watershield.b, colours.watershield.a)
		self:SetBarIcon(self.frames["Shield"].icon, 52127)
		return true
	elseif name == ShockAndAwe.constants["Lightning Shield"] then
		self:ShieldBar(colours.lightningshield.r, colours.lightningshield.g, colours.lightningshield.b, colours.lightningshield.a)
		self:SetBarIcon(self.frames["Shield"].icon, 324)
		return true
	elseif name == ShockAndAwe.constants["Earth Shield"] then
		self:ShieldBar(colours.earthshield.r, colours.earthshield.g, colours.earthshield.b, colours.earthshield.a)
		self:SetBarIcon(self.frames["Shield"].icon, 974)
		return true
	end
	return false
end	

function ShockAndAwe:UpdateShieldBar()
	if ShockAndAwe.db.char.shieldshow and not ShockAndAwe.db.char.disabled then
		
		-- removed this call because it can cause an "interface action failed because of an add on" error
		-- the function self.BaseFrame:Show() is also called in the event routine when entering combat so it should not be needed here
        -- calling this function 2 times at the same time might have caused this problem
		-- if ShockAndAwe.db.char.disablebars and InCombatLockdown() then
			-- self.BaseFrame:Show()
		-- end
		local orbs, shieldType = ShockAndAwe:GetShieldInfo()
		if orbs == 0 then
			updateActiveShield = false
			self.frames["Shield"].spark:Hide()
			self.frames["Shield"].statusbar:SetValue(3600)
			if ShockAndAwe.db.char.barstext then
				self.frames["Shield"].text:SetText(L["No Shield Active"])
			else
				self.frames["Shield"].text:SetText("")
			end
		else
			updateActiveShield = true
			self.frames["Shield"].spark:Show()
			self.frames["Shield"].statusbar:SetValue(ShieldTime - GetTime())
			if ShockAndAwe.db.char.barstext then
				local orbstext = string.format(L["%s orbs remaining"], orbs)
				self.frames["Shield"].text:SetText(orbstext)
			else
				self.frames["Shield"].text:SetText("")
			end
			self.frames["Shield"]:Show()
		end
		if not updateActiveShield then
			local colours = ShockAndAwe.db.char.colours
			if UnitMana("player") == UnitManaMax("player") then
				-- shield down but at max mana
				self.frames["Shield"].statusbar:SetStatusBarColor(colours.noshield.r, colours.noshield.g, colours.noshield.b, .2)
				self.frames["Shield"]:SetBackdropBorderColor(1, 1, 1, .2);
			else 
				-- shield down but not at max mana
				self.frames["Shield"].statusbar:SetStatusBarColor(colours.noshield.r, colours.noshield.g, colours.noshield.b, 1)
				self.frames["Shield"]:SetBackdropBorderColor(1, 1, 1, 1);
			end
		end
		self.frames["Shield"].text:Show()
		self:SetShieldType(shieldType)
		if ShockAndAwe.db.char.disablebars and not InCombatLockdown() then
			self.BaseFrame:Hide()
		end
	else
		self.frames["Shield"]:Hide()
	end
end

---------------------------
-- Buff Info functions
---------------------------

function ShockAndAwe:GetMaelstromInfo()
	local index = 1
	while UnitBuff("PLAYER", index) do
		local name, _, _, count, _, _, maelstromTime = UnitBuff("PLAYER", index)
		if name == ShockAndAwe.constants["Maelstrom Weapon"] then
			return count, maelstromTime
		end
		index = index + 1
	end
	return 0, 0 
end

---------------------------
-- functions
---------------------------

function ShockAndAwe:IsFireTotem(spellID)
	if spellID == 8227 or spellID == 3599 or spellID == 8190 or spellID == 2894 then
		return true
	else
		return false
	end
end

function ShockAndAwe:FireNovaGlyph()
	local numglyphs = GetNumGlyphSockets()
	local fnGlyph = false
	for index = 1, numglyphs do
		local _, _, _, spellID = GetGlyphSocketInfo(index)
		if spellID == 55450 then
			fnGlyph = true
		end
	end
	if fnGlyph then 
		return 3
	else
		return 0
	end
end

function ShockAndAwe:EnablePetFrame()
	if not oldHasPetUI then 
		oldHasPetUI = HasPetUI; 
		HasPetUI = function() 
			return true, false; 
		end
	end
	--PetTab_Update() 
	ToggleCharacter("PetPaperDollFrame")
end

function ShockAndAwe:RedrawFrames()
	self:CreateBaseFrame()
	self:CreateUptimeFrame()
end

function ShockAndAwe:SetTalentEffects()

	ShockAndAwe.db.char.maelstromTalents = 5
 
    updateActiveMaelstrom = true
		
	ShockAndAwe.db.char.feralSpiritTalented = true
	
	ShockAndAwe.db.char.FNlen = 4  -- changed in patch 4.1
	-- TODO replace this with programatic gear check if person has arena gear
	if ShockAndAwe.db.char.arena then
		ShockAndAwe.db.char.SSlen = 6 -- arena bonus reduces by 2 sec.
	else
		ShockAndAwe.db.char.SSlen = 8
	end
	ShockAndAwe.db.char.SBlen = 8
	ShockAndAwe.db.char.EBlen = 12
	ShockAndAwe.db.char.EBBufflen = 8
	ShockAndAwe.db.char.maxLen = 12 --ShockAndAwe.db.char.LLlen
	ShockAndAwe.db.char.SSPercent = ShockAndAwe.db.char.SSlen /  ShockAndAwe.db.char.maxLen
	ShockAndAwe.db.char.SBPercent = ShockAndAwe.db.char.SBlen /  ShockAndAwe.db.char.maxLen
	ShockAndAwe.db.char.EBPercent = ShockAndAwe.db.char.EBlen / ShockAndAwe.db.char.maxLen
	ShockAndAwe.db.char.EBBuffPercent = ShockAndAwe.db.char.EBBufflen / ShockAndAwe.db.char.maxLen
	ShockAndAwe.db.char.LLPercent = ShockAndAwe.db.char.LLlen / ShockAndAwe.db.char.maxLen
	ShockAndAwe.db.char.FNPercent = ShockAndAwe.db.char.FNlen / ShockAndAwe.db.char.maxLen
	ShockAndAwe.db.char.ShockLen = 6
	ShockAndAwe.db.char.EarthShockLen = 6
	ShockAndAwe.db.char.ShearLen = 12
	ShockAndAwe.db.char.StoneBulwarkLen = 30
	ShockAndAwe.db.char.ShockPercent = ShockAndAwe.db.char.ShockLen / ShockAndAwe.db.char.maxLen
	ShockAndAwe.db.char.EarthShockPercent = ShockAndAwe.db.char.EarthShockLen / ShockAndAwe.db.char.maxLen
	ShockAndAwe.db.char.ShearPercent = ShockAndAwe.db.char.ShearLen / ShockAndAwe.db.char.maxLen
	ShockAndAwe.db.char.StoneBulwarkPercent = 1 --ShockAndAwe.db.char.StoneBulwarkLen / ShockAndAwe.db.char.maxLen
	ShockAndAwe.db.char.WFProcPercent = 3 / ShockAndAwe.db.char.maxLen
	if ShockAndAwe.db.char.gcdfullwidth then
		GCDPercent = 1
	else
		GCDPercent = 1.5 / ShockAndAwe.db.char.maxLen
	end
end

function ShockAndAwe:DisplayVersion()
	self:Print(self.version)
end

function ShockAndAwe:CreateBaseFrame()
	if not ShockAndAwe.db.char.SSPercent or not ShockAndAwe.db.char.WFProcPercent or not ShockAndAwe.db.char.ShockPercent or not ShockAndAwe.db.char.ShearPercent or not ShockAndAwe.db.char.LLPercent or not ShockAndAwe.db.char.FNPercent or not GCDPercent then
		self:SetTalentEffects()
	end
	self.BaseFrame:SetScale(ShockAndAwe.db.char.scale)
	self.BaseFrame:SetFrameStrata("BACKGROUND")
	self.BaseFrame:SetWidth(ShockAndAwe.db.char.fWidth + ShockAndAwe.db.char.fHeight / 7)
	self.BaseFrame:SetHeight(ShockAndAwe.db.char.fHeight)
	self.BaseFrame:SetBackdrop(self.frameBackdrop)
	self.BaseFrame:SetBackdropColor(1, 1, 1, 0)
	self.BaseFrame:SetMovable(true)
	self.BaseFrame:RegisterForDrag("LeftButton")
	self.BaseFrame:SetPoint(ShockAndAwe.db.char.point, ShockAndAwe.db.char.relativeTo, ShockAndAwe.db.char.relativePoint, ShockAndAwe.db.char.xOffset, ShockAndAwe.db.char.yOffset)
	self.BaseFrame:SetScript("OnDragStart", 
		function()
			self.BaseFrame:StartMoving();
		end );
	self.BaseFrame:SetScript("OnDragStop",
		function()
			self.BaseFrame:StopMovingOrSizing();
			self.BaseFrame:SetScript("OnUpdate", nil);
			self:FinishedMoving(ShockAndAwe.db.char, self.BaseFrame);
		end );
	self.BaseFrame:Show()
	ShockAndAwe.db.char.movingframes = false
	
	local barHeight = ShockAndAwe.db.char.fHeight / 7
	local baseOffset = (-1 * barHeight) + 3
	local barCount = 0
	local colours = ShockAndAwe.db.char.colours.feralspiritCD
	ShockAndAwe:SetBarFrame(self.frames["FeralSpiritCD"], 
					ShockAndAwe.db.char.fWidth, barHeight,
					barCount * baseOffset, 1,
					0, 120, 
					120, ShockAndAwe.db.char.fWidth - 6,
					colours.r, colours.g, colours.b, colours.a,
					false)
	local colours = ShockAndAwe.db.char.colours.feralspirit
	ShockAndAwe:SetBarFrame(self.frames["FeralSpirit"], 
					30/120 * ShockAndAwe.db.char.fWidth, barHeight,
					barCount * baseOffset, 2,
					0, 30, 
					30, 1,
					colours.r, colours.g, colours.b, colours.a,
					true)
	if ShockAndAwe.db.char.fsshow then
		barCount = barCount + 1 -- we will use feral spirit frame 
	end
	
	local colours = ShockAndAwe.db.char.colours.noshield
	ShockAndAwe:SetBarFrame(self.frames["Shield"], 
					ShockAndAwe.db.char.fWidth, barHeight,
					barCount * baseOffset, 1,
					0, 3600, 
					3600, ShockAndAwe.db.char.fWidth - 6,
					colours.r, colours.g, colours.b, colours.a,
					true)
	if ShockAndAwe.db.char.shieldshow then
		barCount = barCount + 1 -- we will use shield frame 
	end
	
	local colours = ShockAndAwe.db.char.colours.magma
	ShockAndAwe:SetBarFrame(self.frames["fireTotem"], 
					ShockAndAwe.db.char.fWidth, barHeight,
					barCount * baseOffset, 1,
					0, 60, 
					60, ShockAndAwe.db.char.fWidth - 6,
					colours.r, colours.g, colours.b, colours.a,
					true)
	if ShockAndAwe.db.char.firetotemshow then
		barCount = barCount + 1 -- we will use firetotem frame 
	end
	
	ShockAndAwe:SetBarFrame(self.frames["GCD"], 
					ShockAndAwe.db.char.fWidth * GCDPercent, barHeight,
					barCount * baseOffset, 1,
					0, 1.5, 
					6, 1, 
					.6, .6, .6, .6,
					false)
	self.GCDWidth = self.frames["GCD"].statusbar:GetWidth() -- to account for spark width
	if ShockAndAwe.db.char.gcdshow then
		barCount = barCount + 1 -- we will use gcd frame 
	end
	
	colours = ShockAndAwe.db.char.colours.maelstrom
	ShockAndAwe:SetBarFrame(self.frames["Maelstrom"], 
					ShockAndAwe.db.char.fWidth, barHeight,
					barCount * baseOffset, 1,
					0, 30, 
					6, 1, 
					colours.r, colours.g, colours.b, ShockAndAwe.db.char.colours.msalpha,
					true)
	if ShockAndAwe.db.char.msshow then
		barCount = barCount + 1 -- we will use maelstrom frame 
	end
	
	colours = ShockAndAwe.db.char.colours.flameshockDot
	ShockAndAwe:SetBarFrame(self.frames["FS_DOT"], 
					ShockAndAwe.db.char.fWidth, barHeight, 
					barCount * baseOffset, 1,
					0, self:getFSDotDuration(), 
					1, 0.8, 
					colours.r, colours.g, colours.b, colours.a,
					true)
	if ShockAndAwe.db.char.fsdotshow then
		barCount = barCount + 1
	end
	
	local colours = ShockAndAwe.db.char.colours.unleash
	ShockAndAwe:SetBarFrame(self.frames["Unleash"], 
					ShockAndAwe.db.char.fWidth, barHeight,
					barCount * baseOffset, 1,
					0, 15, 
					15, ShockAndAwe.db.char.fWidth - 6,
					colours.r, colours.g, colours.b, colours.a,
					true)
	if ShockAndAwe.db.char.unleashelementsshow then
		barCount = barCount + 1 
	end
	
	local colours = ShockAndAwe.db.char.colours.ElementalBlast
	ShockAndAwe:SetBarFrame(self.frames["ElementalBlast"], 
					ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.EBPercent, barHeight,
					barCount * baseOffset, 1,
					0, 12, 
					12, 1,
					colours.r, colours.g, colours.b, colours.a,
					true)
	local colours = ShockAndAwe.db.char.colours.ElementalBlastBuff
	ShockAndAwe:SetBarFrame(self.frames["ElementalBlastBuff"],
					ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.EBBuffPercent, barHeight,
					barCount * baseOffset, 1,
					0, 8, 
					8, 1,
					colours.r, colours.g, colours.b, colours.a,
					false)
	if ShockAndAwe.db.char.ElementalBlastShow then -- TODO Bertel only if spell known
		barCount = barCount + 1 
	end
	
	ShockAndAwe:SetBarFrame(self.frames["LavaLash"], 
					ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.LLPercent, barHeight, 
					barCount * baseOffset, 1,
					0, ShockAndAwe.db.char.LLlen, 
					10, 1, 
					colours.r, colours.g, colours.b, colours.a,
					true)
	if ShockAndAwe.db.char.llshow then
		barCount = barCount + 1 -- we will use LavaLash frame 
	end
	
	colours = ShockAndAwe.db.char.colours.stormstrike
	ShockAndAwe:SetBarFrame(self.frames["Stormstrike"], 
					ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.SSPercent, barHeight, 
					barCount * baseOffset, 1,
					0, ShockAndAwe.db.char.SSlen, 
					0.4, 0.4, 
					colours.r, colours.g, colours.b, colours.a,
					true)
	ShockAndAwe:SetBarFrame(self.frames["Stormblast"], 
					ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.SBPercent, barHeight, 
					barCount * baseOffset, 1,
					0, ShockAndAwe.db.char.SBlen, 
					0.4, 0.4, 
					colours.r, colours.g, colours.b, colours.a,
					true)
	if ShockAndAwe.db.char.ssshow and not ShockAndAwe.db.char.wfoverlay then
		barCount = barCount + 1 -- we will use Stormstrike frame 
	end				
	colours = ShockAndAwe.db.char.colours.windfury
	ShockAndAwe:SetBarFrame(self.frames["Windfury"], 
					ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.WFProcPercent, barHeight, 
					barCount * baseOffset, 2,
					0, 3, 
					3, (ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.WFProcPercent - 6),
					colours.r, colours.g, colours.b, colours.a,
					true)
	if  ShockAndAwe.db.char.wfshow or (ShockAndAwe.db.char.wfoverlay and ShockAndAwe.db.char.ssshow) then
		barCount = barCount + 1 
	end
	ShockAndAwe:SetBarFrame(self.frames["Shock"], 
					ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.ShockPercent, barHeight, 
					barCount * baseOffset, 1,
					0, ShockAndAwe.db.char.ShockLen, 
					1, 0.8, 
					0, 1, .3, .9,
					true)
	if ShockAndAwe.db.char.shockshow then
		barCount = barCount + 1
	end
	colours = ShockAndAwe.db.char.colours.firenova
	ShockAndAwe:SetBarFrame(self.frames["FireNova"], 
					ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.FNPercent, barHeight, 
					barCount * baseOffset, 1,
					0, ShockAndAwe.db.char.FNlen, 
					0.4, 0.4, 
					colours.r, colours.g, colours.b, colours.a,
					true)
	if ShockAndAwe.db.char.fnshow then
		barCount = barCount + 1
	end
	ShockAndAwe:SetBarFrame(self.frames["Shear"], 
					ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.ShearPercent, barHeight, 
					barCount * baseOffset, 1,
					0, ShockAndAwe.db.char.ShearLen, 
					1, 0.8, 
					0, 1, .3, .9,
					true)
	if ShockAndAwe.db.char.shearshow then
		barCount = barCount + 1
	end
	ShockAndAwe:SetBarFrame(self.frames["StoneBulwark"], 
					ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.StoneBulwarkPercent, barHeight, 
					barCount * baseOffset, 1,
					0, ShockAndAwe.db.char.StoneBulwarkLen, 
					1, 0.8, 
					0, 1, .3, .9,
					true)
	if ShockAndAwe.db.char.sbtshow then
		barCount = barCount + 1
	end
	
	self:SetBarIcon(self.frames["Stormstrike"].icon, 17364)
	self:SetBarIcon(self.frames["Stormblast"].icon, 115356)
	self:SetBarIcon(self.frames["Windfury"].icon, 8232)
	self:SetBarIcon(self.frames["FeralSpirit"].icon, 51533)
	self:SetBarIcon(self.frames["LavaLash"].icon, 60103)
	self:SetBarIcon(self.frames["Maelstrom"].icon, 53817)
	self:SetBarIcon(self.frames["Unleash"].icon, 73680)
	self:SetBarIcon(self.frames["ElementalBlast"].icon, 117014)
	self:SetBarIcon(self.frames["FS_DOT"].icon, 8050)
	self:SetBarIcon(self.frames["StoneBulwark"].icon, 108270)
	self:UpdateShieldBar()
end

function ShockAndAwe:SetBarFrame(frameName, barWidth, barHeight, frameOffset, frameLevel, minValue, maxValue, frameValue, frameSpark, frameR, frameG, frameB, frameAlpha, icon)
	frameName:SetFrameStrata("LOW")
	frameName:SetWidth(barWidth)
	frameName:SetHeight(barHeight)
	frameName:ClearAllPoints()
	frameName:SetPoint("TOPLEFT", self.BaseFrame, "TOPLEFT", barHeight, frameOffset)
	frameName:SetBackdrop(self.barBackdrop);
	frameName:SetBackdropColor(0, 0, 0, .2);
	frameName:SetBackdropBorderColor( 1, 1, 1, 1);
	frameName:EnableMouse(false)
	if not frameName.statusbar then
		frameName.statusbar = CreateFrame("StatusBar", nil, frameName)
	end
	frameName.statusbar:SetFrameLevel(frameLevel)
	frameName.statusbar:ClearAllPoints()
	frameName.statusbar:SetHeight(barHeight - 6)
	frameName.statusbar:SetWidth(barWidth - 6)
	frameName.statusbar:SetPoint("TOPLEFT", frameName, "TOPLEFT", 3, -3)
	frameName.statusbar:SetStatusBarTexture(media:Fetch("statusbar", ShockAndAwe.db.char.texture))
	frameName.statusbar:GetStatusBarTexture():SetHorizTile(true) -- fix for textures stretching rather than revealing
	frameName.statusbar:SetStatusBarColor(frameR, frameG, frameB, frameAlpha)
	frameName.statusbar:SetMinMaxValues(minValue,maxValue)
	frameName.statusbar:SetValue(frameValue)
	
	if not frameName.spark then
		frameName.spark = frameName.statusbar:CreateTexture(nil, "OVERLAY")
	end
	frameName.spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	frameName.spark:SetWidth(16)
	frameName.spark:SetHeight(barHeight + 16)
	frameName.spark:SetBlendMode("ADD")
	frameName.spark:SetPoint("CENTER",frameName.statusbar,"BOTTOMLEFT",(barWidth - 6)* frameSpark, -1)
	frameName.spark:Show()
	
	if not frameName.text then
		frameName.text = frameName:CreateFontString(nil,"OVERLAY")
	end
	local barfont = media:Fetch("font", ShockAndAwe.db.char.barfont)
	frameName.text:SetFont(barfont, ShockAndAwe.db.char.barfontsize, ShockAndAwe.db.char.barfonteffect)
	frameName.text:ClearAllPoints()
	frameName.text:SetTextColor(1, 1, 1, 1)
	frameName.text:SetPoint("CENTER", frameName, "CENTER");
	frameName.text:SetText("")

	frameName:SetScript("OnUpdate", 
		function()
			ShockAndAwe:OnBarUpdate();
		end );
	if icon then
		frameName.icon:SetWidth(barHeight - 3) -- same as height to get square box
		frameName.icon:SetHeight(barHeight - 3)
		frameName.icon:SetPoint("TOPRIGHT", frameName, "TOPLEFT", 0 , -2)
		frameName.icon:Hide()
	end	
	frameName:Hide()
end

function ShockAndAwe:SetBarIcon(iconFrame, spellID)
	local _, _, icon = GetSpellInfo(spellID)
	iconFrame:SetBackdrop({
		bgFile = icon,
		--edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 12,
		insets = { left = 0, right = 0, top = 0, bottom = 0 } })
end

function ShockAndAwe:getFSDotDuration()
	local numglyphs = GetNumGlyphSockets()
	local fnGlyph = false
	for index = 1, numglyphs do
		local _, _, _, spellID = GetGlyphSocketInfo(index)
		if spellID == 55447 then
			fnGlyph = true
		end
	end
	if fnGlyph then 
		return 30
	else
		return 24
	end
end

function ShockAndAwe:ResetBars()
	self.BaseFrame:ClearAllPoints()
	ShockAndAwe.db.char.point = self.defaults.char.point
	ShockAndAwe.db.char.relativeTo = self.defaults.char.relativeTo 
	ShockAndAwe.db.char.relativePoint = self.defaults.char.relativePoint
	ShockAndAwe.db.char.xOffset = self.defaults.char.xOffset
	ShockAndAwe.db.char.yOffset = self.defaults.char.yOffset
	ShockAndAwe.db.char.fWidth = self.defaults.char.fWidth
	ShockAndAwe.db.char.fHeight = self.defaults.char.fHeight
	ShockAndAwe.db.char.scale = self.defaults.char.scale
	ShockAndAwe.db.char.barfont = self.defaults.char.barfont
	ShockAndAwe.db.char.barfontsize = self.defaults.char.barfontsize
	ShockAndAwe.db.char.bartexture = self.defaults.char.bartexture
	ShockAndAwe.db.char.texture = self.defaults.char.texture
	self.BaseFrame:SetPoint(ShockAndAwe.db.char.point, ShockAndAwe.db.char.relativeTo, ShockAndAwe.db.char.relativePoint, ShockAndAwe.db.char.xOffset, ShockAndAwe.db.char.yOffset)
	ShockAndAwe:SetTalentEffects()
	self:RedrawFrames()
	ShockAndAwe.db.char.movingframes = true -- so that call to ShowHideBars resets to false
	self:ShowHideBars()
	self:Print(L["config_reset"])
end

function ShockAndAwe:DebugTalents()
	local numTabs = GetNumTalentTabs();
	for t=1, numTabs do
		DEFAULT_CHAT_FRAME:AddMessage(GetTalentTabInfo(t)..":");
		local numTalents = GetNumTalents(t);
		for i=1, numTalents do
			nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(t,i);
			DEFAULT_CHAT_FRAME:AddMessage("- "..i..":"..nameTalent..": "..currRank.."/"..maxRank);
		end
	end
end

function ShockAndAwe:DebugFrameValues()
	self:Print("SSlen : "..ShockAndAwe.db.char.SSlen)
	self:Print("SSPercent : "..ShockAndAwe.db.char.SSPercent )
	self:Print("ShockLen : "..ShockAndAwe.db.char.ShockLen)
	self:Print("ShockPercent : "..ShockAndAwe.db.char.ShockPercent )
	self:Print("WFProcPercent : "..ShockAndAwe.db.char.WFProcPercent)
end

function ShockAndAwe:WFProcBar()
	local colours = ShockAndAwe.db.char.colours.windfury
	self.frames["Windfury"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["Windfury"]:Show()
	updateActiveWFProc = true
	WFProcTime = GetTime() + 3
	WFPMin, WFPMax = self.frames["Windfury"].statusbar:GetMinMaxValues()
	if ShockAndAwe.db.char.showicons then
		self.frames["Windfury"].icon:Show()
	else
		self.frames["Windfury"].icon:Hide()
	end
end

function ShockAndAwe:ShieldBar(shieldR, shieldB, shieldG, shieldalpha)
	self.frames["Shield"].statusbar:SetStatusBarColor(shieldR, shieldB, shieldG, shieldalpha)
	self.frames["Shield"]:SetBackdropBorderColor( 1, 1, 1, shieldalpha);
	self.frames["Shield"].spark:Show()
	updateActiveShield = true
	ShieldMin, ShieldMax = self.frames["Shield"].statusbar:GetMinMaxValues()
	if ShockAndAwe.db.char.showicons then
		self.frames["Shield"].icon:Show()
	else
		self.frames["Shield"].icon:Hide()
	end
end

function ShockAndAwe:MaelstromBar()
	if ShockAndAwe.db.char.msshow and not ShockAndAwe.db.char.disabled then
		local colours = ShockAndAwe.db.char.colours.maelstrom
		self.frames["Maelstrom"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, ShockAndAwe.db.char.colours.msalpha)
		self.frames["Maelstrom"]:SetBackdropBorderColor( 1, 1, 1, ShockAndAwe.db.char.colours.msalpha);
		self.frames["Maelstrom"].spark:Show()
		self.frames["Maelstrom"]:Show()
		if ShockAndAwe.db.char.showicons then
			self.frames["Maelstrom"].icon:Show()
		else
			self.frames["Maelstrom"].icon:Hide()
		end
	end
	updateActiveMaelstrom = true
	MaelstromMin, MaelstromMax = self.frames["Maelstrom"].statusbar:GetMinMaxValues()
end

function ShockAndAwe:StormstrikeBar()
	local colours = ShockAndAwe.db.char.colours.stormstrike
	self.frames["Stormstrike"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["Stormstrike"]:Show()
	updateActiveSS = true
	SSTime = GetTime() + ShockAndAwe.db.char.SSlen
	SSmin, SSmax = self.frames["Stormstrike"].statusbar:GetMinMaxValues()
	if ShockAndAwe.db.char.showicons then
		self.frames["Stormstrike"].icon:Show()
	else
		self.frames["Stormstrike"].icon:Hide()
	end
end

function ShockAndAwe:StormblastBar()
	local colours = ShockAndAwe.db.char.colours.stormstrike
	self.frames["Stormblast"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["Stormblast"]:Show()
	updateActiveSB = true
	SBTime = GetTime() + ShockAndAwe.db.char.SBlen
	SBmin, SBmax = self.frames["Stormblast"].statusbar:GetMinMaxValues()
	if ShockAndAwe.db.char.showicons then
		self.frames["Stormblast"].icon:Show()
	else
		self.frames["Stormblast"].icon:Hide()
	end
end

function ShockAndAwe:FireNovaBar()
	local colours = ShockAndAwe.db.char.colours.firenova
	self.frames["FireNova"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["FireNova"]:Show()
	updateActiveFN = true
	FNTime = GetTime() + ShockAndAwe.db.char.FNlen
	FNmin, FNmax = self.frames["FireNova"].statusbar:GetMinMaxValues()
	if ShockAndAwe.db.char.showicons then
		self.frames["FireNova"].icon:Show()
	else
		self.frames["FireNova"].icon:Hide()
	end
end

function ShockAndAwe:FireTotemBar(totemName)
	fireTotemGUID = 0 -- fix to ensure that totem death event occuring before create event doesn't screw things up
	local _, _, startTime, maxDuration = GetTotemInfo(1)
	searingTotem = false
	if (totemName == ShockAndAwe.constants["Magma Totem"]) then 
		self:SetBarIcon(self.frames["fireTotem"].icon, 8190)
	elseif (totemName == ShockAndAwe.constants["Searing Totem"]) then
		self:SetBarIcon(self.frames["fireTotem"].icon, 3599)
		searingTotem = true
	elseif (totemName == ShockAndAwe.constants["Fire Elemental Totem"]) then
		self:SetBarIcon(self.frames["fireTotem"].icon, 2894)
	elseif (totemName == ShockAndAwe.constants["Flametongue Totem"]) then
		self:SetBarIcon(self.frames["fireTotem"].icon, 8227)
	else
		totemName= "nothing"
	end
	FireTotemTime = startTime + maxDuration
	ShockAndAwe.db.char.priority.firetotemtime = FireTotemTime
	if ShockAndAwe.db.char.firetotemshow then
		updateActiveFireTotem = true
		local colours = ShockAndAwe.db.char.colours.magma
		self.frames["fireTotem"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
		self.frames["fireTotem"].statusbar:SetMinMaxValues(0, maxDuration)
		self.frames["fireTotem"]:Show()
		FireTotemMin, FireTotemMax = self.frames["fireTotem"].statusbar:GetMinMaxValues()
		if ShockAndAwe.db.char.showicons then
			self.frames["fireTotem"].icon:Show()
		else
			self.frames["fireTotem"].icon:Hide()
		end
	end
end

function ShockAndAwe:LavaLashBar()
	local colours = ShockAndAwe.db.char.colours.lavalash
	self.frames["LavaLash"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["LavaLash"]:Show()
	updateActiveLavaLash = true
	LLTime = GetTime() + ShockAndAwe.db.char.LLlen
	LLMin, LLMax = self.frames["LavaLash"].statusbar:GetMinMaxValues()
	if ShockAndAwe.db.char.showicons then
		self.frames["LavaLash"].icon:Show()
	else
		self.frames["LavaLash"].icon:Hide()
	end
end

function ShockAndAwe:UnleashBar()
	local colours = ShockAndAwe.db.char.colours.unleash
	self.frames["Unleash"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["Unleash"]:Show()
	updateActiveUnleash = true
	UETime = GetTime() + 15
	UEMin, UEMax = self.frames["Unleash"].statusbar:GetMinMaxValues()
	if ShockAndAwe.db.char.showicons then
		self.frames["Unleash"].icon:Show()
	else
		self.frames["Unleash"].icon:Hide()
	end
end

function ShockAndAwe:ElementalBlastBar()
	local colours = ShockAndAwe.db.char.colours.ElementalBlast
	self.frames["ElementalBlast"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["ElementalBlast"]:Show()
	local colours = ShockAndAwe.db.char.colours.ElementalBlastBuff
	self.frames["ElementalBlastBuff"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a) -- TODO Bertel colors
	self.frames["ElementalBlastBuff"]:Show()
	updateActiveElementalBlast = true
	EBTime = GetTime() + 12
	EBBuffTime = GetTime() + 8
	EBMin, EBMax = self.frames["ElementalBlast"].statusbar:GetMinMaxValues()
	EBBuffMin, EBBuffMax = self.frames["ElementalBlastBuff"].statusbar:GetMinMaxValues()
	if ShockAndAwe.db.char.showicons then
		self.frames["ElementalBlast"].icon:Show()
	else
		self.frames["ElementalBlast"].icon:Hide()
	end
end

function ShockAndAwe:FeralSpiritBar()
	local colours = ShockAndAwe.db.char.colours.feralspirit
	self.frames["FeralSpirit"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["FeralSpirit"]:Show()
	updateActiveFeralSpirit = true
	FSTime = GetTime() + 30
	FSMin, FSMax = self.frames["FeralSpirit"].statusbar:GetMinMaxValues()	
	self:FeralSpiritCDBar()
end

function ShockAndAwe:FeralSpiritCDBar()
	local colours = ShockAndAwe.db.char.colours.feralspiritCD
	self.frames["FeralSpiritCD"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["FeralSpiritCD"]:Show()
	FSCDMin, FSCDMax = self.frames["FeralSpiritCD"].statusbar:GetMinMaxValues()
	updateActiveFeralSpiritCD = true  
	if ShockAndAwe.db.char.showicons then
		self.frames["FeralSpirit"].icon:Show()
	else
		self.frames["FeralSpirit"].icon:Hide()
	end
end

function ShockAndAwe:ShockBar(colours)
	self.frames["Shock"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["Shock"]:Show()
	updateActiveShock = true
	if ShockAndAwe.db.char.lastshock == ShockAndAwe.constants["Earth Shock"] then
		ShockTime = GetTime() + ShockAndAwe.db.char.EarthShockLen
		self.frames["Shock"].statusbar:SetMinMaxValues(0, ShockAndAwe.db.char.EarthShockLen)
		self.frames["Shock"]:SetWidth(ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.EarthShockPercent)
		self.frames["Shock"].statusbar:SetWidth(ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.EarthShockPercent - 6)
	else
		ShockTime = GetTime() + ShockAndAwe.db.char.ShockLen
		self.frames["Shock"].statusbar:SetMinMaxValues(0, ShockAndAwe.db.char.ShockLen)
		self.frames["Shock"]:SetWidth(ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.ShockPercent)
		self.frames["Shock"].statusbar:SetWidth(ShockAndAwe.db.char.fWidth * ShockAndAwe.db.char.ShockPercent - 6)
	end
	ShockMin, ShockMax = self.frames["Shock"].statusbar:GetMinMaxValues()
	if ShockAndAwe.db.char.showicons then
		self.frames["Shock"].icon:Show()
	else
		self.frames["Shock"].icon:Hide()
	end
end

function ShockAndAwe:DebugDebuffInfo()
	local index = 1
	while UnitDebuff("target", index) do
		local name, _, _, count, _, _, debuffExpires, unitCaster = UnitDebuff("target", index)
		local isMine = unitCaster == "player" 
		local expires = debuffExpires-GetTime()
		if isMine then
			self:DebugPrint("Debuff :"..name.." expires:"..expires)
		end
		index = index + 1
	end
end

function ShockAndAwe:FlameShockDotBar(shockCast)
	if shockCast then
		local fsDotPresent, duration, _, expiryTime = self:GetDebuffInfo(ShockAndAwe.constants["Flame Shock"])
		FSDotTime = expiryTime
		ShockAndAwe.db.char.priority.FSDotMax = duration
		self.frames["FS_DOT"].statusbar:SetMinMaxValues(0, ShockAndAwe.db.char.priority.FSDotMax)
		self.frames["FS_DOT"]:Show()
		updateActiveFSDot = true
		if ShockAndAwe.db.char.showicons then
			self.frames["FS_DOT"].icon:Show()
		else
			self.frames["FS_DOT"].icon:Hide()
		end
	else 
		self.frames["FS_DOT"]:Hide()
		self.frames["FS_DOT"].icon:Hide()
		updateActiveFSDot = false	
	end
end

function ShockAndAwe:ShearBar()
	local colours = ShockAndAwe.db.char.colours.windshear
	self.frames["Shear"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["Shear"]:Show()
	updateActiveShear = true
	ShearTime = GetTime() + ShockAndAwe.db.char.ShearLen
	ShearMin, ShearMax = self.frames["Shear"].statusbar:GetMinMaxValues()
	if ShockAndAwe.db.char.showicons then
		self.frames["Shear"].icon:Show()
	else
		self.frames["Shear"].icon:Hide()
	end
end

function ShockAndAwe:GCDBar()
	local startTime, duration, enabled = GetSpellCooldown(ShockAndAwe.constants["Lightning Shield"]) -- Lightning Shield chosen because it has no other cooldown and all shammys will have it
	duration = duration or 0 -- force nil to 0 if for some bizzare reason no LS available.
	if duration > 0 then 
		self.frames["GCD"]:Show()
		updateActiveGCD = true
		GCDTime = startTime + duration
		self.GCDMax = duration
	end
end

function ShockAndAwe:DurationString(duration)
    local string = (("%1.1f"):format(duration % 60)) .. "s";
    
    if (duration >= 60) then
        duration = floor(duration - (duration % 60)) / 60; -- minutes
        
        string = (duration % 60) .."m " .. string;
        
        if (duration >= 60) then
            duration = (duration - (duration % 60)) / 60; -- hours
            string = duration .. "h " .. string;
        end
    end
    return string
end

function ShockAndAwe:CheckPurgeableBuff()
	local index = 1
	while UnitBuff("target", index) do
		local _, _, _, _, buffType, _, _, _, purgeable = UnitBuff("target", index)
		if purgeable or buffType == "Magic" then 
			return true
		end
		index = index + 1
	end
	return false
end

local OBU = {}
--OBU.width, OBU.timeLeft, OBU.maelstromTime, OBU.debuffs, OBU.sparkpoint, OBU.start, OBU.startTime, OBU.duration, OBU.EnemySpell, OBU.EnemySpellIcon, OBU.maxTime
--OBU.orbs, OBU.shieldType, OBU.purgeable

function ShockAndAwe:OnBarUpdate()
	if ShockAndAwe.db.char.disabled then
		return
	end
	
	OBU.width = ShockAndAwe.db.char.fWidth - 6
	OBU.timeLeft = 0
	if updateActiveMaelstrom then
		ShockAndAwe.db.char.msstacks, OBU.maelstromTime = self:GetMaelstromInfo()
		OBU.timeLeft = OBU.maelstromTime - GetTime()
		if ShockAndAwe.db.char.msstacks ~= 4 then
			mw4played = false
		end
		if ShockAndAwe.db.char.msstacks == 5 then
			if ShockAndAwe.db.char.mw5soundplay and InCombatLockdown() then
				if ShockAndAwe.db.char.mw5sound and lastSound < GetTime() - ShockAndAwe.db.char.mw5repeat then
					PlaySoundFile(ShockAndAwe.db.char.mw5sound)
					lastSound = GetTime()
				end
			end
		else
			if ShockAndAwe.db.char.msstacks == 4 and ShockAndAwe.db.char.mw4soundplay and not mw4played and InCombatLockdown() then
				PlaySoundFile(ShockAndAwe.db.char.mw4sound)
				mw4played = true
			end
		end				
		if ShockAndAwe.db.char.msshow then
			if ShockAndAwe.db.char.msstacks == 5 then
				self:SetMaelstromAlpha(ShockAndAwe.db.char.colours.msalphaFull)
				if ShockAndAwe.db.char.mw5flash then
					UIFrameFlash(self.frames["Maelstrom"], 0.25, 0.25, 30, true, 0.25, 0.25)
					mwflashing = true
				end
			else
				if mwflashing then
					mwflashing = false
				end
				UIFrameFlashStop(self.frames["Maelstrom"])
				self:SetMaelstromAlpha(ShockAndAwe.db.char.colours.msalpha)
			end
			self.frames["Maelstrom"].statusbar:SetValue(OBU.timeLeft)
			self.frames["Maelstrom"].spark:SetPoint("CENTER",self.frames["Maelstrom"].statusbar,"LEFT", OBU.timeLeft/30 * OBU.width,-1)
			if OBU.maelstromTime < GetTime() or ShockAndAwe.db.char.msstacks == 0 then
				self.frames["Maelstrom"]:Hide()
				self.frames["Maelstrom"].icon:Hide()
			else
				self.frames["Maelstrom"]:Show()
				if ShockAndAwe.db.char.showicons then
					self.frames["Maelstrom"].icon:Show()
				end
			end
		else
			self.frames["Maelstrom"]:Hide()
			self.frames["Maelstrom"].icon:Hide()
		end
		if OBU.maelstromTime < GetTime() then
			self.frames["Maelstrom"]:Hide()
			self.frames["Maelstrom"].icon:Hide()
			if mwflashing then
				UIFrameFlashStop(self.frames["Maelstrom"])
				self:SetMaelstromAlpha(ShockAndAwe.db.char.colours.msalpha)
				mwflashing = false
			end
			updateActiveMaelstrom = false
		end
	end
	
	if updateActiveSS then
		OBU.timeLeft = SSTime - GetTime()
		self.frames["Stormstrike"].statusbar:SetValue(OBU.timeLeft)
		self.frames["Stormstrike"].spark:SetPoint("CENTER",self.frames["Stormstrike"].statusbar,"LEFT", OBU.timeLeft/SSmax * OBU.width * ShockAndAwe.db.char.SSPercent,-1)
		if SSTime < GetTime() then
			self.frames["Stormstrike"]:Hide()
			self.frames["Stormstrike"].icon:Hide()
			updateActiveSS = false
		end
	end
	
	if updateActiveSB then
		OBU.timeLeft = SBTime - GetTime()
		self.frames["Stormblast"].statusbar:SetValue(OBU.timeLeft)
		self.frames["Stormblast"].spark:SetPoint("CENTER",self.frames["Stormblast"].statusbar,"LEFT", OBU.timeLeft/SBmax * OBU.width * ShockAndAwe.db.char.SBPercent,-1)
		if SBTime < GetTime() then
			self.frames["Stormblast"]:Hide()
			self.frames["Stormblast"].icon:Hide()
			updateActiveSB = false
		end
	end
	
	if updateActiveFN then
		OBU.timeLeft = FNTime - GetTime()
		self.frames["FireNova"].statusbar:SetValue(OBU.timeLeft)
		self.frames["FireNova"].spark:SetPoint("CENTER",self.frames["FireNova"].statusbar,"LEFT", OBU.timeLeft/FNmax * OBU.width * ShockAndAwe.db.char.FNPercent,-1)
		if FNTime < GetTime() then
			self.frames["FireNova"]:Hide()
			self.frames["FireNova"].icon:Hide()
			updateActiveFN = false
		end
	end
	
	if updateActiveGCD then
		OBU.timeLeft = GCDTime - GetTime()
		self.frames["GCD"].statusbar:SetValue(OBU.timeLeft)
		OBU.sparkpoint = OBU.timeLeft / 1.5 * self.GCDWidth
		if OBU.sparkpoint > self.GCDWidth then
			OBU.sparkpoint = self.GCDWidth
		end
		self.frames["GCD"].spark:SetPoint("CENTER",self.frames["GCD"].statusbar,"LEFT", OBU.sparkpoint,-1)
		if GCDTime < GetTime() then
			self.frames["GCD"]:Hide()
			updateActiveGCD = false
		end
	end
	
	if updateActiveFireTotem then
		OBU.timeLeft = FireTotemTime - GetTime()
		self.frames["fireTotem"].statusbar:SetValue(OBU.timeLeft)
		self.frames["fireTotem"].spark:SetPoint("CENTER",self.frames["fireTotem"].statusbar,"LEFT", OBU.timeLeft/FireTotemMax * OBU.width ,-1)
		_, _, OBU.start, _ = GetTotemInfo(1)
		if ShockAndAwe.db.char.barstext then			
			local _, _, sfstacks = ShockAndAwe:GetBuffInfo(ShockAndAwe.constants["Searing Flames"])
			sfstacks = sfstacks or 0
			self.frames["fireTotem"].text:SetText(format("%.1f",OBU.timeLeft).." sec ("..sfstacks.." sf stacks)")			
		else
			self.frames["fireTotem"].text:SetText("")
		end
		if FireTotemTime < GetTime() or (FireTotemTime > 0 and (not OBU.start or OBU.start == 0)) then
			self.frames["fireTotem"]:Hide()
			self.frames["fireTotem"].icon:Hide()
			updateActiveFireTotem = false
			FireTotemTime = 0
		end
	end
	
	if updateActiveLavaLash then
		OBU.timeLeft = LLTime - GetTime()
		self.frames["LavaLash"].statusbar:SetValue(OBU.timeLeft)
		self.frames["LavaLash"].spark:SetPoint("CENTER",self.frames["LavaLash"].statusbar,"LEFT", OBU.timeLeft/LLMax * OBU.width * ShockAndAwe.db.char.LLPercent ,-1)
		if LLTime < GetTime() then
			self.frames["LavaLash"]:Hide()
			self.frames["LavaLash"].icon:Hide()
			updateActiveLavaLash = false
		end
	end
	
	if updateActiveUnleash then
		OBU.timeLeft = UETime - GetTime()
		self.frames["Unleash"].statusbar:SetValue(OBU.timeLeft)
		self.frames["Unleash"].spark:SetPoint("CENTER",self.frames["Unleash"].statusbar,"LEFT", OBU.timeLeft/UEMax * OBU.width ,-1)
		if UETime < GetTime() then
			self.frames["Unleash"]:Hide()
			self.frames["Unleash"].icon:Hide()
			updateActiveUnleash = false
		end
	end
	
	if updateActiveElementalBlast then
		OBU.timeLeft = EBTime - GetTime()
		self.frames["ElementalBlast"].statusbar:SetValue(OBU.timeLeft)
		self.frames["ElementalBlast"].spark:SetPoint("CENTER",self.frames["ElementalBlast"].statusbar,"LEFT", OBU.timeLeft/EBMax * OBU.width * ShockAndAwe.db.char.EBPercent,-1)
		if EBTime < GetTime() then
			self.frames["ElementalBlast"]:Hide()
			self.frames["ElementalBlast"].icon:Hide()
			updateActiveElementalBlast = false
		end
		OBU.timeLeft = EBBuffTime - GetTime()
		self.frames["ElementalBlastBuff"].statusbar:SetValue(OBU.timeLeft)
		self.frames["ElementalBlastBuff"].spark:SetPoint("CENTER",self.frames["ElementalBlastBuff"].statusbar,"LEFT", OBU.timeLeft/EBBuffMax * OBU.width * ShockAndAwe.db.char.EBBuffPercent,-1)
		if EBBuffTime < GetTime() then
			self.frames["ElementalBlastBuff"]:Hide()
		end	
	end
	
	if updateActiveShock then
		OBU.timeLeft = ShockTime - GetTime()
		self.frames["Shock"].statusbar:SetValue(OBU.timeLeft)
		self.frames["Shock"].statusbar:SetValue(OBU.timeLeft)
		if ShockAndAwe.db.char.lastshock == ShockAndAwe.constants["Earth Shock"] then
			self.frames["Shock"].spark:SetPoint("CENTER",self.frames["Shock"].statusbar,"LEFT", OBU.timeLeft/ShockMax * OBU.width * ShockAndAwe.db.char.EarthShockPercent ,-1)
		else
			self.frames["Shock"].spark:SetPoint("CENTER",self.frames["Shock"].statusbar,"LEFT", OBU.timeLeft/ShockMax * OBU.width * ShockAndAwe.db.char.ShockPercent ,-1)
		end
		if ShockTime < GetTime() then
			self.frames["Shock"]:Hide()
			self.frames["Shock"].icon:Hide()
			updateActiveShock = false
		end
	end
	if updateActiveFSDot then
		OBU.timeLeft = FSDotTime - GetTime()
		OBU.maxTime = self:getFSDotDuration()
		if ShockAndAwe.db.char.priority.FSDotMax < OBU.maxTime and ShockAndAwe.db.char.priority.FSDotMax > 0 then
			OBU.maxTime = ShockAndAwe.db.char.priority.FSDotMax
		end
		self.frames["FS_DOT"].statusbar:SetValue(OBU.timeLeft)
		self.frames["FS_DOT"].spark:SetPoint("CENTER",self.frames["FS_DOT"].statusbar,"LEFT", OBU.timeLeft/OBU.maxTime * OBU.width ,-1)
		if ShockAndAwe.db.char.barstext then
			self.frames["FS_DOT"].text:SetText(format("%.1f",OBU.timeLeft).." sec")
		else
			self.frames["FS_DOT"].text:SetText("")
		end
		if FSDotTime < GetTime() then
			self.frames["FS_DOT"]:Hide()
			self.frames["FS_DOT"].icon:Hide()
			updateActiveFSDot = false
		end
	end
	if updateActiveShear then
		OBU.timeLeft = ShearTime - GetTime()
		self.frames["Shear"].statusbar:SetValue(OBU.timeLeft)
		self.frames["Shear"].spark:SetPoint("CENTER",self.frames["Shear"].statusbar,"LEFT", OBU.timeLeft/ShearMax * OBU.width * ShockAndAwe.db.char.ShearPercent ,-1)
		if ShearTime < GetTime() then
			self.frames["Shear"]:Hide()
			self.frames["Shear"].icon:Hide()
			updateActiveShear = false
		end
	end
	if updateActiveShield then
		OBU.timeLeft = ShieldTime - GetTime()
		self.frames["Shield"].statusbar:SetValue(OBU.timeLeft)
		self.frames["Shield"].spark:SetPoint("CENTER",self.frames["Shield"].statusbar,"LEFT", OBU.timeLeft/ShieldMax * OBU.width,-1)
		OBU.orbs = ShockAndAwe:GetShieldInfo()
		if OBU.orbs <= ShockAndAwe.db.char.priority.shieldorbs then
			self.frames["Shield"].statusbar:SetStatusBarColor(ShockAndAwe.db.char.colours.noshield.r, ShockAndAwe.db.char.colours.noshield.g, ShockAndAwe.db.char.colours.noshield.b, 1)
			self.frames["Shield"]:SetBackdropBorderColor(1, 1, 1, 1);
		end
		if ShieldTime < GetTime() then
			updateActiveShield = false
		end
	end
	if updateActiveFeralSpirit then
		OBU.timeLeft = FSTime - GetTime()
		self.frames["FeralSpirit"].statusbar:SetValue(OBU.timeLeft)
		self.frames["FeralSpirit"].spark:SetPoint("CENTER",self.frames["FeralSpirit"].statusbar,"LEFT", OBU.timeLeft/FSMax * 30/120 * OBU.width,-1)
		if FSTime < GetTime() then
			self.frames["FeralSpirit"]:Hide()
			if not InCombatLockdown() then
				self.frames["FeralSpirit"].icon:Hide() -- hide icon if feral spirits expire and out of combat.
			end
			updateActiveFeralSpirit = false
		end
	end
	if updateActiveFeralSpiritCD then
		OBU.startTime, OBU.duration = GetSpellCooldown(GetSpellInfo(51533)) 
		OBU.duration = OBU.duration or 0 -- force nil to 0 
		if OBU.duration > 0 then
			OBU.timeLeft = OBU.startTime + OBU.duration - GetTime()
			self.frames["FeralSpiritCD"].statusbar:SetValue(OBU.timeLeft)
			self.frames["FeralSpiritCD"].spark:SetPoint("CENTER",self.frames["FeralSpiritCD"].statusbar,"LEFT", OBU.timeLeft/FSCDMax * OBU.width,-1)
		else
			-- set to full bar if expires
			self.frames["FeralSpiritCD"].statusbar:SetValue(120)
			self.frames["FeralSpiritCD"].spark:SetPoint("CENTER",self.frames["FeralSpiritCD"].statusbar,"LEFT", 120/FSCDMax * OBU.width,-1)
			updateActiveFeralSpiritCD = false
		end
	end
	if updateActiveWFProc then
		OBU.timeLeft = WFProcTime - GetTime()
		self.frames["Windfury"].statusbar:SetValue(OBU.timeLeft)
		self.frames["Windfury"].spark:SetPoint("CENTER",self.frames["Windfury"].statusbar,"LEFT", OBU.timeLeft/WFPMax * OBU.width * ShockAndAwe.db.char.WFProcPercent ,-1)
		if WFProcTime < GetTime() then
			self.frames["Windfury"]:Hide()
			self.frames["Windfury"].icon:Hide()
			updateActiveWFProc = false
		end
	end
	if ShockAndAwe.db.char.priority.show and not ShockAndAwe.db.char.disabled then
		if ShockAndAwe.db.char.priority.showinterrupt and self.PriorityFrame.interrupt then
			OBU.EnemySpell, _, _, OBU.EnemySpellIcon = UnitCastingInfo("target")
			if not OBU.EnemySpell then
				OBU.EnemySpellIcon = "Interface/Tooltips/UI-Tooltip-Background"
			end
			if self:SpellAvailable(ShockAndAwe.constants["Wind Shear"]) then
				self:SetSubFrameBackdrop(self.PriorityFrame.interrupt.frame, OBU.EnemySpellIcon, 4)
				self.PriorityFrame.interrupt.frame:SetBackdropBorderColor(1, 1, 1, 1);
			else
				self:SetSubFrameBackdrop(self.PriorityFrame.interrupt.frame, OBU.EnemySpellIcon, 20)
				self.PriorityFrame.interrupt.frame:SetBackdropBorderColor(1, 0, 0, 1); -- set border colour to Red if Wind Shear not available
			end
			if not OBU.EnemySpell then
				self.PriorityFrame.interrupt.frame:SetBackdropColor(0, 0, 0, 0);
			end
		end
		if ShockAndAwe.db.char.priority.showpurge and self.PriorityFrame.purge then
			OBU.purgeable = self:CheckPurgeableBuff()
			if OBU.purgeable and not ShockAndAwe.db.char.priority.purgeiconset then
				ShockAndAwe.db.char.priority.purgeiconset = true
				self:SetSubFrameBackdrop(self.PriorityFrame.purge.frame, ShockAndAwe.constants["Purge Icon"], 4)
			elseif not OBU.purgeable and ShockAndAwe.db.char.priority.purgeiconset then
				ShockAndAwe.db.char.priority.purgeiconset = false
				self:SetSubFrameBackdrop(self.PriorityFrame.purge.frame, "Interface/Tooltips/UI-Tooltip-Background", 4)
				self.PriorityFrame.purge.frame:SetBackdropColor(0, 0, 0, 0);
			end
		end
	end
	if updateActiveStoneBulwark then
		OBU.timeLeft = StoneBulwarkTime - GetTime()
		self.frames["StoneBulwark"].statusbar:SetValue(OBU.timeLeft)
		self.frames["StoneBulwark"].spark:SetPoint("CENTER",self.frames["StoneBulwark"].statusbar,"LEFT", OBU.timeLeft/StoneBulwarkCD * OBU.width ,-1)
		if StoneBulwarkTime < GetTime() then
			self.frames["StoneBulwark"]:Hide()
			self.frames["StoneBulwark"].icon:Hide()
			updateActiveStoneBulwark = false
		end
	end
end

function ShockAndAwe:CreateMsgFrame()
	self.msgFrame:ClearAllPoints()
	self.msgFrame:SetWidth(400)
	self.msgFrame:SetHeight(75)
	self.msgFrame:SetFrameStrata("BACKGROUND")
	self.msgFrame:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		--edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = false, tileSize = 0, edgeSize = 12,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})
	self.msgFrame:SetBackdropColor(1, 1, 1, 0)
	self.msgFrame:SetMovable(true)
	self.msgFrame:RegisterForDrag("LeftButton")
	self.msgFrame:SetScript("OnDragStart", 
		function()
			self.msgFrame:StartMoving();
		end );
	self.msgFrame:SetScript("OnDragStop",
		function()
			self.msgFrame:StopMovingOrSizing();
			self.msgFrame:SetScript("OnUpdate", nil);
			self:FinishedMoving(ShockAndAwe.db.char.warning, self.msgFrame);
		end );
	self.msgFrame:SetPoint(ShockAndAwe.db.char.warning.point, ShockAndAwe.db.char.warning.relativeTo, ShockAndAwe.db.char.warning.relativePoint, ShockAndAwe.db.char.warning.xOffset, ShockAndAwe.db.char.warning.yOffset)
	self.msgFrame:SetInsertMode("TOP")
	self.msgFrame:SetFrameStrata("HIGH")
	self.msgFrame:SetToplevel(true)
	local font = media:Fetch("font", ShockAndAwe.db.char.msgfont)
	self.msgFrame:SetFont(font, ShockAndAwe.db.char.msgfontsize, ShockAndAwe.db.char.msgfonteffect)
		
	self.msgFrame:Show()
end

function ShockAndAwe:PrintMsg(msg, col, time)
	if ShockAndAwe.db.char.warning.show and not ShockAndAwe.db.char.disabled then
		if col == nil then
			col = { r=1, b=1, g=1, a=1 }
		end
		if time == nil then 
			time = 3
		end
		if time ~= 5 then
			self.msgFrame:SetTimeVisible(time)
		end
		self.msgFrame:AddMessage(msg, col.r, col.g, col.b, 1, col.time)
	end
end

function ShockAndAwe:DebugPrint(msg)
	if ShockAndAwe.db.char.debug then
		self:Print(msg)
	end
end

function ShockAndAwe:getFSDotTime()
  return FSDotTime
end

-- query to determine if stone bulwark talent is known
function ShockAndAwe:StoneBulwarkKnown()
	local nameTalent, icon, tier, column, selected, available= GetTalentInfo(2);
	
	return selected
end

-- set the colour for the stone bulwark bar
function ShockAndAwe:StoneBulwarkApply(buffApplied)

	if buffApplied then
		if StoneBulwarkInitial then

			local colours = ShockAndAwe.db.char.colours.sbulwarkPrimary
			self.frames["StoneBulwark"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
			StoneBulwarkInitial = false
		else
			local colours = ShockAndAwe.db.char.colours.sbulwarkSecondary
			self.frames["StoneBulwark"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
		end
	else
		if StoneBulwarkActive then
			local colours = ShockAndAwe.db.char.colours.sbulwarkDepleted
			self.frames["StoneBulwark"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
			
		else
			local colours = ShockAndAwe.db.char.colours.sbulwarkCD
			self.frames["StoneBulwark"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
			
		end
	
	end
end

function ShockAndAwe:StoneBulwarkBar()
	local _, _, startTime, maxDuration = GetTotemInfo(2)
	
	StoneBulwarkTime = startTime + StoneBulwarkCD
	updateActiveStoneBulwark = true

	local colours = ShockAndAwe.db.char.colours.sbulwarkPrimary
	self.frames["StoneBulwark"].statusbar:SetStatusBarColor(colours.r, colours.g, colours.b, colours.a)
	self.frames["StoneBulwark"].statusbar:SetMinMaxValues(0, StoneBulwarkCD)
	self.frames["StoneBulwark"]:Show()
	
	if ShockAndAwe.db.char.showicons then
		self.frames["StoneBulwark"].icon:Show()
	else
		self.frames["StoneBulwark"].icon:Hide()
	end

end