package hxDaedalus.graphics.pixel;
import hxDaedalus.graphics.Pixels;

class PixelRectangle {

    public var pixels: Pixels;
    public var x: Float;
    public var y: Float;
    public var radius: Float;
    var maxX: Float;
    var minX: Float;
    var maxY: Float;
    var minY: Float;

    public function new( pixels: Pixels, x_: Float, y_: Float, width_: Float, height_: Float ){
        x = x_;
        y = y_;
        width = width_;
        height = height;
        maxX = x_ + width_;
        minX = x_;
        maxY = y_ + height_;
        minY = y_;
    }

    public function hitTest( x_: Float, y_: Float ): Bool {
        return ( x_ > minX && x_ < maxX && y_ > minY && y_ < maxY );
    }

    public function fill( color: Int, alpha: Int ):Void {
        pixels.fillRectColorAndPixel( minX, minY, maxX, maxY, col, alpha );
    }

    public function plot( col: Int, alpha: Int, wid: Float ): Void {
        // maybe not correct circle
        //BresenHamPixels.plotLine( pixels, , col, alpha );
        //BresenHamPixels.plotLine( pixels, , col, alpha );
        //BresenHamPixels.plotLine( pixels, , col, alpha );
        //BresenHamPixels.plotLine( pixels, , col, alpha );
    }
}
