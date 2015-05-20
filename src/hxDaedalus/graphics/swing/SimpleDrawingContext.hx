package hxDaedalus.graphics.swing;

import hxDaedalus.graphics.ISimpleDrawingContext;
import hxDaedalus.swing.BasicSwing;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.geom.GeneralPath;
import hxDaedalus.data.math.MathPoints;
import hxDaedalus.iterators.Iterator0_1;

class SimpleDrawingContext implements ISimpleDrawingContext
{
	public var graphics:Graphics2D;

	var bounds:Rectangle;
	var path:GeneralPath;

	public function new(graphics:BasicSwing) {
		this.bounds = graphics.surface.getBounds();
		this.path = new GeneralPath();
	}

	public function clear():Void {
		graphics.clearRect(bounds.x, bounds.y, bounds.width, bounds.height);
	}

	public function lineStyle(thickness:Float, color:Int, ?alpha:Float = 1):Void
	{
		var a:Int = Std.int(alpha * 255);
		var color = new Color(color | (a << 24), true);
		graphics.setColor(color);
		graphics.setStroke(new BasicStroke(thickness));
	}

	public function beginFill(color:Int, ?alpha:Float = 1):Void {
		var a:Int = Std.int(alpha * 255);
		var color = new Color(color | (a << 24), true);
		graphics.setPaint(color);
	}

	public function endFill():Void {
		//graphics.endFill();
	}

	public function moveTo(x:Float, y:Float):Void {
		path.reset();
		path.moveTo(x, y);
	}

	public function lineTo(x:Float, y:Float):Void {
		path.lineTo(x, y);
		graphics.draw(path);
	}

	public function curveTo( cx: Float, cy: Float, ax: Float, ay: Float ):Void {
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

	public function drawCircle(cx:Float, cy:Float, radius:Float):Void {
		var r = Std.int(radius * 2);
		var x = Std.int(cx - radius);
		var y = Std.int(cy - radius);
		graphics.fillOval(x, y, r, r);
		graphics.drawOval(x, y, r, r);
	}

	public function drawRect(x:Float, y:Float, width:Float, height:Float):Void {
		graphics.fillRect(Std.int(x), Std.int(y), Std.int(width), Std.int(height));
		graphics.drawRect(Std.int(x), Std.int(y), Std.int(width), Std.int(height));
	}
}
