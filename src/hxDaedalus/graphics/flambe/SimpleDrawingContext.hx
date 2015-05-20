package hxDaedalus.graphics.flambe;

import hxDaedalus.graphics.ISimpleDrawingContext;
import hxDaedalus.data.math.MathPoints;
import hxDaedalus.iterators.Iterator0_1;

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

	inline 	public function curveTo( cx: Float, cy: Float, ax: Float, ay: Float ):Void {
			var p0 = { x: _prevX, y: _prevY };
			var p1 = { x: cx, y: cy };
			var p2 = { x: ax, y: ay }
			var approxDistance = MathPoints.distance( p0, p1 ) + MathPoints.distance( p1, p2 );
			var factor = 2;
			var v:{x: Float, y:Float };
			if( approxDistance == 0 ) approxDistance = 0.000001;
			var step = Math.min( 1/(approxDistance*0.707), 0.2 );
			var arr = [ p0, p1, p2 ];
			var t = 0.0;
			v = MathPoints.quadraticBezier( 0.0, arr );
			lineTo( v.x, v.y );
			t += step;
			while( t < 1 ){
				v = MathPoints.quadraticBezier( t, arr );
				lineTo( v.x, v.y );
				t+=step;
			}
			v = MathPoints.quadraticBezier( 1.0, arr );
			lineTo( v.x, v.y );
		}

	inline public function drawCircle(cx:Float, cy:Float, radius:Float):Void {
		graphics.drawCircle(cx, cy, radius);
	}

	inline public function drawRect(x:Float, y:Float, width:Float, height:Float):Void {
		graphics.drawRect(x, y, width, height);
	}
}
