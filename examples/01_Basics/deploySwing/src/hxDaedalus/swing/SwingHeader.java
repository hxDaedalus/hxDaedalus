package hxDaedalus.swing;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class SwingHeader extends haxe.lang.HxObject
{
	static 
	{
		hxDaedalus.swing.SwingHeader.__meta__ = new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"fields"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"parseInt", "toHashColor"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"static"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{null}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{})), new haxe.lang.DynamicObject(new haxe.root.Array<java.lang.String>(new java.lang.String[]{"static"}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{null}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{}))}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{}))}), new haxe.root.Array<java.lang.String>(new java.lang.String[]{}), new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{}));
	}
	public    SwingHeader(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    SwingHeader()
	{
		hxDaedalus.swing.SwingHeader.__hx_ctor_hxDaedalus_swing_SwingHeader(this);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_swing_SwingHeader(hxDaedalus.swing.SwingHeader __temp_me47)
	{
		haxe.root.Array<java.lang.String> swingHeader = haxe.lang.StringExt.split("600:400:60:FFFFFF", ":");
		__temp_me47.width = ((int) (haxe.lang.Runtime.toInt(haxe.root.Std.parseInt(swingHeader.__get(0)))) );
		__temp_me47.height = ((int) (haxe.lang.Runtime.toInt(haxe.root.Std.parseInt(swingHeader.__get(1)))) );
		__temp_me47.frameRate = ((int) (haxe.lang.Runtime.toInt(haxe.root.Std.parseInt(swingHeader.__get(2)))) );
		__temp_me47.bgColor = ((int) (haxe.lang.Runtime.toInt(haxe.root.Std.parseInt(swingHeader.__get(3)))) );
	}
	
	
	public static  java.lang.Object __meta__;
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.swing.SwingHeader(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.swing.SwingHeader();
	}
	
	
	public  int width;
	
	public  int height;
	
	public  int frameRate;
	
	public  int bgColor;
	
	public final   int parseInt(java.lang.String e)
	{
		return ((int) (haxe.lang.Runtime.toInt(haxe.root.Std.parseInt(e))) );
	}
	
	
	public final   java.lang.String toHashColor(java.lang.String e)
	{
		return ( "#" + e );
	}
	
	
	@Override public   double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef208 = true;
			switch (field.hashCode())
			{
				case -204859874:
				{
					if (field.equals("bgColor")) 
					{
						__temp_executeDef208 = false;
						this.bgColor = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 113126854:
				{
					if (field.equals("width")) 
					{
						__temp_executeDef208 = false;
						this.width = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 545057773:
				{
					if (field.equals("frameRate")) 
					{
						__temp_executeDef208 = false;
						this.frameRate = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -1221029593:
				{
					if (field.equals("height")) 
					{
						__temp_executeDef208 = false;
						this.height = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef208) 
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
			boolean __temp_executeDef209 = true;
			switch (field.hashCode())
			{
				case -204859874:
				{
					if (field.equals("bgColor")) 
					{
						__temp_executeDef209 = false;
						this.bgColor = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 113126854:
				{
					if (field.equals("width")) 
					{
						__temp_executeDef209 = false;
						this.width = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 545057773:
				{
					if (field.equals("frameRate")) 
					{
						__temp_executeDef209 = false;
						this.frameRate = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case -1221029593:
				{
					if (field.equals("height")) 
					{
						__temp_executeDef209 = false;
						this.height = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef209) 
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
			boolean __temp_executeDef210 = true;
			switch (field.hashCode())
			{
				case -338484550:
				{
					if (field.equals("toHashColor")) 
					{
						__temp_executeDef210 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("toHashColor"))) );
					}
					
					break;
				}
				
				
				case 113126854:
				{
					if (field.equals("width")) 
					{
						__temp_executeDef210 = false;
						return this.width;
					}
					
					break;
				}
				
				
				case 1187783740:
				{
					if (field.equals("parseInt")) 
					{
						__temp_executeDef210 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("parseInt"))) );
					}
					
					break;
				}
				
				
				case -1221029593:
				{
					if (field.equals("height")) 
					{
						__temp_executeDef210 = false;
						return this.height;
					}
					
					break;
				}
				
				
				case -204859874:
				{
					if (field.equals("bgColor")) 
					{
						__temp_executeDef210 = false;
						return this.bgColor;
					}
					
					break;
				}
				
				
				case 545057773:
				{
					if (field.equals("frameRate")) 
					{
						__temp_executeDef210 = false;
						return this.frameRate;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef210) 
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
			boolean __temp_executeDef211 = true;
			switch (field.hashCode())
			{
				case -204859874:
				{
					if (field.equals("bgColor")) 
					{
						__temp_executeDef211 = false;
						return ((double) (this.bgColor) );
					}
					
					break;
				}
				
				
				case 113126854:
				{
					if (field.equals("width")) 
					{
						__temp_executeDef211 = false;
						return ((double) (this.width) );
					}
					
					break;
				}
				
				
				case 545057773:
				{
					if (field.equals("frameRate")) 
					{
						__temp_executeDef211 = false;
						return ((double) (this.frameRate) );
					}
					
					break;
				}
				
				
				case -1221029593:
				{
					if (field.equals("height")) 
					{
						__temp_executeDef211 = false;
						return ((double) (this.height) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef211) 
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
			boolean __temp_executeDef212 = true;
			switch (field.hashCode())
			{
				case -338484550:
				{
					if (field.equals("toHashColor")) 
					{
						__temp_executeDef212 = false;
						return this.toHashColor(haxe.lang.Runtime.toString(dynargs.__get(0)));
					}
					
					break;
				}
				
				
				case 1187783740:
				{
					if (field.equals("parseInt")) 
					{
						__temp_executeDef212 = false;
						return this.parseInt(haxe.lang.Runtime.toString(dynargs.__get(0)));
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef212) 
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
		baseArr.push("bgColor");
		baseArr.push("frameRate");
		baseArr.push("height");
		baseArr.push("width");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


