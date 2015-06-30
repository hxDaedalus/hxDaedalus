package wings.pixel;
import wings.pixel.TPixels;
import wings.pixel.IPixelShape;
import wings.pixel.Fill;
import wings.pixel.Plot;

using wings.pixel.Plot;
using wings.pixel.Fill;
class PixelTriangle implements IPixelShape {
    var pixels: TPixels;
    var maxX: Int;
    var minX: Int;
    var maxY: Int;
    var minY: Int;

    // triangle precalculations
    var s0: Float;
    var sx: Float;
    var sy: Float;
    var t0: Float;
    var tx: Float;
    var ty: Float;
    var A: Float;

    public var points: Array<Float>;

    public function new( pixels_: TPixels, points_: Array<Float> ){
        pixels = pixels_;
        points = points_;
        position();
    }

    public function move( x_: Float, y_: Float ){
        var dx = points[0] - x_;
        var dy = points[1] - y_;
        translate( dx, dy );
    }

    public function translate( x_: Float, y_: Float ){
        var point: Float;
        var len: Int = Std.int( points.length/2 );
        var id: Int;
        for( i in 0...len ){
            id = Std.int( i*2);
            points[ id ] += x_;
            id += 1;
            points[ id ] += y_;
        }
    }

    function position(){
        var p0x = points[0];
        var p0y = points[1];
        var p1x = points[2];
        var p1y = points[3];
        var p2x = points[4];
        var p2y = points[5];
        maxX = Std.int( Math.max( Math.max( p0x, p1x ), p2x ) );
        minX = Std.int( Math.min( Math.min( p0x, p1x ), p2x ) );
        maxY = Std.int( Math.max( Math.max( p0y, p1y ), p2y ) );
        minY = Std.int( Math.min( Math.min( p0y, p1y ), p2y ) );
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

    public function fill( col: Int, alpha: Float ):Void {
        var a: Int = Std.int( alpha * 0xff );
        for( x in minX...maxX ){
            for( y in minY...maxY ){
                if( hitTest( x, y ) ) Plot.setPixelColorAndAlpha( pixels, x, y, col, a );
            }
        }
    }
    public function plot( col: Int, alpha: Float, ?wid: Float = 1 ): Void {
        var a: Int = Std.int( alpha * 0xff );
        var p0x = Std.int( points[0] );
        var p0y = Std.int( points[1] );
        var p1x = Std.int( points[2] );
        var p1y = Std.int( points[3] );
        var p2x = Std.int( points[4] );
        var p2y = Std.int( points[5] );
        Plot.plotLine( pixels, p0x, p0y, p1x, p1y, col, a );
        Plot.plotLine( pixels, p1x, p1y, p2x, p2y, col, a );
        Plot.plotLine( pixels, p2x, p2y, p0x, p0y, col, a );
    }
}
