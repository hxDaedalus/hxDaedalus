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

	public function quadTo( cx: Float, cy: Float, ax: Float, ay: Float ):Void {
		path.quadTo(cx, cy, ax, ay);
		graphics.draw(path);
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
