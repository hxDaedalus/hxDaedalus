package hxDaedalus.graphics.pixel;

class PixelQuadratic {
    public var pixels: Pixels;
    public var bx: Float;
    public var by: Float;
    public var cx: Float;
    public var cy: Float;
    public var ex: Float;
    public var ey: Float;

	public function new( pixels_: Pixels, bx: Float, by: Float, cx: Float, cy: Float, ex: Float, ey: Float ): Void{
        bx = bx_;
        by = by_;
        cx = cx_;
        cy = cy_;
        ax = ax_;
        ay = ay_;
        // not implemented yet?
    }

    public function hitTest( x_: Float, y_: Float ): Bool {
        // check bounding box first.
        //if(!( x_ > minX && x_ < maxX && y_ > minY && y_ < maxY )) return;
        return false;
    }
    public function plot( col: Int, alpha: Int, wid: Float ): Void {
        //BresenHamPixels.plot*( pixels, , col, alpha );
    }
}
