package ddls.data.math;

class Matrix2D
{
/*	
	DDLSPoint2D represents row vector in homogeneous coordinates:
	[x, y, 1]
	
	DDLSMatrix2D represents transform matrix in homogeneous coordinates:
	[a, b, 0]
	[c, d, 0]
	[e, f, 1]
*/
	
	private var _a:Float;
	private var _b:Float;
	private var _c:Float;
	private var _d:Float;
	private var _e:Float;
	private var _f:Float;
	
	public function new(a:Float=1, b:Float=0, c:Float=0, d:Float=1, e:Float=0, f:Float=0)
	{
		_a = a;
		_b = b;
		_c = c;
		_d = d;
		_e = e;
		_f = f;
	}

	public function identity():Void
	{
		/*
		[1, 0, 0]
		[0, 1, 0]
		[0, 0, 1]
		*/
		
		_a = 1;
		_b = 0;
		_c = 0;
		_d = 1;
		_e = 0;
		_f = 0;
	}
	
	public function translate(tx:Float, ty:Float):Void
	{
		/*
		[1,  0,  0]
		[0,  1,  0]
		[tx, ty, 1]
		
		*/
		_e = _e + tx;
		_f = _f + ty;
	}
	
	public function scale(sx:Float, sy:Float):Void
	{
		/*
		[sx, 0, 0]
		[0, sy, 0]
		[0,  0, 1]
		*/
		_a = _a*sx;
		_b = _b*sy;
		_c = _c*sx;
		_d = _d*sy;
		_e = _e*sx;
		_f = _f*sy;
	}
	
	public function rotate(rad:Float):Void
	{
		/*
					[ cos, sin, 0]
					[-sin, cos, 0]
					[   0,   0, 1]
		
		[a, b, 0]
		[c, d, 0]
		[e, f, 1]
		*/
		var cos:Float = Math.cos(rad);
		var sin:Float = Math.sin(rad);
		var a:Float = _a*cos + _b*-sin;
		var b:Float = _a*sin + _b*cos;
		var c:Float = _c*cos + _d*-sin;
		var d:Float = _c*sin + _d*cos;
		var e:Float = _e*cos + _f*-sin;
		var f:Float = _e*sin + _f*cos;
		_a = a;
		_b = b;
		_c = c;
		_d = d;
		_e = e;
		_f = f;
	}
	
	public function clone():Matrix2D
	{
		return new Matrix2D(_a, _b, _c, _d, _e, _f);
	}
	
	public function tranform(point:Point2D):Void
	{
		/*
					[a, b, 0]
					[c, d, 0]
					[e, f, 1]
		[x, y, 1]
		*/
		var x:Float = _a*point.x + _c*point.y + e;
		var y:Float = _b*point.x + _d*point.y + f;
		point.x = x;
		point.y = y;
	}
	
	public function transformX(x:Float, y:Float):Float
	{
		return _a*x + _c*y + e;
	}
	public function transformY(x:Float, y:Float):Float
	{
		return _b*x + _d*y + f;
	}
	
	public function concat(matrix:Matrix2D):Void
	{
		var a:Float = _a*matrix.a + _b*matrix.c;
		var b:Float = _a*matrix.b + _b*matrix.d;
		var c:Float = _c*matrix.a + _d*matrix.c;
		var d:Float = _c*matrix.b + _d*matrix.d;
		var e:Float = _e*matrix.a + _f*matrix.c + matrix.e;
		var f:Float = _e*matrix.b + _f*matrix.d + matrix.f;
		_a = a;
		_b = b;
		_c = c;
		_d = d;
		_e = e;
		_f = f;
	}
	
	public var a(get, set):Float;
	private function get_a():Float { return _a; }
	private function set_a(value:Float):Float { return _a = value; }
	
	public var b(get, set):Float;
	private function get_b():Float { return _b; }
	private function set_b(value:Float):Float { return _b = value; }
	
	public var c(get, set):Float;
	private function get_c():Float { return _c; }
	private function set_c(value:Float):Float { return _c = value; }
	
	public var d(get, set):Float;
	private function get_d():Float { return _d; }
	private function set_d(value:Float):Float { return _d = value; }
	
	public var e(get, set):Float;
	private function get_e():Float { return _e; }
	private function set_e(value:Float):Float { return _e = value; }
	
	public var f(get, set):Float;
	private function get_f():Float { return _f; }
	private function set_f(value:Float):Float { return _f = value; }
}