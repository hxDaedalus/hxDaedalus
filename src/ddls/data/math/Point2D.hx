package ddls.data.math;
class Point2D{
    public var length(get, never) : Float;
    public var x: Float;
    public var y: Float;
    
    public function new( x_: Float = 0, y_: Float = 0 ){
        x = x_;
        y = y_;
    }
    
    public function transform( matrix: Matrix2D ): Void {
        matrix.tranform( this );
    }
    
    public function setXY( x_: Float, y_: Float ): Void {
        x = x_;
        y = y_;
    }
    
    public function clone(): Point2D {
        return new Point2D( x, y );
    }
    
    public function substract( p: Point2D ): Void {
        x -= p.x;
        y -= p.y;
    }
    
    private function get_length(): Float {
        return Math.sqrt( x*x + y*y );
    }
    
    public function normalize(): Void {
        var norm : Float = length;
        x = x / norm;
        y = y / norm;
    }
    
    public function scale(s : Float): Void {
        x = x * s;
        y = y * s;
    }
    
    public function distanceTo( p: Point2D ): Float {
        var diffX : Float = x - p.x;
        var diffY : Float = y - p.y;
        return Math.sqrt( diffX*diffX + diffY*diffY );
    }
}
