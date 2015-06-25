package hxDaedalus.graphics.pixel;
import hxDaedalus.graphics.Pixels;
class PixelTriangle {
    var pixels: Pixels;
    var maxX: Float;
    var minX: Float;
    var maxY: Float;
    var minY: Float;

    // triangle precalculations
    var s0: Float;
    var sx: Float;
    var sy: Float;
    var t0: Float;
    var tx: Float;
    var ty: Float;
    var A: Float;
    public var points: Array<Float>;

    public function new( pixels_: Pixels, points_: Array<Float> ){
        pixels = pixels_;
        points = points_;
        var p0x = points_[0];
        var p0y = points_[1];
        var p1x = points_[2];
        var p1y = points_[3];
        var p2x = points_[4];
        var p2y = points_[5];
        maxX = Math.max( Math.max( p0x, p1x ), p2x );
        minX = Math.min( Math.min( p0x, p1x ), p2x );
        maxY = Math.max( Math.max( p0y, p1y ), p2y );
        minY = Math.min( Math.min( p0y, p1y ), p2y );
        s0 = p0y*p2x - p0x*p2y;
        sx = p2y - p0y;
        sy = p0x - p2x;
        t0 = p0x*p1y - p0y*p1x;
        tx = p0y - p1y;
        ty = p1x - p0x;
        A = -p1y*p2x + p0y*(-p1x + p2x) + p0x*(p1y - p2y) + p1x*p2y;
    }

    public function hitTest( x: Float, y: Float ): Bool {
        // check bounding box first.
        if( !( x > minX && x < maxX && y > minY && y < maxY ) ) return false;
        var s = s0 + sx*x + sy*y;
        var t = t0 + tx*x + ty*y;
        if (s <= 0 || t <= 0) return false;
        return (s + t) < A;
    }

    public function fill( color: Int, alpha: Int ):Void {
        for( x in minX...maxX ){
            for( y in minY...maxY ){
                if( hitTest( x, y ) ) pixels.setPixelColorAndAlpha( x, y, color, alpha );
            }
        }
    }
    public function plot( col: Int, alpha: Int, wid: Float ): Void {
        // to implement
        //BresenHamPixels.plotLine( pixels, , col, alpha );
        //BresenHamPixels.plotLine( pixels, , col, alpha );
        //BresenHamPixels.plotLine( pixels, , col, alpha );
    }
}
