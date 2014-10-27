package ddls.data.math;

class RandGenerator
{
	
	private var _originalSeed:UInt;
	private var _currSeed:UInt;
	private var _rangeMin:UInt;
	private var _rangeMax:UInt;
	
	private var _numIter:UInt;
	private var _tempString:String;
	
	public function new(seed:UInt=1234, rangeMin:UInt=0, rangeMax:UInt=1)
	{
		_originalSeed = _currSeed = seed;
		_rangeMin = rangeMin;
		_rangeMax = rangeMax;
		
		_numIter = 0;
	}

	public var seed(get, set):UInt;
	private function get_seed():UInt { return _originalSeed; }
	private function set_seed(value:UInt):UInt { return _originalSeed = _currSeed = value; }
	
	public var rangeMin(get, set):UInt;
	private function get_rangeMin():UInt { return _rangeMin; }
	private function set_rangeMin(value:UInt):UInt { return _rangeMin = value; }
	
	public var rangeMax(get, set):UInt;
	private function get_rangeMax():UInt { return _rangeMax; }
	private function set_rangeMax(value:UInt):UInt { return _rangeMax = value; }
	
	public function reset():Void
	{
		_currSeed = _originalSeed;
		_numIter = 0;
	}
	
	public function next():UInt
	{
		_tempString = Std.string(_currSeed*_currSeed);
		
		while (_tempString.length < 8)
		{
			_tempString = "0" + _tempString;
		}
		
		_currSeed = Std.parseInt(_tempString.substr(1, 5));
		
		var res:UInt = Math.round(_rangeMin + (_currSeed / 99999)*(_rangeMax - _rangeMin));
		
		if (_currSeed == 0)
			_currSeed = _originalSeed+_numIter;
		
		_numIter++;
		
		if (_numIter == 200)
			reset();
		
		return res;
	}

}