package wings.javaSwing;

import wings.core.ISimpleDrawingContext;
import wings.javaSwing.BasicSwing;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.geom.GeneralPath;
import wings.data.MathPoints;

class SimpleDrawingContext implements ISimpleDrawingContext
{
	public var graphics:Graphics2D;

	var bounds:Rectangle;
	var path:GeneralPath;

	public function new(graphics:BasicSwing) {
		bounds = graphics.surface.getBounds();
		path = new GeneralPath();
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
		graphics.draw( path );
	}

	public function quadTo( cx: Float, cy: Float, ax: Float, ay: Float ):Void {
		path.quadTo(cx, cy, ax, ay);
		graphics.draw( path );
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

	public function drawEquilaterialTri( x: Float, y: Float, radius: Float, direction: Float ):Void {
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

	public function drawTri( points:Array<Float> ){
		var i = 0;
		while( i < points.length ){
			if( i == 0 ){
				path.moveTo( points[ i ], points[ i + 1 ] );
			} else {
				path.lineTo( points[ i ], points[ i + 1 ] );
			}
			i+=2;
		}
		graphics.draw( path );
	}
}
