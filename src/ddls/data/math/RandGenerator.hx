package ddls.data.math;
class RandGenerator
{
    public var seed(get, set) : UInt;
    public var rangeMin: Int;
    public var rangeMax: Int;

    
    private var _originalSeed : UInt;
    private var _currSeed : UInt;
    private var _rangeMin : Int;
    private var _rangeMax : Int;
    
    private var _numIter : Int;
    private var _tempString : String;
    
    public function new( seed: UInt = 1234, rangeMin_: Int = 0, rangeMax_: Int = 1 )
    {
        _originalSeed = _currSeed = seed;
        rangeMin = rangeMin_;
        rangeMax = rangeMax_;
        
        _numIter = 0;
    }
    
    private function set_seed(value : UInt) : UInt{_originalSeed = _currSeed = value;
        return value;
    }

    
    private function get_seed() : UInt{return _originalSeed;
    }

    
    public function reset() : Void
    {
        _currSeed = _originalSeed;
        _numIter = 0;
    }
    
    public function next() : Int
    {
        var _floatSeed:Float = _currSeed;
        _tempString = Std.string((_floatSeed * _floatSeed));
        while (_tempString.length < 8) _tempString = "0" + _tempString; 
        _currSeed = Std.parseInt(_tempString.substr(1, 5));
        var res : Int = Math.round(rangeMin + (_currSeed / 99999) * (rangeMax - rangeMin));
        if( _currSeed == 0 ) _currSeed = _originalSeed + _numIter;
        _numIter++;
        if( _numIter == 200 ) reset();
        return res;
    }
}
