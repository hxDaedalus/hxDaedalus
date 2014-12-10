
import graphics.flash.SimpleDrawingContext;
import hxDaedalus.ai.EntityAI;
import hxDaedalus.ai.PathFinder;
import hxDaedalus.ai.trajectory.LinearPathSampler;
import hxDaedalus.data.ConstraintSegment;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Object;
import hxDaedalus.data.math.Point2D;
import hxDaedalus.data.math.RandGenerator;
import hxDaedalus.data.Vertex;
import hxDaedalus.factories.RectMesh;
import graphics.SimpleView;

import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;


class GridMazeDemo extends Sprite
{
    
    var mesh : Mesh;
    var view : SimpleView;
	var entityView:graphics.SimpleView;
	var meshView:graphics.SimpleView;
    
    var entityAI : EntityAI;
    var pathfinder : PathFinder;
    var path : Array<Float>;
    var pathSampler : LinearPathSampler;
    
    var newPath:Bool = false;
	
	var rows:Int = 15;
	var cols:Int = 15;
	
    
    public static function main():Void {
        Lib.current.addChild(new GridMazeDemo());
    }
    
    public function new() {
        super();
        
		// build a rectangular 2 polygons mesh of 600x600
        mesh = RectMesh.buildRectangle(600, 600);
        
        // create a viewport
		meshView = new SimpleView(new SimpleDrawingContext(this.graphics));
		
		var viewSprite = new Sprite();
        view = new SimpleView(new SimpleDrawingContext(viewSprite.graphics));
        addChild(viewSprite);
        
		var entitySprite = new Sprite();
		entityView = new SimpleView(new SimpleDrawingContext(entitySprite.graphics));
		addChild(entitySprite);
        
		GridMaze.generate(600, 600, cols, rows);
		mesh.insertObject(GridMaze.object);
		
		meshView.constraintsWidth = 4;
        meshView.drawMesh(mesh);
		
        // we need an entity
        entityAI = new EntityAI();
        // set radius as size for your entity
        entityAI.radius = GridMaze.tileWidth * .3;
        // set a position
        entityAI.x = GridMaze.tileWidth / 2;
        entityAI.y = GridMaze.tileHeight / 2;
        
        // show entity on screen
        view.drawEntity(entityAI);
        
        // now configure the pathfinder
        pathfinder = new PathFinder();
        pathfinder.entity = entityAI;  // set the entity  
        pathfinder.mesh = mesh;  // set the mesh  
        
        // we need a vector to store the path
        path = new Array<Float>();
        
        // then configure the path sampler
        pathSampler = new LinearPathSampler();
        pathSampler.entity = entityAI;
        pathSampler.samplingDistance = 12;
        pathSampler.path = path;
        
        // click/drag
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        
        // animate
        Lib.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        
        // key presses
        Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
    
    function onMouseUp( event: MouseEvent ): Void {
		newPath = false;
    }
    
    function onMouseDown( event: MouseEvent ): Void {
        newPath = true;
    }
    
    function onEnterFrame( event: Event ): Void {
		if (newPath) view.graphics.clear();

        if ( newPath ) {
            // find path !
            pathfinder.findPath( stage.mouseX, stage.mouseY, path );
            
			// show path on screen
            view.drawPath( path );
            
			// reset the path sampler to manage new generated path
            pathSampler.reset();
        }
        
        // animate !
        if ( pathSampler.hasNext ) {
            // move entity
            pathSampler.next();            
        }
		
		// show entity position on screen
		entityView.drawEntity(entityAI, true);
    }
    
    function onKeyDown( event:KeyboardEvent ): Void {
        if( event.keyCode == 27 ) {  // ESC
		#if flash
			flash.system.System.exit(1);
		#elseif sys
			Sys.exit(1);
		#end
        } else if (event.keyCode == 32) { // SPACE
			reset();
		}
    }
	
	function reset():Void {
		mesh = RectMesh.buildRectangle(600, 600);
		var seed = Std.int(Math.random() * 10000 + 1000);
		GridMaze.generate(600, 600, 30, 30, seed);
		GridMaze.object.scaleX = .92;
		GridMaze.object.scaleY = .92;
		GridMaze.object.x = 23;
		GridMaze.object.y = 23;
        entityAI.radius = GridMaze.tileWidth * .3;
		mesh.insertObject(GridMaze.object);
		meshView.drawMesh(mesh, true);
		view.graphics.clear();
		pathfinder.mesh = mesh;
		entityAI.x = GridMaze.tileWidth / 2;
		entityAI.y = GridMaze.tileHeight / 2;
		path = [];
		pathSampler.path = path;
	}
}
