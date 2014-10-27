package ddls.ai;

import ddls.data.Edge;
import ddls.data.Face;
import ddls.data.Mesh;
import ddls.data.math.Geom2D;

class PathFinder
{
	
	private var _mesh:Mesh;
	private var _astar:AStar;
	private var _funnel:Funnel;
	private var _entity:EntityAI;
	private var _radius:Float;
	
	
	private var __listFaces:Array<Face>;
	private var __listEdges:Array<Edge>;
	
	public function new()
	{
		_astar = new AStar();
		_funnel = new Funnel();
		
		__listFaces = new Array<Face>();
		__listEdges = new Array<Edge>();
	}
	
	public function dispose():Void
	{
		_mesh = null;
		_astar.dispose();
		_astar = null;
		_funnel.dispose();
		_funnel = null;
		__listEdges = null;
		__listFaces = null;
	}
	
	public var entity(get, set):EntityAI;
	private function get_entity():EntityAI { return _entity; }
	private function set_entity(value:EntityAI):EntityAI { return _entity = value; }
	
	public var mesh(get, set):Mesh;
	private function get_mesh():Mesh { return _mesh; }
	private function set_mesh(value:Mesh):Mesh 
	{
		_mesh = value;
		_astar.mesh = _mesh;
		return _mesh;
	}
	
	public function findPath(toX:Float, toY:Float, resultPath:Array<Float>):Void
	{
		resultPath.splice(0, resultPath.length);
		
		if (_mesh == null)
			throw "Mesh missing";
		if (_entity == null)
			throw "Entity missing";
		
		if (Geom2D.isCircleIntersectingAnyConstraint(toX, toY, _entity.radius, _mesh))
		{
			return;
		}
		
		_astar.radius = _entity.radius;
		_funnel.radius = _entity.radius;
		
		__listFaces.splice(0, __listFaces.length);
		__listEdges.splice(0, __listEdges.length);
		_astar.findPath(_entity.x, _entity.y, toX, toY, __listFaces, __listEdges);
		if (__listFaces.length == 0)
		{
			trace("PathFinder __listFaces.length == 0");
			return;
		}
		_funnel.findPath(_entity.x, _entity.y, toX, toY, __listFaces, __listEdges, resultPath);
	}

}