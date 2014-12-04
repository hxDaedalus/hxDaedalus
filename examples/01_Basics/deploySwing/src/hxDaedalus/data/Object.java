package hxDaedalus.data;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class Object extends haxe.lang.HxObject
{
	static 
	{
		hxDaedalus.data.Object.INC = 0;
	}
	public    Object(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    Object()
	{
		hxDaedalus.data.Object.__hx_ctor_hxDaedalus_data_Object(this);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_data_Object(hxDaedalus.data.Object __temp_me20)
	{
		__temp_me20._id = hxDaedalus.data.Object.INC;
		hxDaedalus.data.Object.INC++;
		__temp_me20._pivotX = ((double) (0) );
		__temp_me20._pivotY = ((double) (0) );
		__temp_me20._matrix = new hxDaedalus.data.math.Matrix2D(((java.lang.Object) (null) ), ((java.lang.Object) (null) ), ((java.lang.Object) (null) ), ((java.lang.Object) (null) ), ((java.lang.Object) (null) ), ((java.lang.Object) (null) ));
		__temp_me20._scaleX = ((double) (1) );
		__temp_me20._scaleY = ((double) (1) );
		__temp_me20._rotation = ((double) (0) );
		__temp_me20._x = ((double) (0) );
		__temp_me20._y = ((double) (0) );
		__temp_me20._coordinates = new haxe.root.Array<java.lang.Object>();
		__temp_me20._hasChanged = false;
	}
	
	
	public static  int INC;
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.data.Object(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.data.Object();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public  int _id;
	
	public  hxDaedalus.data.math.Matrix2D _matrix;
	
	public  haxe.root.Array<java.lang.Object> _coordinates;
	
	public  hxDaedalus.data.ConstraintShape _constraintShape;
	
	public  double _pivotX;
	
	public  double _pivotY;
	
	public  double _scaleX;
	
	public  double _scaleY;
	
	public  double _rotation;
	
	public  double _x;
	
	public  double _y;
	
	public  boolean _hasChanged;
	
	public   int get_id()
	{
		return this._id;
	}
	
	
	public   void dispose()
	{
		this._matrix = null;
		this._coordinates = null;
		this._constraintShape = null;
	}
	
	
	public   void updateValuesFromMatrix()
	{
		{
		}
		
	}
	
	
	public   void updateMatrixFromValues()
	{
		this._matrix.identity();
		this._matrix.translate( - (this._pivotX) ,  - (this._pivotY) );
		this._matrix.scale(this._scaleX, this._scaleY);
		this._matrix.rotate(this._rotation);
		this._matrix.translate(this._x, this._y);
	}
	
	
	public   double get_pivotX()
	{
		return this._pivotX;
	}
	
	
	public   double set_pivotX(double value)
	{
		this._pivotX = value;
		this._hasChanged = true;
		return value;
	}
	
	
	public   double get_pivotY()
	{
		return this._pivotY;
	}
	
	
	public   double set_pivotY(double value)
	{
		this._pivotY = value;
		this._hasChanged = true;
		return value;
	}
	
	
	public   double get_scaleX()
	{
		return this._scaleX;
	}
	
	
	public   double set_scaleX(double value)
	{
		if (( this._scaleX != value )) 
		{
			this._scaleX = value;
			this._hasChanged = true;
		}
		
		return value;
	}
	
	
	public   double get_scaleY()
	{
		return this._scaleY;
	}
	
	
	public   double set_scaleY(double value)
	{
		if (( this._scaleY != value )) 
		{
			this._scaleY = value;
			this._hasChanged = true;
		}
		
		return value;
	}
	
	
	public   double get_rotation()
	{
		return this._rotation;
	}
	
	
	public   double set_rotation(double value)
	{
		if (( this._rotation != value )) 
		{
			this._rotation = value;
			this._hasChanged = true;
		}
		
		return value;
	}
	
	
	public   double get_x()
	{
		return this._x;
	}
	
	
	public   double set_x(double value)
	{
		if (( this._x != value )) 
		{
			this._x = value;
			this._hasChanged = true;
		}
		
		return value;
	}
	
	
	public   double get_y()
	{
		return this._y;
	}
	
	
	public   double set_y(double value)
	{
		if (( this._y != value )) 
		{
			this._y = value;
			this._hasChanged = true;
		}
		
		return value;
	}
	
	
	public   hxDaedalus.data.math.Matrix2D get_matrix()
	{
		return this._matrix;
	}
	
	
	public   hxDaedalus.data.math.Matrix2D set_matrix(hxDaedalus.data.math.Matrix2D value)
	{
		this._matrix = value;
		this._hasChanged = true;
		return value;
	}
	
	
	public   haxe.root.Array<java.lang.Object> get_coordinates()
	{
		return this._coordinates;
	}
	
	
	public   haxe.root.Array<java.lang.Object> set_coordinates(haxe.root.Array<java.lang.Object> value)
	{
		this._coordinates = value;
		this._hasChanged = true;
		return value;
	}
	
	
	public   hxDaedalus.data.ConstraintShape get_constraintShape()
	{
		return this._constraintShape;
	}
	
	
	public   hxDaedalus.data.ConstraintShape set_constraintShape(hxDaedalus.data.ConstraintShape value)
	{
		this._constraintShape = value;
		this._hasChanged = true;
		return value;
	}
	
	
	public   boolean get_hasChanged()
	{
		return this._hasChanged;
	}
	
	
	public   boolean set_hasChanged(boolean value)
	{
		this._hasChanged = value;
		return value;
	}
	
	
	public   haxe.root.Array<hxDaedalus.data.Edge> get_edges()
	{
		haxe.root.Array<hxDaedalus.data.Edge> res = new haxe.root.Array<hxDaedalus.data.Edge>();
		haxe.root.Array<hxDaedalus.data.ConstraintSegment> seg = this._constraintShape.segments;
		{
			int _g1 = 0;
			int _g = seg.length;
			while (( _g1 < _g ))
			{
				int i = _g1++;
				{
					int _g3 = 0;
					int _g2 = seg.__get(i).get_edges().length;
					while (( _g3 < _g2 ))
					{
						int j = _g3++;
						res.push(seg.__get(i).get_edges().__get(j));
					}
					
				}
				
			}
			
		}
		
		return res;
	}
	
	
	@Override public   double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef143 = true;
			switch (field.hashCode())
			{
				case 3066:
				{
					if (field.equals("_y")) 
					{
						__temp_executeDef143 = false;
						this._y = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -987906986:
				{
					if (field.equals("pivotX")) 
					{
						__temp_executeDef143 = false;
						this.set_pivotX(value);
						return value;
					}
					
					break;
				}
				
				
				case 3065:
				{
					if (field.equals("_x")) 
					{
						__temp_executeDef143 = false;
						this._x = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -987906985:
				{
					if (field.equals("pivotY")) 
					{
						__temp_executeDef143 = false;
						this.set_pivotY(value);
						return value;
					}
					
					break;
				}
				
				
				case 50217181:
				{
					if (field.equals("_rotation")) 
					{
						__temp_executeDef143 = false;
						this._rotation = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -908189618:
				{
					if (field.equals("scaleX")) 
					{
						__temp_executeDef143 = false;
						this.set_scaleX(value);
						return value;
					}
					
					break;
				}
				
				
				case 1800281454:
				{
					if (field.equals("_scaleY")) 
					{
						__temp_executeDef143 = false;
						this._scaleY = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -908189617:
				{
					if (field.equals("scaleY")) 
					{
						__temp_executeDef143 = false;
						this.set_scaleY(value);
						return value;
					}
					
					break;
				}
				
				
				case 1800281453:
				{
					if (field.equals("_scaleX")) 
					{
						__temp_executeDef143 = false;
						this._scaleX = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -40300674:
				{
					if (field.equals("rotation")) 
					{
						__temp_executeDef143 = false;
						this.set_rotation(value);
						return value;
					}
					
					break;
				}
				
				
				case 1720564086:
				{
					if (field.equals("_pivotY")) 
					{
						__temp_executeDef143 = false;
						this._pivotY = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 120:
				{
					if (field.equals("x")) 
					{
						__temp_executeDef143 = false;
						this.set_x(value);
						return value;
					}
					
					break;
				}
				
				
				case 1720564085:
				{
					if (field.equals("_pivotX")) 
					{
						__temp_executeDef143 = false;
						this._pivotX = ((double) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 121:
				{
					if (field.equals("y")) 
					{
						__temp_executeDef143 = false;
						this.set_y(value);
						return value;
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef143 = false;
						this._id = ((int) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef143) 
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
			boolean __temp_executeDef144 = true;
			switch (field.hashCode())
			{
				case -435323815:
				{
					if (field.equals("_hasChanged")) 
					{
						__temp_executeDef144 = false;
						this._hasChanged = haxe.lang.Runtime.toBool(value);
						return value;
					}
					
					break;
				}
				
				
				case -987906986:
				{
					if (field.equals("pivotX")) 
					{
						__temp_executeDef144 = false;
						this.set_pivotX(((double) (haxe.lang.Runtime.toDouble(value)) ));
						return value;
					}
					
					break;
				}
				
				
				case 3066:
				{
					if (field.equals("_y")) 
					{
						__temp_executeDef144 = false;
						this._y = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case -987906985:
				{
					if (field.equals("pivotY")) 
					{
						__temp_executeDef144 = false;
						this.set_pivotY(((double) (haxe.lang.Runtime.toDouble(value)) ));
						return value;
					}
					
					break;
				}
				
				
				case 3065:
				{
					if (field.equals("_x")) 
					{
						__temp_executeDef144 = false;
						this._x = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case -908189618:
				{
					if (field.equals("scaleX")) 
					{
						__temp_executeDef144 = false;
						this.set_scaleX(((double) (haxe.lang.Runtime.toDouble(value)) ));
						return value;
					}
					
					break;
				}
				
				
				case 50217181:
				{
					if (field.equals("_rotation")) 
					{
						__temp_executeDef144 = false;
						this._rotation = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case -908189617:
				{
					if (field.equals("scaleY")) 
					{
						__temp_executeDef144 = false;
						this.set_scaleY(((double) (haxe.lang.Runtime.toDouble(value)) ));
						return value;
					}
					
					break;
				}
				
				
				case 1800281454:
				{
					if (field.equals("_scaleY")) 
					{
						__temp_executeDef144 = false;
						this._scaleY = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case -40300674:
				{
					if (field.equals("rotation")) 
					{
						__temp_executeDef144 = false;
						this.set_rotation(((double) (haxe.lang.Runtime.toDouble(value)) ));
						return value;
					}
					
					break;
				}
				
				
				case 1800281453:
				{
					if (field.equals("_scaleX")) 
					{
						__temp_executeDef144 = false;
						this._scaleX = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 120:
				{
					if (field.equals("x")) 
					{
						__temp_executeDef144 = false;
						this.set_x(((double) (haxe.lang.Runtime.toDouble(value)) ));
						return value;
					}
					
					break;
				}
				
				
				case 1720564086:
				{
					if (field.equals("_pivotY")) 
					{
						__temp_executeDef144 = false;
						this._pivotY = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case 121:
				{
					if (field.equals("y")) 
					{
						__temp_executeDef144 = false;
						this.set_y(((double) (haxe.lang.Runtime.toDouble(value)) ));
						return value;
					}
					
					break;
				}
				
				
				case 1720564085:
				{
					if (field.equals("_pivotX")) 
					{
						__temp_executeDef144 = false;
						this._pivotX = ((double) (haxe.lang.Runtime.toDouble(value)) );
						return value;
					}
					
					break;
				}
				
				
				case -1081239615:
				{
					if (field.equals("matrix")) 
					{
						__temp_executeDef144 = false;
						this.set_matrix(((hxDaedalus.data.math.Matrix2D) (value) ));
						return value;
					}
					
					break;
				}
				
				
				case -461323899:
				{
					if (field.equals("_constraintShape")) 
					{
						__temp_executeDef144 = false;
						this._constraintShape = ((hxDaedalus.data.ConstraintShape) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 1871919611:
				{
					if (field.equals("coordinates")) 
					{
						__temp_executeDef144 = false;
						this.set_coordinates(((haxe.root.Array<java.lang.Object>) (value) ));
						return value;
					}
					
					break;
				}
				
				
				case 1249876028:
				{
					if (field.equals("_coordinates")) 
					{
						__temp_executeDef144 = false;
						this._coordinates = ((haxe.root.Array<java.lang.Object>) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 794782660:
				{
					if (field.equals("constraintShape")) 
					{
						__temp_executeDef144 = false;
						this.set_constraintShape(((hxDaedalus.data.ConstraintShape) (value) ));
						return value;
					}
					
					break;
				}
				
				
				case 1627231456:
				{
					if (field.equals("_matrix")) 
					{
						__temp_executeDef144 = false;
						this._matrix = ((hxDaedalus.data.math.Matrix2D) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -1523636550:
				{
					if (field.equals("hasChanged")) 
					{
						__temp_executeDef144 = false;
						this.set_hasChanged(haxe.lang.Runtime.toBool(value));
						return value;
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef144 = false;
						this._id = ((int) (haxe.lang.Runtime.toInt(value)) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef144) 
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
			boolean __temp_executeDef145 = true;
			switch (field.hashCode())
			{
				case 1133306925:
				{
					if (field.equals("get_edges")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_edges"))) );
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef145 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
				case -220229961:
				{
					if (field.equals("set_hasChanged")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_hasChanged"))) );
					}
					
					break;
				}
				
				
				case -987906986:
				{
					if (field.equals("pivotX")) 
					{
						__temp_executeDef145 = false;
						return this.get_pivotX();
					}
					
					break;
				}
				
				
				case 1551506243:
				{
					if (field.equals("get_hasChanged")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_hasChanged"))) );
					}
					
					break;
				}
				
				
				case -987906985:
				{
					if (field.equals("pivotY")) 
					{
						__temp_executeDef145 = false;
						return this.get_pivotY();
					}
					
					break;
				}
				
				
				case 1653701095:
				{
					if (field.equals("set_constraintShape")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_constraintShape"))) );
					}
					
					break;
				}
				
				
				case -908189618:
				{
					if (field.equals("scaleX")) 
					{
						__temp_executeDef145 = false;
						return this.get_scaleX();
					}
					
					break;
				}
				
				
				case -1097538341:
				{
					if (field.equals("get_constraintShape")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_constraintShape"))) );
					}
					
					break;
				}
				
				
				case -908189617:
				{
					if (field.equals("scaleY")) 
					{
						__temp_executeDef145 = false;
						return this.get_scaleY();
					}
					
					break;
				}
				
				
				case -672149090:
				{
					if (field.equals("set_coordinates")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_coordinates"))) );
					}
					
					break;
				}
				
				
				case -40300674:
				{
					if (field.equals("rotation")) 
					{
						__temp_executeDef145 = false;
						return this.get_rotation();
					}
					
					break;
				}
				
				
				case -1582901614:
				{
					if (field.equals("get_coordinates")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_coordinates"))) );
					}
					
					break;
				}
				
				
				case 120:
				{
					if (field.equals("x")) 
					{
						__temp_executeDef145 = false;
						return this.get_x();
					}
					
					break;
				}
				
				
				case -1358723522:
				{
					if (field.equals("set_matrix")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_matrix"))) );
					}
					
					break;
				}
				
				
				case 121:
				{
					if (field.equals("y")) 
					{
						__temp_executeDef145 = false;
						return this.get_y();
					}
					
					break;
				}
				
				
				case 999438538:
				{
					if (field.equals("get_matrix")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_matrix"))) );
					}
					
					break;
				}
				
				
				case -1081239615:
				{
					if (field.equals("matrix")) 
					{
						__temp_executeDef145 = false;
						return this.get_matrix();
					}
					
					break;
				}
				
				
				case 109328348:
				{
					if (field.equals("set_y")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_y"))) );
					}
					
					break;
				}
				
				
				case 1871919611:
				{
					if (field.equals("coordinates")) 
					{
						__temp_executeDef145 = false;
						return this.get_coordinates();
					}
					
					break;
				}
				
				
				case 98246096:
				{
					if (field.equals("get_y")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_y"))) );
					}
					
					break;
				}
				
				
				case 794782660:
				{
					if (field.equals("constraintShape")) 
					{
						__temp_executeDef145 = false;
						return this.get_constraintShape();
					}
					
					break;
				}
				
				
				case 109328347:
				{
					if (field.equals("set_x")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_x"))) );
					}
					
					break;
				}
				
				
				case -1523636550:
				{
					if (field.equals("hasChanged")) 
					{
						__temp_executeDef145 = false;
						return this.get_hasChanged();
					}
					
					break;
				}
				
				
				case 98246095:
				{
					if (field.equals("get_x")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_x"))) );
					}
					
					break;
				}
				
				
				case 96356950:
				{
					if (field.equals("edges")) 
					{
						__temp_executeDef145 = false;
						return this.get_edges();
					}
					
					break;
				}
				
				
				case -414362949:
				{
					if (field.equals("set_rotation")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_rotation"))) );
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef145 = false;
						return this._id;
					}
					
					break;
				}
				
				
				case -1963355577:
				{
					if (field.equals("get_rotation")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_rotation"))) );
					}
					
					break;
				}
				
				
				case 1627231456:
				{
					if (field.equals("_matrix")) 
					{
						__temp_executeDef145 = false;
						return this._matrix;
					}
					
					break;
				}
				
				
				case -1185673524:
				{
					if (field.equals("set_scaleY")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_scaleY"))) );
					}
					
					break;
				}
				
				
				case 1249876028:
				{
					if (field.equals("_coordinates")) 
					{
						__temp_executeDef145 = false;
						return this._coordinates;
					}
					
					break;
				}
				
				
				case 1172488536:
				{
					if (field.equals("get_scaleY")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_scaleY"))) );
					}
					
					break;
				}
				
				
				case -461323899:
				{
					if (field.equals("_constraintShape")) 
					{
						__temp_executeDef145 = false;
						return this._constraintShape;
					}
					
					break;
				}
				
				
				case -1185673525:
				{
					if (field.equals("set_scaleX")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_scaleX"))) );
					}
					
					break;
				}
				
				
				case 1720564085:
				{
					if (field.equals("_pivotX")) 
					{
						__temp_executeDef145 = false;
						return this._pivotX;
					}
					
					break;
				}
				
				
				case 1172488535:
				{
					if (field.equals("get_scaleX")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_scaleX"))) );
					}
					
					break;
				}
				
				
				case 1720564086:
				{
					if (field.equals("_pivotY")) 
					{
						__temp_executeDef145 = false;
						return this._pivotY;
					}
					
					break;
				}
				
				
				case -1265390892:
				{
					if (field.equals("set_pivotY")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_pivotY"))) );
					}
					
					break;
				}
				
				
				case 1800281453:
				{
					if (field.equals("_scaleX")) 
					{
						__temp_executeDef145 = false;
						return this._scaleX;
					}
					
					break;
				}
				
				
				case 1092771168:
				{
					if (field.equals("get_pivotY")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_pivotY"))) );
					}
					
					break;
				}
				
				
				case 1800281454:
				{
					if (field.equals("_scaleY")) 
					{
						__temp_executeDef145 = false;
						return this._scaleY;
					}
					
					break;
				}
				
				
				case -1265390893:
				{
					if (field.equals("set_pivotX")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("set_pivotX"))) );
					}
					
					break;
				}
				
				
				case 50217181:
				{
					if (field.equals("_rotation")) 
					{
						__temp_executeDef145 = false;
						return this._rotation;
					}
					
					break;
				}
				
				
				case 1092771167:
				{
					if (field.equals("get_pivotX")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_pivotX"))) );
					}
					
					break;
				}
				
				
				case 3065:
				{
					if (field.equals("_x")) 
					{
						__temp_executeDef145 = false;
						return this._x;
					}
					
					break;
				}
				
				
				case -1369572618:
				{
					if (field.equals("updateMatrixFromValues")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("updateMatrixFromValues"))) );
					}
					
					break;
				}
				
				
				case 3066:
				{
					if (field.equals("_y")) 
					{
						__temp_executeDef145 = false;
						return this._y;
					}
					
					break;
				}
				
				
				case 1115911606:
				{
					if (field.equals("updateValuesFromMatrix")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("updateValuesFromMatrix"))) );
					}
					
					break;
				}
				
				
				case -435323815:
				{
					if (field.equals("_hasChanged")) 
					{
						__temp_executeDef145 = false;
						return this._hasChanged;
					}
					
					break;
				}
				
				
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("dispose"))) );
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef145 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("get_id"))) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef145) 
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
			boolean __temp_executeDef146 = true;
			switch (field.hashCode())
			{
				case 3066:
				{
					if (field.equals("_y")) 
					{
						__temp_executeDef146 = false;
						return this._y;
					}
					
					break;
				}
				
				
				case 3355:
				{
					if (field.equals("id")) 
					{
						__temp_executeDef146 = false;
						return ((double) (this.get_id()) );
					}
					
					break;
				}
				
				
				case 3065:
				{
					if (field.equals("_x")) 
					{
						__temp_executeDef146 = false;
						return this._x;
					}
					
					break;
				}
				
				
				case -987906986:
				{
					if (field.equals("pivotX")) 
					{
						__temp_executeDef146 = false;
						return this.get_pivotX();
					}
					
					break;
				}
				
				
				case 50217181:
				{
					if (field.equals("_rotation")) 
					{
						__temp_executeDef146 = false;
						return this._rotation;
					}
					
					break;
				}
				
				
				case -987906985:
				{
					if (field.equals("pivotY")) 
					{
						__temp_executeDef146 = false;
						return this.get_pivotY();
					}
					
					break;
				}
				
				
				case 1800281454:
				{
					if (field.equals("_scaleY")) 
					{
						__temp_executeDef146 = false;
						return this._scaleY;
					}
					
					break;
				}
				
				
				case -908189618:
				{
					if (field.equals("scaleX")) 
					{
						__temp_executeDef146 = false;
						return this.get_scaleX();
					}
					
					break;
				}
				
				
				case 1800281453:
				{
					if (field.equals("_scaleX")) 
					{
						__temp_executeDef146 = false;
						return this._scaleX;
					}
					
					break;
				}
				
				
				case -908189617:
				{
					if (field.equals("scaleY")) 
					{
						__temp_executeDef146 = false;
						return this.get_scaleY();
					}
					
					break;
				}
				
				
				case 1720564086:
				{
					if (field.equals("_pivotY")) 
					{
						__temp_executeDef146 = false;
						return this._pivotY;
					}
					
					break;
				}
				
				
				case -40300674:
				{
					if (field.equals("rotation")) 
					{
						__temp_executeDef146 = false;
						return this.get_rotation();
					}
					
					break;
				}
				
				
				case 1720564085:
				{
					if (field.equals("_pivotX")) 
					{
						__temp_executeDef146 = false;
						return this._pivotX;
					}
					
					break;
				}
				
				
				case 120:
				{
					if (field.equals("x")) 
					{
						__temp_executeDef146 = false;
						return this.get_x();
					}
					
					break;
				}
				
				
				case 94650:
				{
					if (field.equals("_id")) 
					{
						__temp_executeDef146 = false;
						return ((double) (this._id) );
					}
					
					break;
				}
				
				
				case 121:
				{
					if (field.equals("y")) 
					{
						__temp_executeDef146 = false;
						return this.get_y();
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef146) 
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
			boolean __temp_executeDef147 = true;
			switch (field.hashCode())
			{
				case 1133306925:
				{
					if (field.equals("get_edges")) 
					{
						__temp_executeDef147 = false;
						return this.get_edges();
					}
					
					break;
				}
				
				
				case -1249338716:
				{
					if (field.equals("get_id")) 
					{
						__temp_executeDef147 = false;
						return this.get_id();
					}
					
					break;
				}
				
				
				case -220229961:
				{
					if (field.equals("set_hasChanged")) 
					{
						__temp_executeDef147 = false;
						return this.set_hasChanged(haxe.lang.Runtime.toBool(dynargs.__get(0)));
					}
					
					break;
				}
				
				
				case 1671767583:
				{
					if (field.equals("dispose")) 
					{
						__temp_executeDef147 = false;
						this.dispose();
					}
					
					break;
				}
				
				
				case 1551506243:
				{
					if (field.equals("get_hasChanged")) 
					{
						__temp_executeDef147 = false;
						return this.get_hasChanged();
					}
					
					break;
				}
				
				
				case 1115911606:
				{
					if (field.equals("updateValuesFromMatrix")) 
					{
						__temp_executeDef147 = false;
						this.updateValuesFromMatrix();
					}
					
					break;
				}
				
				
				case 1653701095:
				{
					if (field.equals("set_constraintShape")) 
					{
						__temp_executeDef147 = false;
						return this.set_constraintShape(((hxDaedalus.data.ConstraintShape) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case -1369572618:
				{
					if (field.equals("updateMatrixFromValues")) 
					{
						__temp_executeDef147 = false;
						this.updateMatrixFromValues();
					}
					
					break;
				}
				
				
				case -1097538341:
				{
					if (field.equals("get_constraintShape")) 
					{
						__temp_executeDef147 = false;
						return this.get_constraintShape();
					}
					
					break;
				}
				
				
				case 1092771167:
				{
					if (field.equals("get_pivotX")) 
					{
						__temp_executeDef147 = false;
						return this.get_pivotX();
					}
					
					break;
				}
				
				
				case -672149090:
				{
					if (field.equals("set_coordinates")) 
					{
						__temp_executeDef147 = false;
						return this.set_coordinates(((haxe.root.Array<java.lang.Object>) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case -1265390893:
				{
					if (field.equals("set_pivotX")) 
					{
						__temp_executeDef147 = false;
						return this.set_pivotX(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ));
					}
					
					break;
				}
				
				
				case -1582901614:
				{
					if (field.equals("get_coordinates")) 
					{
						__temp_executeDef147 = false;
						return this.get_coordinates();
					}
					
					break;
				}
				
				
				case 1092771168:
				{
					if (field.equals("get_pivotY")) 
					{
						__temp_executeDef147 = false;
						return this.get_pivotY();
					}
					
					break;
				}
				
				
				case -1358723522:
				{
					if (field.equals("set_matrix")) 
					{
						__temp_executeDef147 = false;
						return this.set_matrix(((hxDaedalus.data.math.Matrix2D) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case -1265390892:
				{
					if (field.equals("set_pivotY")) 
					{
						__temp_executeDef147 = false;
						return this.set_pivotY(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ));
					}
					
					break;
				}
				
				
				case 999438538:
				{
					if (field.equals("get_matrix")) 
					{
						__temp_executeDef147 = false;
						return this.get_matrix();
					}
					
					break;
				}
				
				
				case 1172488535:
				{
					if (field.equals("get_scaleX")) 
					{
						__temp_executeDef147 = false;
						return this.get_scaleX();
					}
					
					break;
				}
				
				
				case 109328348:
				{
					if (field.equals("set_y")) 
					{
						__temp_executeDef147 = false;
						return this.set_y(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ));
					}
					
					break;
				}
				
				
				case -1185673525:
				{
					if (field.equals("set_scaleX")) 
					{
						__temp_executeDef147 = false;
						return this.set_scaleX(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ));
					}
					
					break;
				}
				
				
				case 98246096:
				{
					if (field.equals("get_y")) 
					{
						__temp_executeDef147 = false;
						return this.get_y();
					}
					
					break;
				}
				
				
				case 1172488536:
				{
					if (field.equals("get_scaleY")) 
					{
						__temp_executeDef147 = false;
						return this.get_scaleY();
					}
					
					break;
				}
				
				
				case 109328347:
				{
					if (field.equals("set_x")) 
					{
						__temp_executeDef147 = false;
						return this.set_x(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ));
					}
					
					break;
				}
				
				
				case -1185673524:
				{
					if (field.equals("set_scaleY")) 
					{
						__temp_executeDef147 = false;
						return this.set_scaleY(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ));
					}
					
					break;
				}
				
				
				case 98246095:
				{
					if (field.equals("get_x")) 
					{
						__temp_executeDef147 = false;
						return this.get_x();
					}
					
					break;
				}
				
				
				case -1963355577:
				{
					if (field.equals("get_rotation")) 
					{
						__temp_executeDef147 = false;
						return this.get_rotation();
					}
					
					break;
				}
				
				
				case -414362949:
				{
					if (field.equals("set_rotation")) 
					{
						__temp_executeDef147 = false;
						return this.set_rotation(((double) (haxe.lang.Runtime.toDouble(dynargs.__get(0))) ));
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef147) 
			{
				return super.__hx_invokeField(field, dynargs);
			}
			
		}
		
		return null;
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("_hasChanged");
		baseArr.push("_y");
		baseArr.push("_x");
		baseArr.push("_rotation");
		baseArr.push("_scaleY");
		baseArr.push("_scaleX");
		baseArr.push("_pivotY");
		baseArr.push("_pivotX");
		baseArr.push("_constraintShape");
		baseArr.push("_coordinates");
		baseArr.push("_matrix");
		baseArr.push("_id");
		baseArr.push("edges");
		baseArr.push("hasChanged");
		baseArr.push("constraintShape");
		baseArr.push("coordinates");
		baseArr.push("matrix");
		baseArr.push("y");
		baseArr.push("x");
		baseArr.push("rotation");
		baseArr.push("scaleY");
		baseArr.push("scaleX");
		baseArr.push("pivotY");
		baseArr.push("pivotX");
		baseArr.push("id");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


