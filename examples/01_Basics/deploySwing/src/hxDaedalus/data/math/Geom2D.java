package hxDaedalus.data.math;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class Geom2D extends haxe.lang.HxObject
{
	static 
	{
		hxDaedalus.data.math.Geom2D.__samples = new haxe.root.Array<hxDaedalus.data.Vertex>();
		hxDaedalus.data.math.Geom2D.__circumcenter = new hxDaedalus.data.math.Point2D(((java.lang.Object) (null) ), ((java.lang.Object) (null) ));
	}
	public    Geom2D(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    Geom2D()
	{
		hxDaedalus.data.math.Geom2D.__hx_ctor_hxDaedalus_data_math_Geom2D(this);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_data_math_Geom2D(hxDaedalus.data.math.Geom2D __temp_me28)
	{
		{
		}
		
	}
	
	
	public static  hxDaedalus.data.math.RandGenerator _randGen;
	
	public static  haxe.root.Array<hxDaedalus.data.Vertex> __samples;
	
	public static   hxDaedalus.data.math.Intersection locatePosition(double x, double y, hxDaedalus.data.Mesh mesh)
	{
		if (( hxDaedalus.data.math.Geom2D._randGen == null )) 
		{
			hxDaedalus.data.math.Geom2D._randGen = new hxDaedalus.data.math.RandGenerator(((java.lang.Object) (null) ), ((java.lang.Object) (null) ), ((java.lang.Object) (null) ));
		}
		
		hxDaedalus.data.math.Geom2D._randGen.set_seed(((int) (( ( x * 10 ) + ( 4 * y ) )) ));
		int i = 0;
		hxDaedalus.data.math.Geom2D.__samples.splice(0, hxDaedalus.data.math.Geom2D.__samples.length);
		int numSamples = 0;
		{
			double x1 = java.lang.Math.pow(((double) (mesh._vertices.length) ), 0.33333333333333331);
			numSamples = ((int) (x1) );
		}
		
		hxDaedalus.data.math.Geom2D._randGen.rangeMin = 0;
		hxDaedalus.data.math.Geom2D._randGen.rangeMax = ( mesh._vertices.length - 1 );
		{
			int _g = 0;
			while (( _g < numSamples ))
			{
				int i1 = _g++;
				int _rnd = hxDaedalus.data.math.Geom2D._randGen.next();
				hxDaedalus.debug.Debug.assertFalse(( ( _rnd < 0 ) || ( _rnd > ( mesh._vertices.length - 1 ) ) ), ( "_rnd: " + _rnd ), new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.math.Geom2D", "Geom2D.hx", "locatePosition"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (67) )) )})));
				hxDaedalus.debug.Debug.assertFalse(( mesh._vertices == null ), ( "vertices: " + mesh._vertices.length ), new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.math.Geom2D", "Geom2D.hx", "locatePosition"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (68) )) )})));
				hxDaedalus.data.math.Geom2D.__samples.push(mesh._vertices.__get(_rnd));
			}
			
		}
		
		hxDaedalus.data.Vertex currVertex = null;
		hxDaedalus.data.math.Point2D currVertexPos = null;
		double distSquared = 0.0;
		double minDistSquared = java.lang.Double.POSITIVE_INFINITY;
		hxDaedalus.data.Vertex closedVertex = null;
		{
			int _g1 = 0;
			while (( _g1 < numSamples ))
			{
				int i2 = _g1++;
				currVertex = hxDaedalus.data.math.Geom2D.__samples.__get(i2);
				currVertexPos = currVertex.get_pos();
				distSquared = ( ( (( currVertexPos.x - x )) * (( currVertexPos.x - x )) ) + ( (( currVertexPos.y - y )) * (( currVertexPos.y - y )) ) );
				if (( distSquared < minDistSquared )) 
				{
					minDistSquared = distSquared;
					closedVertex = currVertex;
				}
				
			}
			
		}
		
		hxDaedalus.data.Face currFace = null;
		hxDaedalus.iterators.FromVertexToHoldingFaces iterFace = new hxDaedalus.iterators.FromVertexToHoldingFaces();
		iterFace.set_fromVertex(closedVertex);
		currFace = iterFace.next();
		haxe.ds.ObjectMap<hxDaedalus.data.Face, java.lang.Object> faceVisited = new haxe.ds.ObjectMap<hxDaedalus.data.Face, java.lang.Object>();
		hxDaedalus.data.Edge currEdge = null;
		hxDaedalus.iterators.FromFaceToInnerEdges iterEdge = new hxDaedalus.iterators.FromFaceToInnerEdges();
		hxDaedalus.data.math.Intersection objectContainer = hxDaedalus.data.math.Intersection.ENull;
		int relativPos = 0;
		int numIter = 0;
		do 
		{
			boolean __temp_stmt159 = haxe.lang.Runtime.toBool(faceVisited.get(currFace));
			boolean __temp_boolv160 = false;
			if ( ! (__temp_stmt159) ) 
			{
				boolean __temp_stmt161 = false;
				{
					hxDaedalus.data.math.Intersection _g2 = objectContainer = hxDaedalus.data.math.Geom2D.isInFace(x, y, currFace);
					switch (haxe.root.Type.enumIndex(_g2))
					{
						case 3:
						{
							__temp_stmt161 = true;
							break;
						}
						
						
						default:
						{
							__temp_stmt161 = false;
							break;
						}
						
					}
					
				}
				
				__temp_boolv160 = haxe.lang.Runtime.toBool(__temp_stmt161);
			}
			
			boolean __temp_stmt158 = ( __temp_stmt159 || __temp_boolv160 );
			if (__temp_stmt158) 
			{
				faceVisited.get(currFace);
				numIter++;
				if (( numIter == 50 )) 
				{
					haxe.Log.trace.__hx_invoke2_o(0.0, "WALK TAKE MORE THAN 50 LOOP", 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.math.Geom2D", "Geom2D.hx", "locatePosition"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (107) )) )})));
				}
				
				iterEdge.set_fromFace(currFace);
				do 
				{
					currEdge = iterEdge.next();
					if (( currEdge == null )) 
					{
						haxe.Log.trace.__hx_invoke2_o(0.0, "KILL PATH", 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.math.Geom2D", "Geom2D.hx", "locatePosition"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (115) )) )})));
						return hxDaedalus.data.math.Intersection.ENull;
					}
					
					relativPos = hxDaedalus.data.math.Geom2D.getRelativePosition(x, y, currEdge);
				}
				while (( ( relativPos == 1 ) || ( relativPos == 0 ) ));
				currFace = currEdge.get_rightFace();
			}
			 else 
			{
				break;
			}
			
		}
		while (true);
		return objectContainer;
	}
	
	
	public static   boolean isCircleIntersectingAnyConstraint(double x, double y, double radius, hxDaedalus.data.Mesh mesh)
	{
		if (( ( ( ( x <= 0 ) || ( x >= mesh.get_width() ) ) || ( y <= 0 ) ) || ( y >= mesh.get_height() ) )) 
		{
			return true;
		}
		
		hxDaedalus.data.math.Intersection loc = hxDaedalus.data.math.Geom2D.locatePosition(x, y, mesh);
		hxDaedalus.data.Face face = null;
		switch (haxe.root.Type.enumIndex(loc))
		{
			case 0:
			{
				hxDaedalus.data.Vertex vertex = ((hxDaedalus.data.Vertex) (loc.params.__get(0)) );
				face = vertex.get_edge().get_leftFace();
				break;
			}
			
			
			case 1:
			{
				hxDaedalus.data.Edge edge = ((hxDaedalus.data.Edge) (loc.params.__get(0)) );
				face = edge.get_leftFace();
				break;
			}
			
			
			case 2:
			{
				hxDaedalus.data.Face face_ = ((hxDaedalus.data.Face) (loc.params.__get(0)) );
				face = face_;
				break;
			}
			
			
			case 3:
			{
				face = null;
				break;
			}
			
			
		}
		
		double radiusSquared = ( radius * radius );
		hxDaedalus.data.math.Point2D pos = null;
		double distSquared = 0.0;
		pos = face.get_edge().get_originVertex().get_pos();
		distSquared = ( ( (( pos.x - x )) * (( pos.x - x )) ) + ( (( pos.y - y )) * (( pos.y - y )) ) );
		if (( distSquared <= radiusSquared )) 
		{
			return true;
		}
		
		pos = face.get_edge().get_nextLeftEdge().get_originVertex().get_pos();
		distSquared = ( ( (( pos.x - x )) * (( pos.x - x )) ) + ( (( pos.y - y )) * (( pos.y - y )) ) );
		if (( distSquared <= radiusSquared )) 
		{
			return true;
		}
		
		pos = face.get_edge().get_nextLeftEdge().get_nextLeftEdge().get_originVertex().get_pos();
		distSquared = ( ( (( pos.x - x )) * (( pos.x - x )) ) + ( (( pos.y - y )) * (( pos.y - y )) ) );
		if (( distSquared <= radiusSquared )) 
		{
			return true;
		}
		
		haxe.root.Array<hxDaedalus.data.Edge> edgesToCheck = new haxe.root.Array<hxDaedalus.data.Edge>();
		edgesToCheck.push(face.get_edge());
		edgesToCheck.push(face.get_edge().get_nextLeftEdge());
		edgesToCheck.push(face.get_edge().get_nextLeftEdge().get_nextLeftEdge());
		hxDaedalus.data.Edge edge1 = null;
		hxDaedalus.data.math.Point2D pos1 = null;
		hxDaedalus.data.math.Point2D pos2 = null;
		haxe.ds.ObjectMap<hxDaedalus.data.Edge, java.lang.Object> checkedEdges = new haxe.ds.ObjectMap<hxDaedalus.data.Edge, java.lang.Object>();
		boolean intersecting = false;
		while (( edgesToCheck.length > 0 ))
		{
			edge1 = edgesToCheck.pop();
			{
				checkedEdges.set(edge1, true);
				boolean __temp_expr162 = true;
			}
			
			pos1 = edge1.get_originVertex().get_pos();
			pos2 = edge1.get_destinationVertex().get_pos();
			intersecting = hxDaedalus.data.math.Geom2D.intersectionsSegmentCircle(pos1.x, pos1.y, pos2.x, pos2.y, x, y, radius, null);
			if (intersecting) 
			{
				if (edge1.get_isConstrained()) 
				{
					return true;
				}
				 else 
				{
					edge1 = edge1.get_oppositeEdge().get_nextLeftEdge();
					boolean __temp_boolv167 = ( ! (haxe.lang.Runtime.toBool(checkedEdges.get(edge1))) );
					boolean __temp_boolv166 = false;
					boolean __temp_boolv165 = false;
					boolean __temp_boolv164 = false;
					if (__temp_boolv167) 
					{
						java.lang.Object __temp_stmt168 = null;
						{
							hxDaedalus.data.Edge key = edge1.get_oppositeEdge();
							__temp_stmt168 = checkedEdges.get(key);
						}
						
						__temp_boolv166 = ( ! (haxe.lang.Runtime.toBool(__temp_stmt168)) );
						if (__temp_boolv166) 
						{
							__temp_boolv165 = ( edgesToCheck.indexOf(edge1, null) == -1 );
							if (__temp_boolv165) 
							{
								__temp_boolv164 = ( edgesToCheck.indexOf(edge1.get_oppositeEdge(), null) == -1 );
							}
							
						}
						
					}
					
					boolean __temp_stmt163 = ( ( ( __temp_boolv167 && __temp_boolv166 ) && __temp_boolv165 ) && __temp_boolv164 );
					if (__temp_stmt163) 
					{
						edgesToCheck.push(edge1);
					}
					
					edge1 = edge1.get_nextLeftEdge();
					boolean __temp_boolv173 = ( ! (haxe.lang.Runtime.toBool(checkedEdges.get(edge1))) );
					boolean __temp_boolv172 = false;
					boolean __temp_boolv171 = false;
					boolean __temp_boolv170 = false;
					if (__temp_boolv173) 
					{
						java.lang.Object __temp_stmt174 = null;
						{
							hxDaedalus.data.Edge key1 = edge1.get_oppositeEdge();
							__temp_stmt174 = checkedEdges.get(key1);
						}
						
						__temp_boolv172 = ( ! (haxe.lang.Runtime.toBool(__temp_stmt174)) );
						if (__temp_boolv172) 
						{
							__temp_boolv171 = ( edgesToCheck.indexOf(edge1, null) == -1 );
							if (__temp_boolv171) 
							{
								__temp_boolv170 = ( edgesToCheck.indexOf(edge1.get_oppositeEdge(), null) == -1 );
							}
							
						}
						
					}
					
					boolean __temp_stmt169 = ( ( ( __temp_boolv173 && __temp_boolv172 ) && __temp_boolv171 ) && __temp_boolv170 );
					if (__temp_stmt169) 
					{
						edgesToCheck.push(edge1);
					}
					
				}
				
			}
			
		}
		
		return false;
	}
	
	
	public static   int getDirection(double x1, double y1, double x2, double y2, double x3, double y3)
	{
		double dot = ( ( (( x3 - x1 )) * (( y2 - y1 )) ) + ( (( y3 - y1 )) * ((  - (x2)  + x1 )) ) );
		if (( dot == 0 )) 
		{
			return 0;
		}
		 else 
		{
			if (( dot > 0 )) 
			{
				return 1;
			}
			 else 
			{
				return -1;
			}
			
		}
		
	}
	
	
	public static   int getDirection2(double x1, double y1, double x2, double y2, double x3, double y3)
	{
		double dot = ( ( (( x3 - x1 )) * (( y2 - y1 )) ) + ( (( y3 - y1 )) * ((  - (x2)  + x1 )) ) );
		if (( dot == 0 )) 
		{
			return 0;
		}
		 else 
		{
			if (( dot > 0 )) 
			{
				if (( hxDaedalus.data.math.Geom2D.distanceSquaredPointToLine(x3, y3, x1, y1, x2, y2) <= 0.0001 )) 
				{
					return 0;
				}
				 else 
				{
					return 1;
				}
				
			}
			 else 
			{
				if (( hxDaedalus.data.math.Geom2D.distanceSquaredPointToLine(x3, y3, x1, y1, x2, y2) <= 0.0001 )) 
				{
					return 0;
				}
				 else 
				{
					return -1;
				}
				
			}
			
		}
		
	}
	
	
	public static   int getRelativePosition(double x, double y, hxDaedalus.data.Edge eUp)
	{
		return hxDaedalus.data.math.Geom2D.getDirection(eUp.get_originVertex().get_pos().x, eUp.get_originVertex().get_pos().y, eUp.get_destinationVertex().get_pos().x, eUp.get_destinationVertex().get_pos().y, x, y);
	}
	
	
	public static   int getRelativePosition2(double x, double y, hxDaedalus.data.Edge eUp)
	{
		return hxDaedalus.data.math.Geom2D.getDirection2(eUp.get_originVertex().get_pos().x, eUp.get_originVertex().get_pos().y, eUp.get_destinationVertex().get_pos().x, eUp.get_destinationVertex().get_pos().y, x, y);
	}
	
	
	public static   hxDaedalus.data.math.Intersection isInFace(double x, double y, hxDaedalus.data.Face polygon)
	{
		hxDaedalus.data.math.Intersection result = hxDaedalus.data.math.Intersection.ENull;
		hxDaedalus.data.Edge e1_2 = polygon.get_edge();
		hxDaedalus.data.Edge e2_3 = e1_2.get_nextLeftEdge();
		hxDaedalus.data.Edge e3_1 = e2_3.get_nextLeftEdge();
		if (( ( ( hxDaedalus.data.math.Geom2D.getRelativePosition(x, y, e1_2) >= 0 ) && ( hxDaedalus.data.math.Geom2D.getRelativePosition(x, y, e2_3) >= 0 ) ) && ( hxDaedalus.data.math.Geom2D.getRelativePosition(x, y, e3_1) >= 0 ) )) 
		{
			hxDaedalus.data.Vertex v1 = e1_2.get_originVertex();
			hxDaedalus.data.Vertex v2 = e2_3.get_originVertex();
			hxDaedalus.data.Vertex v3 = e3_1.get_originVertex();
			double x1 = v1.get_pos().x;
			double y1 = v1.get_pos().y;
			double x2 = v2.get_pos().x;
			double y2 = v2.get_pos().y;
			double x3 = v3.get_pos().x;
			double y3 = v3.get_pos().y;
			double v_v1squaredLength = ( ( (( x1 - x )) * (( x1 - x )) ) + ( (( y1 - y )) * (( y1 - y )) ) );
			double v_v2squaredLength = ( ( (( x2 - x )) * (( x2 - x )) ) + ( (( y2 - y )) * (( y2 - y )) ) );
			double v_v3squaredLength = ( ( (( x3 - x )) * (( x3 - x )) ) + ( (( y3 - y )) * (( y3 - y )) ) );
			double v1_v2squaredLength = ( ( (( x2 - x1 )) * (( x2 - x1 )) ) + ( (( y2 - y1 )) * (( y2 - y1 )) ) );
			double v2_v3squaredLength = ( ( (( x3 - x2 )) * (( x3 - x2 )) ) + ( (( y3 - y2 )) * (( y3 - y2 )) ) );
			double v3_v1squaredLength = ( ( (( x1 - x3 )) * (( x1 - x3 )) ) + ( (( y1 - y3 )) * (( y1 - y3 )) ) );
			double dot_v_v1v2 = ( ( (( x - x1 )) * (( x2 - x1 )) ) + ( (( y - y1 )) * (( y2 - y1 )) ) );
			double dot_v_v2v3 = ( ( (( x - x2 )) * (( x3 - x2 )) ) + ( (( y - y2 )) * (( y3 - y2 )) ) );
			double dot_v_v3v1 = ( ( (( x - x3 )) * (( x1 - x3 )) ) + ( (( y - y3 )) * (( y1 - y3 )) ) );
			double v_e1_2squaredLength = ( v_v1squaredLength - ( ( dot_v_v1v2 * dot_v_v1v2 ) / v1_v2squaredLength ) );
			double v_e2_3squaredLength = ( v_v2squaredLength - ( ( dot_v_v2v3 * dot_v_v2v3 ) / v2_v3squaredLength ) );
			double v_e3_1squaredLength = ( v_v3squaredLength - ( ( dot_v_v3v1 * dot_v_v3v1 ) / v3_v1squaredLength ) );
			boolean closeTo_e1_2 = ( v_e1_2squaredLength <= 0.0001 );
			boolean closeTo_e2_3 = ( v_e2_3squaredLength <= 0.0001 );
			boolean closeTo_e3_1 = ( v_e3_1squaredLength <= 0.0001 );
			if (closeTo_e1_2) 
			{
				if (closeTo_e3_1) 
				{
					result = hxDaedalus.data.math.Intersection.EVertex(v1);
				}
				 else 
				{
					if (closeTo_e2_3) 
					{
						result = hxDaedalus.data.math.Intersection.EVertex(v2);
					}
					 else 
					{
						result = hxDaedalus.data.math.Intersection.EEdge(e1_2);
					}
					
				}
				
			}
			 else 
			{
				if (closeTo_e2_3) 
				{
					if (closeTo_e3_1) 
					{
						result = hxDaedalus.data.math.Intersection.EVertex(v3);
					}
					 else 
					{
						result = hxDaedalus.data.math.Intersection.EEdge(e2_3);
					}
					
				}
				 else 
				{
					if (closeTo_e3_1) 
					{
						result = hxDaedalus.data.math.Intersection.EEdge(e3_1);
					}
					 else 
					{
						result = hxDaedalus.data.math.Intersection.EFace(polygon);
					}
					
				}
				
			}
			
		}
		
		return result;
	}
	
	
	public static   boolean clipSegmentByTriangle(double s1x, double s1y, double s2x, double s2y, double t1x, double t1y, double t2x, double t2y, double t3x, double t3y, hxDaedalus.data.math.Point2D pResult1, hxDaedalus.data.math.Point2D pResult2)
	{
		int side1_1 = 0;
		int side1_2 = 0;
		side1_1 = hxDaedalus.data.math.Geom2D.getDirection(t1x, t1y, t2x, t2y, s1x, s1y);
		side1_2 = hxDaedalus.data.math.Geom2D.getDirection(t1x, t1y, t2x, t2y, s2x, s2y);
		if (( ( side1_1 <= 0 ) && ( side1_2 <= 0 ) )) 
		{
			return false;
		}
		
		int side2_1 = 0;
		int side2_2 = 0;
		side2_1 = hxDaedalus.data.math.Geom2D.getDirection(t2x, t2y, t3x, t3y, s1x, s1y);
		side2_2 = hxDaedalus.data.math.Geom2D.getDirection(t2x, t2y, t3x, t3y, s2x, s2y);
		if (( ( side2_1 <= 0 ) && ( side2_2 <= 0 ) )) 
		{
			return false;
		}
		
		int side3_1 = 0;
		int side3_2 = 0;
		side3_1 = hxDaedalus.data.math.Geom2D.getDirection(t3x, t3y, t1x, t1y, s1x, s1y);
		side3_2 = hxDaedalus.data.math.Geom2D.getDirection(t3x, t3y, t1x, t1y, s2x, s2y);
		if (( ( side3_1 <= 0 ) && ( side3_2 <= 0 ) )) 
		{
			return false;
		}
		
		if (( ( ( ( side1_1 >= 0 ) && ( side2_1 >= 0 ) ) && ( side3_1 >= 0 ) ) && (( ( ( side1_2 >= 0 ) && ( side2_2 >= 0 ) ) && ( side3_2 >= 0 ) )) )) 
		{
			pResult1.x = s1x;
			pResult1.y = s1y;
			pResult2.x = s2x;
			pResult2.y = s2y;
			return true;
		}
		
		int n = 0;
		if (hxDaedalus.data.math.Geom2D.intersections2segments(s1x, s1y, s2x, s2y, t1x, t1y, t2x, t2y, pResult1, null, null)) 
		{
			n++;
		}
		
		if (( n == 0 )) 
		{
			if (hxDaedalus.data.math.Geom2D.intersections2segments(s1x, s1y, s2x, s2y, t2x, t2y, t3x, t3y, pResult1, null, null)) 
			{
				n++;
			}
			
		}
		 else 
		{
			if (hxDaedalus.data.math.Geom2D.intersections2segments(s1x, s1y, s2x, s2y, t2x, t2y, t3x, t3y, pResult2, null, null)) 
			{
				if (( ( ( ( -0.01 > ( pResult1.x - pResult2.x ) ) || ( ( pResult1.x - pResult2.x ) > 0.01 ) ) || ( -0.01 > ( pResult1.y - pResult2.y ) ) ) || ( ( pResult1.y - pResult2.y ) > 0.01 ) )) 
				{
					n++;
				}
				
			}
			
		}
		
		if (( n == 0 )) 
		{
			if (hxDaedalus.data.math.Geom2D.intersections2segments(s1x, s1y, s2x, s2y, t3x, t3y, t1x, t1y, pResult1, null, null)) 
			{
				n++;
			}
			
		}
		 else 
		{
			if (( n == 1 )) 
			{
				if (hxDaedalus.data.math.Geom2D.intersections2segments(s1x, s1y, s2x, s2y, t3x, t3y, t1x, t1y, pResult2, null, null)) 
				{
					if (( ( ( ( -0.01 > ( pResult1.x - pResult2.x ) ) || ( ( pResult1.x - pResult2.x ) > 0.01 ) ) || ( -0.01 > ( pResult1.y - pResult2.y ) ) ) || ( ( pResult1.y - pResult2.y ) > 0.01 ) )) 
					{
						n++;
					}
					
				}
				
			}
			
		}
		
		if (( n == 1 )) 
		{
			if (( ( ( side1_1 >= 0 ) && ( side2_1 >= 0 ) ) && ( side3_1 >= 0 ) )) 
			{
				pResult2.x = s1x;
				pResult2.y = s1y;
			}
			 else 
			{
				if (( ( ( side1_2 >= 0 ) && ( side2_2 >= 0 ) ) && ( side3_2 >= 0 ) )) 
				{
					pResult2.x = s2x;
					pResult2.y = s2y;
				}
				 else 
				{
					n = 0;
				}
				
			}
			
		}
		
		if (( n > 0 )) 
		{
			return true;
		}
		 else 
		{
			return false;
		}
		
	}
	
	
	public static   boolean isSegmentIntersectingTriangle(double s1x, double s1y, double s2x, double s2y, double t1x, double t1y, double t2x, double t2y, double t3x, double t3y)
	{
		int side1_1 = 0;
		int side1_2 = 0;
		side1_1 = hxDaedalus.data.math.Geom2D.getDirection(t1x, t1y, t2x, t2y, s1x, s1y);
		side1_2 = hxDaedalus.data.math.Geom2D.getDirection(t1x, t1y, t2x, t2y, s2x, s2y);
		if (( ( side1_1 <= 0 ) && ( side1_2 <= 0 ) )) 
		{
			return false;
		}
		
		int side2_1 = 0;
		int side2_2 = 0;
		side2_1 = hxDaedalus.data.math.Geom2D.getDirection(t2x, t2y, t3x, t3y, s1x, s1y);
		side2_2 = hxDaedalus.data.math.Geom2D.getDirection(t2x, t2y, t3x, t3y, s2x, s2y);
		if (( ( side2_1 <= 0 ) && ( side2_2 <= 0 ) )) 
		{
			return false;
		}
		
		int side3_1 = 0;
		int side3_2 = 0;
		side3_1 = hxDaedalus.data.math.Geom2D.getDirection(t3x, t3y, t1x, t1y, s1x, s1y);
		side3_2 = hxDaedalus.data.math.Geom2D.getDirection(t3x, t3y, t1x, t1y, s2x, s2y);
		if (( ( side3_1 <= 0 ) && ( side3_2 <= 0 ) )) 
		{
			return false;
		}
		
		if (( ( ( side1_1 == 1 ) && ( side2_1 == 1 ) ) && ( side3_1 == 1 ) )) 
		{
			return true;
		}
		
		if (( ( ( side1_1 == 1 ) && ( side2_1 == 1 ) ) && ( side3_1 == 1 ) )) 
		{
			return true;
		}
		
		int side1 = 0;
		int side2 = 0;
		if (( ( ( side1_1 == 1 ) && ( side1_2 <= 0 ) ) || ( ( side1_1 <= 0 ) && ( side1_2 == 1 ) ) )) 
		{
			side1 = hxDaedalus.data.math.Geom2D.getDirection(s1x, s1y, s2x, s2y, t1x, t1y);
			side2 = hxDaedalus.data.math.Geom2D.getDirection(s1x, s1y, s2x, s2y, t2x, t2y);
			if (( ( ( side1 == 1 ) && ( side2 <= 0 ) ) || ( ( side1 <= 0 ) && ( side2 == 1 ) ) )) 
			{
				return true;
			}
			
		}
		
		if (( ( ( side2_1 == 1 ) && ( side2_2 <= 0 ) ) || ( ( side2_1 <= 0 ) && ( side2_2 == 1 ) ) )) 
		{
			side1 = hxDaedalus.data.math.Geom2D.getDirection(s1x, s1y, s2x, s2y, t2x, t2y);
			side2 = hxDaedalus.data.math.Geom2D.getDirection(s1x, s1y, s2x, s2y, t3x, t3y);
			if (( ( ( side1 == 1 ) && ( side2 <= 0 ) ) || ( ( side1 <= 0 ) && ( side2 == 1 ) ) )) 
			{
				return true;
			}
			
		}
		
		if (( ( ( side3_1 == 1 ) && ( side3_2 <= 0 ) ) || ( ( side3_1 <= 0 ) && ( side3_2 == 1 ) ) )) 
		{
			side1 = hxDaedalus.data.math.Geom2D.getDirection(s1x, s1y, s2x, s2y, t3x, t3y);
			side2 = hxDaedalus.data.math.Geom2D.getDirection(s1x, s1y, s2x, s2y, t1x, t1y);
			if (( ( ( side1 == 1 ) && ( side2 <= 0 ) ) || ( ( side1 <= 0 ) && ( side2 == 1 ) ) )) 
			{
				return true;
			}
			
		}
		
		return false;
	}
	
	
	public static  hxDaedalus.data.math.Point2D __circumcenter;
	
	public static   boolean isDelaunay(hxDaedalus.data.Edge edge)
	{
		hxDaedalus.data.Vertex vLeft = edge.get_originVertex();
		hxDaedalus.data.Vertex vRight = edge.get_destinationVertex();
		hxDaedalus.data.Vertex vCorner = edge.get_nextLeftEdge().get_destinationVertex();
		hxDaedalus.data.Vertex vOpposite = edge.get_nextRightEdge().get_destinationVertex();
		hxDaedalus.data.math.Geom2D.getCircumcenter(vCorner.get_pos().x, vCorner.get_pos().y, vLeft.get_pos().x, vLeft.get_pos().y, vRight.get_pos().x, vRight.get_pos().y, hxDaedalus.data.math.Geom2D.__circumcenter);
		double squaredRadius = ( ( (( vCorner.get_pos().x - hxDaedalus.data.math.Geom2D.__circumcenter.x )) * (( vCorner.get_pos().x - hxDaedalus.data.math.Geom2D.__circumcenter.x )) ) + ( (( vCorner.get_pos().y - hxDaedalus.data.math.Geom2D.__circumcenter.y )) * (( vCorner.get_pos().y - hxDaedalus.data.math.Geom2D.__circumcenter.y )) ) );
		double squaredDistance = ( ( (( vOpposite.get_pos().x - hxDaedalus.data.math.Geom2D.__circumcenter.x )) * (( vOpposite.get_pos().x - hxDaedalus.data.math.Geom2D.__circumcenter.x )) ) + ( (( vOpposite.get_pos().y - hxDaedalus.data.math.Geom2D.__circumcenter.y )) * (( vOpposite.get_pos().y - hxDaedalus.data.math.Geom2D.__circumcenter.y )) ) );
		return ( squaredDistance >= squaredRadius );
	}
	
	
	public static   hxDaedalus.data.math.Point2D getCircumcenter(double x1, double y1, double x2, double y2, double x3, double y3, hxDaedalus.data.math.Point2D result)
	{
		if (( result == null )) 
		{
			result = new hxDaedalus.data.math.Point2D(((java.lang.Object) (null) ), ((java.lang.Object) (null) ));
		}
		
		double m1 = ( (( x1 + x2 )) / 2 );
		double m2 = ( (( y1 + y2 )) / 2 );
		double m3 = ( (( x1 + x3 )) / 2 );
		double m4 = ( (( y1 + y3 )) / 2 );
		double t1 = ( (( ( ( m1 * (( x1 - x3 )) ) + ( (( m2 - m4 )) * (( y1 - y3 )) ) ) + ( m3 * (( x3 - x1 )) ) )) / (( ( ( x1 * (( y3 - y2 )) ) + ( x2 * (( y1 - y3 )) ) ) + ( x3 * (( y2 - y1 )) ) )) );
		result.x = ( m1 + ( t1 * (( y2 - y1 )) ) );
		result.y = ( m2 - ( t1 * (( x2 - x1 )) ) );
		return result;
	}
	
	
	public static   boolean intersections2segments(double s1p1x, double s1p1y, double s1p2x, double s1p2y, double s2p1x, double s2p1y, double s2p2x, double s2p2y, hxDaedalus.data.math.Point2D posIntersection, haxe.root.Array<java.lang.Object> paramIntersection, java.lang.Object infiniteLineMode)
	{
		boolean __temp_infiniteLineMode26 = ( (( infiniteLineMode == null )) ? (haxe.lang.Runtime.toBool(false)) : (haxe.lang.Runtime.toBool(infiniteLineMode)) );
		double t1 = ((double) (0) );
		double t2 = ((double) (0) );
		boolean result = false;
		double divisor = ( ( (( s1p1x - s1p2x )) * (( s2p1y - s2p2y )) ) + ( (( s1p2y - s1p1y )) * (( s2p1x - s2p2x )) ) );
		if (( divisor == 0 )) 
		{
			result = false;
		}
		 else 
		{
			result = true;
			if (( (  ! (__temp_infiniteLineMode26)  || ( posIntersection != null ) ) || ( paramIntersection != null ) )) 
			{
				t1 = ( (( ( ( ( s1p1x * (( s2p1y - s2p2y )) ) + ( s1p1y * (( s2p2x - s2p1x )) ) ) + ( s2p1x * s2p2y ) ) - ( s2p1y * s2p2x ) )) / divisor );
				t2 = ( (( ( ( ( s1p1x * (( s2p1y - s1p2y )) ) + ( s1p1y * (( s1p2x - s2p1x )) ) ) - ( s1p2x * s2p1y ) ) + ( s1p2y * s2p1x ) )) / divisor );
				if ((  ! (__temp_infiniteLineMode26)  &&  ! ((( ( ( ( 0 <= t1 ) && ( t1 <= 1 ) ) && ( 0 <= t2 ) ) && ( t2 <= 1 ) )))  )) 
				{
					result = false;
				}
				
			}
			
		}
		
		if (result) 
		{
			if (( posIntersection != null )) 
			{
				posIntersection.x = ( s1p1x + ( t1 * (( s1p2x - s1p1x )) ) );
				posIntersection.y = ( s1p1y + ( t1 * (( s1p2y - s1p1y )) ) );
			}
			
			if (( paramIntersection != null )) 
			{
				paramIntersection.push(t1);
				paramIntersection.push(t2);
			}
			
		}
		
		return result;
	}
	
	
	public static   boolean intersections2edges(hxDaedalus.data.Edge edge1, hxDaedalus.data.Edge edge2, hxDaedalus.data.math.Point2D posIntersection, haxe.root.Array<java.lang.Object> paramIntersection, java.lang.Object infiniteLineMode)
	{
		boolean __temp_infiniteLineMode27 = ( (( infiniteLineMode == null )) ? (haxe.lang.Runtime.toBool(false)) : (haxe.lang.Runtime.toBool(infiniteLineMode)) );
		return hxDaedalus.data.math.Geom2D.intersections2segments(edge1.get_originVertex().get_pos().x, edge1.get_originVertex().get_pos().y, edge1.get_destinationVertex().get_pos().x, edge1.get_destinationVertex().get_pos().y, edge2.get_originVertex().get_pos().x, edge2.get_originVertex().get_pos().y, edge2.get_destinationVertex().get_pos().x, edge2.get_destinationVertex().get_pos().y, posIntersection, paramIntersection, __temp_infiniteLineMode27);
	}
	
	
	public static   boolean isConvex(hxDaedalus.data.Edge edge)
	{
		boolean result = true;
		hxDaedalus.data.Edge eLeft = null;
		hxDaedalus.data.Vertex vRight = null;
		eLeft = edge.get_nextLeftEdge().get_oppositeEdge();
		vRight = edge.get_nextRightEdge().get_destinationVertex();
		if (( hxDaedalus.data.math.Geom2D.getRelativePosition(vRight.get_pos().x, vRight.get_pos().y, eLeft) != -1 )) 
		{
			result = false;
		}
		 else 
		{
			eLeft = edge.get_prevRightEdge();
			vRight = edge.get_prevLeftEdge().get_originVertex();
			if (( hxDaedalus.data.math.Geom2D.getRelativePosition(vRight.get_pos().x, vRight.get_pos().y, eLeft) != -1 )) 
			{
				result = false;
			}
			
		}
		
		return result;
	}
	
	
	public static   void projectOrthogonaly(hxDaedalus.data.math.Point2D vertexPos, hxDaedalus.data.Edge edge)
	{
		double a = edge.get_originVertex().get_pos().x;
		double b = edge.get_originVertex().get_pos().y;
		double c = edge.get_destinationVertex().get_pos().x;
		double d = edge.get_destinationVertex().get_pos().y;
		double e = vertexPos.x;
		double f = vertexPos.y;
		double t1 = ( (( ( ( ( ( ( ( ( a * a ) - ( a * c ) ) - ( a * e ) ) + ( b * b ) ) - ( b * d ) ) - ( b * f ) ) + ( c * e ) ) + ( d * f ) )) / (( ( ( ( ( ( a * a ) - ( ( 2 * a ) * c ) ) + ( b * b ) ) - ( ( 2 * b ) * d ) ) + ( c * c ) ) + ( d * d ) )) );
		vertexPos.x = ( a + ( t1 * (( c - a )) ) );
		vertexPos.y = ( b + ( t1 * (( d - b )) ) );
	}
	
	
	public static   boolean intersections2Circles(double cx1, double cy1, double r1, double cx2, double cy2, double r2, haxe.root.Array<java.lang.Object> result)
	{
		double distRadiusSQRD = ( ( (( cx2 - cx1 )) * (( cx2 - cx1 )) ) + ( (( cy2 - cy1 )) * (( cy2 - cy1 )) ) );
		if (( ( (( ( cx1 != cx2 ) || ( cy1 != cy2 ) )) && ( distRadiusSQRD <= ( (( r1 + r2 )) * (( r1 + r2 )) ) ) ) && ( distRadiusSQRD >= ( (( r1 - r2 )) * (( r1 - r2 )) ) ) )) 
		{
			double transcendPart = java.lang.Math.sqrt(( (( ( (( r1 + r2 )) * (( r1 + r2 )) ) - distRadiusSQRD )) * (( distRadiusSQRD - ( (( r2 - r1 )) * (( r2 - r1 )) ) )) ));
			double xFirstPart = ( ( (( cx1 + cx2 )) / 2 ) + ( ( (( cx2 - cx1 )) * (( ( r1 * r1 ) - ( r2 * r2 ) )) ) / (( 2 * distRadiusSQRD )) ) );
			double yFirstPart = ( ( (( cy1 + cy2 )) / 2 ) + ( ( (( cy2 - cy1 )) * (( ( r1 * r1 ) - ( r2 * r2 ) )) ) / (( 2 * distRadiusSQRD )) ) );
			double xFactor = ( (( cy2 - cy1 )) / (( 2 * distRadiusSQRD )) );
			double yFactor = ( (( cx2 - cx1 )) / (( 2 * distRadiusSQRD )) );
			if (( result != null )) 
			{
				int _g = 0;
				haxe.root.Array<java.lang.Object> _g1 = new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (( xFirstPart + ( xFactor * transcendPart ) )) ), ((java.lang.Object) (( yFirstPart - ( yFactor * transcendPart ) )) ), ((java.lang.Object) (( xFirstPart - ( xFactor * transcendPart ) )) ), ((java.lang.Object) (( yFirstPart + ( yFactor * transcendPart ) )) )});
				while (( _g < _g1.length ))
				{
					double f = ((double) (haxe.lang.Runtime.toDouble(_g1.__get(_g))) );
					 ++ _g;
					result.push(f);
				}
				
			}
			
			return true;
		}
		 else 
		{
			return false;
		}
		
	}
	
	
	public static   boolean intersectionsSegmentCircle(double p0x, double p0y, double p1x, double p1y, double cx, double cy, double r, haxe.root.Array<java.lang.Object> result)
	{
		double p0xSQD = ( p0x * p0x );
		double p0ySQD = ( p0y * p0y );
		double a = ( ( ( ( ( ( p1y * p1y ) - ( ( 2 * p1y ) * p0y ) ) + p0ySQD ) + ( p1x * p1x ) ) - ( ( 2 * p1x ) * p0x ) ) + p0xSQD );
		double b = ( ( ( ( ( ( ( ( ( 2 * p0y ) * cy ) - ( 2 * p0xSQD ) ) + ( ( 2 * p1y ) * p0y ) ) - ( 2 * p0ySQD ) ) + ( ( 2 * p1x ) * p0x ) ) - ( ( 2 * p1x ) * cx ) ) + ( ( 2 * p0x ) * cx ) ) - ( ( 2 * p1y ) * cy ) );
		double c = ( ( ( ( ( ( p0ySQD + ( cy * cy ) ) + ( cx * cx ) ) - ( ( 2 * p0y ) * cy ) ) - ( ( 2 * p0x ) * cx ) ) + p0xSQD ) - ( r * r ) );
		double delta = ( ( b * b ) - ( ( 4 * a ) * c ) );
		double deltaSQRT = 0.0;
		double t0 = 0.0;
		double t1 = 0.0;
		if (( delta < 0 )) 
		{
			return false;
		}
		 else 
		{
			if (( delta == 0 )) 
			{
				t0 = (  - (b)  / (( 2 * a )) );
				if (( ( t0 < 0 ) || ( t0 > 1 ) )) 
				{
					return false;
				}
				
				if (( result != null )) 
				{
					int _g = 0;
					haxe.root.Array<java.lang.Object> _g1 = new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (( p0x + ( t0 * (( p1x - p0x )) ) )) ), ((java.lang.Object) (( p0y + ( t0 * (( p1y - p0y )) ) )) ), ((java.lang.Object) (t0) )});
					while (( _g < _g1.length ))
					{
						double f = ((double) (haxe.lang.Runtime.toDouble(_g1.__get(_g))) );
						 ++ _g;
						result.push(f);
					}
					
				}
				
				return true;
			}
			 else 
			{
				deltaSQRT = java.lang.Math.sqrt(delta);
				t0 = ( ((  - (b)  + deltaSQRT )) / (( 2 * a )) );
				t1 = ( ((  - (b)  - deltaSQRT )) / (( 2 * a )) );
				boolean intersecting = false;
				if (( ( 0 <= t0 ) && ( t0 <= 1 ) )) 
				{
					if (( result != null )) 
					{
						int _g2 = 0;
						haxe.root.Array<java.lang.Object> _g11 = new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (( p0x + ( t0 * (( p1x - p0x )) ) )) ), ((java.lang.Object) (( p0y + ( t0 * (( p1y - p0y )) ) )) ), ((java.lang.Object) (t0) )});
						while (( _g2 < _g11.length ))
						{
							double f1 = ((double) (haxe.lang.Runtime.toDouble(_g11.__get(_g2))) );
							 ++ _g2;
							result.push(f1);
						}
						
					}
					
					intersecting = true;
				}
				
				if (( ( 0 <= t1 ) && ( t1 <= 1 ) )) 
				{
					if (( result != null )) 
					{
						int _g3 = 0;
						haxe.root.Array<java.lang.Object> _g12 = new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (( p0x + ( t1 * (( p1x - p0x )) ) )) ), ((java.lang.Object) (( p0y + ( t1 * (( p1y - p0y )) ) )) ), ((java.lang.Object) (t1) )});
						while (( _g3 < _g12.length ))
						{
							double f2 = ((double) (haxe.lang.Runtime.toDouble(_g12.__get(_g3))) );
							 ++ _g3;
							result.push(f2);
						}
						
					}
					
					intersecting = true;
				}
				
				return intersecting;
			}
			
		}
		
	}
	
	
	public static   boolean intersectionsLineCircle(double p0x, double p0y, double p1x, double p1y, double cx, double cy, double r, haxe.root.Array<java.lang.Object> result)
	{
		double p0xSQD = ( p0x * p0x );
		double p0ySQD = ( p0y * p0y );
		double a = ( ( ( ( ( ( p1y * p1y ) - ( ( 2 * p1y ) * p0y ) ) + p0ySQD ) + ( p1x * p1x ) ) - ( ( 2 * p1x ) * p0x ) ) + p0xSQD );
		double b = ( ( ( ( ( ( ( ( ( 2 * p0y ) * cy ) - ( 2 * p0xSQD ) ) + ( ( 2 * p1y ) * p0y ) ) - ( 2 * p0ySQD ) ) + ( ( 2 * p1x ) * p0x ) ) - ( ( 2 * p1x ) * cx ) ) + ( ( 2 * p0x ) * cx ) ) - ( ( 2 * p1y ) * cy ) );
		double c = ( ( ( ( ( ( p0ySQD + ( cy * cy ) ) + ( cx * cx ) ) - ( ( 2 * p0y ) * cy ) ) - ( ( 2 * p0x ) * cx ) ) + p0xSQD ) - ( r * r ) );
		double delta = ( ( b * b ) - ( ( 4 * a ) * c ) );
		double deltaSQRT = 0.0;
		double t0 = 0.0;
		double t1 = 0.0;
		if (( delta < 0 )) 
		{
			return false;
		}
		 else 
		{
			if (( delta == 0 )) 
			{
				t0 = (  - (b)  / (( 2 * a )) );
				{
					int _g = 0;
					haxe.root.Array<java.lang.Object> _g1 = new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (( p0x + ( t0 * (( p1x - p0x )) ) )) ), ((java.lang.Object) (( p0y + ( t0 * (( p1y - p0y )) ) )) ), ((java.lang.Object) (t0) )});
					while (( _g < _g1.length ))
					{
						double f = ((double) (haxe.lang.Runtime.toDouble(_g1.__get(_g))) );
						 ++ _g;
						result.push(f);
					}
					
				}
				
			}
			 else 
			{
				if (( delta > 0 )) 
				{
					deltaSQRT = java.lang.Math.sqrt(delta);
					t0 = ( ((  - (b)  + deltaSQRT )) / (( 2 * a )) );
					t1 = ( ((  - (b)  - deltaSQRT )) / (( 2 * a )) );
					{
						int _g2 = 0;
						haxe.root.Array<java.lang.Object> _g11 = new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (( p0x + ( t0 * (( p1x - p0x )) ) )) ), ((java.lang.Object) (( p0y + ( t0 * (( p1y - p0y )) ) )) ), ((java.lang.Object) (t0) ), ((java.lang.Object) (( p0x + ( t1 * (( p1x - p0x )) ) )) ), ((java.lang.Object) (( p0y + ( t1 * (( p1y - p0y )) ) )) ), ((java.lang.Object) (t1) )});
						while (( _g2 < _g11.length ))
						{
							double f1 = ((double) (haxe.lang.Runtime.toDouble(_g11.__get(_g2))) );
							 ++ _g2;
							result.push(f1);
						}
						
					}
					
				}
				
			}
			
		}
		
		return true;
	}
	
	
	public static   boolean tangentsPointToCircle(double px, double py, double cx, double cy, double r, haxe.root.Array<java.lang.Object> result)
	{
		double c2x = ( (( px + cx )) / 2 );
		double c2y = ( (( py + cy )) / 2 );
		double r2 = ( 0.5 * java.lang.Math.sqrt(( ( (( px - cx )) * (( px - cx )) ) + ( (( py - cy )) * (( py - cy )) ) )) );
		return hxDaedalus.data.math.Geom2D.intersections2Circles(c2x, c2y, r2, cx, cy, r, result);
	}
	
	
	public static   boolean tangentsCrossCircleToCircle(double r, double c1x, double c1y, double c2x, double c2y, haxe.root.Array<java.lang.Object> result)
	{
		double distance = java.lang.Math.sqrt(( ( (( c1x - c2x )) * (( c1x - c2x )) ) + ( (( c1y - c2y )) * (( c1y - c2y )) ) ));
		double radius = ( distance / 4 );
		double centerX = ( c1x + ( (( c2x - c1x )) / 4 ) );
		double centerY = ( c1y + ( (( c2y - c1y )) / 4 ) );
		if (hxDaedalus.data.math.Geom2D.intersections2Circles(c1x, c1y, r, centerX, centerY, radius, result)) 
		{
			double t1x = ((double) (haxe.lang.Runtime.toDouble(result.__get(0))) );
			double t1y = ((double) (haxe.lang.Runtime.toDouble(result.__get(1))) );
			double t2x = ((double) (haxe.lang.Runtime.toDouble(result.__get(2))) );
			double t2y = ((double) (haxe.lang.Runtime.toDouble(result.__get(3))) );
			double midX = ( (( c1x + c2x )) / 2 );
			double midY = ( (( c1y + c2y )) / 2 );
			double dotProd = ( ( (( t1x - midX )) * (( c2y - c1y )) ) + ( (( t1y - midY )) * ((  - (c2x)  + c1x )) ) );
			double tproj = ( dotProd / (( distance * distance )) );
			double projx = ( midX + ( tproj * (( c2y - c1y )) ) );
			double projy = ( midY - ( tproj * (( c2x - c1x )) ) );
			double t4x = ( ( 2 * projx ) - t1x );
			double t4y = ( ( 2 * projy ) - t1y );
			double t3x = ( ( t4x + t2x ) - t1x );
			double t3y = ( ( t2y + t4y ) - t1y );
			{
				int _g = 0;
				haxe.root.Array<java.lang.Object> _g1 = new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (t3x) ), ((java.lang.Object) (t3y) ), ((java.lang.Object) (t4x) ), ((java.lang.Object) (t4y) )});
				while (( _g < _g1.length ))
				{
					double f = ((double) (haxe.lang.Runtime.toDouble(_g1.__get(_g))) );
					 ++ _g;
					result.push(f);
				}
				
			}
			
			return true;
		}
		 else 
		{
			return false;
		}
		
	}
	
	
	public static   void tangentsParalCircleToCircle(double r, double c1x, double c1y, double c2x, double c2y, haxe.root.Array<java.lang.Object> result)
	{
		double distance = java.lang.Math.sqrt(( ( (( c1x - c2x )) * (( c1x - c2x )) ) + ( (( c1y - c2y )) * (( c1y - c2y )) ) ));
		double t1x = ( c1x + ( ( r * (( c2y - c1y )) ) / distance ) );
		double t1y = ( c1y + ( ( r * ((  - (c2x)  + c1x )) ) / distance ) );
		double t2x = ( ( 2 * c1x ) - t1x );
		double t2y = ( ( 2 * c1y ) - t1y );
		double t3x = ( ( t2x + c2x ) - c1x );
		double t3y = ( ( t2y + c2y ) - c1y );
		double t4x = ( ( t1x + c2x ) - c1x );
		double t4y = ( ( t1y + c2y ) - c1y );
		{
			int _g = 0;
			haxe.root.Array<java.lang.Object> _g1 = new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (t1x) ), ((java.lang.Object) (t1y) ), ((java.lang.Object) (t2x) ), ((java.lang.Object) (t2y) ), ((java.lang.Object) (t3x) ), ((java.lang.Object) (t3y) ), ((java.lang.Object) (t4x) ), ((java.lang.Object) (t4y) )});
			while (( _g < _g1.length ))
			{
				double f = ((double) (haxe.lang.Runtime.toDouble(_g1.__get(_g))) );
				 ++ _g;
				result.push(f);
			}
			
		}
		
	}
	
	
	public static   double distanceSquaredPointToLine(double px, double py, double ax, double ay, double bx, double by)
	{
		double a_b_squaredLength = ( ( (( bx - ax )) * (( bx - ax )) ) + ( (( by - ay )) * (( by - ay )) ) );
		double dotProduct = ( ( (( px - ax )) * (( bx - ax )) ) + ( (( py - ay )) * (( by - ay )) ) );
		double p_a_squaredLength = ( ( (( ax - px )) * (( ax - px )) ) + ( (( ay - py )) * (( ay - py )) ) );
		return ( p_a_squaredLength - ( ( dotProduct * dotProduct ) / a_b_squaredLength ) );
	}
	
	
	public static   double distanceSquaredPointToSegment(double px, double py, double ax, double ay, double bx, double by)
	{
		double a_b_squaredLength = ( ( (( bx - ax )) * (( bx - ax )) ) + ( (( by - ay )) * (( by - ay )) ) );
		double dotProduct = ( (( ( (( px - ax )) * (( bx - ax )) ) + ( (( py - ay )) * (( by - ay )) ) )) / a_b_squaredLength );
		if (( dotProduct < 0 )) 
		{
			return ( ( (( px - ax )) * (( px - ax )) ) + ( (( py - ay )) * (( py - ay )) ) );
		}
		 else 
		{
			if (( dotProduct <= 1 )) 
			{
				double p_a_squaredLength = ( ( (( ax - px )) * (( ax - px )) ) + ( (( ay - py )) * (( ay - py )) ) );
				return ( p_a_squaredLength - ( ( dotProduct * dotProduct ) * a_b_squaredLength ) );
			}
			 else 
			{
				return ( ( (( px - bx )) * (( px - bx )) ) + ( (( py - by )) * (( py - by )) ) );
			}
			
		}
		
	}
	
	
	public static   double distanceSquaredVertexToEdge(hxDaedalus.data.Vertex vertex, hxDaedalus.data.Edge edge)
	{
		return hxDaedalus.data.math.Geom2D.distanceSquaredPointToSegment(vertex.get_pos().x, vertex.get_pos().y, edge.get_originVertex().get_pos().x, edge.get_originVertex().get_pos().y, edge.get_destinationVertex().get_pos().x, edge.get_destinationVertex().get_pos().y);
	}
	
	
	public static   double pathLength(haxe.root.Array<java.lang.Object> path)
	{
		double sumDistance = 0.;
		double fromX = ((double) (haxe.lang.Runtime.toDouble(path.__get(0))) );
		double fromY = ((double) (haxe.lang.Runtime.toDouble(path.__get(1))) );
		double nextX = 0.0;
		double nextY = 0.0;
		double x = 0.0;
		double y = 0.0;
		double distance = 0.0;
		int i = 2;
		while (( i < path.length ))
		{
			nextX = ((double) (haxe.lang.Runtime.toDouble(path.__get(i))) );
			nextY = ((double) (haxe.lang.Runtime.toDouble(path.__get(( i + 1 )))) );
			x = ( nextX - fromX );
			y = ( nextY - fromY );
			distance = java.lang.Math.sqrt(( ( x * x ) + ( y * y ) ));
			sumDistance += distance;
			fromX = nextX;
			fromY = nextY;
			i += 2;
		}
		
		return sumDistance;
	}
	
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.data.math.Geom2D(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.data.math.Geom2D();
	}
	
	
}


