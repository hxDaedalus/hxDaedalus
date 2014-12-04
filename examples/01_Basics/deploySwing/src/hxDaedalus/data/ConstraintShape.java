package hxDaedalus.data;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class ConstraintShape extends haxe.lang.HxObject
{
	static 
	{
		hxDaedalus.data.ConstraintShape.INC = 0;
	}
	public    ConstraintShape(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    ConstraintShape()
	{
		hxDaedalus.data.ConstraintShape.__hx_ctor_hxDaedalus_data_ConstraintShape(this);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_data_ConstraintShape(hxDaedalus.data.ConstraintShape __temp_me13)
	{
		__temp_me13._id = hxDaedalus.data.ConstraintShape.INC;
		hxDaedalus.data.ConstraintShape.INC++;
		__temp_me13.segments = new haxe.root.Array<hxDaedalus.data.ConstraintSegment>();
	}
	
	
	public static  int INC;
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.data.ConstraintShape(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.data.ConstraintShape();
	}
	
	
	
	
	public  haxe.root.Array<hxDaedalus.data.ConstraintSegment> segments;
	
	public  int _id;
	
	public   int get_id()
	{
		return this._id;
	}
	
	
	public   void dispose()
	{
		while (( this.segments.length > 0 ))
		{
			this.segments.pop().dispose();
		}
		
		this.segments = null;
	}
	
	
	@Override public   double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef117 = true;
			switch (field.hashCode())
			{
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef117 = false;
						this._id = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef117) 
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
			boolean __temp_executeDef118 = true;
			switch (field.hashCode())
			{
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef118 = false;
						this._id = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 1055868832:
				{
					if (field.equals("segments")) 
					{
						__temp_executeDef118 = false;
						this.segments = ((haxe.root.Array<hxDaedalus.data.ConstraintSegment>) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef118) 
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
			boolean __temp_executeDef119 = true;
			switch (field.hashCode())
			{
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef119 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("dispose"))) );
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef119 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef119 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_id"))) );
					}
					
					break;
				}
				
				
				case 1055868832:
				{
					if (field.equals("segments")) 
					{
						__temp_executeDef119 = false;
						return this.segments;
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef119 = false;
						return this._id;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef119) 
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
			boolean __temp_executeDef120 = true;
			switch (field.hashCode())
			{
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef120 = false;
						return ((double) (this._id) );
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef120 = false;
						return ((double) (this.get_id()) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef120) 
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
			boolean __temp_executeDef121 = true;
			switch (field.hashCode())
			{
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef121 = false;
						this.dispose();
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef121 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef121) 
			{
				return super.__hx_invokeField(field, dynargs);
			}
			
		}
		
		return null;
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("_id");
		baseArr.push("segments");
		baseArr.push("id");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


