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

import h2d.Graphics;
import h2d.Text;
import hxd.Res;
import hxd.res.Font;
@:expose
class HeapsSimpleView {
    public var edgesColor:Int = 0x999999;
    public var edgesWidth:Float = 1;
    public var edgesAlpha:Float = .25;
    public var constraintsColor:Int = 0xFF0000;
    public var constraintsWidth:Float = 2;
    public var constraintsAlpha:Float = 1.0;
    public var verticesColor:Int = 0x0000FF;
    public var verticesRadius:Float = .5;
    public var verticesAlpha:Float = .25;
    public var pathsColor:Int = 0xFF00FF;//FFC010;
    public var pathsWidth:Float = 1.5;
    public var pathsAlpha:Float = .75;
    public var entitiesColor:Int = 0x00FF00;
    public var entitiesWidth:Float = 1;
    public var entitiesAlpha:Float = .75;
    public var faceColor: Int = 0xff00ff;
    public var faceWidth: Float = 1;
    public var faceAlpha: Float = .5;
    public var faceToEdgeIter = new FromFaceToInnerEdges();
    public function new(){}
    inline public function circle( g2: Graphics, p: { x: Float, y: Float }, radius: Float, color: Int, alpha: Float ){
        g2.lineStyle( entitiesWidth, entitiesColor, entitiesAlpha );
        g2.beginFill( entitiesColor, entitiesAlpha );
        g2.drawCircle( p.x, p.y, radius );
        g2.endFill();
    }
    inline public function label( g2: Graphics, p: { x: Float, y: Float }, t: String, font: Font, fontSize: Int, color: Int, alpha: Float ){
        /*var font = Res.fontName.build( fontSize );
        var text = new Text( font, g2 );  // check
        text.x = p.x;
        text.y = p.y;
        text.text = t;
        text.textColor = color;
        text.textAlpha = alpha;*/
    }
    inline public function lineP(    g2: Graphics, p0: { x: Float, y: Float }, p1: { x: Float, y: Float }
                                ,   color: Int, alpha: Float, strength: Float ){
        g2.lineStyle( strength, color, alpha );
        g2.moveTo( p0.x, p0.y );
        g2.lineTo( p1.x, p1.y );
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
        g2.beginFill( faceColor, faceAlpha );
        g2.lineStyle( faceWidth, faceColor, faceAlpha );
        var p: Point2D;
        while( true ){
            edge = faceToEdgeIter.next();
            if( edge == null ) break;
            p = edge.originVertex.pos;
            if( count == 0 ) g2.moveTo( p.x, p.y );
            p = edge.destinationVertex.pos;
            g2.lineTo( p.x, p.y );
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
        g2.lineStyle( pathsWidth, pathsColor, pathsWidth );
        g2.moveTo( path[0], path[1] );
        var i = 2;
        while( i < path.length ) {
            g2.lineTo( path[ i ], path[ i + 1 ] );
            i += 2;
        }
    }
}
