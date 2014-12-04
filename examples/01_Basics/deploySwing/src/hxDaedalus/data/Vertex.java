package hxDaedalus.data;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class Vertex extends haxe.lang.HxObject
{
	static 
	{
		hxDaedalus.data.Vertex.INC = 0;
	}
	public    Vertex(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    Vertex()
	{
		hxDaedalus.data.Vertex.__hx_ctor_hxDaedalus_data_Vertex(this);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_data_Vertex(hxDaedalus.data.Vertex __temp_me22)
	{
		__temp_me22.colorDebug = -1;
		__temp_me22._id = hxDaedalus.data.Vertex.INC;
		hxDaedalus.data.Vertex.INC++;
		__temp_me22._pos = new hxDaedalus.data.math.Point2D(((java.lang.Object) (null) ), ((java.lang.Object) (null) ));
		__temp_me22._fromConstraintSegments = new haxe.root.Array<hxDaedalus.data.ConstraintSegment>();
	}
	
	
	public static  int INC;
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.data.Vertex(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.data.Vertex();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	public  int _id;
	
	public  hxDaedalus.data.math.Point2D _pos;
	
	public  boolean _isReal;
	
	public  hxDaedalus.data.Edge _edge;
	
	public  haxe.root.Array<hxDaedalus.data.ConstraintSegment> _fromConstraintSegments;
	
	public  int colorDebug;
	
	public   int get_id()
	{
		return this._id;
	}
	
	
	public   boolean get_isReal()
	{
		return this._isReal;
	}
	
	
	public   hxDaedalus.data.math.Point2D get_pos()
	{
		return this._pos;
	}
	
	
	public   haxe.root.Array<hxDaedalus.data.ConstraintSegment> get_fromConstraintSegments()
	{
		return this._fromConstraintSegments;
	}
	
	
	public   haxe.root.Array<hxDaedalus.data.ConstraintSegment> set_fromConstraintSegments(haxe.root.Array<hxDaedalus.data.ConstraintSegment> value)
	{
		return this._fromConstraintSegments = value;
	}
	
	
	public   void setDatas(hxDaedalus.data.Edge edge, java.lang.Object isReal)
	{
		boolean __temp_isReal21 = ( (( isReal == null )) ? (haxe.lang.Runtime.toBool(true)) : (haxe.lang.Runtime.toBool(isReal)) );
		this._isReal = __temp_isReal21;
		this._edge = edge;
	}
	
	
	public   void addFromConstraintSegment(hxDaedalus.data.ConstraintSegment segment)
	{
		if (( this._fromConstraintSegments.indexOf(segment, null) == -1 )) 
		{
			this._fromConstraintSegments.push(segment);
		}
		
	}
	
	
	public   void removeFromConstraintSegment(hxDaedalus.data.ConstraintSegment segment)
	{
		int index = this._fromConstraintSegments.indexOf(segment, null);
		if (( index != -1 )) 
		{
			this._fromConstraintSegments.splice(index, 1);
		}
		
	}
	
	
	public   void dispose()
	{
		this._pos = null;
		this._edge = null;
		this._fromConstraintSegments = null;
	}
	
	
	public   hxDaedalus.data.Edge get_edge()
	{
		return this._edge;
	}
	
	
	public   hxDaedalus.data.Edge set_edge(hxDaedalus.data.Edge value)
	{
		return this._edge = value;
	}
	
	
	@Override public   java.lang.String toString()
	{
		return ( "ver_id " + this._id );
	}
	
	
	@Override public   double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef148 = true;
			switch (field.hashCode())
			{
				case 1264295088:
				{
					if (field.equals("colorDebug")) 
					{
						__temp_executeDef148 = false;
						this.colorDebug = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef148 = false;
						this._id = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef148) 
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
			boolean __temp_executeDef149 = true;
			switch (field.hashCode())
			{
				case 1264295088:
				{
					if (field.equals("colorDebug")) 
					{
						__temp_executeDef149 = false;
						this.colorDebug = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case -528444953:
				{
					if (field.equals("fromConstraintSegments")) 
					{
						__temp_executeDef149 = false;
						this.set_fromConstraintSegments(((haxe.root.Array<hxDaedalus.data.ConstraintSegment>) (value) ));
						return value;
					}
					
					break;
				}
				
				
				case 1760063750:
				{
					if (field.equals("_fromConstraintSegments")) 
					{
						__temp_executeDef149 = false;
						this._fromConstraintSegments = ((haxe.root.Array<hxDaedalus.data.ConstraintSegment>) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 3108285:
				{
					if (field.equals("edge")) 
					{
						__temp_executeDef149 = false;
						this.set_edge(((hxDaedalus.data.Edge) (value) ));
						return value;
					}
					
					break;
				}
				
				
				case 90842780:
				{
					if (field.equals("_edge")) 
					{
						__temp_executeDef149 = false;
						this._edge = ((hxDaedalus.data.Edge) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef149 = false;
						this._id = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 1528312583:
				{
					if (field.equals("_isReal")) 
					{
						__temp_executeDef149 = false;
						this._isReal = haxe.lang.Runtime.toBool(value);
						return value;
					}
					
					break;
				}
				
				
				case 2941333:
				{
					if (field.equals("_pos")) 
					{
						__temp_executeDef149 = false;
						this._pos = ((hxDaedalus.data.math.Point2D) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef149) 
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
			boolean __temp_executeDef150 = true;
			switch (field.hashCode())
			{
				case -1776922004:
				{
					if (field.equals("toString")) 
					{
						__temp_executeDef150 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("toString"))) );
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef150 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
				case 1415108474:
				{
					if (field.equals("set_edge")) 
					{
						__temp_executeDef150 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_edge"))) );
					}
					
					break;
				}
				
				
				case -1180158488:
				{
					if (field.equals("isReal")) 
					{
						__temp_executeDef150 = false;
						return this.get_isReal();
					}
					
					break;
				}
				
				
				case 1976220934:
				{
					if (field.equals("get_edge")) 
					{
						__temp_executeDef150 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_edge"))) );
					}
					
					break;
				}
				
				
				case 111188:
				{
					if (field.equals("pos")) 
					{
						__temp_executeDef150 = false;
						return this.get_pos();
					}
					
					break;
				}
				
				
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef150 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("dispose"))) );
					}
					
					break;
				}
				
				
				case -528444953:
				{
					if (field.equals("fromConstraintSegments")) 
					{
						__temp_executeDef150 = false;
						return this.get_fromConstraintSegments();
					}
					
					break;
				}
				
				
				case 1170407912:
				{
					if (field.equals("removeFromConstraintSegment")) 
					{
						__temp_executeDef150 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeFromConstraintSegment"))) );
					}
					
					break;
				}
				
				
				case 3108285:
				{
					if (field.equals("edge")) 
					{
						__temp_executeDef150 = false;
						return this.get_edge();
					}
					
					break;
				}
				
				
				case 910337515:
				{
					if (field.equals("addFromConstraintSegment")) 
					{
						__temp_executeDef150 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addFromConstraintSegment"))) );
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef150 = false;
						return this._id;
					}
					
					break;
				}
				
				
				case 1390069447:
				{
					if (field.equals("setDatas")) 
					{
						__temp_executeDef150 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setDatas"))) );
					}
					
					break;
				}
				
				
				case 2941333:
				{
					if (field.equals("_pos")) 
					{
						__temp_executeDef150 = false;
						return this._pos;
					}
					
					break;
				}
				
				
				case -1790187932:
				{
					if (field.equals("set_fromConstraintSegments")) 
					{
						__temp_executeDef150 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_fromConstraintSegments"))) );
					}
					
					break;
				}
				
				
				case 1528312583:
				{
					if (field.equals("_isReal")) 
					{
						__temp_executeDef150 = false;
						return this._isReal;
					}
					
					break;
				}
				
				
				case 2132541680:
				{
					if (field.equals("get_fromConstraintSegments")) 
					{
						__temp_executeDef150 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_fromConstraintSegments"))) );
					}
					
					break;
				}
				
				
				case 90842780:
				{
					if (field.equals("_edge")) 
					{
						__temp_executeDef150 = false;
						return this._edge;
					}
					
					break;
				}
				
				
				case -74787349:
				{
					if (field.equals("get_pos")) 
					{
						__temp_executeDef150 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_pos"))) );
					}
					
					break;
				}
				
				
				case 1760063750:
				{
					if (field.equals("_fromConstraintSegments")) 
					{
						__temp_executeDef150 = false;
						return this._fromConstraintSegments;
					}
					
					break;
				}
				
				
				case 900519665:
				{
					if (field.equals("get_isReal")) 
					{
						__temp_executeDef150 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_isReal"))) );
					}
					
					break;
				}
				
				
				case 1264295088:
				{
					if (field.equals("colorDebug")) 
					{
						__temp_executeDef150 = false;
						return this.colorDebug;
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef150 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_id"))) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef150) 
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
			boolean __temp_executeDef151 = true;
			switch (field.hashCode())
			{
				case 1264295088:
				{
					if (field.equals("colorDebug")) 
					{
						__temp_executeDef151 = false;
						return ((double) (this.colorDebug) );
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef151 = false;
						return ((double) (this.get_id()) );
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef151 = false;
						return ((double) (this._id) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef151) 
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
			boolean __temp_executeDef152 = true;
			switch (field.hashCode())
			{
				case -1776922004:
				{
					if (field.equals("toString")) 
					{
						__temp_executeDef152 = false;
						return this.toString();
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef152 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
				case 1415108474:
				{
					if (field.equals("set_edge")) 
					{
						__temp_executeDef152 = false;
						return this.set_edge(((hxDaedalus.data.Edge) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 900519665:
				{
					if (field.equals("get_isReal")) 
					{
						__temp_executeDef152 = false;
						return this.get_isReal();
					}
					
					break;
				}
				
				
				case 1976220934:
				{
					if (field.equals("get_edge")) 
					{
						__temp_executeDef152 = false;
						return this.get_edge();
					}
					
					break;
				}
				
				
				case -74787349:
				{
					if (field.equals("get_pos")) 
					{
						__temp_executeDef152 = false;
						return this.get_pos();
					}
					
					break;
				}
				
				
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef152 = false;
						this.dispose();
					}
					
					break;
				}
				
				
				case 2132541680:
				{
					if (field.equals("get_fromConstraintSegments")) 
					{
						__temp_executeDef152 = false;
						return this.get_fromConstraintSegments();
					}
					
					break;
				}
				
				
				case 1170407912:
				{
					if (field.equals("removeFromConstraintSegment")) 
					{
						__temp_executeDef152 = false;
						this.removeFromConstraintSegment(((hxDaedalus.data.ConstraintSegment) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case -1790187932:
				{
					if (field.equals("set_fromConstraintSegments")) 
					{
						__temp_executeDef152 = false;
						return this.set_fromConstraintSegments(((haxe.root.Array<hxDaedalus.data.ConstraintSegment>) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 910337515:
				{
					if (field.equals("addFromConstraintSegment")) 
					{
						__temp_executeDef152 = false;
						this.addFromConstraintSegment(((hxDaedalus.data.ConstraintSegment) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 1390069447:
				{
					if (field.equals("setDatas")) 
					{
						__temp_executeDef152 = false;
						this.setDatas(((hxDaedalus.data.Edge) (dynargs.__get(0)) ), dynargs.__get(1));
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef152) 
			{
				return super.__hx_invokeField(field, dynargs);
			}
			
		}
		
		return null;
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("colorDebug");
		baseArr.push("_fromConstraintSegments");
		baseArr.push("_edge");
		baseArr.push("_isReal");
		baseArr.push("_pos");
		baseArr.push("_id");
		baseArr.push("edge");
		baseArr.push("fromConstraintSegments");
		baseArr.push("pos");
		baseArr.push("isReal");
		baseArr.push("id");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


