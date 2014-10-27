
import ddls.data.ConstraintSegment;
import ddls.data.ConstraintShape;
import ddls.data.Mesh;
import ddls.data.DObject;
import ddls.data.Vertex;
import ddls.factories.RectMeshFactory;
import ddls.view.SimpleView;
#if openfl
import openfl.Lib;
#end
import flash.display.Sprite;
import flash.events.Event;


class DemoBasics extends Sprite
{
    
    private var _mesh : Mesh;
    private var _view : SimpleView;
    private var _object : DObject;
    
    public static function main(){
        new DemoBasics();
    }
    
    public function new()
    {
        super();
        // build a rectangular 2 polygons mesh of 600x400
        _mesh = RectMeshFactory.buildRectangle(600, 400);
        
		Lib.current.addChild(this);
    
        // create a viewport
        _view = new SimpleView();
        addChild( _view.surface );
        
        
        // SINGLE VERTEX INSERTION / DELETION
        // insert a vertex in mesh at coordinates (550, 50)
        var vertex : Vertex = _mesh.insertVertex(550, 50);
        // if you want to delete that vertex :
        //_mesh.deleteVertex(vertex);
        
        
        // SINGLE CONSTRAINT SEGMENT INSERTION / DELETION
        // insert a segment in mesh with end points (70, 300) and (530, 320)
        var segment : ConstraintSegment = _mesh.insertConstraintSegment(70, 300, 530, 320);
        // if you want to delete that edge
        //_mesh.deleteConstraintSegment(segment);
        
        
        // CONSTRAINT SHAPE INSERTION / DELETION
        // insert a shape in mesh (a crossed square)
        var shape = _mesh.insertConstraintShape( [   
                        50., 50., 100., 50.,        /* 1st segment with end points (50, 50) and (100, 50)       */
                        100., 50., 100., 100.,      /* 2nd segment with end points (100, 50) and (100, 100)     */
                        100., 100., 50., 100.,      /* 3rd segment with end points (100, 100) and (50, 100)     */
                        50., 100., 50., 50.,        /* 4rd segment with end points (50, 100) and (50, 50)       */
                        20., 50., 130., 100.        /* 5rd segment with end points (20, 50) and (130, 100)      */
                                                ] );      
        // if you want to delete that shape
        //_mesh.deleteConstraintShape(shape);
        
        
        // OBJECT INSERTION / TRANSFORMATION / DELETION
        // insert an object in mesh (a cross)
        var objectCoords : Array<Float> = new Array<Float>();

        _object = new DObject();
        _object.coordinates = [ -50.,   0.,  50., 0.,
                                  0., -50.,   0., 50.,
                                -30., -30.,  30., 30.,
                                 30., -30., -30., 30.
                                ];
        _mesh.insertObject( _object );  // insert after coordinates are setted  
        // you can transform objects with x, y, rotation, scaleX, scaleY, pivotX, pivotY
        _object.x = 400;
        _object.y = 200;
        _object.scaleX = 2;
        _object.scaleY = 2;
        // if you want to delete that object
        //_mesh.deleteObject(_object);
        
        addEventListener( Event.ENTER_FRAME, _onFrame );
    }
    
    function _onFrame( event: Event) : Void {
        // objects can be transformed at any time
        _object.rotation += 0.05;
        
        _mesh.updateObjects();  // don't forget to update  
        
        // render mesh
        _view.drawMesh(_mesh);
    }
}
