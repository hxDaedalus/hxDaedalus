package wings.pixel;
import wings.pixel.TPixels;
import wings.pixel.Plot;
using wings.pixel.Plot;
class Fill{

    /** Fills the specified rect area, with `value` expressed in ARGB format. Doesn't do any bound checking. */
    public static inline function fillRectColorAndPixel( pixels: TPixels, x: Int, y: Int, wid: Int, hi: Int, col: Int, alpha: Int ):Void {
        var pos = (y * pixels.width + x) << 2;
        var stridePixels = new TPixels( wid, 1, true);
        stridePixels.format = pixels.format;
        var stride = wid << 2;
        for (x in 0...wid) Plot.setPixelColorAndAlpha( stridePixels, x, 0, col, alpha );
        for (y in 0...hi) {
            pixels.bytes.blit(pos, stridePixels.bytes, 0, stride);
            pos += pixels.width << 2;
        }
    }

}
