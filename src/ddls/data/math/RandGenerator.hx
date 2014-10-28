package ddls.data.math;

class RandGenerator
{
	
	private var _originalSeed:UInt;
	private var _currSeed:UInt;
	private var _rangeMin:Int;
	private var _rangeMax:Int;
	
	private var _numIter:Int;
	private var _tempString:String;
	
	public function new(seed:UInt=1234, rangeMin:Int=0, rangeMax:Int=1)
	{
		_originalSeed = _currSeed = seed;
		_rangeMin = rangeMin;
		_rangeMax = rangeMax;
		
		_numIter = 0;
	}

	public var seed(get, set):UInt;
	private function get_seed():UInt { return _originalSeed; }
	private function set_seed(value:UInt):UInt { return _originalSeed = _currSeed = value; }
	
	public var rangeMin(get, set):Int;
	private function get_rangeMin():Int { return _rangeMin; }
	private function set_rangeMin(value:Int):Int { return _rangeMin = value; }
	
	public var rangeMax(get, set):Int;
	private function get_rangeMax():Int { return _rangeMax; }
	private function set_rangeMax(value:Int):Int { return _rangeMax = value; }
	
	public function reset():Void
	{
		_currSeed = _originalSeed;
		_numIter = 0;
	}
	
	public function next():Int
	{
		var _floatSeed:Float = _currSeed;
		_tempString = Std.string(_floatSeed * _floatSeed);
		
		while (_tempString.length < 8)
		{
			_tempString = "0" + _tempString;
		}
		
		_currSeed = Std.parseInt(_tempString.substr(1, 5));
		
		var res:Int = Math.round(_rangeMin + (_currSeed / 99999) * (_rangeMax - _rangeMin));
		
		if (_currSeed == 0)
			_currSeed = _originalSeed+_numIter;
		
		_numIter++;
		
		if (_numIter == 200)
			reset();
		
		return res;
	}

}