package hxDaedalus.factories;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class RectMesh extends haxe.lang.HxObject
{
	public    RectMesh(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    RectMesh()
	{
		hxDaedalus.factories.RectMesh.__hx_ctor_hxDaedalus_factories_RectMesh(this);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_factories_RectMesh(hxDaedalus.factories.RectMesh __temp_me41)
	{
		{
		}
		
	}
	
	
	public static   hxDaedalus.data.Mesh buildRectangle(double width, double height)
	{
		hxDaedalus.data.Vertex vTL = new hxDaedalus.data.Vertex();
		hxDaedalus.data.Vertex vTR = new hxDaedalus.data.Vertex();
		hxDaedalus.data.Vertex vBR = new hxDaedalus.data.Vertex();
		hxDaedalus.data.Vertex vBL = new hxDaedalus.data.Vertex();
		hxDaedalus.data.Edge eTL_TR = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eTR_TL = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eTR_BR = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eBR_TR = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eBR_BL = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eBL_BR = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eBL_TL = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eTL_BL = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eTR_BL = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eBL_TR = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eTL_BR = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eBR_TL = new hxDaedalus.data.Edge();
		hxDaedalus.data.Face fTL_BL_TR = new hxDaedalus.data.Face();
		hxDaedalus.data.Face fTR_BL_BR = new hxDaedalus.data.Face();
		hxDaedalus.data.Face fTL_BR_BL = new hxDaedalus.data.Face();
		hxDaedalus.data.Face fTL_TR_BR = new hxDaedalus.data.Face();
		hxDaedalus.data.ConstraintShape boundShape = new hxDaedalus.data.ConstraintShape();
		hxDaedalus.data.ConstraintSegment segTop = new hxDaedalus.data.ConstraintSegment();
		hxDaedalus.data.ConstraintSegment segRight = new hxDaedalus.data.ConstraintSegment();
		hxDaedalus.data.ConstraintSegment segBot = new hxDaedalus.data.ConstraintSegment();
		hxDaedalus.data.ConstraintSegment segLeft = new hxDaedalus.data.ConstraintSegment();
		hxDaedalus.data.Mesh mesh = new hxDaedalus.data.Mesh(((double) (width) ), ((double) (height) ));
		double offset = 10.;
		vTL.get_pos().setXY(( 0 - offset ), ( 0 - offset ));
		vTR.get_pos().setXY(( width + offset ), ( 0 - offset ));
		vBR.get_pos().setXY(( width + offset ), ( height + offset ));
		vBL.get_pos().setXY(( 0 - offset ), ( height + offset ));
		vTL.setDatas(eTL_TR, null);
		vTR.setDatas(eTR_BR, null);
		vBR.setDatas(eBR_BL, null);
		vBL.setDatas(eBL_TL, null);
		eTL_TR.setDatas(vTL, eTR_TL, eTR_BR, fTL_TR_BR, true, true);
		eTR_TL.setDatas(vTR, eTL_TR, eTL_BL, fTL_BL_TR, true, true);
		eTR_BR.setDatas(vTR, eBR_TR, eBR_TL, fTL_TR_BR, true, true);
		eBR_TR.setDatas(vBR, eTR_BR, eTR_BL, fTR_BL_BR, true, true);
		eBR_BL.setDatas(vBR, eBL_BR, eBL_TL, fTL_BR_BL, true, true);
		eBL_BR.setDatas(vBL, eBR_BL, eBR_TR, fTR_BL_BR, true, true);
		eBL_TL.setDatas(vBL, eTL_BL, eTL_BR, fTL_BR_BL, true, true);
		eTL_BL.setDatas(vTL, eBL_TL, eBL_TR, fTL_BL_TR, true, true);
		eTR_BL.setDatas(vTR, eBL_TR, eBL_BR, fTR_BL_BR, true, false);
		eBL_TR.setDatas(vBL, eTR_BL, eTR_TL, fTL_BL_TR, true, false);
		eTL_BR.setDatas(vTL, eBR_TL, eBR_BL, fTL_BR_BL, false, false);
		eBR_TL.setDatas(vBR, eTL_BR, eTL_TR, fTL_TR_BR, false, false);
		fTL_BL_TR.setDatas(eBL_TR, null);
		fTR_BL_BR.setDatas(eTR_BL, null);
		fTL_BR_BL.setDatas(eBR_BL, false);
		fTL_TR_BR.setDatas(eTR_BR, false);
		vTL.set_fromConstraintSegments(new haxe.root.Array<hxDaedalus.data.ConstraintSegment>(new hxDaedalus.data.ConstraintSegment[]{segTop, segLeft}));
		vTR.set_fromConstraintSegments(new haxe.root.Array<hxDaedalus.data.ConstraintSegment>(new hxDaedalus.data.ConstraintSegment[]{segTop, segRight}));
		vBR.set_fromConstraintSegments(new haxe.root.Array<hxDaedalus.data.ConstraintSegment>(new hxDaedalus.data.ConstraintSegment[]{segRight, segBot}));
		vBL.set_fromConstraintSegments(new haxe.root.Array<hxDaedalus.data.ConstraintSegment>(new hxDaedalus.data.ConstraintSegment[]{segBot, segLeft}));
		eTL_TR.fromConstraintSegments.push(segTop);
		eTR_TL.fromConstraintSegments.push(segTop);
		eTR_BR.fromConstraintSegments.push(segRight);
		eBR_TR.fromConstraintSegments.push(segRight);
		eBR_BL.fromConstraintSegments.push(segBot);
		eBL_BR.fromConstraintSegments.push(segBot);
		eBL_TL.fromConstraintSegments.push(segLeft);
		eTL_BL.fromConstraintSegments.push(segLeft);
		segTop.get_edges().push(eTL_TR);
		segRight.get_edges().push(eTR_BR);
		segBot.get_edges().push(eBR_BL);
		segLeft.get_edges().push(eBL_TL);
		segTop.fromShape = boundShape;
		segRight.fromShape = boundShape;
		segBot.fromShape = boundShape;
		segLeft.fromShape = boundShape;
		{
			int _g = 0;
			haxe.root.Array<hxDaedalus.data.ConstraintSegment> _g1 = new haxe.root.Array<hxDaedalus.data.ConstraintSegment>(new hxDaedalus.data.ConstraintSegment[]{segTop, segRight, segBot, segLeft});
			while (( _g < _g1.length ))
			{
				hxDaedalus.data.ConstraintSegment f = _g1.__get(_g);
				 ++ _g;
				boundShape.segments.push(f);
			}
			
		}
		
		{
			int _g2 = 0;
			haxe.root.Array<hxDaedalus.data.Vertex> _g11 = new haxe.root.Array<hxDaedalus.data.Vertex>(new hxDaedalus.data.Vertex[]{vTL, vTR, vBR, vBL});
			while (( _g2 < _g11.length ))
			{
				hxDaedalus.data.Vertex f1 = _g11.__get(_g2);
				 ++ _g2;
				mesh._vertices.push(f1);
			}
			
		}
		
		{
			int _g3 = 0;
			haxe.root.Array<hxDaedalus.data.Edge> _g12 = new haxe.root.Array<hxDaedalus.data.Edge>(new hxDaedalus.data.Edge[]{eTL_TR, eTR_TL, eTR_BR, eBR_TR, eBR_BL, eBL_BR, eBL_TL, eTL_BL, eTR_BL, eBL_TR, eTL_BR, eBR_TL});
			while (( _g3 < _g12.length ))
			{
				hxDaedalus.data.Edge f2 = _g12.__get(_g3);
				 ++ _g3;
				mesh._edges.push(f2);
			}
			
		}
		
		{
			int _g4 = 0;
			haxe.root.Array<hxDaedalus.data.Face> _g13 = new haxe.root.Array<hxDaedalus.data.Face>(new hxDaedalus.data.Face[]{fTL_BL_TR, fTR_BL_BR, fTL_BR_BL, fTL_TR_BR});
			while (( _g4 < _g13.length ))
			{
				hxDaedalus.data.Face f3 = _g13.__get(_g4);
				 ++ _g4;
				mesh._faces.push(f3);
			}
			
		}
		
		mesh.get___constraintShapes().push(boundShape);
		haxe.root.Array<java.lang.Object> securityRect = new haxe.root.Array<java.lang.Object>();
		{
			int _g5 = 0;
			haxe.root.Array<java.lang.Object> _g14 = new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (0) ), ((java.lang.Object) (0) ), ((java.lang.Object) (width) ), ((java.lang.Object) (0) )});
			while (( _g5 < _g14.length ))
			{
				double f4 = ((double) (haxe.lang.Runtime.toDouble(_g14.__get(_g5))) );
				 ++ _g5;
				securityRect.push(f4);
			}
			
		}
		
		{
			int _g6 = 0;
			haxe.root.Array<java.lang.Object> _g15 = new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (width) ), ((java.lang.Object) (0) ), ((java.lang.Object) (width) ), ((java.lang.Object) (height) )});
			while (( _g6 < _g15.length ))
			{
				double f5 = ((double) (haxe.lang.Runtime.toDouble(_g15.__get(_g6))) );
				 ++ _g6;
				securityRect.push(f5);
			}
			
		}
		
		{
			int _g7 = 0;
			haxe.root.Array<java.lang.Object> _g16 = new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (width) ), ((java.lang.Object) (height) ), ((java.lang.Object) (0) ), ((java.lang.Object) (height) )});
			while (( _g7 < _g16.length ))
			{
				double f6 = ((double) (haxe.lang.Runtime.toDouble(_g16.__get(_g7))) );
				 ++ _g7;
				securityRect.push(f6);
			}
			
		}
		
		{
			int _g8 = 0;
			haxe.root.Array<java.lang.Object> _g17 = new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (0) ), ((java.lang.Object) (height) ), ((java.lang.Object) (0) ), ((java.lang.Object) (0) )});
			while (( _g8 < _g17.length ))
			{
				double f7 = ((double) (haxe.lang.Runtime.toDouble(_g17.__get(_g8))) );
				 ++ _g8;
				securityRect.push(f7);
			}
			
		}
		
		mesh.set_clipping(false);
		mesh.insertConstraintShape(securityRect);
		mesh.set_clipping(true);
		return mesh;
	}
	
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.factories.RectMesh(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.factories.RectMesh();
	}
	
	
}


