package ddls.data;


import ddls.data.math.Matrix2D;

class DObject {
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

    
    private static var INC : Int = 0;
    private var _id : Int;
    
    private var _matrix : Matrix2D;
    private var _coordinates : Array<Float>;
    private var _constraintShape : ConstraintShape;
    
    private var _pivotX : Float;
    private var _pivotY : Float;
    
    private var _scaleX : Float;
    private var _scaleY : Float;
    private var _rotation : Float;
    private var _x : Float;
    private var _y : Float;
    
    private var _hasChanged : Bool;
    
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
    
    private function get_id(): Int {
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
    
    private function get_pivotX(): Float {
        return _pivotX;
    }
    
    private function set_pivotX( value: Float ): Float {
        _pivotX = value;
        _hasChanged = true;
        return value;
    }
    
    private function get_pivotY(): Float {
        return _pivotY;
    }
    
    private function set_pivotY( value: Float ): Float {
        _pivotY = value;
        _hasChanged = true;
        return value;
    }
    
    private function get_scaleX(): Float {
        return _scaleX;
    }
    
    private function set_scaleX( value: Float ): Float {
        if( _scaleX != value ){
            _scaleX = value;
            _hasChanged = true;
        }
        return value;
    }
    
    private function get_scaleY(): Float {
        return _scaleY;
    }
    
    private function set_scaleY( value: Float ): Float {
        if( _scaleY != value ){
            _scaleY = value;
            _hasChanged = true;
        }
        return value;
    }
    
    private function get_rotation(): Float {
        return _rotation;
    }
    
    private function set_rotation( value: Float ): Float {
        if( _rotation != value ){
            _rotation = value;
            _hasChanged = true;
        }
        return value;
    }
    
    private function get_x(): Float {
        return _x;
    }
    
    private function set_x( value : Float ): Float {
        if( _x != value ){
            _x = value;
            _hasChanged = true;
        }
        return value;
    }
    
    private function get_y() : Float {
        return _y;
    }
    
    private function set_y( value: Float ): Float {
        if( _y != value ) {
            _y = value;
            _hasChanged = true;
        }
        return value;
    }
    
    private function get_matrix(): Matrix2D {
        return _matrix;
    }
    
    private function set_matrix( value: Matrix2D ): Matrix2D {
        _matrix = value;
        _hasChanged = true;
        return value;
    }
    
    private function get_coordinates(): Array<Float> {
        return _coordinates;
    }
    
    private function set_coordinates( value: Array<Float> ): Array<Float> {
        _coordinates = value;
        _hasChanged = true;
        return value;
    }
    
    private function get_constraintShape(): ConstraintShape
    {
        return _constraintShape;
    }
    
    private function set_constraintShape( value: ConstraintShape ): ConstraintShape {
        _constraintShape = value;
        _hasChanged = true;
        return value;
    }
    
    private function get_hasChanged(): Bool {
        return _hasChanged;
    }
    
    private function set_hasChanged( value: Bool ): Bool {
        _hasChanged = value;
        return value;
    }
    
    private function get_edges(): Array<Edge> {
        
        var res = new Array<Edge>();
        
        for( i in 0..._constraintShape.segments.length ){
            for( j in 0..._constraintShape.segments[ i ].edges.length ){
                res.push( _constraintShape.segments[ i ].edges[ j ] );
            }
        }
        
        return res;
    }
}
