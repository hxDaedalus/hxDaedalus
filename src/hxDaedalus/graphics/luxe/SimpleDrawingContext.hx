package hxDaedalus.graphics.luxe;

import hxDaedalus.graphics.ISimpleDrawingContext;
import hxDaedalus.graphics.TargetCanvas;
import luxe.Color;
import luxe.Vector;


class SimpleDrawingContext implements ISimpleDrawingContext
{
	public var graphics(default, null):TargetCanvas;

	var _prevX:Float = 0;
	var _prevY:Float = 0;
	
	var _lineColor:Color = new Color();
	var _fillColor:Color = new Color();
	
	var _inFillingMode:Bool = false;
	
	public function new(graphics:TargetCanvas) {
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
	
	public function lineTo(x:Float, y:Float):Void {
		var geom = Luxe.draw.line({
			p0: new Vector(_prevX, _prevY),
			p1: new Vector(x, y),
			color: _lineColor
		});
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
}