
import hxDaedalus.ai.EntityAI;
import hxDaedalus.ai.PathFinder;
import hxDaedalus.ai.trajectory.LinearPathSampler;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Object;
import hxDaedalus.data.math.Point2D;
import hxDaedalus.data.math.RandGenerator;
import hxDaedalus.factories.RectMesh;
import hxDaedalus.view.SimpleViewJS;
import js.Browser;
import js.html.Event;
import js.html.MouseEvent;

class PathfindingJS
{
    
    var mesh : Mesh;
    var view : SimpleViewJS;
    
    var entityAI : EntityAI;
    var pathfinder : PathFinder;
    var path : Array<Float>;
    var pathSampler : LinearPathSampler;
    var x: Float;
    var y: Float;
    var newPath:Bool = false;
    
    public static function main():Void {
        new PathfindingJS();
    }
    
    public function new(){
        
        // build a rectangular 2 polygons mesh of 600x600
        mesh = RectMesh.buildRectangle(600, 600);
        
        // create a viewport
        view = new SimpleViewJS();
        
        
        // pseudo random generator
        var randGen : RandGenerator;
        randGen = new RandGenerator();
        randGen.seed = 7259;  // put a 4 digits number here  
        
        // populate mesh with many square objects
        var object : Object;
        var shapeCoords : Array<Float>;
        for (i in 0...50){
            trace(' i ' + i );
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
            mesh.insertObject(object);
        }  // show result mesh on screen  
        
        view.drawMesh(mesh);
        
        // we need an entity
        entityAI = new EntityAI();
        // set radius as size for your entity
        entityAI.radius = 4;
        // set a position
        entityAI.x = 20;
        entityAI.y = 20;
        
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
        pathSampler.samplingDistance = 5;
        pathSampler.path = path;
        
        // click/drag
        view.basicCanvas.canvas.onmousedown = onMouseDown;
        view.basicCanvas.canvas.onmouseup = onMouseUp;
        view.basicCanvas.canvas.onmousemove = onMouseMove;
        // animate
        view.basicCanvas.onEnterFrame = onEnterFrame;
        
    }
    
    function onMouseMove( e: Event ): Void {
        var p: MouseEvent = cast e;
        x = p.clientX;
        y = p.clientY;
    }
    
    function onMouseUp( event: Event ): Void {
        newPath = false;
    }
    
    function onMouseDown( event: Event ): Void {
        newPath = true;
    }
    
    function onEnterFrame(): Void {
        if ( newPath ) {
            // find path !
            pathfinder.findPath( x, y, path );
            
            // show path on screen
            view.drawPath( path );
            
            // reset the path sampler to manage new generated path
            pathSampler.reset();
        }
        
        // animate !
        if ( pathSampler.hasNext ) {
            // move entity
            pathSampler.next();            
            
            // show entity new position on screen
            view.drawEntity(entityAI);
        }
    }

}
