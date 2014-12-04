package hxDaedalus.data;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class Mesh extends haxe.lang.HxObject
{
	static 
	{
		hxDaedalus.data.Mesh.INC = 0;
	}
	public    Mesh(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    Mesh(double width, double height)
	{
		hxDaedalus.data.Mesh.__hx_ctor_hxDaedalus_data_Mesh(this, width, height);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_data_Mesh(hxDaedalus.data.Mesh __temp_me19, double width, double height)
	{
		__temp_me19.__objectsUpdateInProgress = false;
		__temp_me19.__edgesToCheck = null;
		__temp_me19.__centerVertex = null;
		__temp_me19._objects = null;
		__temp_me19._constraintShapes = null;
		__temp_me19._faces = null;
		__temp_me19._edges = null;
		__temp_me19._vertices = null;
		__temp_me19._clipping = false;
		__temp_me19._height = ((double) (0) );
		__temp_me19._width = ((double) (0) );
		__temp_me19._id = hxDaedalus.data.Mesh.INC;
		hxDaedalus.data.Mesh.INC++;
		__temp_me19._width = width;
		__temp_me19._height = height;
		__temp_me19._clipping = true;
		__temp_me19._vertices = new haxe.root.Array<hxDaedalus.data.Vertex>();
		__temp_me19._edges = new haxe.root.Array<hxDaedalus.data.Edge>();
		__temp_me19._faces = new haxe.root.Array<hxDaedalus.data.Face>();
		__temp_me19._constraintShapes = new haxe.root.Array<hxDaedalus.data.ConstraintShape>();
		__temp_me19._objects = new haxe.root.Array<hxDaedalus.data.Object>();
		__temp_me19.__edgesToCheck = new haxe.root.Array<hxDaedalus.data.Edge>();
	}
	
	
	public static  int INC;
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.data.Mesh(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.data.Mesh(((double) (haxe.lang.Runtime.toDouble(arr.__get(0))) ), ((double) (haxe.lang.Runtime.toDouble(arr.__get(1))) ));
	}
	
	
	
	
	
	
	
	
	
	
	
	
	public  int _id;
	
	public  double _width;
	
	public  double _height;
	
	public  boolean _clipping;
	
	public  haxe.root.Array<hxDaedalus.data.Vertex> _vertices;
	
	public  haxe.root.Array<hxDaedalus.data.Edge> _edges;
	
	public  haxe.root.Array<hxDaedalus.data.Face> _faces;
	
	public  haxe.root.Array<hxDaedalus.data.ConstraintShape> _constraintShapes;
	
	public  haxe.root.Array<hxDaedalus.data.Object> _objects;
	
	public  hxDaedalus.data.Vertex __centerVertex;
	
	public  haxe.root.Array<hxDaedalus.data.Edge> __edgesToCheck;
	
	public   double get_height()
	{
		return this._height;
	}
	
	
	public   double get_width()
	{
		return this._width;
	}
	
	
	public   boolean get_clipping()
	{
		return this._clipping;
	}
	
	
	public   boolean set_clipping(boolean value)
	{
		this._clipping = value;
		return value;
	}
	
	
	public   int get_id()
	{
		return this._id;
	}
	
	
	public   void dispose()
	{
		while (( this._vertices.length > 0 ))
		{
			this._vertices.pop().dispose();
		}
		
		this._vertices = null;
		while (( this._edges.length > 0 ))
		{
			this._edges.pop().dispose();
		}
		
		this._edges = null;
		while (( this._faces.length > 0 ))
		{
			this._faces.pop().dispose();
		}
		
		this._faces = null;
		while (( this._constraintShapes.length > 0 ))
		{
			this._constraintShapes.pop().dispose();
		}
		
		this._constraintShapes = null;
		while (( this._objects.length > 0 ))
		{
			this._objects.pop().dispose();
		}
		
		this._objects = null;
		this.__edgesToCheck = null;
		this.__centerVertex = null;
	}
	
	
	public   haxe.root.Array<hxDaedalus.data.ConstraintShape> get___constraintShapes()
	{
		return this._constraintShapes;
	}
	
	
	public   void buildFromRecord(java.lang.String rec)
	{
		haxe.root.Array positions = ((haxe.root.Array) (haxe.lang.StringExt.split(rec, ";")) );
		int i = 0;
		while (( i < positions.length ))
		{
			this.insertConstraintSegment(haxe.root.Std.parseFloat(haxe.lang.Runtime.toString(positions.__get(i))), haxe.root.Std.parseFloat(haxe.lang.Runtime.toString(positions.__get(( i + 1 )))), haxe.root.Std.parseFloat(haxe.lang.Runtime.toString(positions.__get(( i + 2 )))), haxe.root.Std.parseFloat(haxe.lang.Runtime.toString(positions.__get(( i + 3 )))));
			i += 4;
		}
		
	}
	
	
	public   void insertObject(hxDaedalus.data.Object object)
	{
		if (( object.get_constraintShape() != null )) 
		{
			this.deleteObject(object);
		}
		
		hxDaedalus.data.ConstraintShape shape = new hxDaedalus.data.ConstraintShape();
		hxDaedalus.data.ConstraintSegment segment = null;
		haxe.root.Array<java.lang.Object> coordinates = object.get_coordinates();
		hxDaedalus.data.math.Matrix2D m = object.get_matrix();
		object.updateMatrixFromValues();
		double x1 = 0.0;
		double y1 = 0.0;
		double x2 = 0.0;
		double y2 = 0.0;
		double transfx1 = 0.0;
		double transfy1 = 0.0;
		double transfx2 = 0.0;
		double transfy2 = 0.0;
		int i = 0;
		while (( i < coordinates.length ))
		{
			x1 = ((double) (haxe.lang.Runtime.toDouble(coordinates.__get(i))) );
			y1 = ((double) (haxe.lang.Runtime.toDouble(coordinates.__get(( i + 1 )))) );
			x2 = ((double) (haxe.lang.Runtime.toDouble(coordinates.__get(( i + 2 )))) );
			y2 = ((double) (haxe.lang.Runtime.toDouble(coordinates.__get(( i + 3 )))) );
			transfx1 = m.transformX(x1, y1);
			transfy1 = m.transformY(x1, y1);
			transfx2 = m.transformX(x2, y2);
			transfy2 = m.transformY(x2, y2);
			segment = this.insertConstraintSegment(transfx1, transfy1, transfx2, transfy2);
			if (( segment != null )) 
			{
				segment.fromShape = shape;
				shape.segments.push(segment);
			}
			
			i += 4;
		}
		
		this._constraintShapes.push(shape);
		object.set_constraintShape(shape);
		if ( ! (this.__objectsUpdateInProgress) ) 
		{
			this._objects.push(object);
		}
		
	}
	
	
	public   void deleteObject(hxDaedalus.data.Object object)
	{
		if (( object.get_constraintShape() == null )) 
		{
			return ;
		}
		
		this.deleteConstraintShape(object.get_constraintShape());
		object.set_constraintShape(null);
		if ( ! (this.__objectsUpdateInProgress) ) 
		{
			int index = this._objects.indexOf(object, null);
			this._objects.splice(index, 1);
		}
		
	}
	
	
	public  boolean __objectsUpdateInProgress;
	
	public   void updateObjects()
	{
		this.__objectsUpdateInProgress = true;
		{
			int _g1 = 0;
			int _g = this._objects.length;
			while (( _g1 < _g ))
			{
				int i = _g1++;
				if (this._objects.__get(i).get_hasChanged()) 
				{
					this.deleteObject(this._objects.__get(i));
					this.insertObject(this._objects.__get(i));
					this._objects.__get(i).set_hasChanged(false);
				}
				
			}
			
		}
		
		this.__objectsUpdateInProgress = false;
	}
	
	
	public   hxDaedalus.data.ConstraintShape insertConstraintShape(haxe.root.Array<java.lang.Object> coordinates)
	{
		hxDaedalus.data.ConstraintShape shape = new hxDaedalus.data.ConstraintShape();
		hxDaedalus.data.ConstraintSegment segment = null;
		int i = 0;
		while (( i < coordinates.length ))
		{
			segment = this.insertConstraintSegment(((double) (haxe.lang.Runtime.toDouble(coordinates.__get(i))) ), ((double) (haxe.lang.Runtime.toDouble(coordinates.__get(( i + 1 )))) ), ((double) (haxe.lang.Runtime.toDouble(coordinates.__get(( i + 2 )))) ), ((double) (haxe.lang.Runtime.toDouble(coordinates.__get(( i + 3 )))) ));
			if (( segment != null )) 
			{
				segment.fromShape = shape;
				shape.segments.push(segment);
			}
			
			i += 4;
		}
		
		this._constraintShapes.push(shape);
		return shape;
	}
	
	
	public   void deleteConstraintShape(hxDaedalus.data.ConstraintShape shape)
	{
		{
			int _g1 = 0;
			int _g = shape.segments.length;
			while (( _g1 < _g ))
			{
				int i = _g1++;
				this.deleteConstraintSegment(shape.segments.__get(i));
			}
			
		}
		
		shape.dispose();
		this._constraintShapes.splice(this._constraintShapes.indexOf(shape, null), 1);
	}
	
	
	public   hxDaedalus.data.ConstraintSegment insertConstraintSegment(double x1, double y1, double x2, double y2)
	{
		int p1pos = this.findPositionFromBounds(x1, y1);
		int p2pos = this.findPositionFromBounds(x2, y2);
		double newX1 = x1;
		double newY1 = y1;
		double newX2 = x2;
		double newY2 = y2;
		if (( this._clipping && (( ( p1pos != 0 ) || ( p2pos != 0 ) )) )) 
		{
			hxDaedalus.data.math.Point2D intersectPoint = new hxDaedalus.data.math.Point2D(((java.lang.Object) (null) ), ((java.lang.Object) (null) ));
			if (( ( p1pos != 0 ) && ( p2pos != 0 ) )) 
			{
				if (( ( ( ( ( x1 <= 0 ) && ( x2 <= 0 ) ) || ( ( x1 >= this._width ) && ( x2 >= this._width ) ) ) || ( ( y1 <= 0 ) && ( y2 <= 0 ) ) ) || ( ( y1 >= this._height ) && ( y2 >= this._height ) ) )) 
				{
					return null;
				}
				
				if (( ( ( p1pos == 8 ) && ( p2pos == 4 ) ) || ( ( p1pos == 4 ) && ( p2pos == 8 ) ) )) 
				{
					hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), ((double) (0) ), ((double) (0) ), this._height, intersectPoint, null, null);
					newX1 = intersectPoint.x;
					newY1 = intersectPoint.y;
					hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, this._width, ((double) (0) ), this._width, this._height, intersectPoint, null, null);
					newX2 = intersectPoint.x;
					newY2 = intersectPoint.y;
				}
				 else 
				{
					if (( ( ( p1pos == 2 ) && ( p2pos == 6 ) ) || ( ( p1pos == 6 ) && ( p2pos == 2 ) ) )) 
					{
						hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), ((double) (0) ), this._width, ((double) (0) ), intersectPoint, null, null);
						newX1 = intersectPoint.x;
						newY1 = intersectPoint.y;
						hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), this._height, this._width, this._height, intersectPoint, null, null);
						newX2 = intersectPoint.x;
						newY2 = intersectPoint.y;
					}
					 else 
					{
						if (( ( ( p1pos == 2 ) && ( p2pos == 8 ) ) || ( ( p1pos == 8 ) && ( p2pos == 2 ) ) )) 
						{
							if (hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), ((double) (0) ), this._width, ((double) (0) ), intersectPoint, null, null)) 
							{
								newX1 = intersectPoint.x;
								newY1 = intersectPoint.y;
								hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), ((double) (0) ), ((double) (0) ), this._height, intersectPoint, null, null);
								newX2 = intersectPoint.x;
								newY2 = intersectPoint.y;
							}
							 else 
							{
								return null;
							}
							
						}
						 else 
						{
							if (( ( ( p1pos == 2 ) && ( p2pos == 4 ) ) || ( ( p1pos == 4 ) && ( p2pos == 2 ) ) )) 
							{
								if (hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), ((double) (0) ), this._width, ((double) (0) ), intersectPoint, null, null)) 
								{
									newX1 = intersectPoint.x;
									newY1 = intersectPoint.y;
									hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, this._width, ((double) (0) ), this._width, this._height, intersectPoint, null, null);
									newX2 = intersectPoint.x;
									newY2 = intersectPoint.y;
								}
								 else 
								{
									return null;
								}
								
							}
							 else 
							{
								if (( ( ( p1pos == 6 ) && ( p2pos == 4 ) ) || ( ( p1pos == 4 ) && ( p2pos == 6 ) ) )) 
								{
									if (hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), this._height, this._width, this._height, intersectPoint, null, null)) 
									{
										newX1 = intersectPoint.x;
										newY1 = intersectPoint.y;
										hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, this._width, ((double) (0) ), this._width, this._height, intersectPoint, null, null);
										newX2 = intersectPoint.x;
										newY2 = intersectPoint.y;
									}
									 else 
									{
										return null;
									}
									
								}
								 else 
								{
									if (( ( ( p1pos == 8 ) && ( p2pos == 6 ) ) || ( ( p1pos == 6 ) && ( p2pos == 8 ) ) )) 
									{
										if (hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), this._height, this._width, this._height, intersectPoint, null, null)) 
										{
											newX1 = intersectPoint.x;
											newY1 = intersectPoint.y;
											hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), ((double) (0) ), ((double) (0) ), this._height, intersectPoint, null, null);
											newX2 = intersectPoint.x;
											newY2 = intersectPoint.y;
										}
										 else 
										{
											return null;
										}
										
									}
									 else 
									{
										boolean firstDone = false;
										boolean secondDone = false;
										if (hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), ((double) (0) ), this._width, ((double) (0) ), intersectPoint, null, null)) 
										{
											newX1 = intersectPoint.x;
											newY1 = intersectPoint.y;
											firstDone = true;
										}
										
										if (hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, this._width, ((double) (0) ), this._width, this._height, intersectPoint, null, null)) 
										{
											if ( ! (firstDone) ) 
											{
												newX1 = intersectPoint.x;
												newY1 = intersectPoint.y;
												firstDone = true;
											}
											 else 
											{
												newX2 = intersectPoint.x;
												newY2 = intersectPoint.y;
												secondDone = true;
											}
											
										}
										
										if ((  ! (secondDone)  && hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), this._height, this._width, this._height, intersectPoint, null, null) )) 
										{
											if ( ! (firstDone) ) 
											{
												newX1 = intersectPoint.x;
												newY1 = intersectPoint.y;
												firstDone = true;
											}
											 else 
											{
												newX2 = intersectPoint.x;
												newY2 = intersectPoint.y;
												secondDone = true;
											}
											
										}
										
										if ((  ! (secondDone)  && hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), ((double) (0) ), ((double) (0) ), this._height, intersectPoint, null, null) )) 
										{
											newX2 = intersectPoint.x;
											newY2 = intersectPoint.y;
										}
										
										if ( ! (firstDone) ) 
										{
											return null;
										}
										
									}
									
								}
								
							}
							
						}
						
					}
					
				}
				
			}
			 else 
			{
				if (( ( p1pos == 2 ) || ( p2pos == 2 ) )) 
				{
					hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), ((double) (0) ), this._width, ((double) (0) ), intersectPoint, null, null);
				}
				 else 
				{
					if (( ( p1pos == 4 ) || ( p2pos == 4 ) )) 
					{
						hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, this._width, ((double) (0) ), this._width, this._height, intersectPoint, null, null);
					}
					 else 
					{
						if (( ( p1pos == 6 ) || ( p2pos == 6 ) )) 
						{
							hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), this._height, this._width, this._height, intersectPoint, null, null);
						}
						 else 
						{
							if (( ( p1pos == 8 ) || ( p2pos == 8 ) )) 
							{
								hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), ((double) (0) ), ((double) (0) ), this._height, intersectPoint, null, null);
							}
							 else 
							{
								if ( ! (hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), ((double) (0) ), this._width, ((double) (0) ), intersectPoint, null, null)) ) 
								{
									if ( ! (hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, this._width, ((double) (0) ), this._width, this._height, intersectPoint, null, null)) ) 
									{
										if ( ! (hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), this._height, this._width, this._height, intersectPoint, null, null)) ) 
										{
											hxDaedalus.data.math.Geom2D.intersections2segments(x1, y1, x2, y2, ((double) (0) ), ((double) (0) ), ((double) (0) ), this._height, intersectPoint, null, null);
										}
										
									}
									
								}
								
							}
							
						}
						
					}
					
				}
				
				if (( p1pos == 0 )) 
				{
					newX1 = x1;
					newY1 = y1;
				}
				 else 
				{
					newX1 = x2;
					newY1 = y2;
				}
				
				newX2 = intersectPoint.x;
				newY2 = intersectPoint.y;
			}
			
		}
		
		hxDaedalus.data.Vertex vertexDown = this.insertVertex(newX1, newY1);
		if (( vertexDown == null )) 
		{
			return null;
		}
		
		hxDaedalus.data.Vertex vertexUp = this.insertVertex(newX2, newY2);
		if (( vertexUp == null )) 
		{
			return null;
		}
		
		if (( vertexDown == vertexUp )) 
		{
			return null;
		}
		
		hxDaedalus.iterators.FromVertexToOutgoingEdges iterVertexToOutEdges = new hxDaedalus.iterators.FromVertexToOutgoingEdges();
		hxDaedalus.data.Vertex currVertex = null;
		hxDaedalus.data.Edge currEdge = null;
		int i = 0;
		hxDaedalus.data.ConstraintSegment segment = new hxDaedalus.data.ConstraintSegment();
		hxDaedalus.data.Edge tempEdgeDownUp = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge tempSdgeUpDown = new hxDaedalus.data.Edge();
		tempEdgeDownUp.setDatas(vertexDown, tempSdgeUpDown, null, null, true, true);
		tempSdgeUpDown.setDatas(vertexUp, tempEdgeDownUp, null, null, true, true);
		haxe.root.Array<hxDaedalus.data.Edge> intersectedEdges = new haxe.root.Array<hxDaedalus.data.Edge>();
		haxe.root.Array<hxDaedalus.data.Edge> leftBoundingEdges = new haxe.root.Array<hxDaedalus.data.Edge>();
		haxe.root.Array<hxDaedalus.data.Edge> rightBoundingEdges = new haxe.root.Array<hxDaedalus.data.Edge>();
		hxDaedalus.data.math.Intersection currObjet = null;
		hxDaedalus.data.math.Point2D pIntersect = new hxDaedalus.data.math.Point2D(((java.lang.Object) (null) ), ((java.lang.Object) (null) ));
		hxDaedalus.data.Edge edgeLeft = null;
		hxDaedalus.data.Edge newEdgeDownUp = null;
		hxDaedalus.data.Edge newEdgeUpDown = null;
		boolean done = false;
		currVertex = vertexDown;
		currObjet = hxDaedalus.data.math.Intersection.EVertex(currVertex);
		while (true)
		{
			done = false;
			switch (haxe.root.Type.enumIndex(currObjet))
			{
				case 0:
				{
					hxDaedalus.data.Vertex vertex = ((hxDaedalus.data.Vertex) (currObjet.params.__get(0)) );
					{
						currVertex = vertex;
						iterVertexToOutEdges.set_fromVertex(currVertex);
						while (( (currEdge = iterVertexToOutEdges.next()) != null ))
						{
							if (( currEdge.get_destinationVertex() == vertexUp )) 
							{
								if ( ! (currEdge.get_isConstrained()) ) 
								{
									currEdge.set_isConstrained(true);
									currEdge.get_oppositeEdge().set_isConstrained(true);
								}
								
								currEdge.addFromConstraintSegment(segment);
								currEdge.get_oppositeEdge().fromConstraintSegments = currEdge.fromConstraintSegments;
								vertexDown.addFromConstraintSegment(segment);
								vertexUp.addFromConstraintSegment(segment);
								segment.addEdge(currEdge);
								return segment;
							}
							
							if (( hxDaedalus.data.math.Geom2D.distanceSquaredVertexToEdge(currEdge.get_destinationVertex(), tempEdgeDownUp) <= 0.0001 )) 
							{
								if ( ! (currEdge.get_isConstrained()) ) 
								{
									currEdge.set_isConstrained(true);
									currEdge.get_oppositeEdge().set_isConstrained(true);
								}
								
								currEdge.addFromConstraintSegment(segment);
								currEdge.get_oppositeEdge().fromConstraintSegments = currEdge.fromConstraintSegments;
								vertexDown.addFromConstraintSegment(segment);
								segment.addEdge(currEdge);
								vertexDown = currEdge.get_destinationVertex();
								tempEdgeDownUp.set_originVertex(vertexDown);
								currObjet = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
								done = true;
								break;
							}
							
						}
						
						if (done) 
						{
							continue;
						}
						
						iterVertexToOutEdges.set_fromVertex(currVertex);
						while (( (currEdge = iterVertexToOutEdges.next()) != null ))
						{
							currEdge = currEdge.get_nextLeftEdge();
							if (hxDaedalus.data.math.Geom2D.intersections2edges(currEdge, tempEdgeDownUp, pIntersect, null, null)) 
							{
								if (currEdge.get_isConstrained()) 
								{
									vertexDown = this.splitEdge(currEdge, pIntersect.x, pIntersect.y);
									iterVertexToOutEdges.set_fromVertex(currVertex);
									while (( (currEdge = iterVertexToOutEdges.next()) != null ))
									{
										if (( currEdge.get_destinationVertex() == vertexDown )) 
										{
											currEdge.set_isConstrained(true);
											currEdge.get_oppositeEdge().set_isConstrained(true);
											currEdge.addFromConstraintSegment(segment);
											currEdge.get_oppositeEdge().fromConstraintSegments = currEdge.fromConstraintSegments;
											segment.addEdge(currEdge);
											break;
										}
										
									}
									
									currVertex.addFromConstraintSegment(segment);
									tempEdgeDownUp.set_originVertex(vertexDown);
									currObjet = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
								}
								 else 
								{
									intersectedEdges.push(currEdge);
									leftBoundingEdges.unshift(currEdge.get_nextLeftEdge());
									rightBoundingEdges.push(currEdge.get_prevLeftEdge());
									currEdge = currEdge.get_oppositeEdge();
									currObjet = hxDaedalus.data.math.Intersection.EEdge(currEdge);
								}
								
								break;
							}
							
						}
						
					}
					
					break;
				}
				
				
				case 1:
				{
					hxDaedalus.data.Edge edge = ((hxDaedalus.data.Edge) (currObjet.params.__get(0)) );
					{
						currEdge = edge;
						edgeLeft = currEdge.get_nextLeftEdge();
						if (( edgeLeft.get_destinationVertex() == vertexUp )) 
						{
							leftBoundingEdges.unshift(edgeLeft.get_nextLeftEdge());
							rightBoundingEdges.push(edgeLeft);
							newEdgeDownUp = new hxDaedalus.data.Edge();
							newEdgeUpDown = new hxDaedalus.data.Edge();
							newEdgeDownUp.setDatas(vertexDown, newEdgeUpDown, null, null, true, true);
							newEdgeUpDown.setDatas(vertexUp, newEdgeDownUp, null, null, true, true);
							leftBoundingEdges.push(newEdgeDownUp);
							rightBoundingEdges.push(newEdgeUpDown);
							this.insertNewConstrainedEdge(segment, newEdgeDownUp, intersectedEdges, leftBoundingEdges, rightBoundingEdges);
							return segment;
						}
						 else 
						{
							if (( hxDaedalus.data.math.Geom2D.distanceSquaredVertexToEdge(edgeLeft.get_destinationVertex(), tempEdgeDownUp) <= 0.0001 )) 
							{
								leftBoundingEdges.unshift(edgeLeft.get_nextLeftEdge());
								rightBoundingEdges.push(edgeLeft);
								newEdgeDownUp = new hxDaedalus.data.Edge();
								newEdgeUpDown = new hxDaedalus.data.Edge();
								newEdgeDownUp.setDatas(vertexDown, newEdgeUpDown, null, null, true, true);
								newEdgeUpDown.setDatas(edgeLeft.get_destinationVertex(), newEdgeDownUp, null, null, true, true);
								leftBoundingEdges.push(newEdgeDownUp);
								rightBoundingEdges.push(newEdgeUpDown);
								this.insertNewConstrainedEdge(segment, newEdgeDownUp, intersectedEdges, leftBoundingEdges, rightBoundingEdges);
								intersectedEdges.splice(0, intersectedEdges.length);
								leftBoundingEdges.splice(0, leftBoundingEdges.length);
								rightBoundingEdges.splice(0, rightBoundingEdges.length);
								vertexDown = edgeLeft.get_destinationVertex();
								tempEdgeDownUp.set_originVertex(vertexDown);
								currObjet = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
							}
							 else 
							{
								if (hxDaedalus.data.math.Geom2D.intersections2edges(edgeLeft, tempEdgeDownUp, pIntersect, null, null)) 
								{
									if (edgeLeft.get_isConstrained()) 
									{
										currVertex = this.splitEdge(edgeLeft, pIntersect.x, pIntersect.y);
										iterVertexToOutEdges.set_fromVertex(currVertex);
										while (( (currEdge = iterVertexToOutEdges.next()) != null ))
										{
											if (( currEdge.get_destinationVertex() == leftBoundingEdges.__get(0).get_originVertex() )) 
											{
												leftBoundingEdges.unshift(currEdge);
											}
											
											if (( currEdge.get_destinationVertex() == rightBoundingEdges.__get(( rightBoundingEdges.length - 1 )).get_destinationVertex() )) 
											{
												rightBoundingEdges.push(currEdge.get_oppositeEdge());
											}
											
										}
										
										newEdgeDownUp = new hxDaedalus.data.Edge();
										newEdgeUpDown = new hxDaedalus.data.Edge();
										newEdgeDownUp.setDatas(vertexDown, newEdgeUpDown, null, null, true, true);
										newEdgeUpDown.setDatas(currVertex, newEdgeDownUp, null, null, true, true);
										leftBoundingEdges.push(newEdgeDownUp);
										rightBoundingEdges.push(newEdgeUpDown);
										this.insertNewConstrainedEdge(segment, newEdgeDownUp, intersectedEdges, leftBoundingEdges, rightBoundingEdges);
										intersectedEdges.splice(0, intersectedEdges.length);
										leftBoundingEdges.splice(0, leftBoundingEdges.length);
										rightBoundingEdges.splice(0, rightBoundingEdges.length);
										vertexDown = currVertex;
										tempEdgeDownUp.set_originVertex(vertexDown);
										currObjet = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
									}
									 else 
									{
										intersectedEdges.push(edgeLeft);
										leftBoundingEdges.unshift(edgeLeft.get_nextLeftEdge());
										currEdge = edgeLeft.get_oppositeEdge();
										currObjet = hxDaedalus.data.math.Intersection.EEdge(currEdge);
									}
									
								}
								 else 
								{
									edgeLeft = edgeLeft.get_nextLeftEdge();
									hxDaedalus.data.math.Geom2D.intersections2edges(edgeLeft, tempEdgeDownUp, pIntersect, null, null);
									if (edgeLeft.get_isConstrained()) 
									{
										currVertex = this.splitEdge(edgeLeft, pIntersect.x, pIntersect.y);
										iterVertexToOutEdges.set_fromVertex(currVertex);
										while (( (currEdge = iterVertexToOutEdges.next()) != null ))
										{
											if (( currEdge.get_destinationVertex() == leftBoundingEdges.__get(0).get_originVertex() )) 
											{
												leftBoundingEdges.unshift(currEdge);
											}
											
											if (( currEdge.get_destinationVertex() == rightBoundingEdges.__get(( rightBoundingEdges.length - 1 )).get_destinationVertex() )) 
											{
												rightBoundingEdges.push(currEdge.get_oppositeEdge());
											}
											
										}
										
										newEdgeDownUp = new hxDaedalus.data.Edge();
										newEdgeUpDown = new hxDaedalus.data.Edge();
										newEdgeDownUp.setDatas(vertexDown, newEdgeUpDown, null, null, true, true);
										newEdgeUpDown.setDatas(currVertex, newEdgeDownUp, null, null, true, true);
										leftBoundingEdges.push(newEdgeDownUp);
										rightBoundingEdges.push(newEdgeUpDown);
										this.insertNewConstrainedEdge(segment, newEdgeDownUp, intersectedEdges, leftBoundingEdges, rightBoundingEdges);
										intersectedEdges.splice(0, intersectedEdges.length);
										leftBoundingEdges.splice(0, leftBoundingEdges.length);
										rightBoundingEdges.splice(0, rightBoundingEdges.length);
										vertexDown = currVertex;
										tempEdgeDownUp.set_originVertex(vertexDown);
										currObjet = hxDaedalus.data.math.Intersection.EVertex(vertexDown);
									}
									 else 
									{
										intersectedEdges.push(edgeLeft);
										rightBoundingEdges.push(edgeLeft.get_prevLeftEdge());
										currEdge = edgeLeft.get_oppositeEdge();
										currObjet = hxDaedalus.data.math.Intersection.EEdge(currEdge);
									}
									
								}
								
							}
							
						}
						
					}
					
					break;
				}
				
				
				case 2:
				{
					hxDaedalus.data.Face face = ((hxDaedalus.data.Face) (currObjet.params.__get(0)) );
					{
					}
					
					break;
				}
				
				
				case 3:
				{
					{
					}
					
					break;
				}
				
				
			}
			
		}
		
	}
	
	
	public   void insertNewConstrainedEdge(hxDaedalus.data.ConstraintSegment fromSegment, hxDaedalus.data.Edge edgeDownUp, haxe.root.Array<hxDaedalus.data.Edge> intersectedEdges, haxe.root.Array<hxDaedalus.data.Edge> leftBoundingEdges, haxe.root.Array<hxDaedalus.data.Edge> rightBoundingEdges)
	{
		this._edges.push(edgeDownUp);
		this._edges.push(edgeDownUp.get_oppositeEdge());
		edgeDownUp.addFromConstraintSegment(fromSegment);
		edgeDownUp.get_oppositeEdge().fromConstraintSegments = edgeDownUp.fromConstraintSegments;
		fromSegment.addEdge(edgeDownUp);
		edgeDownUp.get_originVertex().addFromConstraintSegment(fromSegment);
		edgeDownUp.get_destinationVertex().addFromConstraintSegment(fromSegment);
		this.untriangulate(intersectedEdges);
		this.triangulate(leftBoundingEdges, true);
		this.triangulate(rightBoundingEdges, true);
	}
	
	
	public   void deleteConstraintSegment(hxDaedalus.data.ConstraintSegment segment)
	{
		int i = 0;
		haxe.root.Array<hxDaedalus.data.Vertex> vertexToDelete = new haxe.root.Array<hxDaedalus.data.Vertex>();
		hxDaedalus.data.Edge edge = null;
		hxDaedalus.data.Vertex vertex = null;
		haxe.root.Array<hxDaedalus.data.ConstraintSegment> fromConstraintSegment = null;
		{
			int _g1 = 0;
			int _g = segment.get_edges().length;
			while (( _g1 < _g ))
			{
				int i1 = _g1++;
				edge = segment.get_edges().__get(i1);
				edge.removeFromConstraintSegment(segment);
				if (( edge.fromConstraintSegments.length == 0 )) 
				{
					edge.set_isConstrained(false);
					edge.get_oppositeEdge().set_isConstrained(false);
				}
				
				vertex = edge.get_originVertex();
				vertex.removeFromConstraintSegment(segment);
				vertexToDelete.push(vertex);
			}
			
		}
		
		vertex = edge.get_destinationVertex();
		vertex.removeFromConstraintSegment(segment);
		vertexToDelete.push(vertex);
		{
			int _g11 = 0;
			int _g2 = vertexToDelete.length;
			while (( _g11 < _g2 ))
			{
				int i2 = _g11++;
				this.deleteVertex(vertexToDelete.__get(i2));
			}
			
		}
		
		segment.dispose();
	}
	
	
	public   void check()
	{
		{
			int _g1 = 0;
			int _g = this._edges.length;
			while (( _g1 < _g ))
			{
				int i = _g1++;
				if (( this._edges.__get(i).get_nextLeftEdge() == null )) 
				{
					haxe.Log.trace.__hx_invoke2_o(0.0, "!!! missing nextLeftEdge", 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "check"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (794) )) )})));
					return ;
				}
				
			}
			
		}
		
		haxe.Log.trace.__hx_invoke2_o(0.0, "check OK", 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "check"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (798) )) )})));
	}
	
	
	public   hxDaedalus.data.Vertex insertVertex(double x, double y)
	{
		if (( ( ( ( x < 0 ) || ( y < 0 ) ) || ( x > this._width ) ) || ( y > this._height ) )) 
		{
			return null;
		}
		
		this.__edgesToCheck.splice(0, this.__edgesToCheck.length);
		hxDaedalus.data.math.Intersection inObject = hxDaedalus.data.math.Geom2D.locatePosition(x, y, this);
		hxDaedalus.data.Vertex newVertex = null;
		switch (haxe.root.Type.enumIndex(inObject))
		{
			case 0:
			{
				hxDaedalus.data.Vertex vertex = ((hxDaedalus.data.Vertex) (inObject.params.__get(0)) );
				newVertex = vertex;
				break;
			}
			
			
			case 1:
			{
				hxDaedalus.data.Edge edge = ((hxDaedalus.data.Edge) (inObject.params.__get(0)) );
				newVertex = this.splitEdge(edge, x, y);
				break;
			}
			
			
			case 2:
			{
				hxDaedalus.data.Face face = ((hxDaedalus.data.Face) (inObject.params.__get(0)) );
				newVertex = this.splitFace(face, x, y);
				break;
			}
			
			
			case 3:
			{
				{
				}
				
				break;
			}
			
			
		}
		
		this.restoreAsDelaunay();
		return newVertex;
	}
	
	
	public   hxDaedalus.data.Edge flipEdge(hxDaedalus.data.Edge edge)
	{
		hxDaedalus.data.Edge eBot_Top = edge;
		hxDaedalus.data.Edge eTop_Bot = edge.get_oppositeEdge();
		hxDaedalus.data.Edge eLeft_Right = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eRight_Left = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eTop_Left = eBot_Top.get_nextLeftEdge();
		hxDaedalus.data.Edge eLeft_Bot = eTop_Left.get_nextLeftEdge();
		hxDaedalus.data.Edge eBot_Right = eTop_Bot.get_nextLeftEdge();
		hxDaedalus.data.Edge eRight_Top = eBot_Right.get_nextLeftEdge();
		hxDaedalus.data.Vertex vBot = eBot_Top.get_originVertex();
		hxDaedalus.data.Vertex vTop = eTop_Bot.get_originVertex();
		hxDaedalus.data.Vertex vLeft = eLeft_Bot.get_originVertex();
		hxDaedalus.data.Vertex vRight = eRight_Top.get_originVertex();
		hxDaedalus.data.Face fLeft = eBot_Top.get_leftFace();
		hxDaedalus.data.Face fRight = eTop_Bot.get_leftFace();
		hxDaedalus.data.Face fBot = new hxDaedalus.data.Face();
		hxDaedalus.data.Face fTop = new hxDaedalus.data.Face();
		this._edges.push(eLeft_Right);
		this._edges.push(eRight_Left);
		this._faces.push(fTop);
		this._faces.push(fBot);
		eLeft_Right.setDatas(vLeft, eRight_Left, eRight_Top, fTop, edge.get_isReal(), edge.get_isConstrained());
		eRight_Left.setDatas(vRight, eLeft_Right, eLeft_Bot, fBot, edge.get_isReal(), edge.get_isConstrained());
		fTop.setDatas(eLeft_Right, null);
		fBot.setDatas(eRight_Left, null);
		if (( vTop.get_edge() == eTop_Bot )) 
		{
			vTop.setDatas(eTop_Left, null);
		}
		
		if (( vBot.get_edge() == eBot_Top )) 
		{
			vBot.setDatas(eBot_Right, null);
		}
		
		eTop_Left.set_nextLeftEdge(eLeft_Right);
		eTop_Left.set_leftFace(fTop);
		eLeft_Bot.set_nextLeftEdge(eBot_Right);
		eLeft_Bot.set_leftFace(fBot);
		eBot_Right.set_nextLeftEdge(eRight_Left);
		eBot_Right.set_leftFace(fBot);
		eRight_Top.set_nextLeftEdge(eTop_Left);
		eRight_Top.set_leftFace(fTop);
		eBot_Top.dispose();
		eTop_Bot.dispose();
		this._edges.splice(this._edges.indexOf(eBot_Top, null), 1);
		this._edges.splice(this._edges.indexOf(eTop_Bot, null), 1);
		fLeft.dispose();
		fRight.dispose();
		this._faces.splice(this._faces.indexOf(fLeft, null), 1);
		this._faces.splice(this._faces.indexOf(fRight, null), 1);
		return eRight_Left;
	}
	
	
	public   hxDaedalus.data.Vertex splitEdge(hxDaedalus.data.Edge edge, double x, double y)
	{
		this.__edgesToCheck.splice(0, this.__edgesToCheck.length);
		hxDaedalus.data.Edge eLeft_Right = edge;
		hxDaedalus.data.Edge eRight_Left = eLeft_Right.get_oppositeEdge();
		hxDaedalus.data.Edge eRight_Top = eLeft_Right.get_nextLeftEdge();
		hxDaedalus.data.Edge eTop_Left = eRight_Top.get_nextLeftEdge();
		hxDaedalus.data.Edge eLeft_Bot = eRight_Left.get_nextLeftEdge();
		hxDaedalus.data.Edge eBot_Right = eLeft_Bot.get_nextLeftEdge();
		hxDaedalus.data.Vertex vTop = eTop_Left.get_originVertex();
		hxDaedalus.data.Vertex vLeft = eLeft_Right.get_originVertex();
		hxDaedalus.data.Vertex vBot = eBot_Right.get_originVertex();
		hxDaedalus.data.Vertex vRight = eRight_Left.get_originVertex();
		hxDaedalus.data.Face fTop = eLeft_Right.get_leftFace();
		hxDaedalus.data.Face fBot = eRight_Left.get_leftFace();
		if (( ( ( (( vLeft.get_pos().x - x )) * (( vLeft.get_pos().x - x )) ) + ( (( vLeft.get_pos().y - y )) * (( vLeft.get_pos().y - y )) ) ) <= 0.0001 )) 
		{
			return vLeft;
		}
		
		if (( ( ( (( vRight.get_pos().x - x )) * (( vRight.get_pos().x - x )) ) + ( (( vRight.get_pos().y - y )) * (( vRight.get_pos().y - y )) ) ) <= 0.0001 )) 
		{
			return vRight;
		}
		
		hxDaedalus.data.Vertex vCenter = new hxDaedalus.data.Vertex();
		hxDaedalus.data.Edge eTop_Center = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eCenter_Top = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eBot_Center = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eCenter_Bot = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eLeft_Center = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eCenter_Left = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eRight_Center = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eCenter_Right = new hxDaedalus.data.Edge();
		hxDaedalus.data.Face fTopLeft = new hxDaedalus.data.Face();
		hxDaedalus.data.Face fBotLeft = new hxDaedalus.data.Face();
		hxDaedalus.data.Face fBotRight = new hxDaedalus.data.Face();
		hxDaedalus.data.Face fTopRight = new hxDaedalus.data.Face();
		this._vertices.push(vCenter);
		this._edges.push(eCenter_Top);
		this._edges.push(eTop_Center);
		this._edges.push(eCenter_Left);
		this._edges.push(eLeft_Center);
		this._edges.push(eCenter_Bot);
		this._edges.push(eBot_Center);
		this._edges.push(eCenter_Right);
		this._edges.push(eRight_Center);
		this._faces.push(fTopRight);
		this._faces.push(fBotRight);
		this._faces.push(fBotLeft);
		this._faces.push(fTopLeft);
		vCenter.setDatas(( (fTop.get_isReal()) ? (eCenter_Top) : (eCenter_Bot) ), null);
		vCenter.get_pos().x = x;
		vCenter.get_pos().y = y;
		hxDaedalus.data.math.Geom2D.projectOrthogonaly(vCenter.get_pos(), eLeft_Right);
		eCenter_Top.setDatas(vCenter, eTop_Center, eTop_Left, fTopLeft, fTop.get_isReal(), null);
		eTop_Center.setDatas(vTop, eCenter_Top, eCenter_Right, fTopRight, fTop.get_isReal(), null);
		eCenter_Left.setDatas(vCenter, eLeft_Center, eLeft_Bot, fBotLeft, edge.get_isReal(), edge.get_isConstrained());
		eLeft_Center.setDatas(vLeft, eCenter_Left, eCenter_Top, fTopLeft, edge.get_isReal(), edge.get_isConstrained());
		eCenter_Bot.setDatas(vCenter, eBot_Center, eBot_Right, fBotRight, fBot.get_isReal(), null);
		eBot_Center.setDatas(vBot, eCenter_Bot, eCenter_Left, fBotLeft, fBot.get_isReal(), null);
		eCenter_Right.setDatas(vCenter, eRight_Center, eRight_Top, fTopRight, edge.get_isReal(), edge.get_isConstrained());
		eRight_Center.setDatas(vRight, eCenter_Right, eCenter_Bot, fBotRight, edge.get_isReal(), edge.get_isConstrained());
		fTopLeft.setDatas(eCenter_Top, fTop.get_isReal());
		fBotLeft.setDatas(eCenter_Left, fBot.get_isReal());
		fBotRight.setDatas(eCenter_Bot, fBot.get_isReal());
		fTopRight.setDatas(eCenter_Right, fTop.get_isReal());
		if (( vLeft.get_edge() == eLeft_Right )) 
		{
			vLeft.setDatas(eLeft_Center, null);
		}
		
		if (( vRight.get_edge() == eRight_Left )) 
		{
			vRight.setDatas(eRight_Center, null);
		}
		
		eTop_Left.set_nextLeftEdge(eLeft_Center);
		eTop_Left.set_leftFace(fTopLeft);
		eLeft_Bot.set_nextLeftEdge(eBot_Center);
		eLeft_Bot.set_leftFace(fBotLeft);
		eBot_Right.set_nextLeftEdge(eRight_Center);
		eBot_Right.set_leftFace(fBotRight);
		eRight_Top.set_nextLeftEdge(eTop_Center);
		eRight_Top.set_leftFace(fTopRight);
		if (eLeft_Right.get_isConstrained()) 
		{
			haxe.root.Array<hxDaedalus.data.ConstraintSegment> fromSegments = eLeft_Right.fromConstraintSegments;
			eLeft_Center.fromConstraintSegments = fromSegments.slice(0, null);
			eCenter_Left.fromConstraintSegments = eLeft_Center.fromConstraintSegments;
			eCenter_Right.fromConstraintSegments = fromSegments.slice(0, null);
			eRight_Center.fromConstraintSegments = eCenter_Right.fromConstraintSegments;
			haxe.root.Array<hxDaedalus.data.Edge> edges = null;
			int index = 0;
			{
				int _g1 = 0;
				int _g = eLeft_Right.fromConstraintSegments.length;
				while (( _g1 < _g ))
				{
					int i = _g1++;
					edges = eLeft_Right.fromConstraintSegments.__get(i).get_edges();
					index = edges.indexOf(eLeft_Right, null);
					if (( index != -1 )) 
					{
						edges.splice(index, 1);
						edges.insert(index, eLeft_Center);
						edges.insert(( index + 1 ), eCenter_Right);
					}
					 else 
					{
						int index2 = edges.indexOf(eRight_Left, null);
						edges.splice(index2, 1);
						edges.insert(index2, eRight_Center);
						edges.insert(index2, eCenter_Left);
					}
					
				}
				
			}
			
			vCenter.set_fromConstraintSegments(fromSegments.slice(0, null));
		}
		
		eLeft_Right.dispose();
		eRight_Left.dispose();
		this._edges.splice(this._edges.indexOf(eLeft_Right, null), 1);
		this._edges.splice(this._edges.indexOf(eRight_Left, null), 1);
		fTop.dispose();
		fBot.dispose();
		this._faces.splice(this._faces.indexOf(fTop, null), 1);
		this._faces.splice(this._faces.indexOf(fBot, null), 1);
		this.__centerVertex = vCenter;
		this.__edgesToCheck.push(eTop_Left);
		this.__edgesToCheck.push(eLeft_Bot);
		this.__edgesToCheck.push(eBot_Right);
		this.__edgesToCheck.push(eRight_Top);
		return vCenter;
	}
	
	
	public   hxDaedalus.data.Vertex splitFace(hxDaedalus.data.Face face, double x, double y)
	{
		this.__edgesToCheck.splice(0, this.__edgesToCheck.length);
		hxDaedalus.data.Edge eTop_Left = face.get_edge();
		hxDaedalus.data.Edge eLeft_Right = eTop_Left.get_nextLeftEdge();
		hxDaedalus.data.Edge eRight_Top = eLeft_Right.get_nextLeftEdge();
		hxDaedalus.data.Vertex vTop = eTop_Left.get_originVertex();
		hxDaedalus.data.Vertex vLeft = eLeft_Right.get_originVertex();
		hxDaedalus.data.Vertex vRight = eRight_Top.get_originVertex();
		hxDaedalus.data.Vertex vCenter = new hxDaedalus.data.Vertex();
		hxDaedalus.data.Edge eTop_Center = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eCenter_Top = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eLeft_Center = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eCenter_Left = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eRight_Center = new hxDaedalus.data.Edge();
		hxDaedalus.data.Edge eCenter_Right = new hxDaedalus.data.Edge();
		hxDaedalus.data.Face fTopLeft = new hxDaedalus.data.Face();
		hxDaedalus.data.Face fBot = new hxDaedalus.data.Face();
		hxDaedalus.data.Face fTopRight = new hxDaedalus.data.Face();
		this._vertices.push(vCenter);
		this._edges.push(eTop_Center);
		this._edges.push(eCenter_Top);
		this._edges.push(eLeft_Center);
		this._edges.push(eCenter_Left);
		this._edges.push(eRight_Center);
		this._edges.push(eCenter_Right);
		this._faces.push(fTopLeft);
		this._faces.push(fBot);
		this._faces.push(fTopRight);
		vCenter.setDatas(eCenter_Top, null);
		vCenter.get_pos().x = x;
		vCenter.get_pos().y = y;
		eTop_Center.setDatas(vTop, eCenter_Top, eCenter_Right, fTopRight, null, null);
		eCenter_Top.setDatas(vCenter, eTop_Center, eTop_Left, fTopLeft, null, null);
		eLeft_Center.setDatas(vLeft, eCenter_Left, eCenter_Top, fTopLeft, null, null);
		eCenter_Left.setDatas(vCenter, eLeft_Center, eLeft_Right, fBot, null, null);
		eRight_Center.setDatas(vRight, eCenter_Right, eCenter_Left, fBot, null, null);
		eCenter_Right.setDatas(vCenter, eRight_Center, eRight_Top, fTopRight, null, null);
		fTopLeft.setDatas(eCenter_Top, null);
		fBot.setDatas(eCenter_Left, null);
		fTopRight.setDatas(eCenter_Right, null);
		eTop_Left.set_nextLeftEdge(eLeft_Center);
		eTop_Left.set_leftFace(fTopLeft);
		eLeft_Right.set_nextLeftEdge(eRight_Center);
		eLeft_Right.set_leftFace(fBot);
		eRight_Top.set_nextLeftEdge(eTop_Center);
		eRight_Top.set_leftFace(fTopRight);
		face.dispose();
		this._faces.splice(this._faces.indexOf(face, null), 1);
		this.__centerVertex = vCenter;
		this.__edgesToCheck.push(eTop_Left);
		this.__edgesToCheck.push(eLeft_Right);
		this.__edgesToCheck.push(eRight_Top);
		return vCenter;
	}
	
	
	public   void restoreAsDelaunay()
	{
		hxDaedalus.data.Edge edge = null;
		while (( this.__edgesToCheck.length > 0 ))
		{
			edge = this.__edgesToCheck.shift();
			if (( ( edge.get_isReal() &&  ! (edge.get_isConstrained())  ) &&  ! (hxDaedalus.data.math.Geom2D.isDelaunay(edge))  )) 
			{
				if (( edge.get_nextLeftEdge().get_destinationVertex() == this.__centerVertex )) 
				{
					this.__edgesToCheck.push(edge.get_nextRightEdge());
					this.__edgesToCheck.push(edge.get_prevRightEdge());
				}
				 else 
				{
					this.__edgesToCheck.push(edge.get_nextLeftEdge());
					this.__edgesToCheck.push(edge.get_prevLeftEdge());
				}
				
				this.flipEdge(edge);
			}
			
		}
		
	}
	
	
	public   boolean deleteVertex(hxDaedalus.data.Vertex vertex)
	{
		int i = 0;
		boolean freeOfConstraint = false;
		hxDaedalus.iterators.FromVertexToOutgoingEdges iterEdges = new hxDaedalus.iterators.FromVertexToOutgoingEdges();
		iterEdges.set_fromVertex(vertex);
		iterEdges.realEdgesOnly = false;
		hxDaedalus.data.Edge edge = null;
		haxe.root.Array<hxDaedalus.data.Edge> outgoingEdges = new haxe.root.Array<hxDaedalus.data.Edge>();
		freeOfConstraint = ( vertex.get_fromConstraintSegments().length == 0 );
		haxe.root.Array<hxDaedalus.data.Edge> bound = new haxe.root.Array<hxDaedalus.data.Edge>();
		boolean realA = false;
		boolean realB = false;
		haxe.root.Array<hxDaedalus.data.Edge> boundA = new haxe.root.Array<hxDaedalus.data.Edge>(new hxDaedalus.data.Edge[]{});
		haxe.root.Array<hxDaedalus.data.Edge> boundB = new haxe.root.Array<hxDaedalus.data.Edge>(new hxDaedalus.data.Edge[]{});
		if (freeOfConstraint) 
		{
			while (( (edge = iterEdges.next()) != null ))
			{
				outgoingEdges.push(edge);
				bound.push(edge.get_nextLeftEdge());
			}
			
		}
		 else 
		{
			haxe.root.Array<hxDaedalus.data.Edge> edges = null;
			{
				int _g1 = 0;
				int _g = vertex.get_fromConstraintSegments().length;
				while (( _g1 < _g ))
				{
					int i1 = _g1++;
					edges = vertex.get_fromConstraintSegments().__get(i1).get_edges();
					if (( ( edges.__get(0).get_originVertex() == vertex ) || ( edges.__get(( edges.length - 1 )).get_destinationVertex() == vertex ) )) 
					{
						return false;
					}
					
				}
				
			}
			
			int count = 0;
			while (( (edge = iterEdges.next()) != null ))
			{
				outgoingEdges.push(edge);
				if (edge.get_isConstrained()) 
				{
					count++;
					if (( count > 2 )) 
					{
						return false;
					}
					
				}
				
			}
			
			boundA = new haxe.root.Array<hxDaedalus.data.Edge>();
			boundB = new haxe.root.Array<hxDaedalus.data.Edge>();
			hxDaedalus.data.Edge constrainedEdgeA = null;
			hxDaedalus.data.Edge constrainedEdgeB = null;
			hxDaedalus.data.Edge edgeA = new hxDaedalus.data.Edge();
			hxDaedalus.data.Edge edgeB = new hxDaedalus.data.Edge();
			this._edges.push(edgeA);
			this._edges.push(edgeB);
			{
				int _g11 = 0;
				int _g2 = outgoingEdges.length;
				while (( _g11 < _g2 ))
				{
					int i2 = _g11++;
					edge = outgoingEdges.__get(i2);
					if (edge.get_isConstrained()) 
					{
						if (( constrainedEdgeA == null )) 
						{
							edgeB.setDatas(edge.get_destinationVertex(), edgeA, null, null, true, true);
							boundA.push(edgeA);
							boundA.push(edge.get_nextLeftEdge());
							boundB.push(edgeB);
							constrainedEdgeA = edge;
						}
						 else 
						{
							if (( constrainedEdgeB == null )) 
							{
								edgeA.setDatas(edge.get_destinationVertex(), edgeB, null, null, true, true);
								boundB.push(edge.get_nextLeftEdge());
								constrainedEdgeB = edge;
							}
							
						}
						
					}
					 else 
					{
						if (( constrainedEdgeA == null )) 
						{
							boundB.push(edge.get_nextLeftEdge());
						}
						 else 
						{
							if (( constrainedEdgeB == null )) 
							{
								boundA.push(edge.get_nextLeftEdge());
							}
							 else 
							{
								boundB.push(edge.get_nextLeftEdge());
							}
							
						}
						
					}
					
				}
				
			}
			
			realA = constrainedEdgeA.get_leftFace().get_isReal();
			realB = constrainedEdgeB.get_leftFace().get_isReal();
			edgeA.fromConstraintSegments = constrainedEdgeA.fromConstraintSegments.slice(0, null);
			edgeB.fromConstraintSegments = edgeA.fromConstraintSegments;
			int index = 0;
			{
				int _g12 = 0;
				int _g3 = vertex.get_fromConstraintSegments().length;
				while (( _g12 < _g3 ))
				{
					int i3 = _g12++;
					edges = vertex.get_fromConstraintSegments().__get(i3).get_edges();
					index = edges.indexOf(constrainedEdgeA, null);
					if (( index != -1 )) 
					{
						edges.splice(( index - 1 ), 2);
						edges.insert(( index - 1 ), edgeA);
					}
					 else 
					{
						int index2 = ( edges.indexOf(constrainedEdgeB, null) - 1 );
						edges.splice(index2, 2);
						edges.insert(index2, edgeB);
					}
					
				}
				
			}
			
		}
		
		hxDaedalus.data.Face faceToDelete = null;
		{
			int _g13 = 0;
			int _g4 = outgoingEdges.length;
			while (( _g13 < _g4 ))
			{
				int i4 = _g13++;
				edge = outgoingEdges.__get(i4);
				faceToDelete = edge.get_leftFace();
				this._faces.splice(this._faces.indexOf(faceToDelete, null), 1);
				faceToDelete.dispose();
				edge.get_destinationVertex().set_edge(edge.get_nextLeftEdge());
				this._edges.splice(this._edges.indexOf(edge.get_oppositeEdge(), null), 1);
				edge.get_oppositeEdge().dispose();
				this._edges.splice(this._edges.indexOf(edge, null), 1);
				edge.dispose();
			}
			
		}
		
		this._vertices.splice(this._vertices.indexOf(vertex, null), 1);
		vertex.dispose();
		if (freeOfConstraint) 
		{
			this.triangulate(bound, true);
		}
		 else 
		{
			this.triangulate(boundA, realA);
			this.triangulate(boundB, realB);
		}
		
		return true;
	}
	
	
	public   void untriangulate(haxe.root.Array<hxDaedalus.data.Edge> edgesList)
	{
		int i = 0;
		haxe.ds.ObjectMap<hxDaedalus.data.Vertex, java.lang.Object> verticesCleaned = new haxe.ds.ObjectMap<hxDaedalus.data.Vertex, java.lang.Object>();
		hxDaedalus.data.Edge currEdge = null;
		hxDaedalus.data.Edge outEdge = null;
		{
			int _g1 = 0;
			int _g = edgesList.length;
			while (( _g1 < _g ))
			{
				int i1 = _g1++;
				currEdge = edgesList.__get(i1);
				java.lang.Object __temp_stmt132 = null;
				{
					hxDaedalus.data.Vertex key = currEdge.get_originVertex();
					__temp_stmt132 = verticesCleaned.get(key);
				}
				
				if (( __temp_stmt132 == null )) 
				{
					currEdge.get_originVertex().set_edge(currEdge.get_prevLeftEdge().get_oppositeEdge());
					{
						hxDaedalus.data.Vertex k = currEdge.get_originVertex();
						verticesCleaned.set(k, true);
						boolean __temp_expr133 = true;
					}
					
				}
				
				java.lang.Object __temp_stmt134 = null;
				{
					hxDaedalus.data.Vertex key1 = currEdge.get_destinationVertex();
					__temp_stmt134 = verticesCleaned.get(key1);
				}
				
				if (( __temp_stmt134 == null )) 
				{
					currEdge.get_destinationVertex().set_edge(currEdge.get_nextLeftEdge());
					{
						hxDaedalus.data.Vertex k1 = currEdge.get_destinationVertex();
						verticesCleaned.set(k1, true);
						boolean __temp_expr135 = true;
					}
					
				}
				
				this._faces.splice(this._faces.indexOf(currEdge.get_leftFace(), null), 1);
				currEdge.get_leftFace().dispose();
				if (( i1 == ( edgesList.length - 1 ) )) 
				{
					this._faces.splice(this._faces.indexOf(currEdge.get_rightFace(), null), 1);
					currEdge.get_rightFace().dispose();
				}
				
			}
			
		}
		
		{
			int _g11 = 0;
			int _g2 = edgesList.length;
			while (( _g11 < _g2 ))
			{
				int i2 = _g11++;
				currEdge = edgesList.__get(i2);
				this._edges.splice(this._edges.indexOf(currEdge.get_oppositeEdge(), null), 1);
				this._edges.splice(this._edges.indexOf(currEdge, null), 1);
				currEdge.get_oppositeEdge().dispose();
				currEdge.dispose();
			}
			
		}
		
	}
	
	
	public   void triangulate(haxe.root.Array<hxDaedalus.data.Edge> bound, boolean isReal)
	{
		if (( bound.length < 2 )) 
		{
			haxe.Log.trace.__hx_invoke2_o(0.0, "BREAK ! the hole has less than 2 edges", 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "triangulate"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (1396) )) )})));
			return ;
		}
		 else 
		{
			if (( bound.length == 2 )) 
			{
				haxe.Log.trace.__hx_invoke2_o(0.0, "BREAK ! the hole has only 2 edges", 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "triangulate"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (1403) )) )})));
				{
					java.lang.Object value = ( ( ( "  - edge0: " + bound.__get(0).get_originVertex().get_id() ) + " -> " ) + bound.__get(0).get_destinationVertex().get_id() );
					haxe.Log.trace.__hx_invoke2_o(0.0, value, 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "triangulate"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (1404) )) )})));
				}
				
				{
					java.lang.Object value1 = ( ( ( "  - edge1: " + bound.__get(1).get_originVertex().get_id() ) + " -> " ) + bound.__get(1).get_destinationVertex().get_id() );
					haxe.Log.trace.__hx_invoke2_o(0.0, value1, 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "triangulate"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (1405) )) )})));
				}
				
				return ;
			}
			 else 
			{
				if (( bound.length == 3 )) 
				{
					hxDaedalus.data.Face f = new hxDaedalus.data.Face();
					f.setDatas(bound.__get(0), isReal);
					this._faces.push(f);
					bound.__get(0).set_leftFace(f);
					bound.__get(1).set_leftFace(f);
					bound.__get(2).set_leftFace(f);
					bound.__get(0).set_nextLeftEdge(bound.__get(1));
					bound.__get(1).set_nextLeftEdge(bound.__get(2));
					bound.__get(2).set_nextLeftEdge(bound.__get(0));
				}
				 else 
				{
					hxDaedalus.data.Edge baseEdge = bound.__get(0);
					hxDaedalus.data.Vertex vertexA = baseEdge.get_originVertex();
					hxDaedalus.data.Vertex vertexB = baseEdge.get_destinationVertex();
					hxDaedalus.data.Vertex vertexC = null;
					hxDaedalus.data.Vertex vertexCheck = null;
					hxDaedalus.data.math.Point2D circumcenter = new hxDaedalus.data.math.Point2D(((java.lang.Object) (null) ), ((java.lang.Object) (null) ));
					double radiusSquared = 0.0;
					double distanceSquared = 0.0;
					boolean isDelaunay = false;
					int index = 0;
					int i = 0;
					{
						int _g1 = 2;
						int _g = bound.length;
						while (( _g1 < _g ))
						{
							int i1 = _g1++;
							vertexC = bound.__get(i1).get_originVertex();
							if (( hxDaedalus.data.math.Geom2D.getRelativePosition2(vertexC.get_pos().x, vertexC.get_pos().y, baseEdge) == 1 )) 
							{
								index = i1;
								isDelaunay = true;
								hxDaedalus.data.math.Geom2D.getCircumcenter(vertexA.get_pos().x, vertexA.get_pos().y, vertexB.get_pos().x, vertexB.get_pos().y, vertexC.get_pos().x, vertexC.get_pos().y, circumcenter);
								radiusSquared = ( ( (( vertexA.get_pos().x - circumcenter.x )) * (( vertexA.get_pos().x - circumcenter.x )) ) + ( (( vertexA.get_pos().y - circumcenter.y )) * (( vertexA.get_pos().y - circumcenter.y )) ) );
								radiusSquared -= 0.0001;
								{
									int _g3 = 2;
									int _g2 = bound.length;
									while (( _g3 < _g2 ))
									{
										int j = _g3++;
										if (( j != i1 )) 
										{
											vertexCheck = bound.__get(j).get_originVertex();
											distanceSquared = ( ( (( vertexCheck.get_pos().x - circumcenter.x )) * (( vertexCheck.get_pos().x - circumcenter.x )) ) + ( (( vertexCheck.get_pos().y - circumcenter.y )) * (( vertexCheck.get_pos().y - circumcenter.y )) ) );
											if (( distanceSquared < radiusSquared )) 
											{
												isDelaunay = false;
												break;
											}
											
										}
										
									}
									
								}
								
								if (isDelaunay) 
								{
									break;
								}
								
							}
							
						}
						
					}
					
					if ( ! (isDelaunay) ) 
					{
						haxe.Log.trace.__hx_invoke2_o(0.0, "NO DELAUNAY FOUND", 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "triangulate"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (1476) )) )})));
						java.lang.String s = "";
						{
							int _g11 = 0;
							int _g4 = bound.length;
							while (( _g11 < _g4 ))
							{
								int i2 = _g11++;
								s += ( haxe.lang.Runtime.toString(bound.__get(i2).get_originVertex().get_pos().x) + " , " );
								s += ( haxe.lang.Runtime.toString(bound.__get(i2).get_originVertex().get_pos().y) + " , " );
								s += ( haxe.lang.Runtime.toString(bound.__get(i2).get_destinationVertex().get_pos().x) + " , " );
								s += ( haxe.lang.Runtime.toString(bound.__get(i2).get_destinationVertex().get_pos().y) + " , " );
							}
							
						}
						
						index = 2;
					}
					
					hxDaedalus.data.Edge edgeA = null;
					hxDaedalus.data.Edge edgeAopp = null;
					hxDaedalus.data.Edge edgeB = null;
					hxDaedalus.data.Edge edgeBopp = null;
					haxe.root.Array<hxDaedalus.data.Edge> boundA = null;
					haxe.root.Array<hxDaedalus.data.Edge> boundM = null;
					haxe.root.Array<hxDaedalus.data.Edge> boundB = null;
					if (( index < ( bound.length - 1 ) )) 
					{
						edgeA = new hxDaedalus.data.Edge();
						edgeAopp = new hxDaedalus.data.Edge();
						this._edges.push(edgeA);
						this._edges.push(edgeAopp);
						edgeA.setDatas(vertexA, edgeAopp, null, null, isReal, false);
						edgeAopp.setDatas(bound.__get(index).get_originVertex(), edgeA, null, null, isReal, false);
						boundA = bound.slice(index, null);
						boundA.push(edgeA);
						this.triangulate(boundA, isReal);
					}
					
					if (( index > 2 )) 
					{
						edgeB = new hxDaedalus.data.Edge();
						edgeBopp = new hxDaedalus.data.Edge();
						this._edges.push(edgeB);
						this._edges.push(edgeBopp);
						edgeB.setDatas(bound.__get(1).get_originVertex(), edgeBopp, null, null, isReal, false);
						edgeBopp.setDatas(bound.__get(index).get_originVertex(), edgeB, null, null, isReal, false);
						boundB = bound.slice(1, index);
						boundB.push(edgeBopp);
						this.triangulate(boundB, isReal);
					}
					
					if (( index == 2 )) 
					{
						boundM = new haxe.root.Array<hxDaedalus.data.Edge>(new hxDaedalus.data.Edge[]{baseEdge, bound.__get(1), edgeAopp});
					}
					 else 
					{
						if (( index == ( bound.length - 1 ) )) 
						{
							boundM = new haxe.root.Array<hxDaedalus.data.Edge>(new hxDaedalus.data.Edge[]{baseEdge, edgeB, bound.__get(index)});
						}
						 else 
						{
							boundM = new haxe.root.Array<hxDaedalus.data.Edge>(new hxDaedalus.data.Edge[]{baseEdge, edgeB, edgeAopp});
						}
						
					}
					
					this.triangulate(boundM, isReal);
				}
				
			}
			
		}
		
	}
	
	
	public   int findPositionFromBounds(double x, double y)
	{
		if (( x <= 0 )) 
		{
			if (( y <= 0 )) 
			{
				return 1;
			}
			 else 
			{
				if (( y >= this._height )) 
				{
					return 7;
				}
				 else 
				{
					return 8;
				}
				
			}
			
		}
		 else 
		{
			if (( x >= this._width )) 
			{
				if (( y <= 0 )) 
				{
					return 3;
				}
				 else 
				{
					if (( y >= this._height )) 
					{
						return 5;
					}
					 else 
					{
						return 4;
					}
					
				}
				
			}
			 else 
			{
				if (( y <= 0 )) 
				{
					return 2;
				}
				 else 
				{
					if (( y >= this._height )) 
					{
						return 6;
					}
					 else 
					{
						return 0;
					}
					
				}
				
			}
			
		}
		
	}
	
	
	public   void debug()
	{
		int i = 0;
		{
			int _g1 = 0;
			int _g = this._vertices.length;
			while (( _g1 < _g ))
			{
				int i1 = _g1++;
				{
					java.lang.Object value = ( "-- vertex " + this._vertices.__get(i1).get_id() );
					haxe.Log.trace.__hx_invoke2_o(0.0, value, 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "debug"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (1568) )) )})));
				}
				
				{
					java.lang.Object value1 = ( ( ( "  edge " + this._vertices.__get(i1).get_edge().get_id() ) + " - " ) + haxe.root.Std.string(this._vertices.__get(i1).get_edge()) );
					haxe.Log.trace.__hx_invoke2_o(0.0, value1, 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "debug"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (1569) )) )})));
				}
				
				{
					java.lang.Object value2 = ( "  edge isReal: " + haxe.root.Std.string(this._vertices.__get(i1).get_edge().get_isReal()) );
					haxe.Log.trace.__hx_invoke2_o(0.0, value2, 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "debug"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (1570) )) )})));
				}
				
			}
			
		}
		
		{
			int _g11 = 0;
			int _g2 = this._edges.length;
			while (( _g11 < _g2 ))
			{
				int i2 = _g11++;
				{
					java.lang.Object value3 = ( "-- edge " + haxe.root.Std.string(this._edges.__get(i2)) );
					haxe.Log.trace.__hx_invoke2_o(0.0, value3, 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "debug"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (1573) )) )})));
				}
				
				{
					java.lang.Object value4 = ( ( ( "  isReal " + this._edges.__get(i2).get_id() ) + " - " ) + haxe.root.Std.string(this._edges.__get(i2).get_isReal()) );
					haxe.Log.trace.__hx_invoke2_o(0.0, value4, 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "debug"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (1574) )) )})));
				}
				
				{
					java.lang.Object value5 = ( "  nextLeftEdge " + haxe.root.Std.string(this._edges.__get(i2).get_nextLeftEdge()) );
					haxe.Log.trace.__hx_invoke2_o(0.0, value5, 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "debug"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (1575) )) )})));
				}
				
				{
					java.lang.Object value6 = ( "  oppositeEdge " + haxe.root.Std.string(this._edges.__get(i2).get_oppositeEdge()) );
					haxe.Log.trace.__hx_invoke2_o(0.0, value6, 0.0, new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"className", "fileName", "methodName"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{"hxDaedalus.data.Mesh", "Mesh.hx", "debug"}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{"lineNumber"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (((double) (1576) )) )})));
				}
				
			}
			
		}
		
	}
	
	
	public   void traverse(haxe.lang.Function onVertex, haxe.lang.Function onEdge)
	{
		hxDaedalus.data.Vertex vertex = null;
		hxDaedalus.data.Edge incomingEdge = null;
		hxDaedalus.data.Face holdingFace = null;
		hxDaedalus.iterators.FromMeshToVertices iterVertices = null;
		iterVertices = new hxDaedalus.iterators.FromMeshToVertices();
		iterVertices.set_fromMesh(this);
		hxDaedalus.iterators.FromVertexToIncomingEdges iterEdges = null;
		iterEdges = new hxDaedalus.iterators.FromVertexToIncomingEdges();
		haxe.ds.ObjectMap<hxDaedalus.data.Vertex, java.lang.Object> dictVerticesDone = new haxe.ds.ObjectMap<hxDaedalus.data.Vertex, java.lang.Object>();
		while (( (vertex = iterVertices.next()) != null ))
		{
			{
				dictVerticesDone.set(vertex, true);
				boolean __temp_expr136 = true;
			}
			
			if ( ! (this.vertexIsInsideAABB(vertex, this)) ) 
			{
				continue;
			}
			
			onVertex.__hx_invoke1_o(0.0, vertex);
			iterEdges.set_fromVertex(vertex);
			while (( (incomingEdge = iterEdges.next()) != null ))
			{
				java.lang.Object __temp_stmt137 = null;
				{
					hxDaedalus.data.Vertex key = incomingEdge.get_originVertex();
					__temp_stmt137 = dictVerticesDone.get(key);
				}
				
				if (( ! (haxe.lang.Runtime.toBool(__temp_stmt137)) )) 
				{
					onEdge.__hx_invoke1_o(0.0, incomingEdge);
				}
				
			}
			
		}
		
	}
	
	
	public   boolean vertexIsInsideAABB(hxDaedalus.data.Vertex vertex, hxDaedalus.data.Mesh mesh)
	{
		if (( ( ( ( vertex.get_pos().x < 0 ) || ( vertex.get_pos().x > mesh.get_width() ) ) || ( vertex.get_pos().y < 0 ) ) || ( vertex.get_pos().y > mesh.get_height() ) )) 
		{
			return false;
		}
		 else 
		{
			return true;
		}
		
	}
	
	
	@Override public   double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef138 = true;
			switch (field.hashCode())
			{
				case 1487441478:
				{
					if (field.equals("_height")) 
					{
						__temp_executeDef138 = false;
						this._height = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef138 = false;
						this._id = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -1462071097:
				{
					if (field.equals("_width")) 
					{
						__temp_executeDef138 = false;
						this._width = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef138) 
			{
				return super.__hx_setField_f(field, value, handleProperties);
			}
			 else 
			{
				throw null;
			}
			
		}
		
	}
	
	
	@Override public   java.lang.Object __hx_setField(java.lang.String field, java.lang.Object value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef139 = true;
			switch (field.hashCode())
			{
				case -542726801:
				{
					if (field.equals("__objectsUpdateInProgress")) 
					{
						__temp_executeDef139 = false;
						this.__objectsUpdateInProgress = haxe.lang.Runtime.toBool(value);
						return value;
					}
					
					break;
				}
				
				
				case 918617282:
				{
					if (field.equals("clipping")) 
					{
						__temp_executeDef139 = false;
						this.set_clipping(haxe.lang.Runtime.toBool(value));
						return value;
					}
					
					break;
				}
				
				
				case 367204343:
				{
					if (field.equals("__edgesToCheck")) 
					{
						__temp_executeDef139 = false;
						this.__edgesToCheck = ((haxe.root.Array<hxDaedalus.data.Edge>) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef139 = false;
						this._id = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 1431196217:
				{
					if (field.equals("__centerVertex")) 
					{
						__temp_executeDef139 = false;
						this.__centerVertex = ((hxDaedalus.data.Vertex) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -1462071097:
				{
					if (field.equals("_width")) 
					{
						__temp_executeDef139 = false;
						this._width = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 698575829:
				{
					if (field.equals("_objects")) 
					{
						__temp_executeDef139 = false;
						this._objects = ((haxe.root.Array<hxDaedalus.data.Object>) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 1487441478:
				{
					if (field.equals("_height")) 
					{
						__temp_executeDef139 = false;
						this._height = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case -1416138866:
				{
					if (field.equals("_constraintShapes")) 
					{
						__temp_executeDef139 = false;
						this._constraintShapes = ((haxe.root.Array<hxDaedalus.data.ConstraintShape>) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 1009135137:
				{
					if (field.equals("_clipping")) 
					{
						__temp_executeDef139 = false;
						this._clipping = haxe.lang.Runtime.toBool(value);
						return value;
					}
					
					break;
				}
				
				
				case -1478010697:
				{
					if (field.equals("_faces")) 
					{
						__temp_executeDef139 = false;
						this._faces = ((haxe.root.Array<hxDaedalus.data.Face>) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -1893623464:
				{
					if (field.equals("_vertices")) 
					{
						__temp_executeDef139 = false;
						this._vertices = ((haxe.root.Array<hxDaedalus.data.Vertex>) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -1478841001:
				{
					if (field.equals("_edges")) 
					{
						__temp_executeDef139 = false;
						this._edges = ((haxe.root.Array<hxDaedalus.data.Edge>) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef139) 
			{
				return super.__hx_setField(field, value, handleProperties);
			}
			 else 
			{
				throw null;
			}
			
		}
		
	}
	
	
	@Override public   java.lang.Object __hx_getField(java.lang.String field, boolean throwErrors, boolean isCheck, boolean handleProperties)
	{
		{
			boolean __temp_executeDef140 = true;
			switch (field.hashCode())
			{
				case 37005034:
				{
					if (field.equals("vertexIsInsideAABB")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("vertexIsInsideAABB"))) );
					}
					
					break;
				}
				
				
				case -1221029593:
				{
					if (field.equals("height")) 
					{
						__temp_executeDef140 = false;
						return this.get_height();
					}
					
					break;
				}
				
				
				case 1287865714:
				{
					if (field.equals("traverse")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("traverse"))) );
					}
					
					break;
				}
				
				
				case 113126854:
				{
					if (field.equals("width")) 
					{
						__temp_executeDef140 = false;
						return this.get_width();
					}
					
					break;
				}
				
				
				case 95458899:
				{
					if (field.equals("debug")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("debug"))) );
					}
					
					break;
				}
				
				
				case 918617282:
				{
					if (field.equals("clipping")) 
					{
						__temp_executeDef140 = false;
						return this.get_clipping();
					}
					
					break;
				}
				
				
				case -1886126431:
				{
					if (field.equals("findPositionFromBounds")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("findPositionFromBounds"))) );
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef140 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
				case -569584212:
				{
					if (field.equals("triangulate")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("triangulate"))) );
					}
					
					break;
				}
				
				
				case -1648731889:
				{
					if (field.equals("__constraintShapes")) 
					{
						__temp_executeDef140 = false;
						return this.get___constraintShapes();
					}
					
					break;
				}
				
				
				case 776199539:
				{
					if (field.equals("untriangulate")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("untriangulate"))) );
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef140 = false;
						return this._id;
					}
					
					break;
				}
				
				
				case -687999185:
				{
					if (field.equals("deleteVertex")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("deleteVertex"))) );
					}
					
					break;
				}
				
				
				case -1462071097:
				{
					if (field.equals("_width")) 
					{
						__temp_executeDef140 = false;
						return this._width;
					}
					
					break;
				}
				
				
				case 206143175:
				{
					if (field.equals("restoreAsDelaunay")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("restoreAsDelaunay"))) );
					}
					
					break;
				}
				
				
				case 1487441478:
				{
					if (field.equals("_height")) 
					{
						__temp_executeDef140 = false;
						return this._height;
					}
					
					break;
				}
				
				
				case 403916951:
				{
					if (field.equals("splitFace")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("splitFace"))) );
					}
					
					break;
				}
				
				
				case 1009135137:
				{
					if (field.equals("_clipping")) 
					{
						__temp_executeDef140 = false;
						return this._clipping;
					}
					
					break;
				}
				
				
				case 403890167:
				{
					if (field.equals("splitEdge")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("splitEdge"))) );
					}
					
					break;
				}
				
				
				case -1893623464:
				{
					if (field.equals("_vertices")) 
					{
						__temp_executeDef140 = false;
						return this._vertices;
					}
					
					break;
				}
				
				
				case 1850794954:
				{
					if (field.equals("flipEdge")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("flipEdge"))) );
					}
					
					break;
				}
				
				
				case -1478841001:
				{
					if (field.equals("_edges")) 
					{
						__temp_executeDef140 = false;
						return this._edges;
					}
					
					break;
				}
				
				
				case 826126781:
				{
					if (field.equals("insertVertex")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("insertVertex"))) );
					}
					
					break;
				}
				
				
				case -1478010697:
				{
					if (field.equals("_faces")) 
					{
						__temp_executeDef140 = false;
						return this._faces;
					}
					
					break;
				}
				
				
				case 94627080:
				{
					if (field.equals("check")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("check"))) );
					}
					
					break;
				}
				
				
				case -1416138866:
				{
					if (field.equals("_constraintShapes")) 
					{
						__temp_executeDef140 = false;
						return this._constraintShapes;
					}
					
					break;
				}
				
				
				case 997368875:
				{
					if (field.equals("deleteConstraintSegment")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("deleteConstraintSegment"))) );
					}
					
					break;
				}
				
				
				case 698575829:
				{
					if (field.equals("_objects")) 
					{
						__temp_executeDef140 = false;
						return this._objects;
					}
					
					break;
				}
				
				
				case 1763944460:
				{
					if (field.equals("insertNewConstrainedEdge")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("insertNewConstrainedEdge"))) );
					}
					
					break;
				}
				
				
				case 1431196217:
				{
					if (field.equals("__centerVertex")) 
					{
						__temp_executeDef140 = false;
						return this.__centerVertex;
					}
					
					break;
				}
				
				
				case -1434164003:
				{
					if (field.equals("insertConstraintSegment")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("insertConstraintSegment"))) );
					}
					
					break;
				}
				
				
				case 367204343:
				{
					if (field.equals("__edgesToCheck")) 
					{
						__temp_executeDef140 = false;
						return this.__edgesToCheck;
					}
					
					break;
				}
				
				
				case 528495257:
				{
					if (field.equals("deleteConstraintShape")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("deleteConstraintShape"))) );
					}
					
					break;
				}
				
				
				case 859648560:
				{
					if (field.equals("get_height")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_height"))) );
					}
					
					break;
				}
				
				
				case -1190234165:
				{
					if (field.equals("insertConstraintShape")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("insertConstraintShape"))) );
					}
					
					break;
				}
				
				
				case 1150076829:
				{
					if (field.equals("get_width")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_width"))) );
					}
					
					break;
				}
				
				
				case 1139367947:
				{
					if (field.equals("updateObjects")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("updateObjects"))) );
					}
					
					break;
				}
				
				
				case -1004437621:
				{
					if (field.equals("get_clipping")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_clipping"))) );
					}
					
					break;
				}
				
				
				case -542726801:
				{
					if (field.equals("__objectsUpdateInProgress")) 
					{
						__temp_executeDef140 = false;
						return this.__objectsUpdateInProgress;
					}
					
					break;
				}
				
				
				case 544555007:
				{
					if (field.equals("set_clipping")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_clipping"))) );
					}
					
					break;
				}
				
				
				case -891426614:
				{
					if (field.equals("deleteObject")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("deleteObject"))) );
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_id"))) );
					}
					
					break;
				}
				
				
				case 622699352:
				{
					if (field.equals("insertObject")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("insertObject"))) );
					}
					
					break;
				}
				
				
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("dispose"))) );
					}
					
					break;
				}
				
				
				case -784041559:
				{
					if (field.equals("buildFromRecord")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("buildFromRecord"))) );
					}
					
					break;
				}
				
				
				case -42945384:
				{
					if (field.equals("get___constraintShapes")) 
					{
						__temp_executeDef140 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get___constraintShapes"))) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef140) 
			{
				return super.__hx_getField(field, throwErrors, isCheck, handleProperties);
			}
			 else 
			{
				throw null;
			}
			
		}
		
	}
	
	
	@Override public   double __hx_getField_f(java.lang.String field, boolean throwErrors, boolean handleProperties)
	{
		{
			boolean __temp_executeDef141 = true;
			switch (field.hashCode())
			{
				case 1487441478:
				{
					if (field.equals("_height")) 
					{
						__temp_executeDef141 = false;
						return this._height;
					}
					
					break;
				}
				
				
				case -1221029593:
				{
					if (field.equals("height")) 
					{
						__temp_executeDef141 = false;
						return this.get_height();
					}
					
					break;
				}
				
				
				case -1462071097:
				{
					if (field.equals("_width")) 
					{
						__temp_executeDef141 = false;
						return this._width;
					}
					
					break;
				}
				
				
				case 113126854:
				{
					if (field.equals("width")) 
					{
						__temp_executeDef141 = false;
						return this.get_width();
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef141 = false;
						return ((double) (this._id) );
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef141 = false;
						return ((double) (this.get_id()) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef141) 
			{
				return super.__hx_getField_f(field, throwErrors, handleProperties);
			}
			 else 
			{
				throw null;
			}
			
		}
		
	}
	
	
	@Override public   java.lang.Object __hx_invokeField(java.lang.String field, haxe.root.Array dynargs)
	{
		{
			boolean __temp_executeDef142 = true;
			switch (field.hashCode())
			{
				case 37005034:
				{
					if (field.equals("vertexIsInsideAABB")) 
					{
						__temp_executeDef142 = false;
						return this.vertexIsInsideAABB(((hxDaedalus.data.Vertex) (dynargs.__get(0)) ), ((hxDaedalus.data.Mesh) (dynargs.__get(1)) ));
					}
					
					break;
				}
				
				
				case 859648560:
				{
					if (field.equals("get_height")) 
					{
						__temp_executeDef142 = false;
						return this.get_height();
					}
					
					break;
				}
				
				
				case 1287865714:
				{
					if (field.equals("traverse")) 
					{
						__temp_executeDef142 = false;
						this.traverse(((haxe.lang.Function) (dynargs.__get(0)) ), ((haxe.lang.Function) (dynargs.__get(1)) ));
					}
					
					break;
				}
				
				
				case 1150076829:
				{
					if (field.equals("get_width")) 
					{
						__temp_executeDef142 = false;
						return this.get_width();
					}
					
					break;
				}
				
				
				case 95458899:
				{
					if (field.equals("debug")) 
					{
						__temp_executeDef142 = false;
						this.debug();
					}
					
					break;
				}
				
				
				case -1004437621:
				{
					if (field.equals("get_clipping")) 
					{
						__temp_executeDef142 = false;
						return this.get_clipping();
					}
					
					break;
				}
				
				
				case -1886126431:
				{
					if (field.equals("findPositionFromBounds")) 
					{
						__temp_executeDef142 = false;
						return this.findPositionFromBounds(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(1))) ));
					}
					
					break;
				}
				
				
				case 544555007:
				{
					if (field.equals("set_clipping")) 
					{
						__temp_executeDef142 = false;
						return this.set_clipping(haxe.lang.Runtime.toBool(dynargs.__get(0)));
					}
					
					break;
				}
				
				
				case -569584212:
				{
					if (field.equals("triangulate")) 
					{
						__temp_executeDef142 = false;
						this.triangulate(((haxe.root.Array<hxDaedalus.data.Edge>) (dynargs.__get(0)) ), haxe.lang.Runtime.toBool(dynargs.__get(1)));
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef142 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
				case 776199539:
				{
					if (field.equals("untriangulate")) 
					{
						__temp_executeDef142 = false;
						this.untriangulate(((haxe.root.Array<hxDaedalus.data.Edge>) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef142 = false;
						this.dispose();
					}
					
					break;
				}
				
				
				case -687999185:
				{
					if (field.equals("deleteVertex")) 
					{
						__temp_executeDef142 = false;
						return this.deleteVertex(((hxDaedalus.data.Vertex) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case -42945384:
				{
					if (field.equals("get___constraintShapes")) 
					{
						__temp_executeDef142 = false;
						return this.get___constraintShapes();
					}
					
					break;
				}
				
				
				case 206143175:
				{
					if (field.equals("restoreAsDelaunay")) 
					{
						__temp_executeDef142 = false;
						this.restoreAsDelaunay();
					}
					
					break;
				}
				
				
				case -784041559:
				{
					if (field.equals("buildFromRecord")) 
					{
						__temp_executeDef142 = false;
						this.buildFromRecord(haxe.lang.Runtime.toString(dynargs.__get(0)));
					}
					
					break;
				}
				
				
				case 403916951:
				{
					if (field.equals("splitFace")) 
					{
						__temp_executeDef142 = false;
						return this.splitFace(((hxDaedalus.data.Face) (dynargs.__get(0)) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(1))) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(2))) ));
					}
					
					break;
				}
				
				
				case 622699352:
				{
					if (field.equals("insertObject")) 
					{
						__temp_executeDef142 = false;
						this.insertObject(((hxDaedalus.data.Object) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 403890167:
				{
					if (field.equals("splitEdge")) 
					{
						__temp_executeDef142 = false;
						return this.splitEdge(((hxDaedalus.data.Edge) (dynargs.__get(0)) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(1))) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(2))) ));
					}
					
					break;
				}
				
				
				case -891426614:
				{
					if (field.equals("deleteObject")) 
					{
						__temp_executeDef142 = false;
						this.deleteObject(((hxDaedalus.data.Object) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 1850794954:
				{
					if (field.equals("flipEdge")) 
					{
						__temp_executeDef142 = false;
						return this.flipEdge(((hxDaedalus.data.Edge) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 1139367947:
				{
					if (field.equals("updateObjects")) 
					{
						__temp_executeDef142 = false;
						this.updateObjects();
					}
					
					break;
				}
				
				
				case 826126781:
				{
					if (field.equals("insertVertex")) 
					{
						__temp_executeDef142 = false;
						return this.insertVertex(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(1))) ));
					}
					
					break;
				}
				
				
				case -1190234165:
				{
					if (field.equals("insertConstraintShape")) 
					{
						__temp_executeDef142 = false;
						return this.insertConstraintShape(((haxe.root.Array<java.lang.Object>) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 94627080:
				{
					if (field.equals("check")) 
					{
						__temp_executeDef142 = false;
						this.check();
					}
					
					break;
				}
				
				
				case 528495257:
				{
					if (field.equals("deleteConstraintShape")) 
					{
						__temp_executeDef142 = false;
						this.deleteConstraintShape(((hxDaedalus.data.ConstraintShape) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 997368875:
				{
					if (field.equals("deleteConstraintSegment")) 
					{
						__temp_executeDef142 = false;
						this.deleteConstraintSegment(((hxDaedalus.data.ConstraintSegment) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case -1434164003:
				{
					if (field.equals("insertConstraintSegment")) 
					{
						__temp_executeDef142 = false;
						return this.insertConstraintSegment(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(1))) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(2))) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(3))) ));
					}
					
					break;
				}
				
				
				case 1763944460:
				{
					if (field.equals("insertNewConstrainedEdge")) 
					{
						__temp_executeDef142 = false;
						this.insertNewConstrainedEdge(((hxDaedalus.data.ConstraintSegment) (dynargs.__get(0)) ), ((hxDaedalus.data.Edge) (dynargs.__get(1)) ), ((haxe.root.Array<hxDaedalus.data.Edge>) (dynargs.__get(2)) ), ((haxe.root.Array<hxDaedalus.data.Edge>) (dynargs.__get(3)) ), ((haxe.root.Array<hxDaedalus.data.Edge>) (dynargs.__get(4)) ));
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef142) 
			{
				return super.__hx_invokeField(field, dynargs);
			}
			
		}
		
		return null;
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("__objectsUpdateInProgress");
		baseArr.push("__edgesToCheck");
		baseArr.push("__centerVertex");
		baseArr.push("_objects");
		baseArr.push("_constraintShapes");
		baseArr.push("_faces");
		baseArr.push("_edges");
		baseArr.push("_vertices");
		baseArr.push("_clipping");
		baseArr.push("_height");
		baseArr.push("_width");
		baseArr.push("_id");
		baseArr.push("__constraintShapes");
		baseArr.push("id");
		baseArr.push("clipping");
		baseArr.push("width");
		baseArr.push("height");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


