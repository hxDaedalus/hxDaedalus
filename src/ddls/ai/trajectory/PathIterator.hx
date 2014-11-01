package ddls.ai.trajectory;


import ddls.ai.EntityAI;

class PathIterator
{
    public var entity(get, set) : EntityAI;
    public var x(get, never) : Float;
    public var y(get, never) : Float;
    public var hasPrev(get, never) : Bool;
    public var hasNext(get, never) : Bool;
    public var count(get, never) : Int;
    public var countMax(get, never) : Int;
    public var path(never, set) : Array<Float>;

    
    private var _entity : EntityAI;
    private var _currentX : Float;
    private var _currentY : Float;
    private var _hasPrev : Bool;
    private var _hasNext : Bool;
    
    private var _path : Array<Float>;
    private var _count : Int;
    private var _countMax : Int;
    
    public function new()
    {
        
        
    }
    
    private function get_entity() : EntityAI
    {
        return _entity;
    }
    
    private function set_entity(value : EntityAI) : EntityAI
    {
        _entity = value;
        return value;
    }
    
    private function get_x() : Float
    {
        return _currentX;
    }
    
    private function get_y() : Float
    {
        return _currentY;
    }
    
    private function get_hasPrev() : Bool
    {
        return _hasPrev;
    }
    
    private function get_hasNext() : Bool
    {
        return _hasNext;
    }
    
    private function get_count() : Int
    {
        return _count;
    }
    
    private function get_countMax() : Int
    {
        return _countMax;
    }
    
    private function set_path( value: Array<Float> ) : Array<Float>
    {
        _path = value;
        _countMax = _path.length / 2;
        reset();
        return value;
    }
    
    public function reset() : Void
    {
        _count = 0;
        _currentX = _path[_count];
        _currentY = _path[_count + 1];
        updateEntity();
        
        _hasPrev = false;
        if (_path.length > 2) _hasNext = true
        else _hasNext = false;
    }
    
    public function prev() : Bool
    {
        if (!_hasPrev) 
            return false;
        _hasNext = true;
        
        _count--;
        _currentX = _path[_count * 2];
        _currentY = _path[_count * 2 + 1];
        
        updateEntity();
        
        if (_count == 0) _hasPrev = false;
        
        return true;
    }
    
    public function next() : Bool
    {
        if (!_hasNext) return false;
        _hasPrev = true;
        
        _count++;
        _currentX = _path[_count * 2];
        _currentY = _path[_count * 2 + 1];
        
        updateEntity();
        
        if ((_count + 1) * 2 == _path.length) _hasNext = false;
        
        return true;
    }
    
    private function updateEntity() : Void
    {
        if (_entity == null) return;
        
        _entity.x = _currentX;
        _entity.y = _currentY;
    }
}
