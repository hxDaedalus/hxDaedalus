package ddls.ai;

import ddls.data.Object;

class EntityAI
{
	
	private var _radius:Float;
	private var _radiusSquared:Float;
	private var _x:Float;
	private var _y:Float;
	private var _dirNormX:Float;
	private var _dirNormY:Float;
	private var _angleFOV:Float;
	private var _approximateObject:Object;
	inline private static var NUM_SEGMENTS:Int = 6;
	
	public function new()
	{
		_radius = 10;
		_x = _y = 0;
		_dirNormX = 1;
		_dirNormY = 0;
		_angleFOV = 60;
	}
	
	public function buildApproximation():Void
	{
		_approximateObject = new Object();
		_approximateObject.matrix.translate(x, y);
		var coordinates:Array<Float> = new Array<Float>();
		_approximateObject.coordinates = coordinates;
		
		if (_radius == 0)
			return;
		
		for (i in 0...NUM_SEGMENTS)
		{
			coordinates.push(_radius * Math.cos(2*Math.PI*i/NUM_SEGMENTS));
			coordinates.push(_radius * Math.sin(2*Math.PI*i/NUM_SEGMENTS));
			coordinates.push(_radius * Math.cos(2*Math.PI*(i+1)/NUM_SEGMENTS));
			coordinates.push(_radius * Math.sin(2*Math.PI*(i+1)/NUM_SEGMENTS));
		}
		
	}
	
	public var approximateObject(get, never):Object;
	private function get_approximateObject():Object
	{
		_approximateObject.matrix.identity();
		_approximateObject.matrix.translate(x, y);
		return _approximateObject;
	}

	public var angleFOV(get, set):Float;
	private function get_angleFOV():Float { return _angleFOV; }
	private function set_angleFOV(value:Float):Float { return _angleFOV = value; }

	public var dirNormX(get, set):Float;
	private function get_dirNormX():Float { return _dirNormX; }
	private function set_dirNormX(value:Float):Float { return _dirNormX = value; }

	public var dirNormY(get, set):Float;
	private function get_dirNormY():Float { return _dirNormY; }
	private function set_dirNormY(value:Float):Float { return _dirNormY = value; }

	public var x(get, set):Float;
	private function get_x():Float { return _x; }
	private function set_x(value:Float):Float { return _x = value; }

	public var y(get, set):Float;
	private function get_y():Float { return _y; }
	private function set_y(value:Float):Float { return _y = value; }

	public var radius(get, set):Float;
	private function get_radius():Float { return _radius; }
	private function set_radius(value:Float):Float 
	{ 
		_radius = value;
		_radiusSquared = _radius*_radius;
		return _radius; 
	}

	public var radiusSquared(get, never):Float;
	private function get_radiusSquared():Float { return _radiusSquared; }

}