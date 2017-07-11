Screen.backgroundColor = "white"



data = [
	{label: "Sunday", value: 14}
	{label: "Monday", value: 12}
	{label: "Tuesday", value: 19}
	{label: "Wednesday", value: 7}
]


class Bar extends Layer
	constructor: (options) ->

		super options
		_parent = @
		
		@barValue = options.barValue ? @height
		@barBorderRadius = options.barBorderRadius ? 0
		
		@style =
			borderTopLeftRadius: "#{@barBorderRadius}px"
			borderTopRightRadius: "#{@barBorderRadius}px"
		
		@states.collapsed =
			height: 0
			y: @maxY
		@stateSwitch "collapsed"
		
		@onClick ->
			print _parent.barValue
		
	grow: ()->
		@animate "default"

class BarGraph extends Layer
	constructor: (options={}) ->
		super options
		
		@data = options.graphData ? {}
		@gutter = options.graphGutter ? {} 
		
		@_bars = []
		
		
		for datum, i in @data
			bar = new Bar
				parent: @
				value: datum.value
				height: @_scaledValue(datum.value)
				width: @width / @data.length - @gutter
				x: (@width / @data.length) * i
				y: Align.bottom
				
				barBorderRadius: 15
			@_bars.push bar
		
		@animateIn()
			
	
	animateIn: (options) ->
		for bar in @_bars
			bar.animate "default"
	_scaledValue: (val) ->
		return Utils.modulate(val, [0, 30], [0, @height])

graph = new BarGraph
	width: Screen.width
	height: 256
	y: Align.center
	backgroundColor: "rgba(0,0,0,0.05)"
	
	graphData: data
	graphGutter: 12
	graphScale:
		min: 0
		max: 30
	animated: false

		

# Utils.delay 0.5, ->
# 	bar.grow()