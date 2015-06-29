package hxDaedalus.graphics.pixel;
import hxDaedalus.graphics.Pixels;
import hxDaedalus.graphics.pixel.BresenHamPixels;
class PixelCircle {
    public var pixels: IPixels;
    public var cx: Float;
    public var cy: Float;
    public var minX: Int;
    public var maxX: Int;
    public var minY: Int;
    public var maxY: Int;
    public var radius: Float;
    var radius2: Float;

    public function new( pixels_: Pixels, cx_:Float, cy_:Float, radius_:Float ) {
        pixels = pixels_;
        cx = cx_;
        cy = cy_;
        radius = radius_;
        minX = Std.int( cx - radius );
        maxX = Std.int( cx + radius );
        minY = Std.int( cy - radius );
        maxY = Std.int( cy + radius );
        radius2 = radius_*radius_;
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
                if( hitTest( x, y ) ) pixels.setPixelColorAndAlpha( x, y, col, a );
            }
        }
    }
    public function plot( col: Int, alpha: Float, wid: Float ): Void {
        var a: Int = Std.int( alpha * 0xff );
        // maybe not correct circle
        BresenHamPixels.plotCircleAA( pixels, Std.int( cx ), Std.int( cy ), radius, col, a );
    }
}
