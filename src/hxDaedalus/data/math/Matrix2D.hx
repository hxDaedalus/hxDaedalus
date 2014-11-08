package hxDaedalus.data.math;
import hxDaedalus.data.math.Point2D;
class Matrix2D {
    public var a: Float;
    public var b: Float;
    public var c: Float;
    public var d: Float;
    public var e: Float;
    public var f: Float;

    /*    
    hxDaedalusPoint2D represents row vector in homogeneous coordinates:
    [x, y, 1]
    
    hxDaedalusMatrix2D represents transform matrix in homogeneous coordinates:
    [a, b, 0]
    [c, d, 0]
    [e, f, 1]
    */
    
    
    public function new( a_: Float = 1, b_: Float = 0, c_: Float = 0, d_: Float = 1, e_: Float = 0, f_: Float = 0 ){
        a = a_;
        b = b_;
        c = c_;
        d = d_;
        e = e_;
        f = f_;
    }
    
    public function identity(): Void {
        /*
        [1, 0, 0]
        [0, 1, 0]
        [0, 0, 1]
        */
        
        a = 1;
        b = 0;
        c = 0;
        d = 1;
        e = 0;
        f = 0;
    }
    
    public function translate( tx: Float, ty: Float ): Void {
        /*
        [1,  0,  0]
        [0,  1,  0]
        [tx, ty, 1]
        
        */
        e = e + tx;
        f = f + ty;
    }
    
    public function scale( sx : Float, sy : Float ): Void {
        /*
        [sx, 0, 0]
        [0, sy, 0]
        [0,  0, 1]
        */
        a = a * sx;
        b = b * sy;
        c = c * sx;
        d = d * sy;
        e = e * sx;
        f = f * sy;
    }
    
    public function rotate( rad : Float ): Void {
        /*
        [ cos, sin, 0]
        [-sin, cos, 0]
        [   0,   0, 1]
        
        [a, b, 0]
        [c, d, 0]
        [e, f, 1]
        */
        var cos : Float = Math.cos(rad);
        var sin : Float = Math.sin(rad);
        var a_ : Float = a * cos + b * -sin;
        var b_ : Float = a * sin + b * cos;
        var c_ : Float = c * cos + d * -sin;
        var d_ : Float = c * sin + d * cos;
        var e_ : Float = e * cos + f * -sin;
        var f_ : Float = e * sin + f * cos;
        a = a_;
        b = b_;
        c = c_;
        d = d_;
        e = e_;
        f = f_;
    }
    
    public function clone(): Matrix2D {
        return new Matrix2D(a, b, c, d, e, f);
    }
    
    public function tranform( point: Point2D ): Void {
        /*
        [a, b, 0]
        [c, d, 0]
        [e, f, 1]
        [x, y, 1]
        */
        var x : Float = a * point.x + c * point.y + e;
        var y : Float = b * point.x + d * point.y + f;
        point.x = x;
        point.y = y;
    }
    
    public function transformX( x: Float, y: Float ): Float {
        return a * x + c * y + e;
    }
    
    public function transformY( x : Float, y: Float): Float {
        return b * x + d * y + f;
    }
    
    public function concat( matrix: Matrix2D ): Void {
        var a_ : Float = a * matrix.a + b * matrix.c;
        var b_ : Float = a * matrix.b + b * matrix.d;
        var c_ : Float = c * matrix.a + d * matrix.c;
        var d_ : Float = c * matrix.b + d * matrix.d;
        var e_ : Float = e * matrix.a + f * matrix.c + matrix.e;
        var f_ : Float = e * matrix.b + f * matrix.d + matrix.f;
        a = a_;
        b = b_;
        c = c_;
        d = d_;
        e = e_;
        f = f_;
    }
    
}
