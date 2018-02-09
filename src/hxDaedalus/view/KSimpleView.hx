package hxDaedalus.view;
import hxDaedalus.ai.EntityAI;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
import hxDaedalus.data.math.Point2D;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Vertex;
import hxDaedalus.iterators.FromMeshToVertices;
import hxDaedalus.iterators.FromVertexToHoldingFaces;
import hxDaedalus.iterators.FromVertexToIncomingEdges;
import hxDaedalus.data.Face;
import hxDaedalus.iterators.FromFaceToInnerEdges;

import kha.Font;
import kha.Color;
import kha.Image;
import kha.graphics4.DepthStencilFormat;  
import kha.graphics4.TextureFormat;
import kha.graphics2.Graphics;
import kha.graphics2.GraphicsExtension;
using kha.graphics2.GraphicsExtension;
@:expose
class KSimpleView {
    public var edgesColor:Int = 0xFF999999;
    public var edgesWidth:Float = 1;
    public var edgesAlpha:Float = .25;
    public var constraintsColor:Int = 0xFFFF0000;
    public var constraintsWidth:Float = 2;
    public var constraintsAlpha:Float = 1.0;
    public var verticesColor:Int = 0xFF0000FF;
    public var verticesRadius:Float = .5;
    public var verticesAlpha:Float = .25;
    public var pathsColor:Int = 0xFFFF00FF;//FFC010;
    public var pathsWidth:Float = 1.5;
    public var pathsAlpha:Float = .75;
    public var entitiesColor:Int = 0xFF00FF00;
    public var entitiesWidth:Float = 1;
    public var entitiesAlpha:Float = .75;
    public var faceColor: Int = 0xFFff00ff;
    public var faceWidth: Float = 1;
    public var faceAlpha: Float = .5;
    public var faceToEdgeIter = new FromFaceToInnerEdges();
    public function new(){}
    inline public function circle( g2: Graphics, p: { x: Float, y: Float }, radius: Float, color: Color, alpha: Float ){
        g2.opacity = alpha;
        g2.color   = color;
        g2.fillCircle( p.x, p.y, radius );
    }
    inline public function label( g2: Graphics, p: { x: Float, y: Float }, t: String, font: Font, fontSize: Int, color: Color, alpha: Float ){
        g2.opacity = alpha;
        g2.color   = color;
        g2.font    = font;
        g2.fontSize = fontSize;
        g2.drawString( t, p.x, p.y );
    }
    inline public function lineP(    g2: Graphics, p0: { x: Float, y: Float }, p1: { x: Float, y: Float }
                                ,   color: Color, alpha: Float, strength: Float ){
        g2.opacity = alpha;
        g2.color   = color;
        g2.drawLine( p0.x, p0.y, p1.x, p1.y );
    }
    inline public function line(    g2: Graphics, x0, y0, x1, y1
                                ,   color: Color, alpha: Float, strength: Float ){
        g2.opacity = alpha;
        g2.color   = color;
        g2.drawLine( x0, y0, x1, y1 );
    }
    public function drawVertex( g2: Graphics, vertex : Vertex): Void {
        circle( g2, vertex.pos, verticesRadius, verticesColor, verticesAlpha );
        #if showVerticesIndices
            // todo add font!
            // label( g2, p, new Point( vertex.pos.x + 5, vertex.pos.y + 5, font, fontSize, 0xFFFFFFFF, verticesAlpha );
        #end
    }
    
    public function drawFace( g2: Graphics, face: Face ) : Void {
        faceToEdgeIter.fromFace = face;
        var count = 0;
        var edge;
        while( true ){
            edge = faceToEdgeIter.next();
            if( edge == null ) break;
            // need to look at fill of triangles!!
            lineP( g2, cast edge.originVertex, cast edge.destinationVertex, faceColor, faceAlpha, faceWidth );
            count++;
        }
    }
    public function drawEdge( g2: Graphics, edge : Edge ): Void {
        var p0 = edge.originVertex.pos;
        var p1 = edge.destinationVertex.pos;
        if( edge.isConstrained ){
            lineP( g2, p0, p1, constraintsColor, constraintsAlpha, constraintsWidth );
        } else {
            lineP( g2, p0, p1, edgesColor, edgesAlpha, edgesWidth );
        }
    }
    public function drawMesh( g2: Graphics, mesh: Mesh ): Void {
        var all = mesh.getVerticesAndEdges();
        for (v in all.vertices) drawVertex( g2, v );
        for (e in all.edges) drawEdge( g2, e );
    }
    public function drawEntity( g2: Graphics, entity: EntityAI ): Void {
        circle( g2, entity, entity.radius, entitiesColor, entitiesAlpha );
    }
    public function drawEntities( g2: Graphics, vEntities:Array<EntityAI> ): Void {
        for (i in 0...vEntities.length) drawEntity( g2, vEntities[ i ] );
    }
    public function drawPath( g2: Graphics, path:Array<Float>, cleanBefore:Bool = false): Void {
        if (path.length == 0) return;
        var i = 0;
        while( i < path.length ) {
            line( g2, path[ i ], path[i + 1], path[ i + 2], path[ i + 3 ], pathsColor, pathsAlpha, pathsWidth );
            i += 2;
        }
    }
}
