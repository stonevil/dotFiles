mash = {
  position = {"ctrl", "alt", "cmd"},
  focus    = {"ctrl", "alt"},
  utils    = {"ctrl", "alt", "shift"}
}

hs.loadSpoon("Lunette")

require('caffeinate')
require('battery')

customBindings = {
	leftHalf = {
		{mash.position, "left"},
	},
	rightHalf = {
		{mash.position, "right"},
	},
	fullScreen = {
		{mash.position, "f"},
	},
	center = {
		{mash.position, "c"},
	},
	nextDisplay = {
		{mash.utils, "right"},
	},
	prevDisplay = {
		{mash.utils, "left"},
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