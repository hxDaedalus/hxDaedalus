package hxDaedalus.graphics.pixel;

class PixelLine {
    public var pixels: Pixels;
    public var x0: Float;
    public var y0: Float;
    public var x1: Float;
    public var y1: Float;
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

    public function new( pixels_: Pixels, x0_:Float, y0_:Float, x1_:Float, y1_:Float, width_: Float ): Void{
        x0 = x0_;
        y0 = y0_;
        x1 = x1_;
        y1 = y1_;
        width = width_;
        theta = Math.atan2( y1_ - y0_, x1_ - x0_ );
        dy = width_ / Math.abs( Math.cos( theta ) );
        dx = width_ / Math.abs( Math.sin( theta ) );
        maxX = Math.max( x0_, x1_ )+dx;
        minX = Math.min( x0_, x1_ )-dx;
        maxY = Math.max( y0_, y1_ )+dy;
        minY = Math.min( y0_, y1_ )-dy;
        var startX0 = ( x0 < maxX );
        if( startX0 ){
            m = ( y1_ - y0_ )/( x1_ - x0_ );
            c = y1_ - m*x1_;
        } else {
            m = ( y0_ - y1_ )/( x0_ - x1_ );
            c = y1_ - m*x1_;
        }
    }

    public function hitTest( x_: Float, y_: Float ): Bool {
        // check bounding box first.
        if(!( x_ > minX && x_ < maxX && y_ > minY && y_ < maxY )) return false;
        var lineY = m*x_ + c;
        return ( lineY + dy > y_ ) && ( lineY - dy < y_ );
    }

    public function plot( col: Int, alpha: Float ){
        var a: Int = Std.int( alpha * 0xff );
        BresenHamPixels.plotLineWidth( pixels, Std.int( x0 ), Std.int( y0 ), Std.int( x1 ), Std.int( y1 ), width, col, a );
    }

}
