package hxDaedalus.data.math;

@:expose
class RandGenerator
{
    public var seed(get, set) : Int;
    public var rangeMin: Int;
    public var rangeMax: Int;

    
     var _originalSeed : Int;
     var _currSeed : Int;
     var _rangeMin : Int;
     var _rangeMax : Int;
    
     var _numIter : Int;
     var _tempString : String;
    
    public function new( seed: Int = 1234, rangeMin_: Int = 0, rangeMax_: Int = 1 )
    {
        _originalSeed = _currSeed = seed;
        rangeMin = rangeMin_;
        rangeMax = rangeMax_;
        
        _numIter = 0;
    }
    
     function set_seed(value : Int) : Int{_originalSeed = _currSeed = value;
        return value;
    }

    
     function get_seed() : Int{return _originalSeed;
    }

    
    public function reset() : Void
    {
        _currSeed = _originalSeed;
        _numIter = 0;
    }
    
    public function next() : Int
    {
        var _floatSeed:Float = _currSeed * 1.0;	// TODO: remove `* 1.0` if haxe issue #3552 is fixed
        _tempString = Std.string((_floatSeed * _floatSeed));
        while (_tempString.length < 8) _tempString = "0" + _tempString; 
        _currSeed = Std.parseInt(_tempString.substr(1, 5));
        var res : Int = Math.round(rangeMin + (_currSeed / 99999) * (rangeMax - rangeMin));
        if( _currSeed == 0 ) _currSeed = _originalSeed + _numIter;
        _numIter++;
        if( _numIter == 200 ) reset();
        return res;
    }
	
	public function nextInRange(rangeMin:Int, rangeMax:Int):Int
	{
		this.rangeMin = rangeMin;
		this.rangeMax = rangeMax;
		return next();
	}
	
	// Knuth shuffle
	public function shuffle<T>(array:Array<T>):Void {
		var currIdx = array.length;
		
		while (currIdx > 0) {
			var rndIdx = nextInRange(0, currIdx-1);
			currIdx--;
			
			var tmp = array[currIdx];
			array[currIdx] = array[rndIdx];
			array[rndIdx] = tmp;
		}
	}
}
