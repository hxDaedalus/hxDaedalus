package hxDaedalus.data.math;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class Point2D extends haxe.lang.HxObject
{
	public    Point2D(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    Point2D(java.lang.Object x_, java.lang.Object y_)
	{
		hxDaedalus.data.math.Point2D.__hx_ctor_hxDaedalus_data_math_Point2D(this, x_, y_);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_data_math_Point2D(hxDaedalus.data.math.Point2D __temp_me25, java.lang.Object x_, java.lang.Object y_)
	{
		double __temp_y_24 = ( (( y_ == null )) ? (((double) (0) )) : (((double) (haxe.lang.Runtime.toDouble(y_)) )) );
		double __temp_x_23 = ( (( x_ == null )) ? (((double) (0) )) : (((double) (haxe.lang.Runtime.toDouble(x_)) )) );
		__temp_me25.x = __temp_x_23;
		__temp_me25.y = __temp_y_24;
	}
	
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.data.math.Point2D(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.data.math.Point2D(((java.lang.Object) (arr.__get(0)) ), ((java.lang.Object) (arr.__get(1)) ));
	}
	
	
	
	
	public  double x;
	
	public  double y;
	
	public   void transform(hxDaedalus.data.math.Matrix2D matrix)
	{
		matrix.tranform(this);
	}
	
	
	public   void setXY(double x_, double y_)
	{
		this.x = x_;
		this.y = y_;
	}
	
	
	public   hxDaedalus.data.math.Point2D clone()
	{
		return new hxDaedalus.data.math.Point2D(((java.lang.Object) (this.x) ), ((java.lang.Object) (this.y) ));
	}
	
	
	public   void substract(hxDaedalus.data.math.Point2D p)
	{
		this.x -= p.x;
		this.y -= p.y;
	}
	
	
	public   double get_length()
	{
		return java.lang.Math.sqrt(( ( this.x * this.x ) + ( this.y * this.y ) ));
	}
	
	
	public   void normalize()
	{
		double norm = this.get_length();
		this.x = ( this.x / norm );
		this.y = ( this.y / norm );
	}
	
	
	public   void scale(double s)
	{
		this.x = ( this.x * s );
		this.y = ( this.y * s );
	}
	
	
	public   double distanceTo(hxDaedalus.data.math.Point2D p)
	{
		double diffX = ( this.x - p.x );
		double diffY = ( this.y - p.y );
		return java.lang.Math.sqrt(( ( diffX * diffX ) + ( diffY * diffY ) ));
	}
	
	
	@Override public   double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef153 = true;
			switch (field.hashCode())
			{
				case 121:
				{
					if (field.equals("y")) 
					{
						__temp_executeDef153 = false;
						this.y = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 120:
				{
					if (field.equals("x")) 
					{
						__temp_executeDef153 = false;
						this.x = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef153) 
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
			boolean __temp_executeDef154 = true;
			switch (field.hashCode())
			{
				case 121:
				{
					if (field.equals("y")) 
					{
						__temp_executeDef154 = false;
						this.y = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 120:
				{
					if (field.equals("x")) 
					{
						__temp_executeDef154 = false;
						this.x = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef154) 
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
			boolean __temp_executeDef155 = true;
			switch (field.hashCode())
			{
				case -1963037360:
				{
					if (field.equals("distanceTo")) 
					{
						__temp_executeDef155 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("distanceTo"))) );
					}
					
					break;
				}
				
				
				case -1106363674:
				{
					if (field.equals("length")) 
					{
						__temp_executeDef155 = false;
						return this.get_length();
					}
					
					break;
				}
				
				
				case 109250890:
				{
					if (field.equals("scale")) 
					{
						__temp_executeDef155 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("scale"))) );
					}
					
					break;
				}
				
				
				case 120:
				{
					if (field.equals("x")) 
					{
						__temp_executeDef155 = false;
						return this.x;
					}
					
					break;
				}
				
				
				case 236609293:
				{
					if (field.equals("normalize")) 
					{
						__temp_executeDef155 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("normalize"))) );
					}
					
					break;
				}
				
				
				case 121:
				{
					if (field.equals("y")) 
					{
						__temp_executeDef155 = false;
						return this.y;
					}
					
					break;
				}
				
				
				case 974314479:
				{
					if (field.equals("get_length")) 
					{
						__temp_executeDef155 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_length"))) );
					}
					
					break;
				}
				
				
				case 1052666732:
				{
					if (field.equals("transform")) 
					{
						__temp_executeDef155 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("transform"))) );
					}
					
					break;
				}
				
				
				case 530534145:
				{
					if (field.equals("substract")) 
					{
						__temp_executeDef155 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("substract"))) );
					}
					
					break;
				}
				
				
				case 109328099:
				{
					if (field.equals("setXY")) 
					{
						__temp_executeDef155 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setXY"))) );
					}
					
					break;
				}
				
				
				case 94756189:
				{
					if (field.equals("clone")) 
					{
						__temp_executeDef155 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("clone"))) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef155) 
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
			boolean __temp_executeDef156 = true;
			switch (field.hashCode())
			{
				case 121:
				{
					if (field.equals("y")) 
					{
						__temp_executeDef156 = false;
						return this.y;
					}
					
					break;
				}
				
				
				case -1106363674:
				{
					if (field.equals("length")) 
					{
						__temp_executeDef156 = false;
						return this.get_length();
					}
					
					break;
				}
				
				
				case 120:
				{
					if (field.equals("x")) 
					{
						__temp_executeDef156 = false;
						return this.x;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef156) 
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
			boolean __temp_executeDef157 = true;
			switch (field.hashCode())
			{
				case -1963037360:
				{
					if (field.equals("distanceTo")) 
					{
						__temp_executeDef157 = false;
						return this.distanceTo(((hxDaedalus.data.math.Point2D) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 1052666732:
				{
					if (field.equals("transform")) 
					{
						__temp_executeDef157 = false;
						this.transform(((hxDaedalus.data.math.Matrix2D) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case 109250890:
				{
					if (field.equals("scale")) 
					{
						__temp_executeDef157 = false;
						this.scale(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ));
					}
					
					break;
				}
				
				
				case 109328099:
				{
					if (field.equals("setXY")) 
					{
						__temp_executeDef157 = false;
						this.setXY(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(1))) ));
					}
					
					break;
				}
				
				
				case 236609293:
				{
					if (field.equals("normalize")) 
					{
						__temp_executeDef157 = false;
						this.normalize();
					}
					
					break;
				}
				
				
				case 94756189:
				{
					if (field.equals("clone")) 
					{
						__temp_executeDef157 = false;
						return this.clone();
					}
					
					break;
				}
				
				
				case 974314479:
				{
					if (field.equals("get_length")) 
					{
						__temp_executeDef157 = false;
						return this.get_length();
					}
					
					break;
				}
				
				
				case 530534145:
				{
					if (field.equals("substract")) 
					{
						__temp_executeDef157 = false;
						this.substract(((hxDaedalus.data.math.Point2D) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef157) 
			{
				return super.__hx_invokeField(field, dynargs);
			}
			
		}
		
		return null;
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("y");
		baseArr.push("x");
		baseArr.push("length");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


