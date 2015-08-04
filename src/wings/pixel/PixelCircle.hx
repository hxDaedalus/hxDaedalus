package wings.pixel;
import wings.pixel.TPixels;
import wings.pixel.Fill;
import wings.pixel.Plot;
using wings.pixel.Plot;
using wings.pixel.Fill;
class PixelCircle {
    public var pixels: TPixels;
    public var cx: Float;
    public var cy: Float;
    public var cxi: Int;
    public var cyi: Int;
    public var minX: Int;
    public var maxX: Int;
    public var minY: Int;
    public var maxY: Int;
    public var radius: Float;
    var radius2: Float;

    public function new( pixels_: TPixels, cx_:Float, cy_:Float, radius_:Float ) {
        pixels = pixels_;
        radius = radius_;
        move( cx_, cy_ );
        radius2 = radius_*radius_;
    }

    public function move( cx_:Float, cy_:Float ) {
        cx = cx_;
        cy = cy_;
        cxi = Std.int( cx );
        cyi = Std.int( cy );
        minX = Std.int( cx - radius );
        maxX = Std.int( cx + radius );
        minY = Std.int( cy - radius );
        maxY = Std.int( cy + radius );
    }

    public function tranlate( tx_: Float, ty_: Float ) {
        move( cx + tx_, cy + ty_ );
    }

    public function hitTest( x_: Float, y_: Float ): Bool {
        var dx = cx - x_;
        var dy = cy - y_;
        return radius2 >= dx*dx + dy*dy;
    }

    public function fill( col: Int, alpha: Float ): Void
    {
        var a: Int = Std.int( alpha * 0xff );
        for( x in minX...maxX ){
            for( y in minY...maxY ){
                if( hitTest( x, y ) ) Plot.setPixelColorAndAlpha( pixels, x, y, col, a );
            }
        }
    }

    public function plot( col: Int, alpha: Float, ?wid: Float = 1 ): Void {
        var a: Int = Std.int( alpha * 0xff );
        Plot.plotCircleAA( pixels, cxi, cyi, radius, col, a );
    }
}
