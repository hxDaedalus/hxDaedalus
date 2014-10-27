package ddls.data.math;

class Point2D
{
	
	private var _x:Float;
	private var _y:Float;
	
	public function new(x:Float=0, y:Float=0)
	{
		_x = x;
		_y = y;
	}
	
	public function transform(matrix:Matrix2D):Void
	{
		matrix.tranform(this);
	}
	
	public function set(x:Float, y:Float):Void
	{
		_x = x;
		_y = y;
	}
	
	public function clone():Point2D
	{
		return new Point2D(_x, _y);
	}
	
	public function substract(p:Point2D):Void
	{
		_x -= p.x;
		_y -= p.y;
	}
	
	public var length(get, never):Float;
	private function get_length():Float
	{
		return Math.sqrt(_x*_x + _y*_y);
	}
	
	
	public var x(get, set):Float;
	private function get_x():Float { return _x; }
	private function set_x(value:Float):Float { return _x = value; }

	public var y(get, set):Float;
	private function get_y():Float { return _y; }
	private function set_y(value:Float):Float { return _y = value; }
	
	public function normalize():Void
	{
		var norm:Float = length;
		x = x/norm;
		y = y/norm;
	}
	
	public function scale(s:Float):Void
	{
		x = x*s;
		y = y*s;
	}
	
	public function distanceTo(p:Point2D):Float
	{
		var diffX:Float = x - p.x;
		var diffY:Float = y - p.y;
		return Math.sqrt(diffX*diffX + diffY*diffY);
	}

}