local L = LibStub("AceLocale-3.0"):NewLocale("SimpleILevel", "deDE");

if not L then return end

L.core = {
	ageDays = "%s Tage",
	ageHours = "%s Stunden",
	ageMinutes = "%s Minuten",
	ageSeconds = "%s Sekunden",
	desc = "Fügt die durchschnittliche Gegenstandsstufe in den Tooltip des Spielers ein",
	load = "Lade v%s",
	minimapClick = "SimpleiLevel - Klick für Details",
	minimapClickDrag = "Klicken und ziehen um das Icon zu bewegen",
	name = "Simple iLevel",
	purgeNotification = "%s Spieler aus dem Speicher gelöscht",
	purgeNotificationFalse = "Du hast das automatische reinigen nicht eingestellt.",
	scoreDesc = "Dieses ist das durchschnittliche iLevel all deiner angezogene Gegenstände",
	scoreYour = "Deine durchschnittliches Gegenstandsstufe ist %s",
	slashClear = "Einstellungen zurücksetzen",
	slashGetScore = "%s hat eine durchschnittliche Gegenstandsstufe von %s und die Information ist %s alt",
	slashGetScoreFalse = "Entschuldigung, es ist ein Fehler aufgetreten bei der Wertermittlung für %s",
	slashTargetScore = "%s hat eine durchschnittliche Gegenstandsstufe von %s",
	slashTargetScoreFalse = "Entschuldigung, es ist ein Fehler aufgetreten bei der Wertermittlung deines Zieles",
	ttAdvanced = "%s alt",
	ttLeft = "Durchschnittliche Gegenstandsstufe:",
	options = {
		autoscan = "Automatisches scannen bei veränderungen",
		autoscanDesc = "Die Gruppenmitglieder neu scannen wenn sich deren Ausrüstung ändert",
		clear = "Einstellungen zurücksetzen",
		clearDesc = "Setzt alle Einstellungen und den Speicher zurück",
		color = "Färbe Wert",
		colorDesc = "Färbt den Wert der durchschnittlichen Gegenstandsstufe. Deaktiviere diese Option, wenn nur weiße und graue Werte angezeigt werden sollen.",
		get = "Bekomme Wert",
		getDesc = "Zeigt die durchschnittliche Gegenstandsstufe eines Namens wen er im Speicher ist",
		ldb = "LDB Optionen",
		ldbRefresh = "Aktualisierungsrate",
		ldbRefreshDesc = "Wie oft LDB, in Sekunden, aktualisiert werden soll.",
		ldbSource = "LDB Source Label",
		ldbSourceDesc = "Zeigt eine Beschriftung für den LDB Wert.",
		ldbText = "LDB Text",
		ldbTextDesc = "Schaltet LDB an und aus, dieses sparrt ein wenig Ressourcen.",
		maxAge = "Maximaler Aktualisierungs abstand (Minuten)",
		maxAgeDesc = "Legt die Zeitspanne zwischen dem inspizieren in Minuten fest",
		minimap = "Symbol an der Karte anzeigen",
		minimapDesc = "Wechselt die Anzeige des Minimap Button",
		modules = "Lade Module",
		modulesDesc = "Damit diese Änderungen übernommen werden musst du dein UI mit /rl oder /console reloadui neu laden.",
		name = "Allgemeine Optionen",
		open = "SiL Einstellungen öffnen",
		options = "SiL Optionen",
		paperdoll = "Zeigt die Charakterinformationen",
		paperdollDesc = "Zeigt dein durchschnittliches Itemlevel im Charakterfenster an.",
		purge = "Cache reinigen",
		purgeAuto = "Automatische Cache-reinigung",
		purgeAutoDesc = "Automatisches reinigen des Caches wenn sie älter als # Tage sind. 0 für nie.",
		purgeDesc = "Lösche alle gespeicherten Charaktäre die älter sind als %s Tage",
		purgeError = "Bitte geben Sie die Zahl der Tage ein",
		round = "ilevel Ergebniss aufrunden.",
		roundDesc = "Rundet den ilevel auf die nächste ganze Zahl auf.",
		target = "Holt sich die Werte des Zieles",
		targetDesc = "Zeigt die durchschnittliche Gegenstandsstufe deines aktuellen Zieles",
		ttAdvanced = "Erweiterter Tooltip",
		ttAdvancedDesc = "Wechselt zwischen dem normalen und dem erweiterten Tooltip, welches das Alter mit anzeigt",
		ttCombat = "Tooltip im Kampf",
		ttCombatDesc = "Zeigt die SiL Informationen im Tooltip während des Kampfes an",
	},
}
L.group = {
	addonName = "Simple iLevel - Gruppe",
	desc = "Zeige die durchschnittliche Gegenstandsstufe von allen aus deiner Gruppe",
	load = "Gruppen-Modul geladen",
	name = "SiL Gruppe",
	nameShort = "Gruppe",
	outputHeader = "Simple iLevel: Gruppendurchnitt %s",
	outputNoScore = "%s ist nicht verfügbar",
	outputRough = "* bezeichnet einen ungefähren Wert",
	options = {
		group = "Gruppenwert",
		groupDesc = "Gibt den Wert deiner Gruppe in <%s> aus.",
	},
}
L.resil = {
	addonName = "Simple iLevel - Abhärtung",
	desc = "Zeigt die angelegte Menge der PvP Ausrüstung anderer Spieler im Tooltip an",
	load = "Abhärtungs-Modul geladen",
	name = "SiL Abhärtung",
	nameShort = "Abhärtung",
	outputHeader = "Simple iLevel: Durchschnittliche Gruppen PvP Ausrüstung %s",
	outputNoScore = "%s ist nicht verfügbar",
	outputRough = "* Kennzeichnet einen ungefähren Wert",
	ttPaperdoll = "Du hast %s/%s Ausrüstungsteile mit einem Abhärtungswert von %s an.",
	ttPaperdollFalse = "Du hast zur Zeit keine PvP Ausrüstung an.",
	options = {
		cinfo = "Zeige in den Charakterinformationen an",
		cinfoDesc = "Zeigt dein SiL-Abhärtungswert im Charakterfenster an.",
		group = "Gruppen PvP Wert",
		groupDesc = "Gibt den PvP Wert deiner Gruppe in <%s> aus.",
		name = "Sil Abhärtungs Einstellungen",
		pvpDesc = "Zeige die PvP-Ausrüstung von jedem aus deiner Gruppe.",
		ttType = "Tooltip Art",
		ttZero = "Leerer Tooltip",
		ttZeroDesc = "Zeigt Informationen im Tooltip, auch wenn keine PvP-Ausrüstung angelegt ist.",
	},
}
L.social = {
	addonName = "Simple iLevel - Sozial",
	desc = "Fügt die durchschnittliche Gegenstandsstufe im Chatfenster für verschiedene Kanäle hinzu",
	load = "Sozial-Modul geladen",
	name = "SiL Sozial",
	nameShort = "Sozial",
	options = {
		chatEvents = "Zeige den Wert an:",
		color = "Färbe Wert",
		colorDesc = "Färbe den Wert im Chatfenster.",
		enabled = "Aktiviert",
		enabledDesc = "Aktiviere alle Funktionen oder SiL Sozial.",
		name = "SiL Sozial Einstellungen",
	},
}


