package hxDaedalus.view;


import hxDaedalus.ai.EntityAI;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Vertex;
import hxDaedalus.iterators.FromMeshToVertices;
import hxDaedalus.iterators.FromVertexToHoldingFaces;
import hxDaedalus.iterators.FromVertexToIncomingEdges;

import js.html.CanvasRenderingContext2D;
import hxDaedalus.canvas.BasicCanvas;

class SimpleViewJS
{
    public var basicCanvas: BasicCanvas;
    var surface:CanvasRenderingContext2D;
    
    public function new()
    {
        basicCanvas = new BasicCanvas();
        surface = basicCanvas.surface;
    }
    
    var mesh: Mesh;
    
    /** Draws vertices, edges and constraints onto the `surface` sprite. */
    public function drawMesh(mesh_:Mesh=null):Void 
    {
        if( mesh_ != null ) mesh = mesh_;
        
        basicCanvas.clear();
        //basicCanvas.lineStyle( 0.5, 0xFF0000 );
        //surface.beginPath();
		surface.fillStyle = basicCanvas.header.bgColor;
        surface.fillRect(0, 0, mesh.width, mesh.height);
        //basicCanvas.endDraw();
        
        var vertex:Vertex;
        var incomingEdge:Edge;
        var holdingFace:Face;
        
        var iterVertices:FromMeshToVertices;
        iterVertices = new FromMeshToVertices();
        iterVertices.fromMesh = mesh;
        
        var iterEdges:FromVertexToIncomingEdges;
        iterEdges = new FromVertexToIncomingEdges();
        var dictVerticesDone = new Map<Vertex,Bool>();
        
        while ((vertex = iterVertices.next()) != null)
        {
            dictVerticesDone[vertex] = true;
            if (!vertexIsInsideAABB(vertex, mesh)) continue;  
            
            //basicCanvas.beginFill(0x0000FF);
            basicCanvas.drawCircle(vertex.pos.x, vertex.pos.y, 0.5);
            basicCanvas.endDraw();
            #if showVerticesIndices 
                // To implement
            #end
            
            iterEdges.fromVertex = vertex;
            while ((incomingEdge = iterEdges.next()) != null)
            {
                if (!dictVerticesDone[incomingEdge.originVertex]) 
                {
                    if (incomingEdge.isConstrained) 
                    {
						basicCanvas.beginFill(0xFF0000);
                        basicCanvas.lineStyle(2, 0xFF0000);
                        surface.moveTo(incomingEdge.originVertex.pos.x, incomingEdge.originVertex.pos.y);
                        surface.lineTo(incomingEdge.destinationVertex.pos.x, incomingEdge.destinationVertex.pos.y);
                        basicCanvas.endDraw();
                    }
                    else 
                    {
                        basicCanvas.lineStyle(.25, 0x999999);
                        surface.moveTo(incomingEdge.originVertex.pos.x, incomingEdge.originVertex.pos.y);
                        surface.lineTo(incomingEdge.destinationVertex.pos.x, incomingEdge.destinationVertex.pos.y);
                        basicCanvas.endDraw();
                    }
                }
            }
        }
    }
    
    public function drawEntity( entity: EntityAI ):Void 
    {
        basicCanvas.lineStyle(0.5, 0x00FF00);
        basicCanvas.beginFill(0x00FF00);
        basicCanvas.drawCircle(entity.x, entity.y, entity.radius);
        basicCanvas.endDraw();
    }
    
    public function drawEntities(vEntities: Array<EntityAI> ):Void 
    {
        basicCanvas.lineStyle(0.5, 0x00FF00);
        for (i in 0...vEntities.length) {
            basicCanvas.beginFill(0x00FF00);
            basicCanvas.drawCircle(vEntities[i].x, vEntities[i].y, vEntities[i].radius);
            basicCanvas.endDraw();
        }
    }
    
    public function drawPath(path:Array<Float>, cleanBefore:Bool = true): Void 
    {
        if (path.length == 0) 
            return;
        
        basicCanvas.lineStyle( 0.5, 0xFFC010 );
        
        surface.moveTo(path[0], path[1]);
        var i = 2;
        while (i < path.length) {
            surface.lineTo(path[i], path[i + 1]);
            surface.moveTo(path[i], path[i + 1]);
            i += 2;
        }
        basicCanvas.endDraw();
    }
    
    function vertexIsInsideAABB(vertex:Vertex, mesh:Mesh):Bool 
	{
        if (vertex.pos.x < 0 || vertex.pos.x > mesh.width || vertex.pos.y < 0 || vertex.pos.y > mesh.height) 
            return false
        else 
			return true;
    }
}