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
	public var edgesColor:Int = 0x999999;
	public var edgesWidth:Float = 1;
	public var edgesAlpha:Float = .25;
	
	public var constraintsColor:Int = 0xFF0000;
	public var constraintsWidth:Float = 2;
	public var constraintsAlpha:Float = 1.0;
	
	public var verticesColor:Int = 0x0000FF;
	public var verticesRadius:Float = .5;
	public var verticesAlpha:Float = .25;
	
	public var pathsColor:Int = 0xFFC010;
	public var pathsWidth:Float = 1.5;
	public var pathsAlpha:Float = .75;
	
	public var entitiesColor:Int = 0x00FF00;
	public var entitiesWidth:Float = 1;
	public var entitiesAlpha:Float = .75;
	
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
		_vertices.graphics.beginFill(verticesColor, verticesAlpha);
		_vertices.graphics.drawCircle(vertex.pos.x, vertex.pos.y, verticesRadius);
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
			_constraints.graphics.lineStyle(constraintsWidth, constraintsColor, constraintsAlpha, false, LineScaleMode.NONE);
			_constraints.graphics.moveTo(edge.originVertex.pos.x, edge.originVertex.pos.y);
			_constraints.graphics.lineTo(edge.destinationVertex.pos.x, edge.destinationVertex.pos.y);
		}
		else 
		{
			_edges.graphics.lineStyle(edgesWidth, edgesColor, edgesAlpha, false, LineScaleMode.NONE);
			_edges.graphics.moveTo(edge.originVertex.pos.x, edge.originVertex.pos.y);
			_edges.graphics.lineTo(edge.destinationVertex.pos.x, edge.destinationVertex.pos.y);
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
        
        _surface.graphics.lineStyle(constraintsWidth, constraintsColor, constraintsAlpha, false, LineScaleMode.NONE);
        _surface.graphics.drawRect(0, 0, mesh.width, mesh.height);
        
		mesh.traverse(drawVertex, drawEdge);
    }
    
    public function drawEntity(entity:EntityAI, cleanBefore:Bool = true):Void 
	{
        if (cleanBefore) _entities.graphics.clear();
        
        _entities.graphics.lineStyle(entitiesWidth, entitiesColor, entitiesAlpha, false, LineScaleMode.NONE);
        _entities.graphics.beginFill(entitiesColor, entitiesAlpha);
        _entities.graphics.drawCircle(entity.x, entity.y, entity.radius);
        _entities.graphics.endFill();
    }
    
    public function drawEntities(vEntities:Array<EntityAI>, cleanBefore:Bool = true):Void 
	{
        if (cleanBefore) _entities.graphics.clear();
        
        for (i in 0...vEntities.length) {
            drawEntity(vEntities[i], false);
        }
    }
    
    public function drawPath(path:Array<Float>, cleanBefore:Bool = true): Void 
	{
        if (cleanBefore) 
            _paths.graphics.clear();
        
        if (path.length == 0) 
            return;
        
        _paths.graphics.lineStyle(pathsWidth, pathsColor, pathsAlpha, false, LineScaleMode.NONE);
        
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
