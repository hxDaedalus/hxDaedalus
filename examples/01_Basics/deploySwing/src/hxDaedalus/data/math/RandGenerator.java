package hxDaedalus.data.math;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class RandGenerator extends haxe.lang.HxObject
{
	public    RandGenerator(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    RandGenerator(java.lang.Object seed, java.lang.Object rangeMin_, java.lang.Object rangeMax_)
	{
		hxDaedalus.data.math.RandGenerator.__hx_ctor_hxDaedalus_data_math_RandGenerator(this, seed, rangeMin_, rangeMax_);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_data_math_RandGenerator(hxDaedalus.data.math.RandGenerator __temp_me39, java.lang.Object seed, java.lang.Object rangeMin_, java.lang.Object rangeMax_)
	{
		int __temp_rangeMax_38 = ( (( rangeMax_ == null )) ? (((int) (1) )) : (((int) (haxe.lang.Runtime.toInt(rangeMax_)) )) );
		int __temp_rangeMin_37 = ( (( rangeMin_ == null )) ? (((int) (0) )) : (((int) (haxe.lang.Runtime.toInt(rangeMin_)) )) );
		int __temp_seed36 = ( (( seed == null )) ? (((int) (1234) )) : (((int) (haxe.lang.Runtime.toInt(seed)) )) );
		__temp_me39._originalSeed = __temp_me39._currSeed = __temp_seed36;
		__temp_me39.rangeMin = __temp_rangeMin_37;
		__temp_me39.rangeMax = __temp_rangeMax_38;
		__temp_me39._numIter = 0;
	}
	
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.data.math.RandGenerator(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.data.math.RandGenerator(((java.lang.Object) (arr.__get(0)) ), ((java.lang.Object) (arr.__get(1)) ), ((java.lang.Object) (arr.__get(2)) ));
	}
	
	
	
	
	public  int rangeMin;
	
	public  int rangeMax;
	
	public  int _originalSeed;
	
	public  int _currSeed;
	
	public  int _rangeMin;
	
	public  int _rangeMax;
	
	public  int _numIter;
	
	public  java.lang.String _tempString;
	
	public   int set_seed(int value)
	{
		this._originalSeed = this._currSeed = value;
		return value;
	}
	
	
	public   int get_seed()
	{
		return this._originalSeed;
	}
	
	
	public   void reset()
	{
		this._currSeed = this._originalSeed;
		this._numIter = 0;
	}
	
	
	public   int next()
	{
		double _floatSeed = ( this._currSeed * 1.0 );
		this._tempString = haxe.root.Std.string(( _floatSeed * _floatSeed ));
		while (( this._tempString.length() < 8 ))
		{
			this._tempString = ( "0" + this._tempString );
		}
		
		this._currSeed = ((int) (haxe.lang.Runtime.toInt(haxe.root.Std.parseInt(haxe.lang.StringExt.substr(this._tempString, 1, 5)))) );
		int res = ((int) (java.lang.Math.round(( this.rangeMin + ( ( ((double) (this._currSeed) ) / 99999 ) * (( this.rangeMax - this.rangeMin )) ) ))) );
		if (( this._currSeed == 0 )) 
		{
			this._currSeed = ( this._originalSeed + this._numIter );
		}
		
		this._numIter++;
		if (( this._numIter == 200 )) 
		{
			this.reset();
		}
		
		return res;
	}
	
	
	@Override public   double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef180 = true;
			switch (field.hashCode())
			{
				case 356978303:
				{
					if (field.equals("_numIter")) 
					{
						__temp_executeDef180 = false;
						this._numIter = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 3526257:
				{
					if (field.equals("seed")) 
					{
						__temp_executeDef180 = false;
						this.set_seed(((int) (value) ));
						return value;
					}
					
					break;
				}
				
				
				case 343359558:
				{
					if (field.equals("_rangeMax")) 
					{
						__temp_executeDef180 = false;
						this._rangeMax = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 252841941:
				{
					if (field.equals("rangeMin")) 
					{
						__temp_executeDef180 = false;
						this.rangeMin = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 343359796:
				{
					if (field.equals("_rangeMin")) 
					{
						__temp_executeDef180 = false;
						this._rangeMin = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 252841703:
				{
					if (field.equals("rangeMax")) 
					{
						__temp_executeDef180 = false;
						this.rangeMax = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 665375010:
				{
					if (field.equals("_currSeed")) 
					{
						__temp_executeDef180 = false;
						this._currSeed = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 34465217:
				{
					if (field.equals("_originalSeed")) 
					{
						__temp_executeDef180 = false;
						this._originalSeed = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef180) 
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
			boolean __temp_executeDef181 = true;
			switch (field.hashCode())
			{
				case 1694086820:
				{
					if (field.equals("_tempString")) 
					{
						__temp_executeDef181 = false;
						this._tempString = haxe.lang.Runtime.toString(value);
						return value;
					}
					
					break;
				}
				
				
				case 3526257:
				{
					if (field.equals("seed")) 
					{
						__temp_executeDef181 = false;
						this.set_seed(((int) (haxe.lang.Runtime.toInt(value)) ));
						return value;
					}
					
					break;
				}
				
				
				case 356978303:
				{
					if (field.equals("_numIter")) 
					{
						__temp_executeDef181 = false;
						this._numIter = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 252841941:
				{
					if (field.equals("rangeMin")) 
					{
						__temp_executeDef181 = false;
						this.rangeMin = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 343359558:
				{
					if (field.equals("_rangeMax")) 
					{
						__temp_executeDef181 = false;
						this._rangeMax = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 252841703:
				{
					if (field.equals("rangeMax")) 
					{
						__temp_executeDef181 = false;
						this.rangeMax = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 343359796:
				{
					if (field.equals("_rangeMin")) 
					{
						__temp_executeDef181 = false;
						this._rangeMin = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 34465217:
				{
					if (field.equals("_originalSeed")) 
					{
						__temp_executeDef181 = false;
						this._originalSeed = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 665375010:
				{
					if (field.equals("_currSeed")) 
					{
						__temp_executeDef181 = false;
						this._currSeed = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef181) 
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
			boolean __temp_executeDef182 = true;
			switch (field.hashCode())
			{
				case 3377907:
				{
					if (field.equals("next")) 
					{
						__temp_executeDef182 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("next"))) );
					}
					
					break;
				}
				
				
				case 3526257:
				{
					if (field.equals("seed")) 
					{
						__temp_executeDef182 = false;
						return this.get_seed();
					}
					
					break;
				}
				
				
				case 108404047:
				{
					if (field.equals("reset")) 
					{
						__temp_executeDef182 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("reset"))) );
					}
					
					break;
				}
				
				
				case 252841941:
				{
					if (field.equals("rangeMin")) 
					{
						__temp_executeDef182 = false;
						return this.rangeMin;
					}
					
					break;
				}
				
				
				case 1976638906:
				{
					if (field.equals("get_seed")) 
					{
						__temp_executeDef182 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_seed"))) );
					}
					
					break;
				}
				
				
				case 252841703:
				{
					if (field.equals("rangeMax")) 
					{
						__temp_executeDef182 = false;
						return this.rangeMax;
					}
					
					break;
				}
				
				
				case 1415526446:
				{
					if (field.equals("set_seed")) 
					{
						__temp_executeDef182 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_seed"))) );
					}
					
					break;
				}
				
				
				case 34465217:
				{
					if (field.equals("_originalSeed")) 
					{
						__temp_executeDef182 = false;
						return this._originalSeed;
					}
					
					break;
				}
				
				
				case 1694086820:
				{
					if (field.equals("_tempString")) 
					{
						__temp_executeDef182 = false;
						return this._tempString;
					}
					
					break;
				}
				
				
				case 665375010:
				{
					if (field.equals("_currSeed")) 
					{
						__temp_executeDef182 = false;
						return this._currSeed;
					}
					
					break;
				}
				
				
				case 356978303:
				{
					if (field.equals("_numIter")) 
					{
						__temp_executeDef182 = false;
						return this._numIter;
					}
					
					break;
				}
				
				
				case 343359796:
				{
					if (field.equals("_rangeMin")) 
					{
						__temp_executeDef182 = false;
						return this._rangeMin;
					}
					
					break;
				}
				
				
				case 343359558:
				{
					if (field.equals("_rangeMax")) 
					{
						__temp_executeDef182 = false;
						return this._rangeMax;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef182) 
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
			boolean __temp_executeDef183 = true;
			switch (field.hashCode())
			{
				case 356978303:
				{
					if (field.equals("_numIter")) 
					{
						__temp_executeDef183 = false;
						return ((double) (this._numIter) );
					}
					
					break;
				}
				
				
				case 3526257:
				{
					if (field.equals("seed")) 
					{
						__temp_executeDef183 = false;
						return ((double) (this.get_seed()) );
					}
					
					break;
				}
				
				
				case 343359558:
				{
					if (field.equals("_rangeMax")) 
					{
						__temp_executeDef183 = false;
						return ((double) (this._rangeMax) );
					}
					
					break;
				}
				
				
				case 252841941:
				{
					if (field.equals("rangeMin")) 
					{
						__temp_executeDef183 = false;
						return ((double) (this.rangeMin) );
					}
					
					break;
				}
				
				
				case 343359796:
				{
					if (field.equals("_rangeMin")) 
					{
						__temp_executeDef183 = false;
						return ((double) (this._rangeMin) );
					}
					
					break;
				}
				
				
				case 252841703:
				{
					if (field.equals("rangeMax")) 
					{
						__temp_executeDef183 = false;
						return ((double) (this.rangeMax) );
					}
					
					break;
				}
				
				
				case 665375010:
				{
					if (field.equals("_currSeed")) 
					{
						__temp_executeDef183 = false;
						return ((double) (this._currSeed) );
					}
					
					break;
				}
				
				
				case 34465217:
				{
					if (field.equals("_originalSeed")) 
					{
						__temp_executeDef183 = false;
						return ((double) (this._originalSeed) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef183) 
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
			boolean __temp_executeDef184 = true;
			switch (field.hashCode())
			{
				case 3377907:
				{
					if (field.equals("next")) 
					{
						__temp_executeDef184 = false;
						return this.next();
					}
					
					break;
				}
				
				
				case 1415526446:
				{
					if (field.equals("set_seed")) 
					{
						__temp_executeDef184 = false;
						return this.set_seed(((int) (haxe.lang.Runtime.toInt(dynargs.__get(0))) ));
					}
					
					break;
				}
				
				
				case 108404047:
				{
					if (field.equals("reset")) 
					{
						__temp_executeDef184 = false;
						this.reset();
					}
					
					break;
				}
				
				
				case 1976638906:
				{
					if (field.equals("get_seed")) 
					{
						__temp_executeDef184 = false;
						return this.get_seed();
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef184) 
			{
				return super.__hx_invokeField(field, dynargs);
			}
			
		}
		
		return null;
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("_tempString");
		baseArr.push("_numIter");
		baseArr.push("_rangeMax");
		baseArr.push("_rangeMin");
		baseArr.push("_currSeed");
		baseArr.push("_originalSeed");
		baseArr.push("rangeMax");
		baseArr.push("rangeMin");
		baseArr.push("seed");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


