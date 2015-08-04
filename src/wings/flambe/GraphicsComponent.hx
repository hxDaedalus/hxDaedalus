package wings.flambe;

import flambe.Component;
import flambe.display.FillSprite;
import flambe.display.Sprite;
import flambe.Entity;
import flambe.math.FMath;
import flambe.math.Point;
import flambe.math.Rectangle;
import hxDaedalus.data.math.MathPoints;

/**
 * Only for debugging purposes. Uses FillSprites to draw all things
 *
 * @author Mark Knol [mediamonks]
 */
class GraphicsComponent extends Component
{
	var _container:Entity;
	var _prevX:Float = 0;
	var _prevY:Float = 0;
	var _thickness:Float;
	var _color:Int;
	var _alpha:Float;

	public function new(thickness:Float = 1, color:Int = 0x000000, alpha:Float = 1)
	{
		lineStyle(thickness, color, alpha);
		var containerSprite = new Sprite();
		containerSprite.pointerEnabled = false;
		_container = new Entity().add(containerSprite);
	}

	override public function onStart()
	{
		owner.addChild(_container);
	}

	/**
	 * Specifies a line style used for subsequent calls to GraphicsComponent methods such as the lineTo() method or the drawCircle() method.
	 */
	public function lineStyle(thickness:Float = 1, color:Int = 0x000000, alpha:Float = 1)
	{
		_color = color;
		_thickness = thickness;
		_alpha = alpha;
	}

	/**
	 * Draws a solid rectangle.
	 */
	public function drawRect(x:Float, y:Float, width:Float, height:Float)
	{
		var shape = new FillSprite(_color, width, height)
			.setXY(x, y)
			.setAlpha(_alpha);

		shape.pixelSnapping = false;

		_container.addChild(new Entity().add(shape));
	}

	/**
	 * Draws a circle.
	 */
	public function drawCircle(x:Float, y:Float, radius:Float, totalSegments:Int = 45)
	{
		var startX:Float = x;
		var startY:Float = y;
		for (i in 0 ... totalSegments + 1)
		{
			var ratio = (i / totalSegments);
			var v = ratio * (FMath.PI * 2);
			if (i == 0)
			{
				moveTo(startX + Math.cos(v) * radius, startY + Math.sin(v) * radius);
			}
			else
			{
				lineTo(startX + Math.cos(v) * radius, startY + Math.sin(v) * radius);
			}
		}
	}

	/**
	 * Draws an ellipse.
	 */
	public function drawEllipse(x:Float, y:Float, width:Float, height:Float, totalSegments:Int = 45)
	{
		var startX:Float = x;
		var startY:Float = y;
		for (i in 0 ... totalSegments + 1)
		{
			var ratio = (i / totalSegments);
			var v = ratio * (FMath.PI * 2);
			if (i == 0)
			{
				moveTo(startX + Math.cos(v) * width, startY + Math.sin(v) * height);
			}
			else
			{
				lineTo(startX + Math.cos(v) * width, startY + Math.sin(v) * height);
			}
		}
	}

	/**
	 * Draws a pie from/to a certain ratio [0-1]
	 */
	public function drawPie(x:Float, y:Float, radius:Float, fromRatio:Float = 0, toRatio:Float = 1, totalSegments:Int = 45)
	{
		var startX:Float = x;
		var startY:Float = y;
		var started:Bool = false;
		for (i in 0 ... totalSegments + 1)
		{
			var ratio = (i / totalSegments);

			if (ratio < fromRatio) continue;
			else if (ratio > toRatio) break;

			var v = ratio * (FMath.PI * 2);
			if (!started)
			{
				moveTo(startX + Math.cos(v) * radius, startY + Math.sin(v) * radius);
				started = true;
			}
			else
			{
				lineTo(startX + Math.cos(v) * radius, startY + Math.sin(v) * radius);
			}
		}
	}

	/**
	 * Draws a line using the current line style from the current drawing position to (x, y); the current drawing position is then set to (x, y).
	 */
	public function lineTo(x:Float, y:Float)
	{
		var dx:Float = _prevX - x;
		var dy:Float = _prevY - y;

		var distance:Float = Math.sqrt(dx * dx + dy * dy);
		var angle:Float = Math.atan2(dy, dx);
		var shape:Sprite = new FillSprite(_color, distance, _thickness)
			.setRotation(FMath.toDegrees(angle))
			.setXY(x, y)
			.setAnchor(0, _thickness / 2)
			.setAlpha(_alpha);

		shape.pixelSnapping = false;

		_container.addChild(new Entity().add(shape));

		_prevX = x;
		_prevY = y;
	}

	public function quadTo( cx: Float, cy: Float, ax: Float, ay: Float ):Void {
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

	/**
	 * Moves the current drawing position to (x, y)
	 */
	public function moveTo(x:Float, y:Float)
	{
		_prevX = x;
		_prevY = y;
	}

	public function clear()
	{
		_container.disposeChildren();
		_prevX = 0;
		_prevY = 0;
	}

	public function drawPath(path:Array<Point>)
	{
		moveTo(path[0].x, path[0].y);

		if (path.length > 1)
		{
			for (i in 1 ... path.length)
			{
				var p:Point = path[i];
				lineTo(p.x, p.y);
			}
		}
	}

	public function drawTri( points: Array<Float> ){
		var i = 0;
		while( i < points.length ){
			if( i == 0 ){
				moveTo( points[ i ], points[ i + 1 ] );
			} else {
				lineTo( points[ i ], points[ i + 1 ] );
			}
			i+=2;
		}
	}

	override public function dispose()
	{
		_container.dispose();
		_container = null;
		super.dispose();
	}
}
