package hxDaedalus.ai;

import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.math.Geom2D;
import hxDaedalus.debug.Debug;


class PathFinder {
    
    public var entity: EntityAI;
    public var mesh( get, set ) : Mesh;
    var _mesh : Mesh;
    var astar : AStar;
    var funnel : Funnel;
    var radius : Float;
    var listFaces : Array<Face>;
    var listEdges : Array<Edge>;
    
    public function new(){
        astar = new AStar();
        funnel = new Funnel();
        listFaces = new Array<Face>();
        listEdges = new Array<Edge>();
    }
    
    public function dispose() : Void {
        _mesh = null;
        astar.dispose();
        astar = null;
        funnel.dispose();
        funnel = null;
        listEdges = null;
        listFaces = null;
    }
    
     function get_mesh() : Mesh {
        return _mesh;
    }
    
     function set_mesh(value : Mesh) : Mesh
    {
        _mesh = value;
        astar.mesh = _mesh;
        return value;
    }
    
    public function findPath(toX : Float, toY : Float, resultPath : Array<Float>) : Void {
        resultPath.splice( 0, resultPath.length );
        Debug.assertFalse(_mesh == null, "Mesh missing");
        Debug.assertFalse(entity == null, "Entity missing");
        
        if( Geom2D.isCircleIntersectingAnyConstraint( toX, toY, entity.radius, _mesh ) ) return;
        
        astar.radius = entity.radius;
        funnel.radius = entity.radius;
        
        listFaces.splice( 0, listFaces.length );
        listEdges.splice( 0, listEdges.length );
        astar.findPath( entity.x, entity.y, toX, toY, listFaces, listEdges );
        if( listFaces.length == 0 ){
            Debug.trace("PathFinder listFaces.length == 0");
            return;
        }

        funnel.findPath( entity.x, entity.y, toX, toY, listFaces, listEdges, resultPath );
    }
}
