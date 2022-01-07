package hxDaedalus.flx;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

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

using flixel.util.FlxSpriteUtil;

inline
function colorAlpha( color: Int, alpha: Float ): Int
    return ( toHexInt( alpha ) << 24 ) | rgbInt( color );

inline
function toHexInt( c: Float ): Int
    return Math.round( c * 255 );

inline
function rgbInt( c: Int ): Int
    return ( c << 8 ) >> 8;

class FlxSimpleView extends FlxSprite {
    
    public var edgesColor:         FlxColor = 0xFF999999;
    public var edgesWidth:         Float = 1;
    public var edgesAlpha:         Float = .25;
    public var constraintsColor:   FlxColor = 0xFFFF0000;
    public var constraintsWidth:   Float = 2;
    public var constraintsAlpha:   Float = 1.0;
    public var verticesColor:      FlxColor = 0xFF0000FF;
    public var verticesRadius:     Float = 3;
    public var verticesAlpha:      Float = .25;
    public var pathsColor:         FlxColor = 0xFFFF00FF;//FFC010;
    public var pathsWidth:         Float = 1.5;
    public var pathsAlpha:         Float = .75;
    public var entitiesColor:      FlxColor = 0xFF00FF00;
    public var entitiesWidth:      Float = 1;
    public var entitiesAlpha:      Float = .75;
    public var faceColor:          FlxColor = 0xFFff00ff;
    public var faceWidth:          Float = 1;
    public var faceAlpha:          Float = .5;
    public var faceToEdgeIter      = new FromFaceToInnerEdges();
    
    public
    function new( x: Float, y: Float ){
        super( x, y );
        makeGraphic( 1024, 768, FlxColor.TRANSPARENT );
    }
    public
    function whiteBackground(){
        FlxSpriteUtil.drawRect( this, 0, 0, 1024, 768, FlxColor.WHITE );
    }
    public
    function blackBackground(){
        FlxSpriteUtil.drawRect( this, 0, 0, 1024, 768, FlxColor.BLACK );
    }
    public
    function background( color: FlxColor ){
        FlxSpriteUtil.drawRect( this, 0, 0, 1024, 768, color );
    }
    public
    function clear(){
        makeGraphic( 1024, 768, FlxColor.TRANSPARENT, true );
    }
    public
    function circle( p: { x: Float, y: Float }
                   , radius: Float, color: FlxColor, alpha: Float = 1.
                   ){
        if( alpha != 1. ) color = colorAlpha( color, alpha ); 
        FlxSpriteUtil.drawCircle( this, p.x, p.y, radius, color );
    }
    public
    function lineP(  p0: { x: Float, y: Float }
                  ,  p1: { x: Float, y: Float }
                  ,  color: FlxColor, alpha: Float, strength: Float ){
        if( alpha != 1. ) color = colorAlpha( color, alpha ); 
        FlxSpriteUtil.drawLine( this, p0.x, p0.y, p1.x, p1.y
                            , { thickness: strength, color: color } );
    }
    public
    function drawVertex( vertex : Vertex): Void {
        circle( vertex.pos, verticesRadius, verticesColor, verticesAlpha );
        #if showVerticesIndices
            // todo add font!
            // label( g2, p, new Point( vertex.pos.x + 5, vertex.pos.y + 5, font, fontSize, 0xFFFFFFFF, verticesAlpha );
        #end
    }
    public
    function drawFace( face: Face ) : Void {
        faceToEdgeIter.fromFace = face;
        var count = 0;
        var edge;
        // fills need resolve consider drawPolygon
        //flashGfx.lineStyle( faceWidth, faceColor, faceAlpha );
        var p: Point2D;
        var alpha = faceAlpha;
        var color = faceColor;
        if( alpha != 1. ) color = colorAlpha( color, alpha ); 
        var sx = 0.;
        var sy = 0.;
        var ex = 0.;
        var ey = 0.;
        while( true ){
            edge = faceToEdgeIter.next();
            if( edge == null ) break;
            p = edge.originVertex.pos;
            if( count == 0 ) {
                sx = p.x;
                sy = p.y;
            }
            p = edge.destinationVertex.pos;
            ex = p.x;
            ey = p.y;
            FlxSpriteUtil.drawLine( this, sx, sy, ex, ey, { thickness: faceWidth, color: color } );
            sx = ex;
            sy = ey;
            count++;
        }
    }
    public
    function drawEdge( edge : Edge ): Void {
        var p0 = edge.originVertex.pos;
        var p1 = edge.destinationVertex.pos;
        if( edge.isConstrained ){
            lineP( p0, p1, constraintsColor, constraintsAlpha, constraintsWidth );
        } else {
            lineP( p0, p1, edgesColor, edgesAlpha, edgesWidth );
        }
    }
    public
    function drawMesh( mesh: Mesh ): Void {
        var all = mesh.getVerticesAndEdges();
        for (v in all.vertices) drawVertex( v );
        for (e in all.edges) drawEdge( e );
    }
    public
    function drawEntity( entity: EntityAI ): Void {
        circle( entity, entity.radius, entitiesColor, entitiesAlpha );
    }
    public
    function drawEntities( vEntities:Array<EntityAI> ): Void {
        for (i in 0...vEntities.length) drawEntity( vEntities[ i ] );
    }
    public
    function drawPath( path:Array<Float>, cleanBefore:Bool = false): Void {
        if (path.length == 0) return;
        var alpha = pathsAlpha;
        var color = pathsColor;
        if( alpha != 1. ) color = colorAlpha( color, alpha ); 
        var i = 2;
        var sx = path[0];
        var sy = path[1];
        var ex = .0;
        var ey = .0;
        while( i < path.length ) {
            ex = path[ i ];
            ey = path[ i + 1 ];
            FlxSpriteUtil.drawLine( this, sx, sy, ex, ey, { thickness: pathsWidth, color: color } );
            sx = ex;
            sy = ey;
            i += 2;
        }
    }
}
