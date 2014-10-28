import flash.display.BitmapData;
#if testImage
@:bitmap("test.png")
#else
@:bitmap("DemoFromBitmap.png")
#end
class DemoFromBitmapImage extends flash.display.BitmapData{}