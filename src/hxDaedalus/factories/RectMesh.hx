package hxDaedalus.factories;


import hxDaedalus.data.Constants;
import hxDaedalus.data.ConstraintSegment;
import hxDaedalus.data.ConstraintShape;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Vertex;

@:expose
class RectMesh
{
    
    public static function buildRectangle( width: Float, height: Float) : Mesh
    {
        /*
           TL
             ----+-----+ TR
        \   |    /|
        \   |   / |
        \   |  /  |
        \   | /   |
        \   |/    |
        \   +-----+ BR
        \  BL     \
        \----------
        */
        
        var vTL = new Vertex();
        var vTR = new Vertex();
        var vBR = new Vertex();
        var vBL = new Vertex();
        
        var eTL_TR = new Edge();
        var eTR_TL = new Edge();
        var eTR_BR = new Edge();
        var eBR_TR = new Edge();
        var eBR_BL = new Edge();
        var eBL_BR = new Edge();
        var eBL_TL = new Edge();
        var eTL_BL = new Edge();
        var eTR_BL = new Edge();
        var eBL_TR = new Edge();
        var eTL_BR = new Edge();
        var eBR_TL = new Edge();
        
        var fTL_BL_TR = new Face();
        var fTR_BL_BR = new Face();
        var fTL_BR_BL = new Face();
        var fTL_TR_BR = new Face();
        
        var boundShape : ConstraintShape = new ConstraintShape();
        var segTop : ConstraintSegment = new ConstraintSegment();
        var segRight : ConstraintSegment = new ConstraintSegment();
        var segBot : ConstraintSegment = new ConstraintSegment();
        var segLeft : ConstraintSegment = new ConstraintSegment();
        
        var mesh : Mesh = new Mesh(width, height);
        
        //
        
        var offset : Float = Constants.EPSILON * 1000;
        vTL.pos.setXY( 0 - offset, 0 - offset);
        vTR.pos.setXY( width + offset, 0 - offset);
        vBR.pos.setXY( width + offset, height + offset);
        vBL.pos.setXY( 0 - offset, height + offset);
        
        vTL.setDatas(eTL_TR);
        vTR.setDatas(eTR_BR);
        vBR.setDatas(eBR_BL);
        vBL.setDatas(eBL_TL);
        
        eTL_TR.setDatas(vTL, eTR_TL, eTR_BR, fTL_TR_BR, true, true);
        eTR_TL.setDatas(vTR, eTL_TR, eTL_BL, fTL_BL_TR, true, true);
        eTR_BR.setDatas(vTR, eBR_TR, eBR_TL, fTL_TR_BR, true, true);
        eBR_TR.setDatas(vBR, eTR_BR, eTR_BL, fTR_BL_BR, true, true);
        eBR_BL.setDatas(vBR, eBL_BR, eBL_TL, fTL_BR_BL, true, true);
        eBL_BR.setDatas(vBL, eBR_BL, eBR_TR, fTR_BL_BR, true, true);
        eBL_TL.setDatas(vBL, eTL_BL, eTL_BR, fTL_BR_BL, true, true);
        eTL_BL.setDatas(vTL, eBL_TL, eBL_TR, fTL_BL_TR, true, true);
        eTR_BL.setDatas(vTR, eBL_TR, eBL_BR, fTR_BL_BR, true, false);  // diagonal edge  
        eBL_TR.setDatas(vBL, eTR_BL, eTR_TL, fTL_BL_TR, true, false);  // diagonal edge  
        eTL_BR.setDatas(vTL, eBR_TL, eBR_BL, fTL_BR_BL, false, false);  // imaginary edge  
        eBR_TL.setDatas(vBR, eTL_BR, eTL_TR, fTL_TR_BR, false, false);  // imaginary edge  
        
        fTL_BL_TR.setDatas(eBL_TR);
        fTR_BL_BR.setDatas(eTR_BL);
        fTL_BR_BL.setDatas(eBR_BL, false);
        fTL_TR_BR.setDatas(eTR_BR, false);
        
        // constraint relations datas
        vTL.fromConstraintSegments = [ segTop, segLeft ];
        vTR.fromConstraintSegments = [ segTop, segRight ];
        vBR.fromConstraintSegments = [ segRight, segBot ];
        vBL.fromConstraintSegments = [ segBot, segLeft ];
        
        eTL_TR.fromConstraintSegments.push(segTop);
        eTR_TL.fromConstraintSegments.push(segTop);
        eTR_BR.fromConstraintSegments.push(segRight);
        eBR_TR.fromConstraintSegments.push(segRight);
        eBR_BL.fromConstraintSegments.push(segBot);
        eBL_BR.fromConstraintSegments.push(segBot);
        eBL_TL.fromConstraintSegments.push(segLeft);
        eTL_BL.fromConstraintSegments.push(segLeft);
        
        segTop.edges.push(eTL_TR);
        segRight.edges.push(eTR_BR);
        segBot.edges.push(eBR_BL);
        segLeft.edges.push(eBL_TL);
        segTop.fromShape = boundShape;
        segRight.fromShape = boundShape;
        segBot.fromShape = boundShape;
        segLeft.fromShape = boundShape;
        
        for(f in [segTop, segRight, segBot, segLeft]) boundShape.segments.push(f);
        for(f in [vTL, vTR, vBR, vBL]) mesh._vertices.push(f);
        for(f in [eTL_TR, eTR_TL, eTR_BR, eBR_TR, eBR_BL, eBL_BR, eBL_TL, eTL_BL, eTR_BL, eBL_TR, eTL_BR, eBR_TL]) mesh._edges.push(f);
        for( f in [fTL_BL_TR, fTR_BL_BR, fTL_BR_BL, fTL_TR_BR]) mesh._faces.push(f);
        mesh.__constraintShapes.push(boundShape);
        var securityRect = new Array<Float>();
        for( f in [0, 0, width, 0]) securityRect.push(f);
        for( f in [width, 0, width, height]) securityRect.push(f);
        for( f in [width, height, 0, height]) securityRect.push(f);
        for( f in [0, height, 0, 0]) securityRect.push(f);
        
        mesh.clipping = false;
        mesh.insertConstraintShape(securityRect);
        mesh.clipping = true;
        
        return mesh;
    }

    public function new()
    {
    }
}
