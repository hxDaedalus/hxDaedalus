package hxDaedalus.data;


import hxDaedalus.data.math.Matrix2D;

@:expose
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
    public var polyPoints(never,set): Array<Float>;
    public var multiPoints( never, set ): Array<Array<Float>>;
    
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
    public function clockWise(): Bool {
        var count = 0;
        var c = coordinates;
        var x1: Float;
        var y1: Float;
        var x2: Float;
        var y2: Float;
        var signedArea2: Float = 0;
        var len = c.length;
        while( count < len ){
            x1 = c[count];
            y1 = c[count+1];
            x2 = c[count+2];
            y2 = c[count+3];
            count+=4;
            signedArea2 += (x1 * y2 - x2 * y1);
        }
        return signedArea2>0;
    }
    function set_multiPoints( arr: Array<Array<Float>> ): Array<Array<Float>> {
        var shapeCoords = new Array<Float>();
        var j: Int;
        for( shape in arr ){
            shapeCoords.push( shape[0] );
            shapeCoords.push( shape[1] );
            for( i in 2...shape.length ){
                if( ( i )%2 == 0 && i > 2 ){
                    shapeCoords.push( shape[ i - 2 ] );
                    shapeCoords.push( shape[ i - 1 ] );
                }
                shapeCoords.push( shape[ i ] );
            }
            j = shape.length;
            shapeCoords.push( shape[ j - 2 ] );
            shapeCoords.push( shape[ j - 1 ] );
            shapeCoords.push( shape[ 0 ] );
            shapeCoords.push( shape[ 1 ] );
        }
        coordinates = shapeCoords;
        return arr;
    }
    function set_polyPoints( shape: Array<Float> ):Array<Float> {
        var shapeCoords = new Array<Float>();
        shapeCoords.push( shape[0] );
        shapeCoords.push( shape[1] );
        for( i in 2...shape.length ){
            if( ( i )%2 == 0 && i > 2 ) {
                shapeCoords.push( shape[ i - 2 ]);
                shapeCoords.push( shape[ i - 1 ] );
            }
            shapeCoords.push( shape[ i ] );
        }
        var i = shape.length;
        shapeCoords.push( shape[ i - 2 ] );
        shapeCoords.push( shape[ i - 1 ] );
        shapeCoords.push( shape[ 0 ] );
        shapeCoords.push( shape[ 1 ] );
        coordinates = shapeCoords;
        return shape;
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
