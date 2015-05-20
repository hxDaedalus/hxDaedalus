package hxDaedalus.graphics.js;

import hxDaedalus.canvas.BasicCanvas;
import hxDaedalus.graphics.ISimpleDrawingContext;


class SimpleDrawingContext implements ISimpleDrawingContext
{
	public var graphics(default, null):BasicCanvas;

	public function new(graphics:BasicCanvas) {
		this.graphics = graphics;
	}

	inline public function clear():Void {
		graphics.clear();
	}

	inline public function lineStyle(thickness:Float, color:Int, ?alpha:Float = 1):Void
	{
		graphics.lineStyle(thickness, color, alpha);
	}

	inline public function beginFill(color:Int, ?alpha:Float = 1):Void {
		graphics.beginFill(color, alpha);
	}

	inline public function endFill():Void {
		graphics.endFill();
	}

	inline public function moveTo(x:Float, y:Float):Void {
		graphics.moveTo(x, y);
	}

	inline public function lineTo(x:Float, y:Float):Void {
		graphics.lineTo(x, y);
	}

	inline public function curveTo(cx:Float, cy:Float, ax: Float, ay: Float):Void {
		graphics.quadraticCurveTo(cx, cy, ax, ay);
	}

	inline public function drawCircle(cx:Float, cy:Float, radius:Float):Void {
		graphics.drawCircle(cx, cy, radius);
	}

	inline public function drawRect(x:Float, y:Float, width:Float, height:Float):Void {
		graphics.drawRect(x, y, width, height);
	}
}
