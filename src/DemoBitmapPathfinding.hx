package;

import hxDaedalus.ai.EntityAI;
import hxDaedalus.ai.PathFinder;
import hxDaedalus.ai.trajectory.LinearPathSampler;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Object;
import hxDaedalus.factories.BitmapObject;
import hxDaedalus.factories.RectMesh;
import hxDaedalus.view.SimpleView;

import flash.display.MovieClip;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.Lib;

@:bitmap("galapagosBW.png")
class GalapagosBW extends flash.display.BitmapData {}

@:bitmap("galapagosColor.png")
class GalapagosColor extends flash.display.BitmapData {}

class DemoBitmapPathfinding extends Sprite {

	var _mesh:  Mesh;
	var _view:  SimpleView;
	var _entityAI: EntityAI;
	var _pathfinder:PathFinder;
	var _path: Array<Float>;
	var _pathSampler: LinearPathSampler;
	var _object: Object;
	var _bmp:Bitmap;
	var _overlay: Bitmap;

    var _newPath:Bool = false;

	public static function main(): Void {
		Lib.current.addChild(new DemoBitmapPathfinding());
	}

	public function new() {
		super();
		
		// build a rectangular 2 polygons mesh
		_mesh = RectMesh.buildRectangle( 1024, 1024 );
		
		// show the source bmp
    #if html5	// load as openfl asset: see DemoFromBitmapPathfinding.xml
        _bmp = new Bitmap(openfl.Assets.getBitmapData("GalapagosBW"));		
    #else		
        _bmp = new Bitmap(new GalapagosBW(0, 0));
	#end
		_bmp.x = 0;
		_bmp.y = 0;
		
		// show the image bmp
    #if html5	// load as openfl asset: see DemoFromBitmapPathfinding.xml
        _overlay = new Bitmap(openfl.Assets.getBitmapData("GalapagosColor"));
    #else		
        _overlay = new Bitmap(new GalapagosColor(0, 0));	
	#end
		_overlay.x = 0;
		_overlay.y = 0;
		addChild(_overlay);
		_view = new SimpleView();
		addChild( _view.surface );
		
		// create an object from bitmap
		_object = BitmapObject.buildFromBmpData( _bmp.bitmapData );
		_object.x = 0;
		_object.y = 0;
		_mesh.insertObject( _object );
		
		// display result mesh
		_view.drawMesh( _mesh );
		
		// we need an entity
		_entityAI = new EntityAI();
		
		// set radius as size for your entity
		_entityAI.radius = 4;
		
		// set a position
		_entityAI.x = 150;
		_entityAI.y = 150;
		
		// show entity on screen
		_view.drawEntity( _entityAI );
		
		// now configure the pathfinder
		_pathfinder = new PathFinder();
		_pathfinder.entity = _entityAI; // set the entity
		_pathfinder.mesh = _mesh; // set the mesh
		
		// we need a vector to store the path
		_path = new Array<Float>();
		
		// then configure the path sampler
		_pathSampler = new LinearPathSampler();
		_pathSampler.entity = _entityAI;
		_pathSampler.samplingDistance = 5;
		_pathSampler.path = _path;

		// click/drag
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
		
		// animate
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		
		// key presses
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
	}

	function _onClick( event: MouseEvent ): Void {
		// find path !
		_pathfinder.findPath(stage.mouseX, stage.mouseY, _path);
		
		// show path on screen
		_view.drawPath(_path);
		
		// reset the path sampler to manage new generated path
		_pathSampler.reset();
		
		// animate !
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
	}

    function _onMouseUp( event: MouseEvent ): Void {
		_newPath = false;
    }
    
    function _onMouseDown( event: MouseEvent ): Void {
        _newPath = true;
    }
    
    function _onEnterFrame( event: Event ): Void {
        if ( _newPath ) {
            
			// find path !
            _pathfinder.findPath( stage.mouseX, stage.mouseY, _path );
            
			// show path on screen
            _view.drawPath( _path );
            
			// reset the path sampler to manage new generated path
            _pathSampler.reset();
        }
        
        // animate !
        if ( _pathSampler.hasNext ) {
            
			// move entity
            _pathSampler.next();            
            
			// show entity new position on screen
            _view.drawEntity(_entityAI);
        }
    }
	
	function _onKeyDown(event:KeyboardEvent):Void
	{
		if (event.keyCode == 27) {  // ESC
			#if flash
				flash.system.System.exit(1);
			#elseif sys
				Sys.exit(1);
			#end
		}
	}
}