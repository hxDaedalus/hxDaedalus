package;

import ddls.data.math.Point2D;
import ddls.data.Mesh;
import ddls.data.Object;
import ddls.factories.BitmapObjectFactory;
import ddls.factories.RectMeshFactory;
import ddls.view.SimpleView;

import flash.display.Bitmap;
import flash.display.Sprite;


#if !html5
@:bitmap("DemoFromBitmap.png")
class TestImage extends flash.display.BitmapData {}
#end

class DemoFromBitmap extends Sprite
{
	
	private var _mesh:Mesh;
	private var _view:SimpleView;
	private var _object:Object;
	
	private var _bmp:Bitmap;
	
	public static function main():Void 
	{
		flash.Lib.current.addChild(new DemoFromBitmap());
	}
	
	public function new()
	{
		super();
		
		// build a rectangular 2 polygons mesh of 600x600
		_mesh = RectMeshFactory.buildRectangle(600, 600);
		
		// show the source bmp
	#if html5	// openfl hack: see DemoFromBitmap.xml
		_bmp = new Bitmap(openfl.Assets.getBitmapData("TestImage"));
	#else
		_bmp = new Bitmap(new TestImage(0, 0));
	#end
		_bmp.x = 110;
		_bmp.y = 220;
		addChild(_bmp);
		
		
		// create a viewport
		_view = new SimpleView();
		addChild(_view.surface);
		
		
		// create an object from bitmap
		_object = BitmapObjectFactory.buildFromBmpData(_bmp.bitmapData);
		_object.x = 110;
		_object.y = 220;
		_mesh.insertObject(_object);
		
		
		// display result mesh
		_view.drawMesh(_mesh);
	}
}