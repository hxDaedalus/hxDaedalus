package hxDaedalus.view;


import hxDaedalus.ai.EntityAI;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Vertex;
import hxDaedalus.iterators.FromMeshToVertices;
import hxDaedalus.iterators.FromVertexToHoldingFaces;
import hxDaedalus.iterators.FromVertexToIncomingEdges;

import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.text.TextField;


class SimpleView
{
    var _surface:Sprite;
	
	/** 
	 * Top level container sprite. Has `edges`, `constraints`, `vertices`, 
	 * `paths` and `entities` sprites as children. 
	 */
    public var surface(get, null):Sprite;
    function get_surface():Sprite {
        return _surface;
    }
    
    var _edges:Sprite;
    public var edges(get, null):Sprite;
    function get_edges():Sprite {
        return _edges;
    }
    
	var _constraints:Sprite;
    public var constraints(get, null):Sprite;
    function get_constraints():Sprite {
        return _constraints;
    }
	
    var _vertices:Sprite;
    public var vertices(get, null):Sprite;
    function get_vertices():Sprite {
        return _vertices;
    }

    var _paths:Sprite;
    public var paths(get, null):Sprite;
    function get_paths():Sprite {
        return _paths;
    }
   
    var _entities:Sprite;
    public var entities(get, null):Sprite;
    function get_entities():Sprite {
        return _entities;
    }
    
    
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

    public function drawVertex(vertex : Vertex) : Void
	{
		_vertices.graphics.beginFill(0x0000FF, 1);
		_vertices.graphics.drawCircle(vertex.pos.x, vertex.pos.y, 0.5);
		_vertices.graphics.endFill();
		
		#if showVerticesIndices 
			var t f :TextField = new TextField();
			tf.mouseEnabled = false;
			tf.text = Std.string(vertex.id);
			tf.x = vertex.pos.x + 5;
			tf.y = vertex.pos.y + 5;
			tf.width = tf.height = 20;
			_vertices.addChild(tf);
		#end
	}
	
	public function drawEdge(edge : Edge) : Void 
	{
		if (edge.isConstrained) 
		{
			_constraints.graphics.beginFill(0, 1);
			_constraints.graphics.lineStyle(2, 0xFF0000, 1, false, LineScaleMode.NONE);
			_constraints.graphics.moveTo(edge.originVertex.pos.x, edge.originVertex.pos.y);
			_constraints.graphics.lineTo(edge.destinationVertex.pos.x, edge.destinationVertex.pos.y);
			_constraints.graphics.endFill();
		}
		else 
		{
			_edges.graphics.beginFill(0, 1);
			_edges.graphics.lineStyle(1, 0x999999, .25, false, LineScaleMode.NONE);
			_edges.graphics.moveTo(edge.originVertex.pos.x, edge.originVertex.pos.y);
			_edges.graphics.lineTo(edge.destinationVertex.pos.x, edge.destinationVertex.pos.y);
			_edges.graphics.endFill();
		}
	}
	
	/** Draws vertices, edges and constraints onto the `surface` sprite. */
    public function drawMesh(mesh:Mesh):Void 
	{
        _surface.graphics.clear();
        _edges.graphics.clear();
        _constraints.graphics.clear();
        _vertices.graphics.clear();
        
        while (_vertices.numChildren != 0) _vertices.removeChildAt(0);
        
        _surface.graphics.beginFill(0x00, 0);
        _surface.graphics.lineStyle(1, 0xFF0000, 1, false, LineScaleMode.NONE);
        _surface.graphics.drawRect(0, 0, mesh.width, mesh.height);
        _surface.graphics.endFill();
        
		mesh.traverse(drawVertex, drawEdge);
    }
    
    public function drawEntity(entity:EntityAI, cleanBefore:Bool = true):Void 
	{
        if (cleanBefore) _entities.graphics.clear();
        
        _entities.graphics.lineStyle(1, 0x00FF00, .75, false, LineScaleMode.NONE);
        _entities.graphics.beginFill(0x00FF00, 1);
        _entities.graphics.drawCircle(entity.x, entity.y, entity.radius);
        _entities.graphics.endFill();
    }
    
    public function drawEntities(vEntities:Array<EntityAI>, cleanBefore:Bool = true):Void 
	{
        if (cleanBefore) _entities.graphics.clear();
        
        _entities.graphics.lineStyle(1, 0x00FF00, .75, false, LineScaleMode.NONE);
        for (i in 0...vEntities.length) {
            _entities.graphics.beginFill(0x00FF00, 1);
            _entities.graphics.drawCircle(vEntities[i].x, vEntities[i].y, vEntities[i].radius);
            _entities.graphics.endFill();
        }
    }
    
    public function drawPath(path:Array<Float>, cleanBefore:Bool = true): Void 
	{
        if (cleanBefore) 
            _paths.graphics.clear();
        
        if (path.length == 0) 
            return;
        
        _paths.graphics.lineStyle(1.5, 0xFFC010, .75, false, LineScaleMode.NONE);
        
        _paths.graphics.moveTo(path[0], path[1]);
        var i = 2;
        while (i < path.length) {
			//TODO: remove this conditionals once openfl behaves consistently
            #if sys
                _paths.graphics.beginFill(0, 1);
            #end
                _paths.graphics.lineTo(path[i], path[i + 1]);
            #if sys
                _paths.graphics.endFill();
            #end
            _paths.graphics.moveTo(path[i], path[i + 1]);
            i += 2;
        }
    }
}
