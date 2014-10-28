import ddls.data.Mesh;
import ddls.data.DObject;
import ddls.factories.BitmapObjectFactory;
import ddls.factories.RectMeshFactory;
import ddls.view.SimpleView;
#if openfl
import openfl.Lib;
#end
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.BitmapData;
import DemoFromBitmapImage;

class DemoFromBitmap extends Sprite
{
    
    private var _mesh : Mesh;
    private var _view : SimpleView;
    private var _object : DObject;
    
    private var _bmp : Bitmap;
    
    public static function main(){
        new DemoFromBitmap();
    }
    
    public function new()
    {
        super();
        // build a rectangular 2 polygons mesh of 600x600
        _mesh = RectMeshFactory.buildRectangle( 600, 600 );
        
        // show the source bmp
        var bd: BitmapData = cast new DemoFromBitmapImage(0,0);
        _bmp = new Bitmap( bd );
        _bmp.x = 110;
        _bmp.y = 220;
        addChild( _bmp );
        
		flash.Lib.current.addChild(this);
	
        // create a viewport
        _view = new SimpleView();
        addChild( _view.surface );
        
        
        // create an object from bitmap
        _object = BitmapObjectFactory.buildFromBmpData( bd );
        _object.x = 110;
        _object.y = 220;
        _mesh.insertObject( _object );
        
        
        // display result mesh
        _view.drawMesh( _mesh );
	}
}
