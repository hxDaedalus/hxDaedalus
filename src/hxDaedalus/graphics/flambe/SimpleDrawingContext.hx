package hxDaedalus.graphics.flambe;

import hxDaedalus.graphics.ISimpleDrawingContext;

@:access(hxDaedalus.graphics.flambe.GraphicsComponent)
class SimpleDrawingContext implements ISimpleDrawingContext
{
	var savedColor:Int;
	var savedAlpha:Float;
	var inFillingMode:Bool;
	
	public var graphics(default, null):GraphicsComponent;

	public function new(graphics:GraphicsComponent) {
		savedColor = graphics._color;
		savedAlpha = graphics._alpha;
		inFillingMode = false;
		this.graphics = graphics;
	}
	
	inline public function clear():Void {
		graphics.clear();
	}
	
	inline public function lineStyle(thickness:Float, color:Int, ?alpha:Float = 1):Void
	{
		graphics.lineStyle(thickness, color, alpha);
	}
	
	public function beginFill(color:Int, ?alpha:Float = 1):Void {
		if (!inFillingMode) {
			savedColor = graphics._color;
			savedAlpha = graphics._alpha;
		}
		lineStyle(graphics._thickness, color, alpha);
		inFillingMode = true;
	}
	
	public function endFill():Void {
		lineStyle(graphics._thickness, savedColor, savedAlpha);
		inFillingMode = false;
	}
	
	inline public function moveTo(x:Float, y:Float):Void {
		graphics.moveTo(x, y);
	}
	
	inline public function lineTo(x:Float, y:Float):Void {
		graphics.lineTo(x, y);
	}
	
	inline public function drawCircle(cx:Float, cy:Float, radius:Float):Void {
		graphics.drawCircle(cx, cy, radius);
	}
	
	inline public function drawRect(x:Float, y:Float, width:Float, height:Float):Void {
		graphics.drawRect(x, y, width, height);
	}
}