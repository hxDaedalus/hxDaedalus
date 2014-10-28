
import ddls.ai.EntityAI;
import ddls.ai.PathFinder;
import ddls.ai.trajectory.LinearPathSampler;
import ddls.data.Mesh;
import ddls.data.Object;
import ddls.data.math.Point2D;
import ddls.data.math.RandGenerator;
import ddls.factories.RectMeshFactory;
import ddls.view.SimpleView;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;

class DemoPathFinding extends Sprite
{
    
    private var _mesh:Mesh;
    private var _view:SimpleView;
    
    private var _entityAI:EntityAI;
    private var _pathfinder:PathFinder;
    private var _path:Array<Float>;
    private var _pathSampler:LinearPathSampler;
	
	private var _newPath:Bool = false;
    
	public static function main():Void 
	{
		flash.Lib.current.addChild(new DemoPathFinding());
	}
	
    public function new()
    {
        super();
		
        // build a rectangular 2 polygons mesh of 600x600
        _mesh = RectMeshFactory.buildRectangle(600, 600);

		
        // create a viewport
        _view = new SimpleView();
        addChild(_view.surface);
        
        
        // pseudo random generator
        var randGen:RandGenerator;
        randGen = new RandGenerator();
        randGen.seed = 7259;  // put a 4 digits number here  
        
        // populate mesh with many square objects
        var object:Object;
        var shapeCoords:Array<Float>;
        for (i in 0...50){
            object = new Object();
            shapeCoords = new Array<Float>();
            shapeCoords = [ -1, -1, 1, -1,
                             1, -1, 1, 1,
                            1, 1, -1, 1,
                            -1, 1, -1, -1];
            object.coordinates = shapeCoords;
            randGen.rangeMin = 10;
            randGen.rangeMax = 40;
            object.scaleX = randGen.next();
            object.scaleY = randGen.next();
            randGen.rangeMin = 0;
            randGen.rangeMax = 1000;
            object.rotation = (randGen.next() / 1000) * Math.PI / 2;
            randGen.rangeMin = 50;
            randGen.rangeMax = 600;
            object.x = randGen.next();
            object.y = randGen.next();
            _mesh.insertObject(object);
        }
        
		
		// show result mesh on screen
        _view.drawMesh(_mesh);
        
        
        // we need an entity
        _entityAI = new EntityAI();
        // set radius as size for your entity
        _entityAI.radius = 10;
        // set a position
        _entityAI.x = 20;
        _entityAI.y = 20;
        
        
        // show entity on screen
        _view.drawEntity(_entityAI);
        
        
        // now configure the pathfinder
        _pathfinder = new PathFinder();
        _pathfinder.entity = _entityAI;  // set the entity  
        _pathfinder.mesh = _mesh;  // set the mesh  
        
        
        // we need a vector to store the path
        _path = new Array<Float>();
        
        
        // then configure the path sampler
        _pathSampler = new LinearPathSampler();
        _pathSampler.entity = _entityAI;
        _pathSampler.samplingDistance = 7;
        _pathSampler.path = _path;
        
        
        // click/drag
        flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
        flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
        
		// animate
		flash.Lib.current.stage.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
		
		// key presses
		flash.Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
    }
    
    private function _onMouseUp(event:MouseEvent):Void
    {
		_newPath = false;
    }
    
    private function _onMouseDown(event:MouseEvent):Void
    {
		_newPath = true;
    }
    
    private function _onEnterFrame(event:Event):Void
    {
        if (_newPath) {
			// find path !
			_pathfinder.findPath(stage.mouseX, stage.mouseY, _path);
			
			// show path on screen
			_view.drawPath(_path);
			
			// reset the path sampler to manage new generated path
			_pathSampler.reset();
        }
        
		// animate !
        if (_pathSampler.hasNext) 
        {
            // move entity
            _pathSampler.next();
            
            // show entty new position on screen
            _view.drawEntity(_entityAI);
        }
    }
    
	private function _onKeyDown(event:KeyboardEvent):Void
    {
		if (event.keyCode == 27) {	// ESC
		#if flash
			flash.system.System.exit(1);
		#elseif sys
			Sys.exit(1);
		#end
		}
    }
}
