package hxDaedalus.graphics.flambe;

import hxDaedalus.graphics.ISimpleDrawingContext;

@:access(hxDaedalus.graphics.flambe.GraphicsComponent)
class SimpleDrawingContext implements ISimpleDrawingContext
{
	private var fillStyles:Array<{color:Int, alpha:Float}> = [];
	
	public var graphics(default, null):GraphicsComponent;

	public function new(graphics:GraphicsComponent) {
		fillStyles.push({color:graphics._color, alpha:graphics._alpha});
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
		fillStyles.push({color:graphics._color, alpha:graphics._alpha});
		fillStyles.push({color:color, alpha:alpha});
	}
	
	public function endFill():Void {
		fillStyles.pop();
		var style = fillStyles.pop();
		graphics._color = style.color;
		graphics._alpha = style.alpha;
	}
	
	inline public function moveTo(x:Float, y:Float):Void {
		graphics.moveTo(x, y);
	}
	
	inline public function lineTo(x:Float, y:Float):Void {
		graphics.lineTo(x, y);
	}
	
	public function drawCircle(cx:Float, cy:Float, radius:Float):Void {
		if (fillStyles.length > 0) {
			var style = fillStyles[fillStyles.length - 1];
			graphics._color = style.color;
			graphics._alpha = style.alpha;
		}
		graphics.drawCircle(cx, cy, radius);
	}
	
	public function drawRect(x:Float, y:Float, width:Float, height:Float):Void {
		if (fillStyles.length > 0) {
			var style = fillStyles[fillStyles.length - 1];
			graphics._color = style.color;
			graphics._alpha = style.alpha;
		}
		graphics.drawRect(x, y, width, height);
	}
}