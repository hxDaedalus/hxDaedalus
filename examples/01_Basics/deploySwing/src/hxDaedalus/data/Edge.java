package hxDaedalus.data;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class Edge extends haxe.lang.HxObject
{
	static 
	{
		hxDaedalus.data.Edge.INC = 0;
	}
	public    Edge(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    Edge()
	{
		hxDaedalus.data.Edge.__hx_ctor_hxDaedalus_data_Edge(this);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_data_Edge(hxDaedalus.data.Edge __temp_me16)
	{
		__temp_me16.colorDebug = -1;
		__temp_me16._id = hxDaedalus.data.Edge.INC;
		hxDaedalus.data.Edge.INC++;
		__temp_me16.fromConstraintSegments = new haxe.root.Array<hxDaedalus.data.ConstraintSegment>();
	}
	
	
	public static  int INC;
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.data.Edge(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.data.Edge();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public  haxe.root.Array<hxDaedalus.data.ConstraintSegment> fromConstraintSegments;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public  int _id;
	
	public  boolean _isReal;
	
	public  boolean _isConstrained;
	
	public  hxDaedalus.data.Vertex _originVertex;
	
	public  hxDaedalus.data.Edge _oppositeEdge;
	
	public  hxDaedalus.data.Edge _nextLeftEdge;
	
	public  hxDaedalus.data.Face _leftFace;
	
	public  int colorDebug;
	
	public   int get_id()
	{
		return this._id;
	}
	
	
	public   boolean get_isReal()
	{
		return this._isReal;
	}
	
	
	public   boolean get_isConstrained()
	{
		return this._isConstrained;
	}
	
	
	public   void setDatas(hxDaedalus.data.Vertex originVertex, hxDaedalus.data.Edge oppositeEdge, hxDaedalus.data.Edge nextLeftEdge, hxDaedalus.data.Face leftFace, java.lang.Object isReal, java.lang.Object isConstrained)
	{
		boolean __temp_isConstrained15 = ( (( isConstrained == null )) ? (haxe.lang.Runtime.toBool(false)) : (haxe.lang.Runtime.toBool(isConstrained)) );
		boolean __temp_isReal14 = ( (( isReal == null )) ? (haxe.lang.Runtime.toBool(true)) : (haxe.lang.Runtime.toBool(isReal)) );
		this._isConstrained = __temp_isConstrained15;
		this._isReal = __temp_isReal14;
		this._originVertex = originVertex;
		this._oppositeEdge = oppositeEdge;
		this._nextLeftEdge = nextLeftEdge;
		this._leftFace = leftFace;
	}
	
	
	public   void addFromConstraintSegment(hxDaedalus.data.ConstraintSegment segment)
	{
		if (( this.fromConstraintSegments.indexOf(segment, null) == -1 )) 
		{
			this.fromConstraintSegments.push(segment);
		}
		
	}
	
	
	public   void removeFromConstraintSegment(hxDaedalus.data.ConstraintSegment segment)
	{
		int index = this.fromConstraintSegments.indexOf(segment, null);
		if (( index != -1 )) 
		{
			this.fromConstraintSegments.splice(index, 1);
		}
		
	}
	
	
	public   hxDaedalus.data.Vertex set_originVertex(hxDaedalus.data.Vertex value)
	{
		this._originVertex = value;
		return value;
	}
	
	
	public   hxDaedalus.data.Edge set_nextLeftEdge(hxDaedalus.data.Edge value)
	{
		this._nextLeftEdge = value;
		return value;
	}
	
	
	public   hxDaedalus.data.Face set_leftFace(hxDaedalus.data.Face value)
	{
		this._leftFace = value;
		return value;
	}
	
	
	public   boolean set_isConstrained(boolean value)
	{
		this._isConstrained = value;
		return value;
	}
	
	
	public   void dispose()
	{
		this._originVertex = null;
		this._oppositeEdge = null;
		this._nextLeftEdge = null;
		this._leftFace = null;
		this.fromConstraintSegments = null;
	}
	
	
	public   hxDaedalus.data.Vertex get_originVertex()
	{
		return this._originVertex;
	}
	
	
	public   hxDaedalus.data.Vertex get_destinationVertex()
	{
		return this.get_oppositeEdge().get_originVertex();
	}
	
	
	public   hxDaedalus.data.Edge get_oppositeEdge()
	{
		return this._oppositeEdge;
	}
	
	
	public   hxDaedalus.data.Edge get_nextLeftEdge()
	{
		return this._nextLeftEdge;
	}
	
	
	public   hxDaedalus.data.Edge get_prevLeftEdge()
	{
		return this._nextLeftEdge.get_nextLeftEdge();
	}
	
	
	public   hxDaedalus.data.Edge get_nextRightEdge()
	{
		return this._oppositeEdge.get_nextLeftEdge().get_nextLeftEdge().get_oppositeEdge();
	}
	
	
	public   hxDaedalus.data.Edge get_prevRightEdge()
	{
		return this._oppositeEdge.get_nextLeftEdge().get_oppositeEdge();
	}
	
	
	public   hxDaedalus.data.Edge get_rotLeftEdge()
	{
		return this._nextLeftEdge.get_nextLeftEdge().get_oppositeEdge();
	}
	
	
	public   hxDaedalus.data.Edge get_rotRightEdge()
	{
		return this._oppositeEdge.get_nextLeftEdge();
	}
	
	
	public   hxDaedalus.data.Face get_leftFace()
	{
		return this._leftFace;
	}
	
	
	public   hxDaedalus.data.Face get_rightFace()
	{
		return this._oppositeEdge.get_leftFace();
	}
	
	
	@Override public   java.lang.String toString()
	{
		return ( ( ( "edge " + this.get_originVertex().get_id() ) + " - " ) + this.get_destinationVertex().get_id() );
	}
	
	
	@Override public   double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef122 = true;
			switch (field.hashCode())
			{
				case 1264295088:
				{
					if (field.equals("colorDebug")) 
					{
						__temp_executeDef122 = false;
						this.colorDebug = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef122 = false;
						this._id = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef122) 
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
			boolean __temp_executeDef123 = true;
			switch (field.hashCode())
			{
				case 1264295088:
				{
					if (field.equals("colorDebug")) 
					{
						__temp_executeDef123 = false;
						this.colorDebug = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 1278230732:
				{
					if (field.equals("isConstrained")) 
					{
						__temp_executeDef123 = false;
						this.set_isConstrained(haxe.lang.Runtime.toBool(value));
						return value;
					}
					
					break;
				}
				
				
				case 1808515171:
				{
					if (field.equals("_leftFace")) 
					{
						__temp_executeDef123 = false;
						this._leftFace = ((hxDaedalus.data.Face) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 1817499754:
				{
					if (field.equals("originVertex")) 
					{
						__temp_executeDef123 = false;
						this.set_originVertex(((hxDaedalus.data.Vertex) (value) ));
						return value;
					}
					
					break;
				}
				
				
				case -1428235178:
				{
					if (field.equals("_nextLeftEdge")) 
					{
						__temp_executeDef123 = false;
						this._nextLeftEdge = ((hxDaedalus.data.Edge) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 675246711:
				{
					if (field.equals("nextLeftEdge")) 
					{
						__temp_executeDef123 = false;
						this.set_nextLeftEdge(((hxDaedalus.data.Edge) (value) ));
						return value;
					}
					
					break;
				}
				
				
				case 1320793891:
				{
					if (field.equals("_oppositeEdge")) 
					{
						__temp_executeDef123 = false;
						this._oppositeEdge = ((hxDaedalus.data.Edge) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 1717997316:
				{
					if (field.equals("leftFace")) 
					{
						__temp_executeDef123 = false;
						this.set_leftFace(((hxDaedalus.data.Face) (value) ));
						return value;
					}
					
					break;
				}
				
				
				case -285982135:
				{
					if (field.equals("_originVertex")) 
					{
						__temp_executeDef123 = false;
						this._originVertex = ((hxDaedalus.data.Vertex) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -528444953:
				{
					if (field.equals("fromConstraintSegments")) 
					{
						__temp_executeDef123 = false;
						this.fromConstraintSegments = ((haxe.root.Array<hxDaedalus.data.ConstraintSegment>) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 494801613:
				{
					if (field.equals("_isConstrained")) 
					{
						__temp_executeDef123 = false;
						this._isConstrained = haxe.lang.Runtime.toBool(value);
						return value;
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef123 = false;
						this._id = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 1528312583:
				{
					if (field.equals("_isReal")) 
					{
						__temp_executeDef123 = false;
						this._isReal = haxe.lang.Runtime.toBool(value);
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef123) 
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
			boolean __temp_executeDef124 = true;
			switch (field.hashCode())
			{
				case -1776922004:
				{
					if (field.equals("toString")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("toString"))) );
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef124 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
				case -1054706448:
				{
					if (field.equals("get_rightFace")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_rightFace"))) );
					}
					
					break;
				}
				
				
				case -1180158488:
				{
					if (field.equals("isReal")) 
					{
						__temp_executeDef124 = false;
						return this.get_isReal();
					}
					
					break;
				}
				
				
				case -205057587:
				{
					if (field.equals("get_leftFace")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_leftFace"))) );
					}
					
					break;
				}
				
				
				case 1278230732:
				{
					if (field.equals("isConstrained")) 
					{
						__temp_executeDef124 = false;
						return this.get_isConstrained();
					}
					
					break;
				}
				
				
				case -674188245:
				{
					if (field.equals("get_rotRightEdge")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_rotRightEdge"))) );
					}
					
					break;
				}
				
				
				case 1817499754:
				{
					if (field.equals("originVertex")) 
					{
						__temp_executeDef124 = false;
						return this.get_originVertex();
					}
					
					break;
				}
				
				
				case 84285938:
				{
					if (field.equals("get_rotLeftEdge")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_rotLeftEdge"))) );
					}
					
					break;
				}
				
				
				case 675246711:
				{
					if (field.equals("nextLeftEdge")) 
					{
						__temp_executeDef124 = false;
						return this.get_nextLeftEdge();
					}
					
					break;
				}
				
				
				case 872828893:
				{
					if (field.equals("get_prevRightEdge")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_prevRightEdge"))) );
					}
					
					break;
				}
				
				
				case 1717997316:
				{
					if (field.equals("leftFace")) 
					{
						__temp_executeDef124 = false;
						return this.get_leftFace();
					}
					
					break;
				}
				
				
				case 392249117:
				{
					if (field.equals("get_nextRightEdge")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_nextRightEdge"))) );
					}
					
					break;
				}
				
				
				case -528444953:
				{
					if (field.equals("fromConstraintSegments")) 
					{
						__temp_executeDef124 = false;
						return this.fromConstraintSegments;
					}
					
					break;
				}
				
				
				case -558546944:
				{
					if (field.equals("get_prevLeftEdge")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_prevLeftEdge"))) );
					}
					
					break;
				}
				
				
				case -1558175918:
				{
					if (field.equals("destinationVertex")) 
					{
						__temp_executeDef124 = false;
						return this.get_destinationVertex();
					}
					
					break;
				}
				
				
				case 949971136:
				{
					if (field.equals("get_nextLeftEdge")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_nextLeftEdge"))) );
					}
					
					break;
				}
				
				
				case -870691516:
				{
					if (field.equals("oppositeEdge")) 
					{
						__temp_executeDef124 = false;
						return this.get_oppositeEdge();
					}
					
					break;
				}
				
				
				case -595967091:
				{
					if (field.equals("get_oppositeEdge")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_oppositeEdge"))) );
					}
					
					break;
				}
				
				
				case -833271369:
				{
					if (field.equals("prevLeftEdge")) 
					{
						__temp_executeDef124 = false;
						return this.get_prevLeftEdge();
					}
					
					break;
				}
				
				
				case 987475625:
				{
					if (field.equals("get_destinationVertex")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_destinationVertex"))) );
					}
					
					break;
				}
				
				
				case 465726534:
				{
					if (field.equals("nextRightEdge")) 
					{
						__temp_executeDef124 = false;
						return this.get_nextRightEdge();
					}
					
					break;
				}
				
				
				case 2092224179:
				{
					if (field.equals("get_originVertex")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_originVertex"))) );
					}
					
					break;
				}
				
				
				case 946306310:
				{
					if (field.equals("prevRightEdge")) 
					{
						__temp_executeDef124 = false;
						return this.get_prevRightEdge();
					}
					
					break;
				}
				
				
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("dispose"))) );
					}
					
					break;
				}
				
				
				case -755860133:
				{
					if (field.equals("rotLeftEdge")) 
					{
						__temp_executeDef124 = false;
						return this.get_rotLeftEdge();
					}
					
					break;
				}
				
				
				case 264600495:
				{
					if (field.equals("set_isConstrained")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_isConstrained"))) );
					}
					
					break;
				}
				
				
				case -948912670:
				{
					if (field.equals("rotRightEdge")) 
					{
						__temp_executeDef124 = false;
						return this.get_rotRightEdge();
					}
					
					break;
				}
				
				
				case 1343935041:
				{
					if (field.equals("set_leftFace")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_leftFace"))) );
					}
					
					break;
				}
				
				
				case -1569546599:
				{
					if (field.equals("rightFace")) 
					{
						__temp_executeDef124 = false;
						return this.get_rightFace();
					}
					
					break;
				}
				
				
				case -881471692:
				{
					if (field.equals("set_nextLeftEdge")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_nextLeftEdge"))) );
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef124 = false;
						return this._id;
					}
					
					break;
				}
				
				
				case 260781351:
				{
					if (field.equals("set_originVertex")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_originVertex"))) );
					}
					
					break;
				}
				
				
				case 1528312583:
				{
					if (field.equals("_isReal")) 
					{
						__temp_executeDef124 = false;
						return this._isReal;
					}
					
					break;
				}
				
				
				case 1170407912:
				{
					if (field.equals("removeFromConstraintSegment")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeFromConstraintSegment"))) );
					}
					
					break;
				}
				
				
				case 494801613:
				{
					if (field.equals("_isConstrained")) 
					{
						__temp_executeDef124 = false;
						return this._isConstrained;
					}
					
					break;
				}
				
				
				case 910337515:
				{
					if (field.equals("addFromConstraintSegment")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addFromConstraintSegment"))) );
					}
					
					break;
				}
				
				
				case -285982135:
				{
					if (field.equals("_originVertex")) 
					{
						__temp_executeDef124 = false;
						return this._originVertex;
					}
					
					break;
				}
				
				
				case 1390069447:
				{
					if (field.equals("setDatas")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setDatas"))) );
					}
					
					break;
				}
				
				
				case 1320793891:
				{
					if (field.equals("_oppositeEdge")) 
					{
						__temp_executeDef124 = false;
						return this._oppositeEdge;
					}
					
					break;
				}
				
				
				case 1204753315:
				{
					if (field.equals("get_isConstrained")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_isConstrained"))) );
					}
					
					break;
				}
				
				
				case -1428235178:
				{
					if (field.equals("_nextLeftEdge")) 
					{
						__temp_executeDef124 = false;
						return this._nextLeftEdge;
					}
					
					break;
				}
				
				
				case 900519665:
				{
					if (field.equals("get_isReal")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_isReal"))) );
					}
					
					break;
				}
				
				
				case 1808515171:
				{
					if (field.equals("_leftFace")) 
					{
						__temp_executeDef124 = false;
						return this._leftFace;
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef124 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_id"))) );
					}
					
					break;
				}
				
				
				case 1264295088:
				{
					if (field.equals("colorDebug")) 
					{
						__temp_executeDef124 = false;
						return this.colorDebug;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef124) 
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
			boolean __temp_executeDef125 = true;
			switch (field.hashCode())
			{
				case 1264295088:
				{
					if (field.equals("colorDebug")) 
					{
						__temp_executeDef125 = false;
						return ((double) (this.colorDebug) );
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef125 = false;
						return ((double) (this.get_id()) );
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef125 = false;
						return ((double) (this._id) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef125) 
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
			boolean __temp_executeDef126 = true;
			switch (field.hashCode())
			{
				case -1776922004:
				{
					if (field.equals("toString")) 
					{
						__temp_executeDef126 = false;
						return this.toString();
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef126 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
				case -1054706448:
				{
					if (field.equals("get_rightFace")) 
					{
						__temp_executeDef126 = false;
						return this.get_rightFace();
					}
					
					break;
				}
				
				
				case 900519665:
				{
					if (field.equals("get_isReal")) 
					{
						__temp_executeDef126 = false;
						return this.get_isReal();
					}
					
					break;
				}
				
				
				case -205057587:
				{
					if (field.equals("get_leftFace")) 
					{
						__temp_executeDef126 = false;
						return this.get_leftFace();
					}
					
					break;
				}
				
				
				case 1204753315:
				{
					if (field.equals("get_isConstrained")) 
					{
						__temp_executeDef126 = false;
						return this.get_isConstrained();
					}
					
					break;
				}
				
				
				case -674188245:
				{
					if (field.equals("get_rotRightEdge")) 
					{
						__temp_executeDef126 = false;
						return this.get_rotRightEdge();
					}
					
					break;
				}
				
				
				case 1390069447:
				{
					if (field.equals("setDatas")) 
					{
						__temp_executeDef126 = false;
						this.setDatas(((hxDaedalus.data.Vertex) (dynargs.__get(0)) ), ((hxDaedalus.data.Edge) (dynargs.__get(1)) ), ((hxDaedalus.data.Edge) (dynargs.__get(2)) ), ((hxDaedalus.data.Face) (dynargs.__get(3)) ), dynargs.__get(4), dynargs.__get(5));
					}
					
					break;
				}
				
				
				case 84285938:
				{
					if (field.equals("get_rotLeftEdge")) 
					{
						__temp_executeDef126 = false;
						return this.get_rotLeftEdge();
					}
					
					break;
				}
				
				
				case 910337515:
				{
					if (field.equals("addFromConstraintSegment")) 
					{
						__temp_executeDef126 = false;
						this.addFromConstraintSegment(((hxDaedalus.data.ConstraintSegment) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 872828893:
				{
					if (field.equals("get_prevRightEdge")) 
					{
						__temp_executeDef126 = false;
						return this.get_prevRightEdge();
					}
					
					break;
				}
				
				
				case 1170407912:
				{
					if (field.equals("removeFromConstraintSegment")) 
					{
						__temp_executeDef126 = false;
						this.removeFromConstraintSegment(((hxDaedalus.data.ConstraintSegment) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 392249117:
				{
					if (field.equals("get_nextRightEdge")) 
					{
						__temp_executeDef126 = false;
						return this.get_nextRightEdge();
					}
					
					break;
				}
				
				
				case 260781351:
				{
					if (field.equals("set_originVertex")) 
					{
						__temp_executeDef126 = false;
						return this.set_originVertex(((hxDaedalus.data.Vertex) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case -558546944:
				{
					if (field.equals("get_prevLeftEdge")) 
					{
						__temp_executeDef126 = false;
						return this.get_prevLeftEdge();
					}
					
					break;
				}
				
				
				case -881471692:
				{
					if (field.equals("set_nextLeftEdge")) 
					{
						__temp_executeDef126 = false;
						return this.set_nextLeftEdge(((hxDaedalus.data.Edge) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 949971136:
				{
					if (field.equals("get_nextLeftEdge")) 
					{
						__temp_executeDef126 = false;
						return this.get_nextLeftEdge();
					}
					
					break;
				}
				
				
				case 1343935041:
				{
					if (field.equals("set_leftFace")) 
					{
						__temp_executeDef126 = false;
						return this.set_leftFace(((hxDaedalus.data.Face) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case -595967091:
				{
					if (field.equals("get_oppositeEdge")) 
					{
						__temp_executeDef126 = false;
						return this.get_oppositeEdge();
					}
					
					break;
				}
				
				
				case 264600495:
				{
					if (field.equals("set_isConstrained")) 
					{
						__temp_executeDef126 = false;
						return this.set_isConstrained(haxe.lang.Runtime.toBool(dynargs.__get(0)));
					}
					
					break;
				}
				
				
				case 987475625:
				{
					if (field.equals("get_destinationVertex")) 
					{
						__temp_executeDef126 = false;
						return this.get_destinationVertex();
					}
					
					break;
				}
				
				
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef126 = false;
						this.dispose();
					}
					
					break;
				}
				
				
				case 2092224179:
				{
					if (field.equals("get_originVertex")) 
					{
						__temp_executeDef126 = false;
						return this.get_originVertex();
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef126) 
			{
				return super.__hx_invokeField(field, dynargs);
			}
			
		}
		
		return null;
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("colorDebug");
		baseArr.push("_leftFace");
		baseArr.push("_nextLeftEdge");
		baseArr.push("_oppositeEdge");
		baseArr.push("_originVertex");
		baseArr.push("_isConstrained");
		baseArr.push("_isReal");
		baseArr.push("_id");
		baseArr.push("rightFace");
		baseArr.push("rotRightEdge");
		baseArr.push("rotLeftEdge");
		baseArr.push("prevRightEdge");
		baseArr.push("nextRightEdge");
		baseArr.push("prevLeftEdge");
		baseArr.push("oppositeEdge");
		baseArr.push("destinationVertex");
		baseArr.push("fromConstraintSegments");
		baseArr.push("leftFace");
		baseArr.push("nextLeftEdge");
		baseArr.push("originVertex");
		baseArr.push("isConstrained");
		baseArr.push("isReal");
		baseArr.push("id");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


