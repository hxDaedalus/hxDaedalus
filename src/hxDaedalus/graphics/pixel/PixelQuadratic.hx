package hxDaedalus.graphics.pixel;

class PixelQuadratic {
    public var pixels: Pixels;
    public var bx: Float;
    public var by: Float;
    public var cx: Float;
    public var cy: Float;
    public var ex: Float;
    public var ey: Float;
    public var thickness: Float;

	public function new( pixels_: Pixels, bx_: Float, by_: Float, cx_: Float, cy_: Float, ex_: Float, ey_: Float, w: Float ): Void{
        pixels = pixels_;
        bx = bx_;
        by = by_;
        cx = cx_;
        cy = cy_;
        ex = ex_;
        ey = ey_;
        thickness = w;
        // max and min not implemented yet?
    }

    public function hitTest( x_: Float, y_: Float ): Bool {
        // check bounding box first.
        //if(!( x_ > minX && x_ < maxX && y_ > minY && y_ < maxY )) return;
        return false;
    }
    public function plot( col: Int, alpha: Float ): Void {
        var a: Int = Std.int( alpha * 0xff );
        BresenHamPixels.plotQuadBezierSegAA( pixels, Std.int( bx ), Std.int( by ), Std.int( cx ), Std.int( cy ), Std.int( ex ), Std.int( ey ), col, a );
    }
}
