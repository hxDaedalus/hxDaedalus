package _Array;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public final class ArrayIterator<T> extends haxe.lang.HxObject
{
	public    ArrayIterator(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    ArrayIterator(haxe.root.Array<T> a)
	{
		_Array.ArrayIterator.__hx_ctor__Array_ArrayIterator(this, a);
	}
	
	
	public static  <T_c> void __hx_ctor__Array_ArrayIterator(_Array.ArrayIterator<T_c> __temp_me2, haxe.root.Array<T_c> a)
	{
		__temp_me2.arr = a;
		__temp_me2.len = a.length;
		__temp_me2.i = 0;
	}
	
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new _Array.ArrayIterator<java.lang.Object>(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new _Array.ArrayIterator<java.lang.Object>(((haxe.root.Array<java.lang.Object>) (arr.__get(0)) ));
	}
	
	
	public  haxe.root.Array<T> arr;
	
	public  int len;
	
	public  int i;
	
	public final   boolean hasNext()
	{
		return ( this.i < this.len );
	}
	
	
	public final   T next()
	{
		return this.arr.__get(this.i++);
	}
	
	
	@Override public   double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef63 = true;
			switch (field.hashCode())
			{
				case 105:
				{
					if (field.equals("i")) 
					{
						__temp_executeDef63 = false;
						this.i = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 107029:
				{
					if (field.equals("len")) 
					{
						__temp_executeDef63 = false;
						this.len = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef63) 
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
			boolean __temp_executeDef64 = true;
			switch (field.hashCode())
			{
				case 105:
				{
					if (field.equals("i")) 
					{
						__temp_executeDef64 = false;
						this.i = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 96865:
				{
					if (field.equals("arr")) 
					{
						__temp_executeDef64 = false;
						this.arr = ((haxe.root.Array<T>) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 107029:
				{
					if (field.equals("len")) 
					{
						__temp_executeDef64 = false;
						this.len = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef64) 
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
			boolean __temp_executeDef65 = true;
			switch (field.hashCode())
			{
				case 3377907:
				{
					if (field.equals("next")) 
					{
						__temp_executeDef65 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("next"))) );
					}
					
					break;
				}
				
				
				case 96865:
				{
					if (field.equals("arr")) 
					{
						__temp_executeDef65 = false;
						return this.arr;
					}
					
					break;
				}
				
				
				case 696759469:
				{
					if (field.equals("hasNext")) 
					{
						__temp_executeDef65 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("hasNext"))) );
					}
					
					break;
				}
				
				
				case 107029:
				{
					if (field.equals("len")) 
					{
						__temp_executeDef65 = false;
						return this.len;
					}
					
					break;
				}
				
				
				case 105:
				{
					if (field.equals("i")) 
					{
						__temp_executeDef65 = false;
						return this.i;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef65) 
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
			boolean __temp_executeDef66 = true;
			switch (field.hashCode())
			{
				case 105:
				{
					if (field.equals("i")) 
					{
						__temp_executeDef66 = false;
						return ((double) (this.i) );
					}
					
					break;
				}
				
				
				case 107029:
				{
					if (field.equals("len")) 
					{
						__temp_executeDef66 = false;
						return ((double) (this.len) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef66) 
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
			boolean __temp_executeDef67 = true;
			switch (field.hashCode())
			{
				case 3377907:
				{
					if (field.equals("next")) 
					{
						__temp_executeDef67 = false;
						return this.next();
					}
					
					break;
				}
				
				
				case 696759469:
				{
					if (field.equals("hasNext")) 
					{
						__temp_executeDef67 = false;
						return this.hasNext();
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef67) 
			{
				return super.__hx_invokeField(field, dynargs);
			}
			 else 
			{
				throw null;
			}
			
		}
		
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("i");
		baseArr.push("len");
		baseArr.push("arr");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


