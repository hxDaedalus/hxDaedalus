package hxDaedalus.graphics.pixel;
import hxDaedalus.graphics.Pixels;

class PixelRectangle {

    public var pixels: Pixels;
    public var x: Float;
    public var y: Float;
    public var radius: Float;
    public var width: Float;
    public var height: Float;
    var maxX: Int;
    var minX: Int;
    var maxY: Int;
    var minY: Int;

    public function new( pixels: Pixels, x_: Float, y_: Float, width_: Float, height_: Float ){
        x = x_;
        y = y_;
        width = width_;
        height = height_;
        maxX = Std.int( x_ + width_ );
        minX = Std.int( x_ );
        maxY = Std.int( y_ + height_ );
        minY = Std.int( y_ );
    }

    public function hitTest( x_: Float, y_: Float ): Bool {
        return ( x_ > minX && x_ < maxX && y_ > minY && y_ < maxY );
    }

    public function fill( col: Int, alpha: Float ):Void {
        var a: Int = Std.int( alpha * 0xff );
        pixels.fillRectColorAndPixel( minX, minY, maxX, maxY, col, a );
    }

    public function plot( col: Int, alpha: Float, wid: Float ): Void {
        var a: Int = Std.int( alpha * 0xff );
        // to implement
        //BresenHamPixels.plotLine( pixels, , col, alpha );
        //BresenHamPixels.plotLine( pixels, , col, alpha );
        //BresenHamPixels.plotLine( pixels, , col, alpha );
        //BresenHamPixels.plotLine( pixels, , col, alpha );
    }
}
