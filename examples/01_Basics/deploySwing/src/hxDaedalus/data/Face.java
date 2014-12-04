package hxDaedalus.data;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class Face extends haxe.lang.HxObject
{
	static 
	{
		hxDaedalus.data.Face.INC = 0;
	}
	public    Face(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    Face()
	{
		hxDaedalus.data.Face.__hx_ctor_hxDaedalus_data_Face(this);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_data_Face(hxDaedalus.data.Face __temp_me18)
	{
		__temp_me18.colorDebug = -1;
		__temp_me18._id = hxDaedalus.data.Face.INC;
		hxDaedalus.data.Face.INC++;
	}
	
	
	public static  int INC;
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.data.Face(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.data.Face();
	}
	
	
	
	
	
	
	
	
	public  int _id;
	
	public  boolean _isReal;
	
	public  hxDaedalus.data.Edge _edge;
	
	public  int colorDebug;
	
	public   int get_id()
	{
		return this._id;
	}
	
	
	public   boolean get_isReal()
	{
		return this._isReal;
	}
	
	
	public   void set_datas(hxDaedalus.data.Edge edge)
	{
		this._isReal = true;
		this._edge = edge;
	}
	
	
	public   void setDatas(hxDaedalus.data.Edge edge, java.lang.Object isReal)
	{
		boolean __temp_isReal17 = ( (( isReal == null )) ? (haxe.lang.Runtime.toBool(true)) : (haxe.lang.Runtime.toBool(isReal)) );
		this._isReal = __temp_isReal17;
		this._edge = edge;
	}
	
	
	public   void dispose()
	{
		this._edge = null;
	}
	
	
	public   hxDaedalus.data.Edge get_edge()
	{
		return this._edge;
	}
	
	
	@Override public   double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef127 = true;
			switch (field.hashCode())
			{
				case 1264295088:
				{
					if (field.equals("colorDebug")) 
					{
						__temp_executeDef127 = false;
						this.colorDebug = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef127 = false;
						this._id = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef127) 
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
			boolean __temp_executeDef128 = true;
			switch (field.hashCode())
			{
				case 1264295088:
				{
					if (field.equals("colorDebug")) 
					{
						__temp_executeDef128 = false;
						this.colorDebug = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef128 = false;
						this._id = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 90842780:
				{
					if (field.equals("_edge")) 
					{
						__temp_executeDef128 = false;
						this._edge = ((hxDaedalus.data.Edge) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 1528312583:
				{
					if (field.equals("_isReal")) 
					{
						__temp_executeDef128 = false;
						this._isReal = haxe.lang.Runtime.toBool(value);
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef128) 
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
			boolean __temp_executeDef129 = true;
			switch (field.hashCode())
			{
				case 1976220934:
				{
					if (field.equals("get_edge")) 
					{
						__temp_executeDef129 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_edge"))) );
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef129 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef129 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("dispose"))) );
					}
					
					break;
				}
				
				
				case -1180158488:
				{
					if (field.equals("isReal")) 
					{
						__temp_executeDef129 = false;
						return this.get_isReal();
					}
					
					break;
				}
				
				
				case 1390069447:
				{
					if (field.equals("setDatas")) 
					{
						__temp_executeDef129 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setDatas"))) );
					}
					
					break;
				}
				
				
				case 3108285:
				{
					if (field.equals("edge")) 
					{
						__temp_executeDef129 = false;
						return this.get_edge();
					}
					
					break;
				}
				
				
				case 917689324:
				{
					if (field.equals("set_datas")) 
					{
						__temp_executeDef129 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_datas"))) );
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef129 = false;
						return this._id;
					}
					
					break;
				}
				
				
				case 900519665:
				{
					if (field.equals("get_isReal")) 
					{
						__temp_executeDef129 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_isReal"))) );
					}
					
					break;
				}
				
				
				case 1528312583:
				{
					if (field.equals("_isReal")) 
					{
						__temp_executeDef129 = false;
						return this._isReal;
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef129 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_id"))) );
					}
					
					break;
				}
				
				
				case 90842780:
				{
					if (field.equals("_edge")) 
					{
						__temp_executeDef129 = false;
						return this._edge;
					}
					
					break;
				}
				
				
				case 1264295088:
				{
					if (field.equals("colorDebug")) 
					{
						__temp_executeDef129 = false;
						return this.colorDebug;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef129) 
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
			boolean __temp_executeDef130 = true;
			switch (field.hashCode())
			{
				case 1264295088:
				{
					if (field.equals("colorDebug")) 
					{
						__temp_executeDef130 = false;
						return ((double) (this.colorDebug) );
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef130 = false;
						return ((double) (this.get_id()) );
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef130 = false;
						return ((double) (this._id) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef130) 
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
			boolean __temp_executeDef131 = true;
			switch (field.hashCode())
			{
				case 1976220934:
				{
					if (field.equals("get_edge")) 
					{
						__temp_executeDef131 = false;
						return this.get_edge();
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef131 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef131 = false;
						this.dispose();
					}
					
					break;
				}
				
				
				case 900519665:
				{
					if (field.equals("get_isReal")) 
					{
						__temp_executeDef131 = false;
						return this.get_isReal();
					}
					
					break;
				}
				
				
				case 1390069447:
				{
					if (field.equals("setDatas")) 
					{
						__temp_executeDef131 = false;
						this.setDatas(((hxDaedalus.data.Edge) (dynargs.__get(0)) ), dynargs.__get(1));
					}
					
					break;
				}
				
				
				case 917689324:
				{
					if (field.equals("set_datas")) 
					{
						__temp_executeDef131 = false;
						this.set_datas(((hxDaedalus.data.Edge) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef131) 
			{
				return super.__hx_invokeField(field, dynargs);
			}
			
		}
		
		return null;
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("colorDebug");
		baseArr.push("_edge");
		baseArr.push("_isReal");
		baseArr.push("_id");
		baseArr.push("edge");
		baseArr.push("isReal");
		baseArr.push("id");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


