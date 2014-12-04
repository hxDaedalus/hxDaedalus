package hxDaedalus.data.math;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class Matrix2D extends haxe.lang.HxObject
{
	public    Matrix2D(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    Matrix2D(java.lang.Object a_, java.lang.Object b_, java.lang.Object c_, java.lang.Object d_, java.lang.Object e_, java.lang.Object f_)
	{
		hxDaedalus.data.math.Matrix2D.__hx_ctor_hxDaedalus_data_math_Matrix2D(this, a_, b_, c_, d_, e_, f_);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_data_math_Matrix2D(hxDaedalus.data.math.Matrix2D __temp_me35, java.lang.Object a_, java.lang.Object b_, java.lang.Object c_, java.lang.Object d_, java.lang.Object e_, java.lang.Object f_)
	{
		double __temp_f_34 = ( (( f_ == null )) ? (((double) (0) )) : (((double) (haxe.lang.Runtime.toDouble(f_)) )) );
		double __temp_e_33 = ( (( e_ == null )) ? (((double) (0) )) : (((double) (haxe.lang.Runtime.toDouble(e_)) )) );
		double __temp_d_32 = ( (( d_ == null )) ? (((double) (1) )) : (((double) (haxe.lang.Runtime.toDouble(d_)) )) );
		double __temp_c_31 = ( (( c_ == null )) ? (((double) (0) )) : (((double) (haxe.lang.Runtime.toDouble(c_)) )) );
		double __temp_b_30 = ( (( b_ == null )) ? (((double) (0) )) : (((double) (haxe.lang.Runtime.toDouble(b_)) )) );
		double __temp_a_29 = ( (( a_ == null )) ? (((double) (1) )) : (((double) (haxe.lang.Runtime.toDouble(a_)) )) );
		__temp_me35.a = __temp_a_29;
		__temp_me35.b = __temp_b_30;
		__temp_me35.c = __temp_c_31;
		__temp_me35.d = __temp_d_32;
		__temp_me35.e = __temp_e_33;
		__temp_me35.f = __temp_f_34;
	}
	
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.data.math.Matrix2D(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.data.math.Matrix2D(((java.lang.Object) (arr.__get(0)) ), ((java.lang.Object) (arr.__get(1)) ), ((java.lang.Object) (arr.__get(2)) ), ((java.lang.Object) (arr.__get(3)) ), ((java.lang.Object) (arr.__get(4)) ), ((java.lang.Object) (arr.__get(5)) ));
	}
	
	
	public  double a;
	
	public  double b;
	
	public  double c;
	
	public  double d;
	
	public  double e;
	
	public  double f;
	
	public   void identity()
	{
		this.a = ((double) (1) );
		this.b = ((double) (0) );
		this.c = ((double) (0) );
		this.d = ((double) (1) );
		this.e = ((double) (0) );
		this.f = ((double) (0) );
	}
	
	
	public   void translate(double tx, double ty)
	{
		this.e = ( this.e + tx );
		this.f = ( this.f + ty );
	}
	
	
	public   void scale(double sx, double sy)
	{
		this.a = ( this.a * sx );
		this.b = ( this.b * sy );
		this.c = ( this.c * sx );
		this.d = ( this.d * sy );
		this.e = ( this.e * sx );
		this.f = ( this.f * sy );
	}
	
	
	public   void rotate(double rad)
	{
		double cos = java.lang.Math.cos(rad);
		double sin = java.lang.Math.sin(rad);
		double a_ = ( ( this.a * cos ) + ( this.b *  - (sin)  ) );
		double b_ = ( ( this.a * sin ) + ( this.b * cos ) );
		double c_ = ( ( this.c * cos ) + ( this.d *  - (sin)  ) );
		double d_ = ( ( this.c * sin ) + ( this.d * cos ) );
		double e_ = ( ( this.e * cos ) + ( this.f *  - (sin)  ) );
		double f_ = ( ( this.e * sin ) + ( this.f * cos ) );
		this.a = a_;
		this.b = b_;
		this.c = c_;
		this.d = d_;
		this.e = e_;
		this.f = f_;
	}
	
	
	public   hxDaedalus.data.math.Matrix2D clone()
	{
		return new hxDaedalus.data.math.Matrix2D(((java.lang.Object) (this.a) ), ((java.lang.Object) (this.b) ), ((java.lang.Object) (this.c) ), ((java.lang.Object) (this.d) ), ((java.lang.Object) (this.e) ), ((java.lang.Object) (this.f) ));
	}
	
	
	public   void tranform(hxDaedalus.data.math.Point2D point)
	{
		double x = ( ( ( this.a * point.x ) + ( this.c * point.y ) ) + this.e );
		double y = ( ( ( this.b * point.x ) + ( this.d * point.y ) ) + this.f );
		point.x = x;
		point.y = y;
	}
	
	
	public   double transformX(double x, double y)
	{
		return ( ( ( this.a * x ) + ( this.c * y ) ) + this.e );
	}
	
	
	public   double transformY(double x, double y)
	{
		return ( ( ( this.b * x ) + ( this.d * y ) ) + this.f );
	}
	
	
	public   void concat(hxDaedalus.data.math.Matrix2D matrix)
	{
		double a_ = ( ( this.a * matrix.a ) + ( this.b * matrix.c ) );
		double b_ = ( ( this.a * matrix.b ) + ( this.b * matrix.d ) );
		double c_ = ( ( this.c * matrix.a ) + ( this.d * matrix.c ) );
		double d_ = ( ( this.c * matrix.b ) + ( this.d * matrix.d ) );
		double e_ = ( ( ( this.e * matrix.a ) + ( this.f * matrix.c ) ) + matrix.e );
		double f_ = ( ( ( this.e * matrix.b ) + ( this.f * matrix.d ) ) + matrix.f );
		this.a = a_;
		this.b = b_;
		this.c = c_;
		this.d = d_;
		this.e = e_;
		this.f = f_;
	}
	
	
	@Override public   double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef175 = true;
			switch (field.hashCode())
			{
				case 102:
				{
					if (field.equals("f")) 
					{
						__temp_executeDef175 = false;
						this.f = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 97:
				{
					if (field.equals("a")) 
					{
						__temp_executeDef175 = false;
						this.a = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 101:
				{
					if (field.equals("e")) 
					{
						__temp_executeDef175 = false;
						this.e = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 98:
				{
					if (field.equals("b")) 
					{
						__temp_executeDef175 = false;
						this.b = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 100:
				{
					if (field.equals("d")) 
					{
						__temp_executeDef175 = false;
						this.d = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 99:
				{
					if (field.equals("c")) 
					{
						__temp_executeDef175 = false;
						this.c = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef175) 
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
			boolean __temp_executeDef176 = true;
			switch (field.hashCode())
			{
				case 102:
				{
					if (field.equals("f")) 
					{
						__temp_executeDef176 = false;
						this.f = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 97:
				{
					if (field.equals("a")) 
					{
						__temp_executeDef176 = false;
						this.a = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 101:
				{
					if (field.equals("e")) 
					{
						__temp_executeDef176 = false;
						this.e = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 98:
				{
					if (field.equals("b")) 
					{
						__temp_executeDef176 = false;
						this.b = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 100:
				{
					if (field.equals("d")) 
					{
						__temp_executeDef176 = false;
						this.d = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 99:
				{
					if (field.equals("c")) 
					{
						__temp_executeDef176 = false;
						this.c = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef176) 
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
			boolean __temp_executeDef177 = true;
			switch (field.hashCode())
			{
				case -1354795244:
				{
					if (field.equals("concat")) 
					{
						__temp_executeDef177 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("concat"))) );
					}
					
					break;
				}
				
				
				case 97:
				{
					if (field.equals("a")) 
					{
						__temp_executeDef177 = false;
						return this.a;
					}
					
					break;
				}
				
				
				case -1727069587:
				{
					if (field.equals("transformY")) 
					{
						__temp_executeDef177 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("transformY"))) );
					}
					
					break;
				}
				
				
				case 98:
				{
					if (field.equals("b")) 
					{
						__temp_executeDef177 = false;
						return this.b;
					}
					
					break;
				}
				
				
				case -1727069588:
				{
					if (field.equals("transformX")) 
					{
						__temp_executeDef177 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("transformX"))) );
					}
					
					break;
				}
				
				
				case 99:
				{
					if (field.equals("c")) 
					{
						__temp_executeDef177 = false;
						return this.c;
					}
					
					break;
				}
				
				
				case 1280504431:
				{
					if (field.equals("tranform")) 
					{
						__temp_executeDef177 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("tranform"))) );
					}
					
					break;
				}
				
				
				case 100:
				{
					if (field.equals("d")) 
					{
						__temp_executeDef177 = false;
						return this.d;
					}
					
					break;
				}
				
				
				case 94756189:
				{
					if (field.equals("clone")) 
					{
						__temp_executeDef177 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("clone"))) );
					}
					
					break;
				}
				
				
				case 101:
				{
					if (field.equals("e")) 
					{
						__temp_executeDef177 = false;
						return this.e;
					}
					
					break;
				}
				
				
				case -925180581:
				{
					if (field.equals("rotate")) 
					{
						__temp_executeDef177 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("rotate"))) );
					}
					
					break;
				}
				
				
				case 102:
				{
					if (field.equals("f")) 
					{
						__temp_executeDef177 = false;
						return this.f;
					}
					
					break;
				}
				
				
				case 109250890:
				{
					if (field.equals("scale")) 
					{
						__temp_executeDef177 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("scale"))) );
					}
					
					break;
				}
				
				
				case -135761730:
				{
					if (field.equals("identity")) 
					{
						__temp_executeDef177 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("identity"))) );
					}
					
					break;
				}
				
				
				case 1052832078:
				{
					if (field.equals("translate")) 
					{
						__temp_executeDef177 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("translate"))) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef177) 
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
			boolean __temp_executeDef178 = true;
			switch (field.hashCode())
			{
				case 102:
				{
					if (field.equals("f")) 
					{
						__temp_executeDef178 = false;
						return this.f;
					}
					
					break;
				}
				
				
				case 97:
				{
					if (field.equals("a")) 
					{
						__temp_executeDef178 = false;
						return this.a;
					}
					
					break;
				}
				
				
				case 101:
				{
					if (field.equals("e")) 
					{
						__temp_executeDef178 = false;
						return this.e;
					}
					
					break;
				}
				
				
				case 98:
				{
					if (field.equals("b")) 
					{
						__temp_executeDef178 = false;
						return this.b;
					}
					
					break;
				}
				
				
				case 100:
				{
					if (field.equals("d")) 
					{
						__temp_executeDef178 = false;
						return this.d;
					}
					
					break;
				}
				
				
				case 99:
				{
					if (field.equals("c")) 
					{
						__temp_executeDef178 = false;
						return this.c;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef178) 
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
			boolean __temp_executeDef179 = true;
			switch (field.hashCode())
			{
				case -1354795244:
				{
					if (field.equals("concat")) 
					{
						__temp_executeDef179 = false;
						this.concat(((hxDaedalus.data.math.Matrix2D) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case -135761730:
				{
					if (field.equals("identity")) 
					{
						__temp_executeDef179 = false;
						this.identity();
					}
					
					break;
				}
				
				
				case -1727069587:
				{
					if (field.equals("transformY")) 
					{
						__temp_executeDef179 = false;
						return this.transformY(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(1))) ));
					}
					
					break;
				}
				
				
				case 1052832078:
				{
					if (field.equals("translate")) 
					{
						__temp_executeDef179 = false;
						this.translate(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(1))) ));
					}
					
					break;
				}
				
				
				case -1727069588:
				{
					if (field.equals("transformX")) 
					{
						__temp_executeDef179 = false;
						return this.transformX(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(1))) ));
					}
					
					break;
				}
				
				
				case 109250890:
				{
					if (field.equals("scale")) 
					{
						__temp_executeDef179 = false;
						this.scale(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ), ((double) (haxe.lang.Runtime.toDouble(dynargs.__get(1))) ));
					}
					
					break;
				}
				
				
				case 1280504431:
				{
					if (field.equals("tranform")) 
					{
						__temp_executeDef179 = false;
						this.tranform(((hxDaedalus.data.math.Point2D) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case -925180581:
				{
					if (field.equals("rotate")) 
					{
						__temp_executeDef179 = false;
						this.rotate(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ));
					}
					
					break;
				}
				
				
				case 94756189:
				{
					if (field.equals("clone")) 
					{
						__temp_executeDef179 = false;
						return this.clone();
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef179) 
			{
				return super.__hx_invokeField(field, dynargs);
			}
			
		}
		
		return null;
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("f");
		baseArr.push("e");
		baseArr.push("d");
		baseArr.push("c");
		baseArr.push("b");
		baseArr.push("a");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


