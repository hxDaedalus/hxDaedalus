package wings.pixel;
import wings.pixel.IPixelShape;
import wings.pixel.TPixels;
import wings.pixel.Plot;
using wings.pixel.Plot;
class PixelLine implements IPixelShape {
    public var pixels: TPixels;
    public var d0x: Float;
    public var d0y: Float;
    public var x0: Float;
    public var y0: Float;
    public var x1: Float;
    public var y1: Float;
    public var x0i: Int;
    public var y0i: Int;
    public var x1i: Int;
    public var y1i: Int;

    public var width: Float;
    var maxX: Float;
    var minX: Float;
    var maxY: Float;
    var minY: Float;
    var m: Float;
    var c: Float;
    var dx: Float;
    var dy: Float;
    var theta: Float;

    public function new( pixels_: TPixels, x0_:Float, y0_:Float, x1_:Float, y1_:Float, width_: Float ): Void{
        pixels = pixels_;
        width = width_;
        d0x = x0_ - x1_;
        d0y = y0_ - y1_;
        move( x0_, y0_ );
    }

    public function move( x0_: Float, y0_: Float ): Void {
        x0 = x0_;
        y0 = y0_;
        x1 = x0_ + d0x;
        y1 = y0_ + d0y;
        x0i = Std.int( x0 );
        y0i = Std.int( y0 );
        x1i = Std.int( x1 );
        y1i = Std.int( y1 );
        theta = Math.atan2( y1 - y0, x1 - x0 );
        dy = width / Math.abs( Math.cos( theta ) );
        dx = width / Math.abs( Math.sin( theta ) );
        maxX = Math.max( x0, x1 )+dx;
        minX = Math.min( x0, x1 )-dx;
        maxY = Math.max( y0, y1 )+dy;
        minY = Math.min( y0, y1 )-dy;
        var startX0 = ( x0 < maxX );
        if( startX0 ){
            m = ( y1 - y0 )/( x1 - x0 );
            c = y1 - m*x1;
        } else {
            m = ( y0 - y1 )/( x0 - x1 );
            c = y1 - m*x1;
        }
    }

    public function fill( col: Int, alpha: Float ):Void {}

    public function translate( tx_: Float, ty_: Float ) {
        move( x0 + tx_, y0 + ty_ );
    }

    public function hitTest( x_: Float, y_: Float ): Bool {
        // check bounding box first.
        if(!( x_ > minX && x_ < maxX && y_ > minY && y_ < maxY )) return false;
        var lineY = m*x_ + c;
        return ( lineY + dy > y_ ) && ( lineY - dy < y_ );
    }

    public function plot( col: Int, alpha: Float, ?width: Float = 1 ){
        var a: Int = Std.int( alpha * 0xff );
        //pixels.plotLineWidth( x0i, y0i, x1i, y1i, width, col, a );
        Plot.plotLine( pixels, x0i, y0i, x1i, y1i, col, a );
        //pixels.plotLineAA(  x0i, y0i, x1i, y1i, col, a );
    }

}
