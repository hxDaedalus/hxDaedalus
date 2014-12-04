package haxe.root;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class BasicsJava extends hxDaedalus.swing.BasicSwing
{
	public static void main(String[] args)
	{
		main();
	}
	public    BasicsJava(haxe.lang.EmptyObject empty)
	{
		super(haxe.lang.EmptyObject.EMPTY);
	}
	
	
	public    BasicsJava()
	{
		super();
		this.mesh = hxDaedalus.factories.RectMesh.buildRectangle(((double) (600) ), ((double) (400) ));
		this.view = new hxDaedalus.view.SimpleViewSwing();
		this.surface.paintFunction = ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("paintFunction"))) );
		hxDaedalus.data.Vertex vertex = this.mesh.insertVertex(((double) (550) ), ((double) (50) ));
		hxDaedalus.data.ConstraintSegment segment = this.mesh.insertConstraintSegment(((double) (70) ), ((double) (300) ), ((double) (530) ), ((double) (320) ));
		hxDaedalus.data.ConstraintShape shape = this.mesh.insertConstraintShape(new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (50.) ), ((java.lang.Object) (50.) ), ((java.lang.Object) (100.) ), ((java.lang.Object) (50.) ), ((java.lang.Object) (100.) ), ((java.lang.Object) (50.) ), ((java.lang.Object) (100.) ), ((java.lang.Object) (100.) ), ((java.lang.Object) (100.) ), ((java.lang.Object) (100.) ), ((java.lang.Object) (50.) ), ((java.lang.Object) (100.) ), ((java.lang.Object) (50.) ), ((java.lang.Object) (100.) ), ((java.lang.Object) (50.) ), ((java.lang.Object) (50.) ), ((java.lang.Object) (20.) ), ((java.lang.Object) (50.) ), ((java.lang.Object) (130.) ), ((java.lang.Object) (100.) )}));
		haxe.root.Array<java.lang.Object> objectCoords = new haxe.root.Array<java.lang.Object>();
		this.object = new hxDaedalus.data.Object();
		this.object.set_coordinates(new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{((java.lang.Object) (-50.) ), ((java.lang.Object) (0.) ), ((java.lang.Object) (50.) ), ((java.lang.Object) (0.) ), ((java.lang.Object) (0.) ), ((java.lang.Object) (-50.) ), ((java.lang.Object) (0.) ), ((java.lang.Object) (50.) ), ((java.lang.Object) (-30.) ), ((java.lang.Object) (-30.) ), ((java.lang.Object) (30.) ), ((java.lang.Object) (30.) ), ((java.lang.Object) (30.) ), ((java.lang.Object) (-30.) ), ((java.lang.Object) (-30.) ), ((java.lang.Object) (30.) )}));
		this.mesh.insertObject(this.object);
		this.object.set_x(((double) (400) ));
		this.object.set_y(((double) (200) ));
		this.object.set_scaleX(((double) (2) ));
		this.object.set_scaleY(((double) (2) ));
		haxe.Timer timer = new haxe.Timer(((int) (((int) (java.lang.Math.floor(16.666666666666668)) )) ));
		timer.run = ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("renderTimer"))) );
	}
	
	
	public static   void main()
	{
		new haxe.root.BasicsJava();
	}
	
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new haxe.root.BasicsJava(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new haxe.root.BasicsJava();
	}
	
	
	public  hxDaedalus.data.Mesh mesh;
	
	public  hxDaedalus.data.Object object;
	
	public  hxDaedalus.view.SimpleViewSwing view;
	
	public   void renderTimer()
	{
		{
			hxDaedalus.data.Object _g = this.object;
			_g.set_rotation(( _g.get_rotation() + 0.05 ));
		}
		
		this.mesh.updateObjects();
		this.surface.repaint();
	}
	
	
	public   void paintFunction(java.awt.Graphics2D g)
	{
		this.view.drawMesh(g, this.mesh);
	}
	
	
	@Override public   java.lang.Object __hx_setField(java.lang.String field, java.lang.Object value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef74 = true;
			switch (field.hashCode())
			{
				case 3619493:
				{
					if (field.equals("view")) 
					{
						__temp_executeDef74 = false;
						this.view = ((hxDaedalus.view.SimpleViewSwing) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 3347949:
				{
					if (field.equals("mesh")) 
					{
						__temp_executeDef74 = false;
						this.mesh = ((hxDaedalus.data.Mesh) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -1023368385:
				{
					if (field.equals("object")) 
					{
						__temp_executeDef74 = false;
						this.object = ((hxDaedalus.data.Object) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef74) 
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
			boolean __temp_executeDef75 = true;
			switch (field.hashCode())
			{
				case -768961962:
				{
					if (field.equals("paintFunction")) 
					{
						__temp_executeDef75 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("paintFunction"))) );
					}
					
					break;
				}
				
				
				case 3347949:
				{
					if (field.equals("mesh")) 
					{
						__temp_executeDef75 = false;
						return this.mesh;
					}
					
					break;
				}
				
				
				case -1638046897:
				{
					if (field.equals("renderTimer")) 
					{
						__temp_executeDef75 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("renderTimer"))) );
					}
					
					break;
				}
				
				
				case -1023368385:
				{
					if (field.equals("object")) 
					{
						__temp_executeDef75 = false;
						return this.object;
					}
					
					break;
				}
				
				
				case 3619493:
				{
					if (field.equals("view")) 
					{
						__temp_executeDef75 = false;
						return this.view;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef75) 
			{
				return super.__hx_getField(field, throwErrors, isCheck, handleProperties);
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
			boolean __temp_executeDef76 = true;
			switch (field.hashCode())
			{
				case -768961962:
				{
					if (field.equals("paintFunction")) 
					{
						__temp_executeDef76 = false;
						this.paintFunction(((java.awt.Graphics2D) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
				case -1638046897:
				{
					if (field.equals("renderTimer")) 
					{
						__temp_executeDef76 = false;
						this.renderTimer();
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef76) 
			{
				return super.__hx_invokeField(field, dynargs);
			}
			
		}
		
		return null;
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("view");
		baseArr.push("object");
		baseArr.push("mesh");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


