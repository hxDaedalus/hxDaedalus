package wings.jsSvg;

import wings.core.ISimpleDrawingContext;
import wings.jsSvg.BasicSvg;
import wings.data.MathPoints;


class SimpleDrawingContext implements ISimpleDrawingContext
{
    public var graphics( default, null ): BasicSvg;

	var _prevX: Float = 0;
	var _prevY: Float = 0;

	var _lineColor: Int;
    var _lineAlpha: Float;
	var _fillColor: Int;
    var _fillAlpha: Float;
    var _thickness: Float;
    var _inFillingMode: Bool;

	public function new( graphics_: BasicSvg ) {
		graphics = graphics_;
        _inFillingMode = false;
	}

	public function clear(): Void {
		graphics.clear();
	}

	public function lineStyle( thickness: Float, color: Int, ?alpha: Float = 1 ): Void{
        _thickness = thickness;
        _lineColor = color;
		_lineAlpha = alpha;
	}

	public function beginFill( color: Int, ?alpha: Float = 1 ): Void {
		_fillColor = color;
		_fillAlpha = alpha;
		_inFillingMode = true;
	}

	public function endFill():Void {
		_inFillingMode = false;
	}

	public function moveTo( x: Float, y: Float ): Void {
		_prevX = x;
		_prevY = y;
	}


	public function quadTo( cx: Float, cy: Float, ax: Float, ay: Float ): Void {
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

	public function lineTo( x: Float, y: Float ): Void {
		var geom = graphics.createLine( _prevX, _prevY, x, y, _lineColor, _thickness, _lineAlpha );
		_prevX = x;
		_prevY = y;
		graphics.add( geom );
	}

    public function drawEquilaterialTri( x: Float, y: Float, r: Float, direction: Float ):Void{
        var fill = if( _inFillingMode ){
            _fillColor;
        } else {
            -1;
        }
        var geom = graphics.createEquilateralTriangle( x, y, r, direction, _lineColor, _lineAlpha, _fillColor, _fillAlpha, _thickness );
        graphics.add( geom );
    }

    public function drawTri( points: Array<Float> ):Void {
        var fill = if( _inFillingMode ){
            _fillColor;
        } else {
            -1;
        }
        var geom = graphics.createTri( points, _lineColor, _lineAlpha, _fillColor, _fillAlpha, _thickness );
        graphics.add( geom );
    }

	public function drawCircle( cx: Float, cy: Float, radius: Float ): Void {
		var fill = if( _inFillingMode ){
			_fillColor;
		} else {
            -1;
        }
        var geom = graphics.createCircle( cx, cy, radius, _lineColor, _lineAlpha, _fillColor, _fillAlpha, _thickness );
        graphics.add( geom );
	}

	public function drawRect( x: Float, y: Float, width: Float, height: Float ): Void {
        var fill = if( _inFillingMode ){
            _fillColor;
        } else {
            -1;
        }
        var geom = graphics.createRect( x, y, width, height, _lineColor, _lineAlpha, _fillColor, _fillAlpha, _thickness );
        graphics.add( geom );
	}
}
