
import hxDaedalus.data.ConstraintSegment;
import hxDaedalus.data.ConstraintShape;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Object;
import hxDaedalus.data.Vertex;
import hxDaedalus.factories.RectMesh;
import hxDaedalus.view.SimpleViewSwing;
import hxDaedalus.swing.BasicSwing;
import java.awt.Graphics2D;
import haxe.Timer;
class BasicsJava extends BasicSwing
{
    
    var mesh : Mesh;
    var object : Object;
    var view: SimpleViewSwing;
    public static function main():Void 
    {
        new BasicsJava();
    }
    
    public function new()
    {
        super();
        // build a rectangular 2 polygons mesh of 600x400
        mesh = RectMesh.buildRectangle(600, 400);
        
        
        // create a viewport
        view = new SimpleViewSwing();
        surface.paintFunction = paintFunction;
        
        // SINGLE VERTEX INSERTION / DELETION
        // insert a vertex in mesh at coordinates (550, 50)
        var vertex : Vertex = mesh.insertVertex(550, 50);
        // if you want to delete that vertex :
        //_mesh.deleteVertex(vertex);
        
        
        // SINGLE CONSTRAINT SEGMENT INSERTION / DELETION
        // insert a segment in mesh with end points (70, 300) and (530, 320)
        var segment : ConstraintSegment = mesh.insertConstraintSegment(70, 300, 530, 320);
        // if you want to delete that edge
        //_mesh.deleteConstraintSegment(segment);
        
        
        // CONSTRAINT SHAPE INSERTION / DELETION
        // insert a shape in mesh (a crossed square)
        var shape = mesh.insertConstraintShape( [   
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

        object = new Object();
        object.coordinates = [ -50.,   0.,  50., 0.,
                                  0., -50.,   0., 50.,
                                -30., -30.,  30., 30.,
                                 30., -30., -30., 30.
                                ];
        mesh.insertObject( object );  // insert after coordinates are setted  
        // you can transform objects with x, y, rotation, scaleX, scaleY, pivotX, pivotY
        object.x = 400;
        object.y = 200;
        object.scaleX = 2;
        object.scaleY = 2;
        // if you want to delete that object
        //_mesh.deleteObject(_object);
        
        // animate
        var timer = new Timer( Math.floor( 1000/60 ) );
        timer.run = renderTimer;
    }
    
    function renderTimer():Void {
        // objects can be transformed at any time
        object.rotation += 0.05;
    
        mesh.updateObjects();  // don't forget to update  
        // render mesh
        surface.repaint();
    }
    
    function paintFunction( g: Graphics2D ):Void {
        view.drawMesh( g, mesh );
    }

}
