package hxDaedalus.view;

import hxDaedalus.ai.EntityAI;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
import hxDaedalus.data.math.Point2D;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Vertex;
import wings.core.SimpleDrawingContext;
import hxDaedalus.iterators.FromMeshToVertices;
import hxDaedalus.iterators.FromVertexToHoldingFaces;
import hxDaedalus.iterators.FromVertexToIncomingEdges;
import wings.core.TargetCanvas;
import wings.core.SimpleDrawingContext;

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

    public var graphics(default, null): SimpleDrawingContext;

    #if java
    public function refreshGraphics2D( g: java.awt.Graphics2D ){
        graphics.graphics = g;
    }
    #end

    public function new( targetCanvas: TargetCanvas )
    {
        graphics = new SimpleDrawingContext( targetCanvas );
    }

    public function drawVertex(vertex : Vertex) : Void
	{
		graphics.lineStyle(verticesRadius, verticesColor, verticesAlpha);
		graphics.beginFill(verticesColor, verticesAlpha);
		graphics.drawCircle(vertex.pos.x, vertex.pos.y, verticesRadius);
		graphics.endFill();

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

	public function drawEdge(edge : Edge) : Void
	{
		if (edge.isConstrained)
		{
			graphics.lineStyle(constraintsWidth, constraintsColor, constraintsAlpha);
			graphics.moveTo(edge.originVertex.pos.x, edge.originVertex.pos.y);
			graphics.lineTo(edge.destinationVertex.pos.x, edge.destinationVertex.pos.y);
		}
		else
		{
			graphics.lineStyle(edgesWidth, edgesColor, edgesAlpha);
			graphics.moveTo(edge.originVertex.pos.x, edge.originVertex.pos.y);
			graphics.lineTo(edge.destinationVertex.pos.x, edge.destinationVertex.pos.y);
		}
	}

    public function drawMesh(mesh:Mesh, cleanBefore : Bool = false):Void
	{
        if (cleanBefore) graphics.clear();

		mesh.traverse(drawVertex, drawEdge);
    }

    public function drawEntity(entity:EntityAI, cleanBefore:Bool = false):Void
	{
        if (cleanBefore) graphics.clear();

        graphics.lineStyle(entitiesWidth, entitiesColor, entitiesAlpha);
        graphics.beginFill(entitiesColor, entitiesAlpha);
        graphics.drawCircle(entity.x, entity.y, entity.radius);
        graphics.endFill();
    }

    public function drawEntities(vEntities:Array<EntityAI>, cleanBefore:Bool = false):Void
	{
        if (cleanBefore) graphics.clear();

        for (i in 0...vEntities.length) {
            drawEntity(vEntities[i], false);
        }
    }

    public function drawPath(path:Array<Float>, cleanBefore:Bool = false): Void
	{
        if (cleanBefore) graphics.clear();

        if (path.length == 0) return;

        graphics.lineStyle(pathsWidth, pathsColor, pathsAlpha);

        graphics.moveTo(path[0], path[1]);
        var i = 2;
        while (i < path.length) {
            graphics.lineTo(path[i], path[i + 1]);
            graphics.moveTo(path[i], path[i + 1]);
            i += 2;
        }
    }
}
