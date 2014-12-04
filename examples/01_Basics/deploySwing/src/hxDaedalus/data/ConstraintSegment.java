package hxDaedalus.data;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class ConstraintSegment extends haxe.lang.HxObject
{
	static 
	{
		hxDaedalus.data.ConstraintSegment.INC = 0;
	}
	public    ConstraintSegment(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    ConstraintSegment()
	{
		hxDaedalus.data.ConstraintSegment.__hx_ctor_hxDaedalus_data_ConstraintSegment(this);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_data_ConstraintSegment(hxDaedalus.data.ConstraintSegment __temp_me12)
	{
		__temp_me12._id = hxDaedalus.data.ConstraintSegment.INC;
		hxDaedalus.data.ConstraintSegment.INC++;
		__temp_me12._edges = new haxe.root.Array<hxDaedalus.data.Edge>();
	}
	
	
	public static  int INC;
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.data.ConstraintSegment(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.data.ConstraintSegment();
	}
	
	
	
	
	public  hxDaedalus.data.ConstraintShape fromShape;
	
	
	
	public  int _id;
	
	public  haxe.root.Array<hxDaedalus.data.Edge> _edges;
	
	public   int get_id()
	{
		return this._id;
	}
	
	
	public   void addEdge(hxDaedalus.data.Edge edge)
	{
		if (( ( this._edges.indexOf(edge, null) == -1 ) && ( this._edges.indexOf(edge.get_oppositeEdge(), null) == -1 ) )) 
		{
			this._edges.push(edge);
		}
		
	}
	
	
	public   void removeEdge(hxDaedalus.data.Edge edge)
	{
		int index = 0;
		index = this._edges.indexOf(edge, null);
		if (( index == -1 )) 
		{
			index = this._edges.indexOf(edge.get_oppositeEdge(), null);
		}
		
		if (( index != -1 )) 
		{
			this._edges.splice(index, 1);
		}
		
	}
	
	
	public   haxe.root.Array<hxDaedalus.data.Edge> get_edges()
	{
		return this._edges;
	}
	
	
	public   void dispose()
	{
		this._edges = null;
		this.fromShape = null;
	}
	
	
	@Override public   java.lang.String toString()
	{
		return ( "seg_id " + this._id );
	}
	
	
	@Override public   double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef112 = true;
			switch (field.hashCode())
			{
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef112 = false;
						this._id = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef112) 
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
			boolean __temp_executeDef113 = true;
			switch (field.hashCode())
			{
				case -1478841001:
				{
					if (field.equals("_edges")) 
					{
						__temp_executeDef113 = false;
						this._edges = ((haxe.root.Array<hxDaedalus.data.Edge>) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 69239319:
				{
					if (field.equals("fromShape")) 
					{
						__temp_executeDef113 = false;
						this.fromShape = ((hxDaedalus.data.ConstraintShape) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef113 = false;
						this._id = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef113) 
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
			boolean __temp_executeDef114 = true;
			switch (field.hashCode())
			{
				case -1776922004:
				{
					if (field.equals("toString")) 
					{
						__temp_executeDef114 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("toString"))) );
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef114 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef114 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("dispose"))) );
					}
					
					break;
				}
				
				
				case 69239319:
				{
					if (field.equals("fromShape")) 
					{
						__temp_executeDef114 = false;
						return this.fromShape;
					}
					
					break;
				}
				
				
				case 1133306925:
				{
					if (field.equals("get_edges")) 
					{
						__temp_executeDef114 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_edges"))) );
					}
					
					break;
				}
				
				
				case 96356950:
				{
					if (field.equals("edges")) 
					{
						__temp_executeDef114 = false;
						return this.get_edges();
					}
					
					break;
				}
				
				
				case 1098119265:
				{
					if (field.equals("removeEdge")) 
					{
						__temp_executeDef114 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeEdge"))) );
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef114 = false;
						return this._id;
					}
					
					break;
				}
				
				
				case -1149033986:
				{
					if (field.equals("addEdge")) 
					{
						__temp_executeDef114 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addEdge"))) );
					}
					
					break;
				}
				
				
				case -1478841001:
				{
					if (field.equals("_edges")) 
					{
						__temp_executeDef114 = false;
						return this._edges;
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef114 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_id"))) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef114) 
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
			boolean __temp_executeDef115 = true;
			switch (field.hashCode())
			{
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef115 = false;
						return ((double) (this._id) );
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef115 = false;
						return ((double) (this.get_id()) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef115) 
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
			boolean __temp_executeDef116 = true;
			switch (field.hashCode())
			{
				case -1776922004:
				{
					if (field.equals("toString")) 
					{
						__temp_executeDef116 = false;
						return this.toString();
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef116 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef116 = false;
						this.dispose();
					}
					
					break;
				}
				
				
				case -1149033986:
				{
					if (field.equals("addEdge")) 
					{
						__temp_executeDef116 = false;
						this.addEdge(((hxDaedalus.data.Edge) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 1133306925:
				{
					if (field.equals("get_edges")) 
					{
						__temp_executeDef116 = false;
						return this.get_edges();
					}
					
					break;
				}
				
				
				case 1098119265:
				{
					if (field.equals("removeEdge")) 
					{
						__temp_executeDef116 = false;
						this.removeEdge(((hxDaedalus.data.Edge) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef116) 
			{
				return super.__hx_invokeField(field, dynargs);
			}
			
		}
		
		return null;
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("_edges");
		baseArr.push("_id");
		baseArr.push("edges");
		baseArr.push("fromShape");
		baseArr.push("id");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


