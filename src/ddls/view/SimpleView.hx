package ddls.view;

import ddls.ai.EntityAI;
import ddls.data.Edge;
import ddls.data.Face;
import ddls.data.Mesh;
import ddls.data.Vertex;
import ddls.iterators.FromMeshToVertices;
import ddls.iterators.FromVertexToHoldingFaces;
import ddls.iterators.FromVertexToIncomingEdges;

import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.text.TextField;

class SimpleView
{
	
	private var _edges:Sprite;
	private var _constraints:Sprite;
	private var _vertices:Sprite;
	private var _paths:Sprite;
	private var _entities:Sprite;
	
	private var _surface:Sprite;
	
	private var _showVerticesIndices:Bool = false;
	
	public function new()
	{
		_edges = new Sprite();
		_constraints = new Sprite();
		_vertices = new Sprite();
		_paths = new Sprite();
		_entities = new Sprite();
		
		_surface = new Sprite();
		_surface.addChild(_edges);
		_surface.addChild(_constraints);
		_surface.addChild(_vertices);
		_surface.addChild(_paths);
		_surface.addChild(_entities);
	}
	
	public var surface(get, never):Sprite;
	private function get_surface():Sprite { return _surface; }
	
	public function drawMesh(mesh:Mesh):Void
	{
		_surface.graphics.clear();
		_edges.graphics.clear();
		_constraints.graphics.clear();
		_vertices.graphics.clear();
		
		while (_vertices.numChildren > 0)
			_vertices.removeChildAt(0);
		
		_surface.graphics.beginFill(0x00, 0);
		_surface.graphics.lineStyle(1, 0xFF0000, 1, false, LineScaleMode.NONE);
		_surface.graphics.drawRect(0, 0, mesh.width, mesh.height);
		_surface.graphics.endFill();
		
		var vertex:Vertex;
		var incomingEdge:Edge;
		var holdingFace:Face;
		
		var iterVertices:FromMeshToVertices;
		iterVertices = new FromMeshToVertices();
		iterVertices.fromMesh = mesh;
		//
		var iterEdges:FromVertexToIncomingEdges;
		iterEdges = new FromVertexToIncomingEdges();
		var dictVerticesDone = new Map<Vertex, Bool>();
		//
		while ((vertex = iterVertices.next()) != null)
		{
			dictVerticesDone[vertex] = true;
			if (!vertexIsInsideAABB(vertex, mesh))
				continue;
			
			//_vertices.graphics.lineStyle(0, 0);
			_vertices.graphics.beginFill(0x0000FF, 1);
			_vertices.graphics.drawCircle(vertex.pos.x, vertex.pos.y, 0.5);
			_vertices.graphics.endFill();
			
			if (_showVerticesIndices)
			{
				var tf:TextField = new TextField();
				tf.mouseEnabled = false;
				tf.text = Std.string(vertex.id);
				tf.x = vertex.pos.x + 5;
				tf.y = vertex.pos.y + 5;
				tf.width = tf.height = 20;
				_vertices.addChild(tf);
			}
			
			iterEdges.fromVertex = vertex;
			while ((incomingEdge = iterEdges.next()) != null )
			{
				if (!dictVerticesDone[incomingEdge.originVertex])
				{
					if (incomingEdge.isConstrained)
					{
						_constraints.graphics.beginFill(0, 1);
						_constraints.graphics.lineStyle(2, 0xFF0000, 1, false, LineScaleMode.NONE);
						_constraints.graphics.moveTo(incomingEdge.originVertex.pos.x, incomingEdge.originVertex.pos.y);
						_constraints.graphics.lineTo(incomingEdge.destinationVertex.pos.x, incomingEdge.destinationVertex.pos.y);
						_constraints.graphics.endFill();
					}
					else
					{
						_edges.graphics.beginFill(0, 1);
						_edges.graphics.lineStyle(1, 0x999999, 1, false, LineScaleMode.NONE);
						_edges.graphics.moveTo(incomingEdge.originVertex.pos.x, incomingEdge.originVertex.pos.y);
						_edges.graphics.lineTo(incomingEdge.destinationVertex.pos.x, incomingEdge.destinationVertex.pos.y);
						_edges.graphics.endFill();
					}
				}
			}
		}
		
		
	}
	
	public function drawEntity(entity:EntityAI, cleanBefore:Bool=true):Void	
	{
		if (cleanBefore)
			_entities.graphics.clear();
		
		_entities.graphics.lineStyle(1, 0x00FF00, 1, false, LineScaleMode.NONE);
		_entities.graphics.beginFill(0x00FF00, 0.5);
		_entities.graphics.drawCircle(entity.x, entity.y, entity.radius);
		_entities.graphics.endFill();
	}
	
	public function drawEntities(vEntities:Array<EntityAI>, cleanBefore:Bool=true):Void	
	{
		if (cleanBefore)
			_entities.graphics.clear();
		
		_entities.graphics.lineStyle(1, 0x00FF00, 0.5, false, LineScaleMode.NONE);
		for (i in 0...vEntities.length)
		{
			_entities.graphics.beginFill(0x00FF00, 1);
			_entities.graphics.drawCircle(vEntities[i].x, vEntities[i].y, vEntities[i].radius);
			_entities.graphics.endFill();
		}
	}
	
	public function drawPath(path:Array<Float>, cleanBefore:Bool=true):Void
	{
		if (cleanBefore)
			_paths.graphics.clear();
		
		if (path.length == 0)
			return;
		
		_paths.graphics.lineStyle(1.5, 0xFF00FF, 0.5, false, LineScaleMode.NONE);
		_paths.graphics.moveTo(path[0], path[1]);
		var i = 2;
		while (i < path.length) {
			_paths.graphics.lineTo(path[i], path[i + 1]);
			i += 2;
		}
	}
	
	private function vertexIsInsideAABB(vertex:Vertex, mesh:Mesh):Bool
	{
		if (vertex.pos.x < 0 || vertex.pos.x > mesh.width || vertex.pos.y < 0 || vertex.pos.y > mesh.height)
			return false;
		else
			return true;
	}
	
}