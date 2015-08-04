package wings.pixel;
import wings.pixel.IPixelShape;
import wings.pixel.Plot;
using wings.pixel.Plot;
class PixelRectangle implements IPixelShape{

    public var pixels: TPixels;
    public var x: Float;
    public var y: Float;
    public var radius: Float;
    public var width: Int;
    public var height: Int;
    var maxX: Int;
    var minX: Int;
    var maxY: Int;
    var minY: Int;

    public function new( pixels_: TPixels, x_: Float, y_: Float, width_: Float, height_: Float ){
        pixels = pixels_;
        width = Std.int( width_ );
        height = Std.int( height_ );
        move( x_, y_ );
    }

    public function move( x_: Float, y_: Float ):Void {
        x = x_;
        y = y_;
        maxX = Std.int( x_ + width );
        minX = Std.int( x_ );
        maxY = Std.int( y_ + height );
        minY = Std.int( y_ );
    }

    public function translate( x_: Float, y_: Float ):Void {
        move( x + x_, y + y_ );
    }

    public function hitTest( x_: Float, y_: Float ): Bool {
        return ( x_ > minX && x_ < maxX && y_ > minY && y_ < maxY );
    }

    public function fill( col: Int, alpha: Float ):Void {
        var a: Int = Std.int( alpha * 0xff );
        Fill.fillRectColorAndPixel( pixels, minX, minY, width, height, col, a );
    }

    public function plot( col: Int, alpha: Float, ?wid: Float = 1 ): Void {
        var a: Int = Std.int( alpha * 0xff );
        Plot.plotLine( pixels, minX, minY, maxX, minY, col, a );
        Plot.plotLine( pixels, maxX, minY, maxX, maxY, col, a );
        Plot.plotLine( pixels, maxX, maxY, minX, maxY, col, a );
        Plot.plotLine( pixels, minX, maxY, minX, minY, col, a );
    }
}
