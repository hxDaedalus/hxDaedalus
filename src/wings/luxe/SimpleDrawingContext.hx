package wings.luxe;

import wings.core.ISimpleDrawingContext;
import wings.core.TargetCanvas;
import wings.data.MathPoints;
import luxe.Color;
import luxe.Vector;
import phoenix.geometry.Geometry;

//
import phoenix.Batcher;
import luxe.Input.Key;
import luxe.Input.KeyEvent;
import luxe.Sprite;
import luxe.Vector;
import phoenix.Texture;


typedef DPoint2D = hxDaedalus.data.math.Point2D;
typedef PVertex = phoenix.geometry.Vertex;
class SimpleDrawingContext implements ISimpleDrawingContext
{
	public var graphics(default, null): TargetCanvas;

	var _prevX:Float = 0;
	var _prevY:Float = 0;

	var _lineColor:Color = new Color();
	var _fillColor:Color = new Color();

	var _inFillingMode:Bool = false;

	public function new( graphics: TargetCanvas ) {
		this.graphics = graphics;
	}

	public function clear():Void {
		var geom;
		while ((geom = graphics.pop()) != null) geom.drop();
	}

	public function lineStyle(thickness:Float, color:Int, ?alpha:Float = 1):Void
	{
		_lineColor = new Color().rgb(color);
		_lineColor.a = alpha;
	}

	public function beginFill(color:Int, ?alpha:Float = 1):Void {
		_fillColor = new Color().rgb(color);
		_fillColor.a = alpha;
		_inFillingMode = true;
	}

	public function endFill():Void {
		_inFillingMode = false;
	}

	public function moveTo(x:Float, y:Float):Void {
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

	public function lineTo(x:Float, y:Float):Void {
		var geom = Luxe.draw.line({
			p0: new Vector(_prevX, _prevY),
			p1: new Vector(x, y),
			color: _lineColor
		});
		trace( 'lineTo' );
		_prevX = x;
		_prevY = y;
		graphics.push(geom);
	}

	public function drawCircle(cx:Float, cy:Float, radius:Float):Void {
		if (_inFillingMode) {
			var geom = Luxe.draw.circle({
				x: cx,
				y: cy,
				r: radius,
				color: _fillColor
			});
			graphics.push(geom);
		}

		var geom = Luxe.draw.ring({
			x: cx,
			y: cy,
			r: radius,
			color: _lineColor
		});
		graphics.push(geom);
	}

	public function drawRect(x:Float, y:Float, width:Float, height:Float):Void {
		if (_inFillingMode) {
			var geom = Luxe.draw.box({
				x: x,
				y: y,
				w: width,
				h: height,
				color: _fillColor
			});
			graphics.push(geom);
		}

		var geom = Luxe.draw.rectangle({
			x: x,
			y: y,
			w: width,
			h: height,
			color: _lineColor
		});
		graphics.push(geom);
	}
///
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

	public inline static function vertexConverter( v: { x: Float, y: Float }, col: Color ):PVertex {
		return new PVertex( new Vector( v.x, v.y ), col  );
	}

	public function drawTri( points:Array<Float> ){
		var shape = new Geometry({
			primitive_type:PrimitiveType.triangles,
			batcher: Luxe.renderer.batcher
		});
		var i = 0;
		var col = _fillColor;
		shape.depth = -1;
		while( i < points.length ){
			if( i == 0 ){
				moveTo( points[ i ], points[ i + 1 ] );
			} else {
				lineTo( points[ i ], points[ i + 1 ] );
			}
			shape.add( vertexConverter( { x: points[ i ], y: points[ i + 1 ] }, col ) );
			i+=2;
		}
	}
}
