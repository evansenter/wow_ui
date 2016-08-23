
SkadaDB = {
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["hasUpgraded"] = true,
	["profileKeys"] = {
		["Venala - Cho'gall"] = "Default",
		["Cometron - Illidan"] = "Comet - Illidan",
		["Combustion - Illidan"] = "Pandatal - Illidan",
		["Centromere - Dark Iron"] = "Pandatal - Illidan",
		["Pandatal - Illidan"] = "Comet - Illidan",
		["Plane - Illidan"] = "Pandatal - Illidan",
		["Colton - Dark Iron"] = "Default",
		["Natalan - Dark Iron"] = "Default",
		["Ereinion - Dark Iron"] = "Default",
		["Natal - Illidan"] = "Pandatal - Illidan",
		["Comet - Illidan"] = "Comet - Illidan",
		["Natalan - Illidan"] = "Pandatal - Illidan",
		["Evan - Illidan"] = "Comet - Illidan",
		["Metal - Illidan"] = "Comet - Illidan",
	},
	["profiles"] = {
		["Comet - Illidan"] = {
			["showtotals"] = true,
			["hidepvp"] = true,
			["windows"] = {
				{
					["titleset"] = false,
					["barheight"] = 15,
					["barslocked"] = true,
					["y"] = 183.999664306641,
					["x"] = -4.0013427734375,
					["title"] = {
						["color"] = {
							["a"] = 0,
							["r"] = 0,
							["g"] = 0,
							["b"] = 0,
						},
						["font"] = "ABF",
						["fontsize"] = 11,
						["height"] = 16,
						["texture"] = "BantoBar",
					},
					["barfontsize"] = 12,
					["point"] = "BOTTOMRIGHT",
					["mode"] = "Healing",
					["buttons"] = {
						["stop"] = true,
					},
					["barwidth"] = 411.998657226563,
					["barspacing"] = 1,
					["background"] = {
						["color"] = {
							["a"] = 0,
						},
						["borderthickness"] = 0,
						["height"] = 113.999969482422,
						["bordertexture"] = "None",
					},
					["name"] = "Healing",
					["barfont"] = "ABF",
				}, -- [1]
				{
					["titleset"] = false,
					["barheight"] = 15,
					["classicons"] = true,
					["barslocked"] = true,
					["clickthrough"] = false,
					["wipemode"] = "",
					["set"] = "current",
					["hidden"] = false,
					["y"] = 187.000122070313,
					["barfont"] = "ABF",
					["title"] = {
						["color"] = {
							["a"] = 0,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
						["bordertexture"] = "None",
						["font"] = "ABF",
						["borderthickness"] = 2,
						["fontsize"] = 11,
						["fontflags"] = "",
						["height"] = 16,
						["margin"] = 0,
						["texture"] = "BantoBar",
					},
					["display"] = "bar",
					["barfontflags"] = "",
					["strata"] = "LOW",
					["classcolortext"] = false,
					["barbgcolor"] = {
						["a"] = 0.6,
						["b"] = 0.3,
						["g"] = 0.3,
						["r"] = 0.3,
					},
					["barcolor"] = {
						["a"] = 1,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.8,
					},
					["barfontsize"] = 12,
					["barorientation"] = 1,
					["snapto"] = true,
					["x"] = 5.00001859664917,
					["mode"] = "Damage",
					["modeincombat"] = "",
					["buttons"] = {
						["report"] = true,
						["stop"] = true,
						["menu"] = true,
						["mode"] = true,
						["segment"] = true,
						["reset"] = true,
					},
					["barwidth"] = 410.999542236328,
					["barspacing"] = 1,
					["returnaftercombat"] = false,
					["version"] = 1,
					["background"] = {
						["borderthickness"] = 0,
						["color"] = {
							["a"] = 0,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
						["height"] = 112,
						["bordertexture"] = "None",
						["margin"] = 0,
						["texture"] = "Solid",
					},
					["reversegrowth"] = false,
					["scale"] = 1,
					["classcolorbars"] = true,
					["point"] = "BOTTOMLEFT",
					["bartexture"] = "BantoBar",
					["enabletitle"] = true,
					["name"] = "Damage",
				}, -- [2]
			},
			["icon"] = {
				["minimapPos"] = 181.018472339963,
				["hide"] = true,
			},
			["report"] = {
				["number"] = 4,
				["channel"] = "party",
				["target"] = "murlocobama",
				["mode"] = "Enemy damage taken",
			},
			["tooltiprows"] = 10,
			["setstokeep"] = 30,
		},
		["Default"] = {
			["report"] = {
				["number"] = 3,
				["mode"] = "Enemy damage taken",
				["target"] = "teanbiscuits",
				["channel"] = "guild",
			},
			["showtotals"] = true,
			["tooltiprows"] = 5,
			["windows"] = {
				{
					["point"] = "BOTTOMLEFT",
					["barwidth"] = 407.999206542969,
					["barfontsize"] = 12,
					["y"] = 188.999923706055,
					["x"] = 5.99948120117188,
					["barslocked"] = true,
					["name"] = "Healing",
					["barfont"] = "ABF",
					["mode"] = "DPS",
					["background"] = {
						["color"] = {
							["a"] = 0.200000047683716,
							["b"] = 0,
						},
						["height"] = 97.9999160766602,
					},
					["title"] = {
						["color"] = {
							["a"] = 0.800000011920929,
							["r"] = 0,
							["g"] = 0,
							["b"] = 0,
						},
						["font"] = "ABF",
					},
				}, -- [1]
				{
					["barheight"] = 15,
					["classicons"] = true,
					["barslocked"] = true,
					["clickthrough"] = false,
					["wipemode"] = "",
					["set"] = "current",
					["hidden"] = false,
					["y"] = -225.999847412109,
					["barfont"] = "ABF",
					["title"] = {
						["color"] = {
							["a"] = 0.800000011920929,
							["r"] = 0,
							["g"] = 0,
							["b"] = 0,
						},
						["bordertexture"] = "None",
						["font"] = "ABF",
						["borderthickness"] = 2,
						["fontsize"] = 11,
						["fontflags"] = "",
						["height"] = 15,
						["margin"] = 0,
						["texture"] = "Aluminium",
					},
					["display"] = "bar",
					["barfontflags"] = "",
					["classcolortext"] = false,
					["barbgcolor"] = {
						["a"] = 0.6,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.3,
					},
					["barcolor"] = {
						["a"] = 1,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.8,
					},
					["barfontsize"] = 12,
					["barorientation"] = 1,
					["snapto"] = true,
					["mode"] = "Damage",
					["modeincombat"] = "",
					["background"] = {
						["borderthickness"] = 0,
						["color"] = {
							["a"] = 0.200000047683716,
							["r"] = 0,
							["g"] = 0,
							["b"] = 0,
						},
						["height"] = 128.000076293945,
						["bordertexture"] = "None",
						["margin"] = 0,
						["texture"] = "Solid",
					},
					["buttons"] = {
						["segment"] = true,
						["menu"] = true,
						["stop"] = true,
						["mode"] = true,
						["report"] = true,
						["reset"] = true,
					},
					["barwidth"] = 407.999664306641,
					["barspacing"] = 0,
					["returnaftercombat"] = false,
					["point"] = "LEFT",
					["x"] = 5.99995422363281,
					["reversegrowth"] = false,
					["scale"] = 1,
					["classcolorbars"] = true,
					["enabletitle"] = true,
					["bartexture"] = "BantoBar",
					["name"] = "Damage",
					["version"] = 1,
				}, -- [2]
			},
			["hidepvp"] = true,
			["icon"] = {
				["minimapPos"] = 181.018472339963,
				["hide"] = true,
			},
			["setstokeep"] = 30,
		},
		["Pandatal - Illidan"] = {
			["report"] = {
				["number"] = 4,
				["mode"] = "Enemy damage taken",
				["target"] = "murlocobama",
				["channel"] = "party",
			},
			["hidepvp"] = true,
			["tooltiprows"] = 10,
			["windows"] = {
				{
					["titleset"] = false,
					["point"] = "BOTTOMRIGHT",
					["barwidth"] = 411.998657226563,
					["barspacing"] = 1,
					["barfontsize"] = 12,
					["y"] = 183.999664306641,
					["barfont"] = "ABF",
					["barslocked"] = true,
					["name"] = "Healing",
					["background"] = {
						["height"] = 113.999969482422,
						["color"] = {
							["a"] = 0,
							["b"] = 0,
						},
					},
					["mode"] = "Healing",
					["x"] = -4.0013427734375,
					["title"] = {
						["color"] = {
							["a"] = 0,
							["r"] = 0,
							["g"] = 0,
							["b"] = 0,
						},
						["font"] = "ABF",
						["height"] = 16,
						["texture"] = "BantoBar",
					},
				}, -- [1]
				{
					["titleset"] = false,
					["barheight"] = 15,
					["classicons"] = true,
					["barslocked"] = true,
					["modeincombat"] = "",
					["wipemode"] = "",
					["set"] = "current",
					["hidden"] = false,
					["y"] = 187.000122070313,
					["barfont"] = "ABF",
					["title"] = {
						["color"] = {
							["a"] = 0,
							["r"] = 0,
							["g"] = 0,
							["b"] = 0,
						},
						["bordertexture"] = "None",
						["font"] = "ABF",
						["fontsize"] = 11,
						["borderthickness"] = 2,
						["height"] = 16,
						["fontflags"] = "",
						["margin"] = 0,
						["texture"] = "BantoBar",
					},
					["display"] = "bar",
					["barfontflags"] = "",
					["classcolortext"] = false,
					["scale"] = 1,
					["reversegrowth"] = false,
					["returnaftercombat"] = false,
					["barorientation"] = 1,
					["snapto"] = true,
					["name"] = "Damage",
					["enabletitle"] = true,
					["buttons"] = {
						["report"] = true,
						["menu"] = true,
						["stop"] = true,
						["mode"] = true,
						["segment"] = true,
						["reset"] = true,
					},
					["bartexture"] = "BantoBar",
					["barwidth"] = 410.999542236328,
					["barspacing"] = 1,
					["point"] = "BOTTOMLEFT",
					["barfontsize"] = 12,
					["background"] = {
						["borderthickness"] = 0,
						["color"] = {
							["a"] = 0,
							["r"] = 0,
							["g"] = 0,
							["b"] = 0,
						},
						["height"] = 112,
						["bordertexture"] = "None",
						["margin"] = 0,
						["texture"] = "Solid",
					},
					["barcolor"] = {
						["a"] = 1,
						["b"] = 0.8,
						["g"] = 0.3,
						["r"] = 0.3,
					},
					["barbgcolor"] = {
						["a"] = 0.6,
						["r"] = 0.3,
						["g"] = 0.3,
						["b"] = 0.3,
					},
					["classcolorbars"] = true,
					["mode"] = "Damage",
					["clickthrough"] = false,
					["x"] = 5.00001859664917,
					["version"] = 1,
				}, -- [2]
			},
			["icon"] = {
				["minimapPos"] = 181.018472339963,
				["hide"] = true,
			},
			["setstokeep"] = 30,
		},
		["Natal - Illidan"] = {
			["report"] = {
				["number"] = 4,
				["chantype"] = "RealID",
				["set"] = 12,
				["target"] = "Jenova",
				["channel"] = "realid",
			},
			["showtotals"] = true,
			["tooltiprows"] = 5,
			["windows"] = {
				{
					["point"] = "BOTTOMLEFT",
					["barwidth"] = 407.999206542969,
					["barfontsize"] = 12,
					["y"] = 188.999923706055,
					["barfont"] = "ABF",
					["barslocked"] = true,
					["title"] = {
						["color"] = {
							["a"] = 0.800000011920929,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
						["font"] = "ABF",
					},
					["x"] = 5.99948120117188,
					["mode"] = "Healing",
					["background"] = {
						["height"] = 97.9999160766602,
						["color"] = {
							["a"] = 0.200000047683716,
							["b"] = 0,
						},
					},
					["name"] = "Healing",
				}, -- [1]
				{
					["barheight"] = 15,
					["classicons"] = true,
					["barslocked"] = true,
					["clickthrough"] = false,
					["wipemode"] = "",
					["set"] = "current",
					["hidden"] = false,
					["y"] = -225.999847412109,
					["barfont"] = "ABF",
					["title"] = {
						["color"] = {
							["a"] = 0.800000011920929,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
						["bordertexture"] = "None",
						["font"] = "ABF",
						["fontsize"] = 11,
						["borderthickness"] = 2,
						["height"] = 15,
						["fontflags"] = "",
						["margin"] = 0,
						["texture"] = "Aluminium",
					},
					["display"] = "bar",
					["barfontflags"] = "",
					["classcolortext"] = false,
					["scale"] = 1,
					["reversegrowth"] = false,
					["barfontsize"] = 12,
					["barorientation"] = 1,
					["snapto"] = true,
					["background"] = {
						["borderthickness"] = 0,
						["color"] = {
							["a"] = 0.200000047683716,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
						["height"] = 128.000076293945,
						["bordertexture"] = "None",
						["margin"] = 0,
						["texture"] = "Solid",
					},
					["name"] = "Damage",
					["bartexture"] = "BantoBar",
					["barwidth"] = 407.999664306641,
					["barspacing"] = 0,
					["modeincombat"] = "",
					["buttons"] = {
						["report"] = true,
						["menu"] = true,
						["mode"] = true,
						["segment"] = true,
						["reset"] = true,
					},
					["barbgcolor"] = {
						["a"] = 0.6,
						["b"] = 0.3,
						["g"] = 0.3,
						["r"] = 0.3,
					},
					["barcolor"] = {
						["a"] = 1,
						["b"] = 0.8,
						["g"] = 0.3,
						["r"] = 0.3,
					},
					["mode"] = "Damage",
					["classcolorbars"] = true,
					["returnaftercombat"] = false,
					["enabletitle"] = true,
					["x"] = 5.99995422363281,
					["point"] = "LEFT",
				}, -- [2]
			},
			["setstokeep"] = 30,
			["icon"] = {
				["minimapPos"] = 181.018472339963,
				["hide"] = true,
			},
			["hidepvp"] = true,
		},
	},
}
