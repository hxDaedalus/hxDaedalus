package ddls.ai.trajectory;


import ddls.ai.EntityAI;

class LinearPathSampler{
    public var entity: EntityAI;
    public var x( get, never ): Float;
    public var y( get, never ): Float;
    public var hasPrev( get, never ): Bool;
    public var hasNext( get, never ): Bool;
    public var count( get, set ): Int;
    public var countMax( get, never ): Int;
    public var samplingDistance( get, set ): Float;
    public var path( never, set ): Array<Float>;
    var _entity: EntityAI;
    var _currentX: Float;
    var _currentY: Float;
    var _hasPrev: Bool;
    var _hasNext: Bool;
    var _samplingDistance: Float = 1;
    var _samplingDistanceSquared: Float = 1;
    var _path: Array<Float>;
    var _iPrev: Int;
    var _iNext: Int;
    var _preComputed: Bool;
    var _count: Int;
    var _preCompX: Array<Float>;
    var _preCompY: Array<Float>;
    
    public function new(){
        _preCompX = new Array<Float>();
        _preCompY = new Array<Float>();
    }
    
    public function dispose(): Void {
        entity = null;
        _path = null;
        _preCompX = null;
        _preCompY = null;
    }
    
    function get_x(): Float {
        return _currentX;
    }
    
    function get_y(): Float {
        return _currentY;
    }
    
    function get_hasPrev(): Bool {
        return _hasPrev;
    }
    
    function get_hasNext(): Bool {
        return _hasNext;
    }
    
    function get_count(): Int {
        return _count;
    }
    
    function set_count( value: Int ): Int {
        _count = value;
        if( _count < 0 ) _count = 0;
        if( _count > countMax - 1 ) _count = countMax - 1;
        _hasPrev = ( _count == 0 ) false: true;
        _hasNext = ( _count == countMax - 1 ) false: true;
        _currentX = _preCompX[ _count ];
        _currentY = _preCompY[ _count ];
        updateEntity();
        return value;
    }
    
    function get_countMax(): Int {
        return _preCompX.length - 1;
    }
    
    function get_samplingDistance(): Float {
        return _samplingDistance;
    }
    
    function set_samplingDistance( value: Float ): Float {
        _samplingDistance = value;
        _samplingDistanceSquared = _samplingDistance * _samplingDistance;
        return value;
    }
    
    function set_path( value: Array<Float> ): Array<Float>{
        _path = value;
        _preComputed = false;
        reset();
        return value;
    }
    
    public function reset(): Void {
        if( _path.length > 0 ){
            _currentX = _path[ 0 ];
            _currentY = _path[ 1 ];
            _iPrev = 0;
            _iNext = 2;
            _hasPrev = false;
            _hasNext = true;
            _count = 0;
            updateEntity();
        } else {
            _hasPrev = false;
            _hasNext = false;
            _count = 0;
        }
    }
    
    public function preCompute(): Void {
        _preCompX.splice( 0, _preCompX.length );
        _preCompY.splice( 0, _preCompY.length );
        _count = 0;
        _preCompX.push(_currentX);
        _preCompY.push(_currentY);
        _preComputed = false;
        while( next() ){
            _preCompX.push( _currentX );
            _preCompY.push( _currentY );
        }
        reset();
        _preComputed = true;
    }
    
    inline static function pythag( a: Float, b: Float ): Float
    {
        return Math.sqrt( a*a + b*b );
    }
    
    public function prev(): Bool {
        if( !_hasPrev ) return false;
        _hasNext = true;
        if( _preComputed ) {
            _count--;
            if( _count == 0 ) _hasPrev = false;
            _currentX = _preCompX[ _count ];
            _currentY = _preCompY[ _count ];
            updateEntity();
            return true;
        }
        var remainingDist : Float;
        var dist : Float;
        remainingDist = _samplingDistance;
        while( true ){
            var pathPrev = _path[ _iPrev ];
            var pathPrev1 = _path[ _iPrev + 1 ];
            dist = pythag( _currentX - pathPrev, _currentY - pathPrev1 );
            if( dist < remainingDist ) {
                remainingDist -= dist;
                _iPrev -= 2;
                _iNext -= 2;
                if( _iNext == 0 ) break;
            } else { 
                break;
            }
        }
        if( _iNext == 0 ){
            _currentX = _path[ 0 ];
            _currentY = _path[ 1 ];
            _hasPrev = false;
            _iNext = 2;
            _iPrev = 0;
            updateEntity();
            return true;
        } else {
            _currentX = _currentX + ( _path[ _iPrev ] - _currentX) * remainingDist / dist;
            _currentY = _currentY + ( _path[ _iPrev + 1 ] - _currentY) * remainingDist / dist;
            updateEntity();
            return true;
        }
    }
    
    public function next(): Bool {
        if (!_hasNext) return false;
        _hasPrev = true;
        if( _preComputed ){
            _count++;
            if( _count == _preCompX.length - 1 ) 
                _hasNext = false;
            _currentX = _preCompX[ _count ];
            _currentY = _preCompY[ _count ];
            updateEntity();
            return true;
        }
        var remainingDist : Float;
        var dist : Float;
        remainingDist = _samplingDistance;
        while (true)
        {
            var pathNext = _path[ _iNext ];
            var pathNext1 = _path[ _iNext + 1 ];
            dist = pythag( _currentX - pathNext, _currentY - pathNext1 );
            if( dist < remainingDist ) {
                remainingDist -= dist;
                _currentX = _path[_iNext];
                _currentY = _path[_iNext + 1];
                _iPrev += 2;
                _iNext += 2;
                if( _iNext == _path.length ) break;
            }
            else break;
        }
        if( _iNext == _path.length ) {
            _currentX = _path[_iPrev];
            _currentY = _path[_iPrev + 1];
            _hasNext = false;
            _iNext = _path.length - 2;
            _iPrev = _iNext - 2;
            updateEntity();
            return true;
        } else {
            _currentX = _currentX + (_path[_iNext] - _currentX) * remainingDist / dist;
            _currentY = _currentY + (_path[_iNext + 1] - _currentY) * remainingDist / dist;
            updateEntity();
            return true;
        }
    }
    
     function updateEntity() : Void {
        if( entity == null ) return;
        entity.x = _currentX;
        entity.y = _currentY;
    }
}
