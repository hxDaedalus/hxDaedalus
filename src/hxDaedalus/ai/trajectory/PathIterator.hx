package hxDaedalus.ai.trajectory;


import hxDaedalus.ai.EntityAI;

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

    
     var _entity : EntityAI;
     var _currentX : Float;
     var _currentY : Float;
     var _hasPrev : Bool;
     var _hasNext : Bool;
    
     var _path : Array<Float>;
     var _count : Int;
     var _countMax : Int;
    
    public function new()
    {
        
        
    }
    
     function get_entity() : EntityAI
    {
        return _entity;
    }
    
     function set_entity(value : EntityAI) : EntityAI
    {
        _entity = value;
        return value;
    }
    
     function get_x() : Float
    {
        return _currentX;
    }
    
     function get_y() : Float
    {
        return _currentY;
    }
    
     function get_hasPrev() : Bool
    {
        return _hasPrev;
    }
    
     function get_hasNext() : Bool
    {
        return _hasNext;
    }
    
     function get_count() : Int
    {
        return _count;
    }
    
     function get_countMax() : Int
    {
        return _countMax;
    }
    
     function set_path( value: Array<Float> ) : Array<Float>
    {
        _path = value;
        _countMax = _path.length / 2;
        reset();
        return value;
    }
    
    public function reset(): Void {
        _count = 0;
        _currentX = _path[_count];
        _currentY = _path[_count + 1];
        updateEntity();
        
        _hasPrev = false;
        _hasNext = (_path.length > 2)? true: false;
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
    
     function updateEntity() : Void
    {
        if (_entity == null) return;
        
        _entity.x = _currentX;
        _entity.y = _currentY;
    }
}
