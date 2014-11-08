package hxDaedalus.data;


import hxDaedalus.data.math.Matrix2D;

class Object {
    public var id(get, never) : Int;
    public var pivotX(get, set) : Float;
    public var pivotY(get, set) : Float;
    public var scaleX(get, set) : Float;
    public var scaleY(get, set) : Float;
    public var rotation(get, set) : Float;
    public var x(get, set) : Float;
    public var y(get, set) : Float;
    public var matrix(get, set) : Matrix2D;
    public var coordinates(get, set) : Array<Float>;
    public var constraintShape(get, set) : ConstraintShape;
    public var hasChanged(get, set) : Bool;
    public var edges(get, never) : Array<Edge>;

    
     static var INC : Int = 0;
     var _id : Int;
    
     var _matrix : Matrix2D;
     var _coordinates : Array<Float>;
     var _constraintShape : ConstraintShape;
    
     var _pivotX : Float;
     var _pivotY : Float;
    
     var _scaleX : Float;
     var _scaleY : Float;
     var _rotation : Float;
     var _x : Float;
     var _y : Float;
    
     var _hasChanged : Bool;
    
    public function new(){
        _id = INC;
        INC++;
        
        _pivotX = 0;
        _pivotY = 0;
        
        _matrix = new Matrix2D();
        _scaleX = 1;
        _scaleY = 1;
        _rotation = 0;
        _x = 0;
        _y = 0;
        
        _coordinates = new Array<Float>();
        
        _hasChanged = false;
    }
    
     function get_id(): Int {
        return _id;
    }
    
    public function dispose(): Void {
        _matrix = null;
        _coordinates = null;
        _constraintShape = null;
    }
    
    public function updateValuesFromMatrix(): Void {
        
        
    }
    
    public function updateMatrixFromValues(): Void {
        _matrix.identity();
        _matrix.translate(-_pivotX, -_pivotY);
        _matrix.scale(_scaleX, _scaleY);
        _matrix.rotate(_rotation);
        _matrix.translate(_x, _y);
    }
    
     function get_pivotX(): Float {
        return _pivotX;
    }
    
     function set_pivotX( value: Float ): Float {
        _pivotX = value;
        _hasChanged = true;
        return value;
    }
    
     function get_pivotY(): Float {
        return _pivotY;
    }
    
     function set_pivotY( value: Float ): Float {
        _pivotY = value;
        _hasChanged = true;
        return value;
    }
    
     function get_scaleX(): Float {
        return _scaleX;
    }
    
     function set_scaleX( value: Float ): Float {
        if( _scaleX != value ){
            _scaleX = value;
            _hasChanged = true;
        }
        return value;
    }
    
     function get_scaleY(): Float {
        return _scaleY;
    }
    
     function set_scaleY( value: Float ): Float {
        if( _scaleY != value ){
            _scaleY = value;
            _hasChanged = true;
        }
        return value;
    }
    
     function get_rotation(): Float {
        return _rotation;
    }
    
     function set_rotation( value: Float ): Float {
        if( _rotation != value ){
            _rotation = value;
            _hasChanged = true;
        }
        return value;
    }
    
     function get_x(): Float {
        return _x;
    }
    
     function set_x( value : Float ): Float {
        if( _x != value ){
            _x = value;
            _hasChanged = true;
        }
        return value;
    }
    
     function get_y() : Float {
        return _y;
    }
    
     function set_y( value: Float ): Float {
        if( _y != value ) {
            _y = value;
            _hasChanged = true;
        }
        return value;
    }
    
     function get_matrix(): Matrix2D {
        return _matrix;
    }
    
     function set_matrix( value: Matrix2D ): Matrix2D {
        _matrix = value;
        _hasChanged = true;
        return value;
    }
    
     function get_coordinates(): Array<Float> {
        return _coordinates;
    }
    
     function set_coordinates( value: Array<Float> ): Array<Float> {
        _coordinates = value;
        _hasChanged = true;
        return value;
    }
    
     function get_constraintShape(): ConstraintShape
    {
        return _constraintShape;
    }
    
     function set_constraintShape( value: ConstraintShape ): ConstraintShape {
        _constraintShape = value;
        _hasChanged = true;
        return value;
    }
    
     function get_hasChanged(): Bool {
        return _hasChanged;
    }
    
     function set_hasChanged( value: Bool ): Bool {
        _hasChanged = value;
        return value;
    }
    
     function get_edges(): Array<Edge> {
        
        var res = new Array<Edge>();
        var seg = _constraintShape.segments;
        for( i in 0...seg.length ){
            for( j in 0...seg[ i ].edges.length ){
                res.push( seg[ i ].edges[ j ] );
            }
        }
        
        return res;
    }
}
