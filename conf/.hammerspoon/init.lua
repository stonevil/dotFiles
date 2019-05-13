mash = {
  position = {"ctrl", "alt", "cmd"},
  focus    = {"ctrl", "alt"},
  utils    = {"ctrl", "alt", "cmd"}
}

hs.loadSpoon("Lunette")

require('caffeinate')
require('battery')

customBindings = {
	leftHalf = {
		{{"cmd", "alt"}, "left"},
	},
	rightHalf = {
		{{"cmd", "alt"}, "right"},
	},
	fullScreen = {
		{{"ctrl", "cmd", "alt"}, "f"},
	},
	center = {
		{{"cmd", "alt"}, "C"},
	},
	nextDisplay = {
		{{"ctrl", "alt", "cmd"}, "right"},
	},
	prevDisplay = {
		{{"ctrl", "alt", "cmd"}, "left"},
	},
	topHalf = false,
	bottomHalf = false,
	topLeft = false,
	topRight = false,
	bottomLeft = false,
	bottomRight = false,
	nextThird = false,
	prevThird = false,
	enlarge = false,
	shrink = false,
	undo = false,
	redo = false
}

spoon.Lunette:bindHotkeys(customBindings)
