package hxDaedalus.view;


import hxDaedalus.ai.EntityAI;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Vertex;
import hxDaedalus.iterators.FromMeshToVertices;
import hxDaedalus.iterators.FromVertexToHoldingFaces;
import hxDaedalus.iterators.FromVertexToIncomingEdges;

import hxDaedalus.swing.Surface;
import hxDaedalus.swing.BasicSwing;
import java.awt.geom.GeneralPath;
import java.awt.Graphics2D;
import java.awt.BasicStroke;
import java.awt.Color;
class SimpleViewSwing
{
    private var noughtFiveStroke = new BasicStroke( 0.5 );
    private var normalStroke = new BasicStroke( 1 );
    private var boldStroke = new BasicStroke( 2 );
    public function new()
    {
    }
    
    var mesh: Mesh;
    
    /** Draws vertices, edges and constraints onto the `surface` sprite. */
    public function drawMesh(g: Graphics2D, mesh_:Mesh=null):Void 
    {
        if( mesh_ != null ) mesh = mesh_;
        
        g.setPaint( new Color( 0xff0000 ) );
        g.setStroke( noughtFiveStroke );
        g.drawRect(0, 0, Std.int( mesh.width ), Std.int( mesh.height ));
        
        var vertex:Vertex;
        var incomingEdge:Edge;
        var holdingFace:Face;
        
        var iterVertices:FromMeshToVertices;
        iterVertices = new FromMeshToVertices();
        iterVertices.fromMesh = mesh;
        
        var iterEdges:FromVertexToIncomingEdges;
        iterEdges = new FromVertexToIncomingEdges();
        var dictVerticesDone = new Map<Vertex,Bool>();
        var gpath: GeneralPath;
        while ((vertex = iterVertices.next()) != null)
        {
            dictVerticesDone[vertex] = true;
            if (!vertexIsInsideAABB(vertex, mesh)) continue;  
            
            g.setPaint( new Color( 0x0000FF ) );
            g.fillOval( Std.int( vertex.pos.x - 0.5 ), Std.int( vertex.pos.y - 0.5), Std.int( 2*0.5), Std.int(2*0.5));
            
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
                        g.setPaint( new Color( 0xff0000 ) );
                        g.setStroke( boldStroke );
                        gpath = new GeneralPath();
                        gpath.moveTo(incomingEdge.originVertex.pos.x, incomingEdge.originVertex.pos.y);
                        gpath.lineTo(incomingEdge.destinationVertex.pos.x, incomingEdge.destinationVertex.pos.y);
                        g.draw( gpath );
                    }
                    else 
                    {
                        g.setPaint( new Color( 0x999999 ) );
                        g.setStroke( noughtFiveStroke );
                        gpath = new GeneralPath();
                        gpath.moveTo(incomingEdge.originVertex.pos.x, incomingEdge.originVertex.pos.y);
                        gpath.lineTo(incomingEdge.destinationVertex.pos.x, incomingEdge.destinationVertex.pos.y);
                        g.draw( gpath );
                    }
                }
            }
        }
    }
    
    public function drawEntity( g: Graphics2D, entity: EntityAI ):Void 
    {
        g.setPaint( new Color( 0x00FF00 ) );
        g.setStroke( noughtFiveStroke );
        var r = entity.radius;
        var r2 = r*2;
        g.fillOval( Std.int( entity.x - r ), Std.int( entity.y - r ), Std.int( r2 ), Std.int( r2 ) );
    }
    
    public function drawEntities(g: Graphics2D, vEntities: Array<EntityAI> ):Void 
    {
        g.setStroke( noughtFiveStroke );
        g.setPaint( new Color ( 0x00FF00));
        for (i in 0...vEntities.length) {
            g.setPaint( new Color ( 0x00FF00));
            var r = vEntities[i].radius;
            var r2 = r*2;
            g.fillOval( Std.int( vEntities[i].x-r ), Std.int( vEntities[i].y-r ), Std.int( r2 ), Std.int( r2 ) );
        }
    }
    
    public function drawPath(g: Graphics2D,path:Array<Float>): Void 
    {
        if (path.length == 0) 
            return;
        g.setStroke( boldStroke );
        g.setPaint( new Color ( 0xFFC010));
        var gpath = new GeneralPath();
        gpath.moveTo(path[0], path[1]);
        var i = 2;
        while (i < path.length) {
            gpath.lineTo(path[i], path[i + 1]);
            gpath.moveTo(path[i], path[i + 1]);
            i += 2;
        }
        g.draw(gpath);
    }
    
    function vertexIsInsideAABB(vertex:Vertex, mesh:Mesh):Bool 
	{
        if (vertex.pos.x < 0 || vertex.pos.x > mesh.width || vertex.pos.y < 0 || vertex.pos.y > mesh.height) 
            return false
        else 
			return true;
    }
}