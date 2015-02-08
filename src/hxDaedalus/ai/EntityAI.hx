package hxDaedalus.ai;


import hxDaedalus.data.Object;

class EntityAI
{
    public var approximateObject(get, never) : Object;
    public var dirNormY : Float;
    public var dirNormX : Float;
    public var y : Float;
    public var x : Float;
    public var radius(get, set) : Float;
    public var radiusSquared(get, never) : Float;

    
     var _radius : Float;
     var _radiusSquared : Float;
     var _x : Float;
     var _y : Float;
     var _dirNormX : Float;
     var _dirNormY : Float;
     var _approximateObject : Object;
     static inline var NUM_SEGMENTS : Int = 6;
    
    public function new()
    {
        _radius = 10;
        x = y = 0;
        dirNormX = 1;
        dirNormY = 0;
    }
    
    public function buildApproximation() : Void {
        _approximateObject = new Object();
        _approximateObject.matrix.translate(x, y);
        var coordinates  = new Array<Float>();
        _approximateObject.coordinates = coordinates;
        
        if (_radius == 0) return;
        
        for (i in 0...NUM_SEGMENTS){
            coordinates.push(_radius * Math.cos(2 * Math.PI * i / NUM_SEGMENTS));
            coordinates.push(_radius * Math.sin(2 * Math.PI * i / NUM_SEGMENTS));
            coordinates.push(_radius * Math.cos(2 * Math.PI * (i + 1) / NUM_SEGMENTS));
            coordinates.push(_radius * Math.sin(2 * Math.PI * (i + 1) / NUM_SEGMENTS));
        }
    }
    
     function get_approximateObject() : Object
    {
        _approximateObject.matrix.identity();
        _approximateObject.matrix.translate(x, y);
        return _approximateObject;
    }
    
     function get_radius() : Float
    {
        return _radius;
    }
    
     function get_radiusSquared() : Float
    {
        return _radiusSquared;
    }
    
     function set_radius(value : Float) : Float
    {
        _radius = value;
        _radiusSquared = _radius * _radius;
        return value;
    }
}
