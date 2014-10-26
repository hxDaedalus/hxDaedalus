package ddls.ai;


import ddls.data.DObject;

class EntityAI
{
    public var approximateObject(get, never) : DObject;
    public var angleFOV : Float;
    public var dirNormY : Float;
    public var dirNormX : Float;
    public var y : Float;
    public var x : Float;
    public var radius(get, set) : Float;
    public var radiusSquared(get, never) : Float;

    
    private var _radius : Float;
    private var _radiusSquared : Float;
    private var _x : Float;
    private var _y : Float;
    private var _dirNormX : Float;
    private var _dirNormY : Float;
    private var _angleFOV : Float;
    private var _approximateObject : DObject;
    private static inline var NUM_SEGMENTS : Int = 6;
    
    public function new()
    {
        _radius = 10;
        x = y = 0;
        dirNormX = 1;
        dirNormY = 0;
        angleFOV = 60;
    }
    
    public function buildApproximation() : Void {
        _approximateObject = new DObject();
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
    
    private function get_approximateObject() : DObject
    {
        _approximateObject.matrix.identity();
        _approximateObject.matrix.translate(x, y);
        return _approximateObject;
    }
    
    private function get_radius() : Float
    {
        return _radius;
    }
    
    private function get_radiusSquared() : Float
    {
        return _radiusSquared;
    }
    
    private function set_radius(value : Float) : Float
    {
        _radius = value;
        _radiusSquared = _radius * _radius;
        return value;
    }
}
