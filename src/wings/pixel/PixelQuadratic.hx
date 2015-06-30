package wings.pixel;
import wings.pixel.IPixelShape;
import wings.pixel.TPixels;
import wings.pixel.Plot;
using wings.pixel.Plot;
class PixelQuadratic implements IPixelShape {
    public var pixels: TPixels;
    var dxc: Float;
    var dyc: Float;
    var dxe: Float;
    var dye: Float;

    public var bx: Float;
    public var by: Float;
    public var cx: Float;
    public var cy: Float;
    public var ex: Float;
    public var ey: Float;
    public var bxi: Int;
    public var byi: Int;
    public var cxi: Int;
    public var cyi: Int;
    public var exi: Int;
    public var eyi: Int;
    public var thickness: Float;

	public function new( pixels_: TPixels, bx_: Float, by_: Float, cx_: Float, cy_: Float, ex_: Float, ey_: Float, w: Float ): Void{
        pixels = pixels_;
        dxc = bx_ - cx_;
        dyc = bx_ - cy_;
        dxe = bx_ - ex_;
        dye = by_ - ey_;
        move( bx_, by_ );
        thickness = w;
        // max and min not implemented yet?
    }

    public function fill( col: Int, alpha: Float ):Void {}

    public function move( bx_: Float, by_: Float ){
        bx = bx_;
        by = by_;
        cx = bx_ + dxc;
        cy = by_ + dxc;
        ex = bx_ + dxe;
        ey = by_ + dye;
        bxi = Std.int( bx );
        byi = Std.int( by );
        cxi = Std.int( cx );
        cyi = Std.int( cy );
        exi = Std.int( ex );
        eyi = Std.int( ey );
    }

    public function translate( tx_: Float, ty_: Float ){
        move( bx + tx_, by + ty_ );
    }

    public function hitTest( x_: Float, y_: Float ): Bool {
        // check bounding box first.
        //if(!( x_ > minX && x_ < maxX && y_ > minY && y_ < maxY )) return;
        return false;
    }
    public function plot( col: Int, alpha: Float, ?w: Float = 1 ): Void {
        var a: Int = Std.int( alpha * 0xff );
        Plot.plotQuadBezierSegAA( pixels, bxi, byi, cxi, cyi, exi, eyi, col, a );
    }
}
