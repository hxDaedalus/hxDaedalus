package hxDaedalus.view;


import hxDaedalus.ai.EntityAI;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Vertex;
import hxDaedalus.graphics.SimpleDrawingContext;
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

    var _graphics:SimpleDrawingContext;
	
    public var graphics(get, null):SimpleDrawingContext;
    function get_graphics():SimpleDrawingContext {
        return _graphics;
    }
    
    var _showEdges:Bool = true;
    public var showEdges(default, set):Bool;
    function set_showEdges(value:Bool):Bool {
        if (value != _showEdges) redrawAll();
		return _showEdges;
    }
    
    var _showConstraints:Bool = true;
    public var showConstraints(default, set):Bool;
    function set_showConstraints(value:Bool):Bool {
        if (value != _showConstraints) redrawAll();
		return _showConstraints;
    }
    
    var _showVertices:Bool = true;
    public var showVertices(default, set):Bool;
    function set_showVertices(value:Bool):Bool {
        if (value != _showVertices) redrawAll();
		return _showVertices;
    }
    
    var _showPaths:Bool = true;
    public var showPaths(default, set):Bool;
    function set_showPaths(value:Bool):Bool {
        if (value != _showPaths) redrawAll();
		return _showPaths;
    }
    
    var _showEntities:Bool = true;
    public var showEntities(default, set):Bool;
    function set_showEntities(value:Bool):Bool {
        if (value != _showEntities) redrawAll();
		return _showEntities;
    }
    

    public function new(sprite:Sprite)
    {
		this._graphics = new SimpleDrawingContext(sprite.graphics);
    }
    
	public function redrawAll():Void
	{
		/*_graphics.clear();
		if (_showConstraints || _showEdges || _showVertices) drawMesh();
		if (_showPaths) drawPath();
		if (_showEntities) drawEntities();*/
	}
	
    function drawVertex(vertex : Vertex) : Void
	{
		_graphics.beginFill(verticesColor, verticesAlpha);
		_graphics.drawCircle(vertex.pos.x, vertex.pos.y, verticesRadius);
		_graphics.endFill();
		
		#if showVerticesIndices 
			var tf : TextField = new TextField();
			tf.mouseEnabled = false;
			tf.text = Std.string(vertex.id);
			tf.x = vertex.pos.x + 5;
			tf.y = vertex.pos.y + 5;
			tf.width = tf.height = 20;
			_vertices.addChild(tf);
		#end
	}
	
	function drawEdge(edge : Edge) : Void 
	{
		if (edge.isConstrained) 
		{
			_graphics.lineStyle(constraintsWidth, constraintsColor, constraintsAlpha);
			_graphics.moveTo(edge.originVertex.pos.x, edge.originVertex.pos.y);
			_graphics.lineTo(edge.destinationVertex.pos.x, edge.destinationVertex.pos.y);
		}
		else 
		{
			_graphics.lineStyle(edgesWidth, edgesColor, edgesAlpha);
			_graphics.moveTo(edge.originVertex.pos.x, edge.originVertex.pos.y);
			_graphics.lineTo(edge.destinationVertex.pos.x, edge.destinationVertex.pos.y);
		}
	}
	
	/** Draws vertices, edges and constraints onto the `surface` sprite. */
    public function drawMesh(mesh:Mesh):Void 
	{
        //_graphics.clear();
        
        _graphics.lineStyle(constraintsWidth, constraintsColor, constraintsAlpha);
        _graphics.drawRect(0, 0, mesh.width, mesh.height);
        
		mesh.traverse(drawVertex, drawEdge);
    }
    
    public function drawEntity(entity:EntityAI, cleanBefore:Bool = true):Void 
	{
        if (cleanBefore) _graphics.clear();
        
        _graphics.lineStyle(entitiesWidth, entitiesColor, entitiesAlpha);
        _graphics.beginFill(entitiesColor, entitiesAlpha);
        _graphics.drawCircle(entity.x, entity.y, entity.radius);
        _graphics.endFill();
    }
    
    public function drawEntities(vEntities:Array<EntityAI>, cleanBefore:Bool = true):Void 
	{
        //if (cleanBefore) _graphics.clear();
        
        for (i in 0...vEntities.length) {
            drawEntity(vEntities[i], false);
        }
    }
    
    public function drawPath(path:Array<Float>, cleanBefore:Bool = true): Void 
	{
        //if (cleanBefore) _graphics.clear();
        
        if (path.length == 0) return;
        
        _graphics.lineStyle(pathsWidth, pathsColor, pathsAlpha);
        
        _graphics.moveTo(path[0], path[1]);
        var i = 2;
        while (i < path.length) {
			//TODO: remove this conditionals once openfl behaves consistently
		#if sys
			_graphics.beginFill(0, 1);
		#end
			_graphics.lineTo(path[i], path[i + 1]);
		#if sys
			_graphics.endFill();
		#end
            _graphics.moveTo(path[i], path[i + 1]);
            i += 2;
        }
    }
}
