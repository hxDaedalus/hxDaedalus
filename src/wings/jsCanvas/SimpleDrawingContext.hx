package wings.jsCanvas;

import wings.jsCanvas.BasicCanvas;
import wings.core.ISimpleDrawingContext;


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

	inline public function quadTo(cx:Float, cy:Float, ax: Float, ay: Float):Void {
		graphics.quadTo(cx, cy, ax, ay);
	}

	inline public function drawCircle(cx:Float, cy:Float, radius:Float):Void {
		graphics.drawCircle(cx, cy, radius);
	}

	inline public function drawRect(x:Float, y:Float, width:Float, height:Float):Void {
		graphics.drawRect(x, y, width, height);
	}

	inline public function drawEquilaterialTri( x: Float, y: Float, radius: Float, direction: Float ):Void {
		var third = (Math.PI * 2) / 3;
		var points = new Array<Float>();
		var x1: Float;
		var y1: Float;
		for( i in 0...3 ){
			x1 = x + radius * Math.cos( direction + i * third );
			y1 = y + radius * Math.sin( direction + i * third );
			points.push( x1 );
			points.push( y1 );
		}
		drawTri( points );
	}

	inline public function drawTri( points:Array<Float> ){
		graphics.drawTri( points );
	}
}
