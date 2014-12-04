package hxDaedalus.swing;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class Surface extends javax.swing.JPanel implements haxe.lang.IHxObject
{
	public    Surface(haxe.lang.EmptyObject empty)
	{
		super();
	}
	
	
	public    Surface()
	{
		super(haxe.lang.Runtime.toBool(true));
	}
	
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.swing.Surface(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.swing.Surface();
	}
	
	
	public  java.awt.Graphics2D g;
	
	public  haxe.lang.Function paintFunction;
	
	public   void paintComponent(java.awt.Graphics g)
	{
		super.paintComponent(((java.awt.Graphics) (g) ));
		java.awt.Graphics2D g2D = ((java.awt.Graphics2D) (g) );
		java.lang.Class rHint = java.awt.RenderingHints.class;
		g2D.setRenderingHint(((java.awt.RenderingHints.Key) (java.awt.RenderingHints.KEY_ANTIALIASING) ), ((java.lang.Object) (java.awt.RenderingHints.VALUE_ANTIALIAS_ON) ));
		g2D.setRenderingHint(((java.awt.RenderingHints.Key) (java.awt.RenderingHints.KEY_RENDERING) ), ((java.lang.Object) (java.awt.RenderingHints.VALUE_RENDER_QUALITY) ));
		if (( this.paintFunction != null )) 
		{
			this.paintFunction.__hx_invoke1_o(0.0, g2D);
		}
		
		g2D.dispose();
	}
	
	
	public   boolean __hx_deleteField(java.lang.String field)
	{
		return false;
	}
	
	
	public   java.lang.Object __hx_lookupField(java.lang.String field, boolean throwErrors, boolean isCheck)
	{
		if (isCheck) 
		{
			return haxe.lang.Runtime.undefined;
		}
		 else 
		{
			if (throwErrors) 
			{
				throw haxe.lang.HaxeException.wrap("Field not found.");
			}
			 else 
			{
				return null;
			}
			
		}
		
	}
	
	
	public   double __hx_lookupField_f(java.lang.String field, boolean throwErrors)
	{
		if (throwErrors) 
		{
			throw haxe.lang.HaxeException.wrap("Field not found or incompatible field type.");
		}
		 else 
		{
			return 0.0;
		}
		
	}
	
	
	public   java.lang.Object __hx_lookupSetField(java.lang.String field, java.lang.Object value)
	{
		throw haxe.lang.HaxeException.wrap("Cannot access field for writing.");
	}
	
	
	public   double __hx_lookupSetField_f(java.lang.String field, double value)
	{
		throw haxe.lang.HaxeException.wrap("Cannot access field for writing or incompatible type.");
	}
	
	
	public   double __hx_setField_f(java.lang.String field, double value, boolean handleProperties)
	{
		{
			{
				return this.__hx_lookupSetField_f(field, value);
			}
			
		}
		
	}
	
	
	public   java.lang.Object __hx_setField(java.lang.String field, java.lang.Object value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef203 = true;
			switch (field.hashCode())
			{
				case 3732:
				{
					if (field.equals("ui")) 
					{
						__temp_executeDef203 = false;
						this.ui = ((javax.swing.plaf.ComponentUI) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 103:
				{
					if (field.equals("g")) 
					{
						__temp_executeDef203 = false;
						this.g = ((java.awt.Graphics2D) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -1505267854:
				{
					if (field.equals("listenerList")) 
					{
						__temp_executeDef203 = false;
						this.listenerList = ((javax.swing.event.EventListenerList) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -768961962:
				{
					if (field.equals("paintFunction")) 
					{
						__temp_executeDef203 = false;
						this.paintFunction = ((haxe.lang.Function) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -61228775:
				{
					if (field.equals("accessibleContext")) 
					{
						__temp_executeDef203 = false;
						this.accessibleContext = ((javax.accessibility.AccessibleContext) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef203) 
			{
				return this.__hx_lookupSetField(field, value);
			}
			 else 
			{
				throw null;
			}
			
		}
		
	}
	
	
	public   java.lang.Object __hx_getField(java.lang.String field, boolean throwErrors, boolean isCheck, boolean handleProperties)
	{
		{
			boolean __temp_executeDef204 = true;
			switch (field.hashCode())
			{
				case -132109047:
				{
					if (field.equals("getComponentOrientation")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getComponentOrientation"))) );
					}
					
					break;
				}
				
				
				case 103:
				{
					if (field.equals("g")) 
					{
						__temp_executeDef204 = false;
						return this.g;
					}
					
					break;
				}
				
				
				case 1920162837:
				{
					if (field.equals("setComponentOrientation")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setComponentOrientation"))) );
					}
					
					break;
				}
				
				
				case -768961962:
				{
					if (field.equals("paintFunction")) 
					{
						__temp_executeDef204 = false;
						return this.paintFunction;
					}
					
					break;
				}
				
				
				case 1053245860:
				{
					if (field.equals("getPropertyChangeListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getPropertyChangeListeners"))) );
					}
					
					break;
				}
				
				
				case 672648767:
				{
					if (field.equals("paintComponent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("paintComponent"))) );
					}
					
					break;
				}
				
				
				case -1645115555:
				{
					if (field.equals("removePropertyChangeListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removePropertyChangeListener"))) );
					}
					
					break;
				}
				
				
				case 1334722659:
				{
					if (field.equals("getAccessibleContext")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getAccessibleContext"))) );
					}
					
					break;
				}
				
				
				case -1776922004:
				{
					if (field.equals("toString")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("toString"))) );
					}
					
					break;
				}
				
				
				case 820971262:
				{
					if (field.equals("paramString")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("paramString"))) );
					}
					
					break;
				}
				
				
				case 1115025797:
				{
					if (field.equals("isFocusOwner")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isFocusOwner"))) );
					}
					
					break;
				}
				
				
				case -133970743:
				{
					if (field.equals("getUIClassID")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getUIClassID"))) );
					}
					
					break;
				}
				
				
				case 117596766:
				{
					if (field.equals("hasFocus")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("hasFocus"))) );
					}
					
					break;
				}
				
				
				case 1322595613:
				{
					if (field.equals("updateUI")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("updateUI"))) );
					}
					
					break;
				}
				
				
				case 122660510:
				{
					if (field.equals("transferFocusUpCycle")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("transferFocusUpCycle"))) );
					}
					
					break;
				}
				
				
				case 98245738:
				{
					if (field.equals("getUI")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getUI"))) );
					}
					
					break;
				}
				
				
				case 1229986480:
				{
					if (field.equals("transferFocusBackward")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("transferFocusBackward"))) );
					}
					
					break;
				}
				
				
				case 109327990:
				{
					if (field.equals("setUI")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setUI"))) );
					}
					
					break;
				}
				
				
				case 1193982373:
				{
					if (field.equals("nextFocus")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("nextFocus"))) );
					}
					
					break;
				}
				
				
				case 116955034:
				{
					if (field.equals("isDoubleBuffered")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isDoubleBuffered"))) );
					}
					
					break;
				}
				
				
				case -2037192787:
				{
					if (field.equals("transferFocus")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("transferFocus"))) );
					}
					
					break;
				}
				
				
				case -218282935:
				{
					if (field.equals("revalidate")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("revalidate"))) );
					}
					
					break;
				}
				
				
				case 564387289:
				{
					if (field.equals("getFocusCycleRootAncestor")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getFocusCycleRootAncestor"))) );
					}
					
					break;
				}
				
				
				case 1094177291:
				{
					if (field.equals("repaint")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("repaint"))) );
					}
					
					break;
				}
				
				
				case -1338154671:
				{
					if (field.equals("getFocusTraversalKeysEnabled")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getFocusTraversalKeysEnabled"))) );
					}
					
					break;
				}
				
				
				case -2036853317:
				{
					if (field.equals("firePropertyChange")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("firePropertyChange"))) );
					}
					
					break;
				}
				
				
				case -100025915:
				{
					if (field.equals("setFocusTraversalKeysEnabled")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setFocusTraversalKeysEnabled"))) );
					}
					
					break;
				}
				
				
				case -336661013:
				{
					if (field.equals("isOpaque")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isOpaque"))) );
					}
					
					break;
				}
				
				
				case -1126567952:
				{
					if (field.equals("setFocusable")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setFocusable"))) );
					}
					
					break;
				}
				
				
				case 474985501:
				{
					if (field.equals("getHeight")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getHeight"))) );
					}
					
					break;
				}
				
				
				case -1487536088:
				{
					if (field.equals("isFocusable")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isFocusable"))) );
					}
					
					break;
				}
				
				
				case 1968952336:
				{
					if (field.equals("getWidth")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getWidth"))) );
					}
					
					break;
				}
				
				
				case -1426705793:
				{
					if (field.equals("isFocusTraversable")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isFocusTraversable"))) );
					}
					
					break;
				}
				
				
				case 3169219:
				{
					if (field.equals("getY")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getY"))) );
					}
					
					break;
				}
				
				
				case 619607060:
				{
					if (field.equals("lostFocus")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("lostFocus"))) );
					}
					
					break;
				}
				
				
				case 3169218:
				{
					if (field.equals("getX")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getX"))) );
					}
					
					break;
				}
				
				
				case -2056434772:
				{
					if (field.equals("gotFocus")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("gotFocus"))) );
					}
					
					break;
				}
				
				
				case -316023509:
				{
					if (field.equals("getLocation")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getLocation"))) );
					}
					
					break;
				}
				
				
				case -1422950858:
				{
					if (field.equals("action")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("action"))) );
					}
					
					break;
				}
				
				
				case -75151241:
				{
					if (field.equals("getSize")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getSize"))) );
					}
					
					break;
				}
				
				
				case 101944666:
				{
					if (field.equals("keyUp")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("keyUp"))) );
					}
					
					break;
				}
				
				
				case 312809899:
				{
					if (field.equals("getBounds")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getBounds"))) );
					}
					
					break;
				}
				
				
				case -815927391:
				{
					if (field.equals("keyDown")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("keyDown"))) );
					}
					
					break;
				}
				
				
				case 1097148750:
				{
					if (field.equals("reshape")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("reshape"))) );
					}
					
					break;
				}
				
				
				case 585928547:
				{
					if (field.equals("mouseExit")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("mouseExit"))) );
					}
					
					break;
				}
				
				
				case 1671308008:
				{
					if (field.equals("disable")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("disable"))) );
					}
					
					break;
				}
				
				
				case 983628083:
				{
					if (field.equals("mouseEnter")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("mouseEnter"))) );
					}
					
					break;
				}
				
				
				case -1298848381:
				{
					if (field.equals("enable")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("enable"))) );
					}
					
					break;
				}
				
				
				case 586158614:
				{
					if (field.equals("mouseMove")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("mouseMove"))) );
					}
					
					break;
				}
				
				
				case 2065058606:
				{
					if (field.equals("processMouseMotionEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("processMouseMotionEvent"))) );
					}
					
					break;
				}
				
				
				case 1243066912:
				{
					if (field.equals("mouseUp")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("mouseUp"))) );
					}
					
					break;
				}
				
				
				case 786391236:
				{
					if (field.equals("processMouseEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("processMouseEvent"))) );
					}
					
					break;
				}
				
				
				case 585892729:
				{
					if (field.equals("mouseDrag")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("mouseDrag"))) );
					}
					
					break;
				}
				
				
				case 2139532042:
				{
					if (field.equals("processKeyEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("processKeyEvent"))) );
					}
					
					break;
				}
				
				
				case 585890535:
				{
					if (field.equals("mouseDown")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("mouseDown"))) );
					}
					
					break;
				}
				
				
				case -855811280:
				{
					if (field.equals("setBackground")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setBackground"))) );
					}
					
					break;
				}
				
				
				case 1469558098:
				{
					if (field.equals("handleEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("handleEvent"))) );
					}
					
					break;
				}
				
				
				case -1834127547:
				{
					if (field.equals("setForeground")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setForeground"))) );
					}
					
					break;
				}
				
				
				case -2051715969:
				{
					if (field.equals("processHierarchyBoundsEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("processHierarchyBoundsEvent"))) );
					}
					
					break;
				}
				
				
				case 1364071551:
				{
					if (field.equals("setEnabled")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setEnabled"))) );
					}
					
					break;
				}
				
				
				case 584549812:
				{
					if (field.equals("processHierarchyEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("processHierarchyEvent"))) );
					}
					
					break;
				}
				
				
				case -854558288:
				{
					if (field.equals("setVisible")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setVisible"))) );
					}
					
					break;
				}
				
				
				case 2117937310:
				{
					if (field.equals("processInputMethodEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("processInputMethodEvent"))) );
					}
					
					break;
				}
				
				
				case -2053764159:
				{
					if (field.equals("getBaselineResizeBehavior")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getBaselineResizeBehavior"))) );
					}
					
					break;
				}
				
				
				case -1880947691:
				{
					if (field.equals("processMouseWheelEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("processMouseWheelEvent"))) );
					}
					
					break;
				}
				
				
				case 357114811:
				{
					if (field.equals("getBaseline")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getBaseline"))) );
					}
					
					break;
				}
				
				
				case -1262981007:
				{
					if (field.equals("processFocusEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("processFocusEvent"))) );
					}
					
					break;
				}
				
				
				case -2116360191:
				{
					if (field.equals("getGraphics")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getGraphics"))) );
					}
					
					break;
				}
				
				
				case 1944745964:
				{
					if (field.equals("processComponentEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("processComponentEvent"))) );
					}
					
					break;
				}
				
				
				case -567445985:
				{
					if (field.equals("contains")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("contains"))) );
					}
					
					break;
				}
				
				
				case 23978912:
				{
					if (field.equals("coalesceEvents")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("coalesceEvents"))) );
					}
					
					break;
				}
				
				
				case -1403787411:
				{
					if (field.equals("setMinimumSize")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setMinimumSize"))) );
					}
					
					break;
				}
				
				
				case -1240522207:
				{
					if (field.equals("disableEvents")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("disableEvents"))) );
					}
					
					break;
				}
				
				
				case -726354817:
				{
					if (field.equals("setMaximumSize")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setMaximumSize"))) );
					}
					
					break;
				}
				
				
				case -2086501252:
				{
					if (field.equals("enableEvents")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("enableEvents"))) );
					}
					
					break;
				}
				
				
				case 737172192:
				{
					if (field.equals("setPreferredSize")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setPreferredSize"))) );
					}
					
					break;
				}
				
				
				case -730558213:
				{
					if (field.equals("getInputContext")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getInputContext"))) );
					}
					
					break;
				}
				
				
				case 2087644222:
				{
					if (field.equals("getFontMetrics")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getFontMetrics"))) );
					}
					
					break;
				}
				
				
				case 150256377:
				{
					if (field.equals("getInputMethodRequests")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getInputMethodRequests"))) );
					}
					
					break;
				}
				
				
				case -132373474:
				{
					if (field.equals("requestFocusInWindow")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("requestFocusInWindow"))) );
					}
					
					break;
				}
				
				
				case -1549673046:
				{
					if (field.equals("getInputMethodListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getInputMethodListeners"))) );
					}
					
					break;
				}
				
				
				case 1280029577:
				{
					if (field.equals("requestFocus")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("requestFocus"))) );
					}
					
					break;
				}
				
				
				case -910517253:
				{
					if (field.equals("removeInputMethodListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeInputMethodListener"))) );
					}
					
					break;
				}
				
				
				case -1166363724:
				{
					if (field.equals("printAll")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("printAll"))) );
					}
					
					break;
				}
				
				
				case -1026988866:
				{
					if (field.equals("addInputMethodListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addInputMethodListener"))) );
					}
					
					break;
				}
				
				
				case 319849826:
				{
					if (field.equals("isValidateRoot")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isValidateRoot"))) );
					}
					
					break;
				}
				
				
				case 2003512819:
				{
					if (field.equals("getMouseWheelListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getMouseWheelListeners"))) );
					}
					
					break;
				}
				
				
				case -1001125651:
				{
					if (field.equals("removeNotify")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeNotify"))) );
					}
					
					break;
				}
				
				
				case -25699282:
				{
					if (field.equals("removeMouseWheelListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeMouseWheelListener"))) );
					}
					
					break;
				}
				
				
				case -146849974:
				{
					if (field.equals("addNotify")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addNotify"))) );
					}
					
					break;
				}
				
				
				case 1910206219:
				{
					if (field.equals("addMouseWheelListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addMouseWheelListener"))) );
					}
					
					break;
				}
				
				
				case -1228323959:
				{
					if (field.equals("getListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getListeners"))) );
					}
					
					break;
				}
				
				
				case 1929852986:
				{
					if (field.equals("getMouseMotionListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getMouseMotionListeners"))) );
					}
					
					break;
				}
				
				
				case -1635067428:
				{
					if (field.equals("setFocusTraversalKeys")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setFocusTraversalKeys"))) );
					}
					
					break;
				}
				
				
				case 33009515:
				{
					if (field.equals("removeMouseMotionListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeMouseMotionListener"))) );
					}
					
					break;
				}
				
				
				case 1984576465:
				{
					if (field.equals("setFont")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setFont"))) );
					}
					
					break;
				}
				
				
				case -83462098:
				{
					if (field.equals("addMouseMotionListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addMouseMotionListener"))) );
					}
					
					break;
				}
				
				
				case -1328196917:
				{
					if (field.equals("getAlignmentX")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getAlignmentX"))) );
					}
					
					break;
				}
				
				
				case 2072701968:
				{
					if (field.equals("getMouseListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getMouseListeners"))) );
					}
					
					break;
				}
				
				
				case -1328196916:
				{
					if (field.equals("getAlignmentY")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getAlignmentY"))) );
					}
					
					break;
				}
				
				
				case -2119295403:
				{
					if (field.equals("removeMouseListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeMouseListener"))) );
					}
					
					break;
				}
				
				
				case 512222700:
				{
					if (field.equals("getInsets")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getInsets"))) );
					}
					
					break;
				}
				
				
				case 2091349336:
				{
					if (field.equals("addMouseListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addMouseListener"))) );
					}
					
					break;
				}
				
				
				case 367948793:
				{
					if (field.equals("getMinimumSize")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getMinimumSize"))) );
					}
					
					break;
				}
				
				
				case -68050666:
				{
					if (field.equals("getKeyListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getKeyListeners"))) );
					}
					
					break;
				}
				
				
				case 1045381387:
				{
					if (field.equals("getMaximumSize")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getMaximumSize"))) );
					}
					
					break;
				}
				
				
				case 2108484879:
				{
					if (field.equals("removeKeyListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeKeyListener"))) );
					}
					
					break;
				}
				
				
				case -1726352276:
				{
					if (field.equals("getPreferredSize")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getPreferredSize"))) );
					}
					
					break;
				}
				
				
				case 705046738:
				{
					if (field.equals("addKeyListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addKeyListener"))) );
					}
					
					break;
				}
				
				
				case 106934957:
				{
					if (field.equals("print")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("print"))) );
					}
					
					break;
				}
				
				
				case -292872821:
				{
					if (field.equals("getHierarchyBoundsListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getHierarchyBoundsListeners"))) );
					}
					
					break;
				}
				
				
				case 106428510:
				{
					if (field.equals("paint")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("paint"))) );
					}
					
					break;
				}
				
				
				case 1695089402:
				{
					if (field.equals("removeHierarchyBoundsListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeHierarchyBoundsListener"))) );
					}
					
					break;
				}
				
				
				case -838846263:
				{
					if (field.equals("update")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("update"))) );
					}
					
					break;
				}
				
				
				case 875541053:
				{
					if (field.equals("addHierarchyBoundsListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addHierarchyBoundsListener"))) );
					}
					
					break;
				}
				
				
				case -1269752847:
				{
					if (field.equals("setInheritsPopupMenu")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setInheritsPopupMenu"))) );
					}
					
					break;
				}
				
				
				case -300913280:
				{
					if (field.equals("getHierarchyListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getHierarchyListeners"))) );
					}
					
					break;
				}
				
				
				case -658829443:
				{
					if (field.equals("getInheritsPopupMenu")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getInheritsPopupMenu"))) );
					}
					
					break;
				}
				
				
				case -2019322395:
				{
					if (field.equals("removeHierarchyListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeHierarchyListener"))) );
					}
					
					break;
				}
				
				
				case 1988229040:
				{
					if (field.equals("setComponentPopupMenu")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setComponentPopupMenu"))) );
					}
					
					break;
				}
				
				
				case 675525480:
				{
					if (field.equals("addHierarchyListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addHierarchyListener"))) );
					}
					
					break;
				}
				
				
				case -547981916:
				{
					if (field.equals("getComponentPopupMenu")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getComponentPopupMenu"))) );
					}
					
					break;
				}
				
				
				case 1237998909:
				{
					if (field.equals("getFocusListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getFocusListeners"))) );
					}
					
					break;
				}
				
				
				case 241460722:
				{
					if (field.equals("getComponentGraphics")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getComponentGraphics"))) );
					}
					
					break;
				}
				
				
				case -2007673976:
				{
					if (field.equals("removeFocusListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeFocusListener"))) );
					}
					
					break;
				}
				
				
				case -490374019:
				{
					if (field.equals("paintChildren")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("paintChildren"))) );
					}
					
					break;
				}
				
				
				case -2091996533:
				{
					if (field.equals("addFocusListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addFocusListener"))) );
					}
					
					break;
				}
				
				
				case -1778836950:
				{
					if (field.equals("paintBorder")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("paintBorder"))) );
					}
					
					break;
				}
				
				
				case -1150319688:
				{
					if (field.equals("getComponentListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getComponentListeners"))) );
					}
					
					break;
				}
				
				
				case -20235056:
				{
					if (field.equals("printComponent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("printComponent"))) );
					}
					
					break;
				}
				
				
				case 862771373:
				{
					if (field.equals("removeComponentListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeComponentListener"))) );
					}
					
					break;
				}
				
				
				case 1704032204:
				{
					if (field.equals("printChildren")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("printChildren"))) );
					}
					
					break;
				}
				
				
				case -737348048:
				{
					if (field.equals("addComponentListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addComponentListener"))) );
					}
					
					break;
				}
				
				
				case -824599239:
				{
					if (field.equals("printBorder")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("printBorder"))) );
					}
					
					break;
				}
				
				
				case 1979010522:
				{
					if (field.equals("postEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("postEvent"))) );
					}
					
					break;
				}
				
				
				case 142938588:
				{
					if (field.equals("isPaintingTile")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isPaintingTile"))) );
					}
					
					break;
				}
				
				
				case -2140931520:
				{
					if (field.equals("dispatchEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("dispatchEvent"))) );
					}
					
					break;
				}
				
				
				case -770686062:
				{
					if (field.equals("isPaintingForPrint")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isPaintingForPrint"))) );
					}
					
					break;
				}
				
				
				case -1183789060:
				{
					if (field.equals("inside")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("inside"))) );
					}
					
					break;
				}
				
				
				case 890536972:
				{
					if (field.equals("isManagingFocus")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isManagingFocus"))) );
					}
					
					break;
				}
				
				
				case 913594403:
				{
					if (field.equals("getIgnoreRepaint")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getIgnoreRepaint"))) );
					}
					
					break;
				}
				
				
				case 1256979008:
				{
					if (field.equals("setNextFocusableComponent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setNextFocusableComponent"))) );
					}
					
					break;
				}
				
				
				case -917848425:
				{
					if (field.equals("setIgnoreRepaint")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setIgnoreRepaint"))) );
					}
					
					break;
				}
				
				
				case 413687348:
				{
					if (field.equals("getNextFocusableComponent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getNextFocusableComponent"))) );
					}
					
					break;
				}
				
				
				case -538855117:
				{
					if (field.equals("checkImage")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("checkImage"))) );
					}
					
					break;
				}
				
				
				case 217231286:
				{
					if (field.equals("setRequestFocusEnabled")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setRequestFocusEnabled"))) );
					}
					
					break;
				}
				
				
				case -2048673644:
				{
					if (field.equals("prepareImage")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("prepareImage"))) );
					}
					
					break;
				}
				
				
				case -375268882:
				{
					if (field.equals("isRequestFocusEnabled")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isRequestFocusEnabled"))) );
					}
					
					break;
				}
				
				
				case -746920573:
				{
					if (field.equals("createVolatileImage")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("createVolatileImage"))) );
					}
					
					break;
				}
				
				
				case -1605080596:
				{
					if (field.equals("grabFocus")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("grabFocus"))) );
					}
					
					break;
				}
				
				
				case -514107969:
				{
					if (field.equals("createImage")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("createImage"))) );
					}
					
					break;
				}
				
				
				case -2089656352:
				{
					if (field.equals("setVerifyInputWhenFocusTarget")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setVerifyInputWhenFocusTarget"))) );
					}
					
					break;
				}
				
				
				case -2066473468:
				{
					if (field.equals("imageUpdate")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("imageUpdate"))) );
					}
					
					break;
				}
				
				
				case -1816942124:
				{
					if (field.equals("getVerifyInputWhenFocusTarget")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getVerifyInputWhenFocusTarget"))) );
					}
					
					break;
				}
				
				
				case 925942883:
				{
					if (field.equals("paintAll")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("paintAll"))) );
					}
					
					break;
				}
				
				
				case 98093870:
				{
					if (field.equals("setBorder")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setBorder"))) );
					}
					
					break;
				}
				
				
				case 1873980194:
				{
					if (field.equals("isCursorSet")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isCursorSet"))) );
					}
					
					break;
				}
				
				
				case 312710946:
				{
					if (field.equals("getBorder")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getBorder"))) );
					}
					
					break;
				}
				
				
				case 346895948:
				{
					if (field.equals("getCursor")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getCursor"))) );
					}
					
					break;
				}
				
				
				case -554065704:
				{
					if (field.equals("setAlignmentY")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setAlignmentY"))) );
					}
					
					break;
				}
				
				
				case 132278872:
				{
					if (field.equals("setCursor")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setCursor"))) );
					}
					
					break;
				}
				
				
				case -554065705:
				{
					if (field.equals("setAlignmentX")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setAlignmentX"))) );
					}
					
					break;
				}
				
				
				case -1057546709:
				{
					if (field.equals("isMaximumSizeSet")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isMaximumSizeSet"))) );
					}
					
					break;
				}
				
				
				case -136014978:
				{
					if (field.equals("setInputVerifier")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setInputVerifier"))) );
					}
					
					break;
				}
				
				
				case -400630659:
				{
					if (field.equals("isMinimumSizeSet")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isMinimumSizeSet"))) );
					}
					
					break;
				}
				
				
				case 1695427850:
				{
					if (field.equals("getInputVerifier")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getInputVerifier"))) );
					}
					
					break;
				}
				
				
				case -1787544022:
				{
					if (field.equals("isPreferredSizeSet")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isPreferredSizeSet"))) );
					}
					
					break;
				}
				
				
				case -1390686654:
				{
					if (field.equals("setDebugGraphicsOptions")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setDebugGraphicsOptions"))) );
					}
					
					break;
				}
				
				
				case 1387686788:
				{
					if (field.equals("isLightweight")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isLightweight"))) );
					}
					
					break;
				}
				
				
				case 852008758:
				{
					if (field.equals("getDebugGraphicsOptions")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getDebugGraphicsOptions"))) );
					}
					
					break;
				}
				
				
				case 98192823:
				{
					if (field.equals("setBounds")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setBounds"))) );
					}
					
					break;
				}
				
				
				case -1402521984:
				{
					if (field.equals("registerKeyboardAction")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("registerKeyboardAction"))) );
					}
					
					break;
				}
				
				
				case -1383205195:
				{
					if (field.equals("bounds")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("bounds"))) );
					}
					
					break;
				}
				
				
				case -1167238055:
				{
					if (field.equals("unregisterKeyboardAction")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("unregisterKeyboardAction"))) );
					}
					
					break;
				}
				
				
				case -934437708:
				{
					if (field.equals("resize")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("resize"))) );
					}
					
					break;
				}
				
				
				case -760205708:
				{
					if (field.equals("getRegisteredKeyStrokes")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getRegisteredKeyStrokes"))) );
					}
					
					break;
				}
				
				
				case 1984958339:
				{
					if (field.equals("setSize")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setSize"))) );
					}
					
					break;
				}
				
				
				case -2016664141:
				{
					if (field.equals("getConditionForKeyStroke")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getConditionForKeyStroke"))) );
					}
					
					break;
				}
				
				
				case 3530753:
				{
					if (field.equals("size")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("size"))) );
					}
					
					break;
				}
				
				
				case -1337788934:
				{
					if (field.equals("getActionForKeyStroke")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getActionForKeyStroke"))) );
					}
					
					break;
				}
				
				
				case 3357649:
				{
					if (field.equals("move")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("move"))) );
					}
					
					break;
				}
				
				
				case -1777533497:
				{
					if (field.equals("resetKeyboardActions")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("resetKeyboardActions"))) );
					}
					
					break;
				}
				
				
				case -404603337:
				{
					if (field.equals("setLocation")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setLocation"))) );
					}
					
					break;
				}
				
				
				case -1834948684:
				{
					if (field.equals("setInputMap")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setInputMap"))) );
					}
					
					break;
				}
				
				
				case 1901043637:
				{
					if (field.equals("location")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("location"))) );
					}
					
					break;
				}
				
				
				case -1746368856:
				{
					if (field.equals("getInputMap")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getInputMap"))) );
					}
					
					break;
				}
				
				
				case 204504438:
				{
					if (field.equals("getLocationOnScreen")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getLocationOnScreen"))) );
					}
					
					break;
				}
				
				
				case 1737665796:
				{
					if (field.equals("setActionMap")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setActionMap"))) );
					}
					
					break;
				}
				
				
				case 975157628:
				{
					if (field.equals("getColorModel")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getColorModel"))) );
					}
					
					break;
				}
				
				
				case 188673168:
				{
					if (field.equals("getActionMap")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getActionMap"))) );
					}
					
					break;
				}
				
				
				case 383935836:
				{
					if (field.equals("setLocale")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setLocale"))) );
					}
					
					break;
				}
				
				
				case -1253361850:
				{
					if (field.equals("requestDefaultFocus")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("requestDefaultFocus"))) );
					}
					
					break;
				}
				
				
				case 598552912:
				{
					if (field.equals("getLocale")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getLocale"))) );
					}
					
					break;
				}
				
				
				case 1312303337:
				{
					if (field.equals("processComponentKeyEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("processComponentKeyEvent"))) );
					}
					
					break;
				}
				
				
				case -1260721911:
				{
					if (field.equals("isFontSet")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isFontSet"))) );
					}
					
					break;
				}
				
				
				case 69241589:
				{
					if (field.equals("processKeyBinding")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("processKeyBinding"))) );
					}
					
					break;
				}
				
				
				case -75533115:
				{
					if (field.equals("getFont")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getFont"))) );
					}
					
					break;
				}
				
				
				case 90841582:
				{
					if (field.equals("setToolTipText")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setToolTipText"))) );
					}
					
					break;
				}
				
				
				case 274796362:
				{
					if (field.equals("isBackgroundSet")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isBackgroundSet"))) );
					}
					
					break;
				}
				
				
				case 1862577786:
				{
					if (field.equals("getToolTipText")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getToolTipText"))) );
					}
					
					break;
				}
				
				
				case -1629942492:
				{
					if (field.equals("getBackground")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getBackground"))) );
					}
					
					break;
				}
				
				
				case -1795253630:
				{
					if (field.equals("getToolTipLocation")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getToolTipLocation"))) );
					}
					
					break;
				}
				
				
				case 902956821:
				{
					if (field.equals("isForegroundSet")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isForegroundSet"))) );
					}
					
					break;
				}
				
				
				case -1988967221:
				{
					if (field.equals("getPopupLocation")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getPopupLocation"))) );
					}
					
					break;
				}
				
				
				case 1686708537:
				{
					if (field.equals("getForeground")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getForeground"))) );
					}
					
					break;
				}
				
				
				case 1106410311:
				{
					if (field.equals("createToolTip")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("createToolTip"))) );
					}
					
					break;
				}
				
				
				case 3202370:
				{
					if (field.equals("hide")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("hide"))) );
					}
					
					break;
				}
				
				
				case 954363430:
				{
					if (field.equals("scrollRectToVisible")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("scrollRectToVisible"))) );
					}
					
					break;
				}
				
				
				case 3529469:
				{
					if (field.equals("show")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("show"))) );
					}
					
					break;
				}
				
				
				case 753917173:
				{
					if (field.equals("setAutoscrolls")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setAutoscrolls"))) );
					}
					
					break;
				}
				
				
				case -174300757:
				{
					if (field.equals("enableInputMethods")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("enableInputMethods"))) );
					}
					
					break;
				}
				
				
				case -1769313919:
				{
					if (field.equals("getAutoscrolls")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getAutoscrolls"))) );
					}
					
					break;
				}
				
				
				case 2105594551:
				{
					if (field.equals("isEnabled")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isEnabled"))) );
					}
					
					break;
				}
				
				
				case -1691618275:
				{
					if (field.equals("setTransferHandler")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setTransferHandler"))) );
					}
					
					break;
				}
				
				
				case 1487521595:
				{
					if (field.equals("isShowing")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isShowing"))) );
					}
					
					break;
				}
				
				
				case 1683315369:
				{
					if (field.equals("getTransferHandler")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getTransferHandler"))) );
					}
					
					break;
				}
				
				
				case -113035288:
				{
					if (field.equals("isVisible")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isVisible"))) );
					}
					
					break;
				}
				
				
				case -1141635146:
				{
					if (field.equals("getClientProperty")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getClientProperty"))) );
					}
					
					break;
				}
				
				
				case 304683410:
				{
					if (field.equals("isDisplayable")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isDisplayable"))) );
					}
					
					break;
				}
				
				
				case -1425362001:
				{
					if (field.equals("putClientProperty")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("putClientProperty"))) );
					}
					
					break;
				}
				
				
				case 2073378034:
				{
					if (field.equals("isValid")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isValid"))) );
					}
					
					break;
				}
				
				
				case 470702883:
				{
					if (field.equals("setOpaque")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setOpaque"))) );
					}
					
					break;
				}
				
				
				case -103224824:
				{
					if (field.equals("getToolkit")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getToolkit"))) );
					}
					
					break;
				}
				
				
				case 456055999:
				{
					if (field.equals("computeVisibleRect")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("computeVisibleRect"))) );
					}
					
					break;
				}
				
				
				case -831132833:
				{
					if (field.equals("getTreeLock")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getTreeLock"))) );
					}
					
					break;
				}
				
				
				case -509772736:
				{
					if (field.equals("getVisibleRect")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getVisibleRect"))) );
					}
					
					break;
				}
				
				
				case 1406043765:
				{
					if (field.equals("getGraphicsConfiguration")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getGraphicsConfiguration"))) );
					}
					
					break;
				}
				
				
				case -800831894:
				{
					if (field.equals("fireVetoableChange")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("fireVetoableChange"))) );
					}
					
					break;
				}
				
				
				case 631903574:
				{
					if (field.equals("getDropTarget")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getDropTarget"))) );
					}
					
					break;
				}
				
				
				case -894798487:
				{
					if (field.equals("addVetoableChangeListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addVetoableChangeListener"))) );
					}
					
					break;
				}
				
				
				case 1406034786:
				{
					if (field.equals("setDropTarget")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setDropTarget"))) );
					}
					
					break;
				}
				
				
				case -1422550772:
				{
					if (field.equals("removeVetoableChangeListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeVetoableChangeListener"))) );
					}
					
					break;
				}
				
				
				case -75245096:
				{
					if (field.equals("getPeer")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getPeer"))) );
					}
					
					break;
				}
				
				
				case -637180459:
				{
					if (field.equals("getVetoableChangeListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getVetoableChangeListeners"))) );
					}
					
					break;
				}
				
				
				case 700591008:
				{
					if (field.equals("getParent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getParent"))) );
					}
					
					break;
				}
				
				
				case -701878888:
				{
					if (field.equals("getTopLevelAncestor")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getTopLevelAncestor"))) );
					}
					
					break;
				}
				
				
				case 1984801293:
				{
					if (field.equals("setName")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setName"))) );
					}
					
					break;
				}
				
				
				case -1065055640:
				{
					if (field.equals("addAncestorListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addAncestorListener"))) );
					}
					
					break;
				}
				
				
				case -75308287:
				{
					if (field.equals("getName")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getName"))) );
					}
					
					break;
				}
				
				
				case -1567628213:
				{
					if (field.equals("removeAncestorListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeAncestorListener"))) );
					}
					
					break;
				}
				
				
				case -606755785:
				{
					if (field.equals("transferFocusDownCycle")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("transferFocusDownCycle"))) );
					}
					
					break;
				}
				
				
				case -727692042:
				{
					if (field.equals("getAncestorListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getAncestorListeners"))) );
					}
					
					break;
				}
				
				
				case -1708753933:
				{
					if (field.equals("isFocusTraversalPolicyProvider")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isFocusTraversalPolicyProvider"))) );
					}
					
					break;
				}
				
				
				case -1444703808:
				{
					if (field.equals("isOptimizedDrawingEnabled")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isOptimizedDrawingEnabled"))) );
					}
					
					break;
				}
				
				
				case 626370347:
				{
					if (field.equals("setFocusTraversalPolicyProvider")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setFocusTraversalPolicyProvider"))) );
					}
					
					break;
				}
				
				
				case -209888556:
				{
					if (field.equals("isPaintingOrigin")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isPaintingOrigin"))) );
					}
					
					break;
				}
				
				
				case -44786190:
				{
					if (field.equals("setFocusCycleRoot")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setFocusCycleRoot"))) );
					}
					
					break;
				}
				
				
				case 1356268992:
				{
					if (field.equals("paintImmediately")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("paintImmediately"))) );
					}
					
					break;
				}
				
				
				case 602541344:
				{
					if (field.equals("isFocusTraversalPolicySet")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isFocusTraversalPolicySet"))) );
					}
					
					break;
				}
				
				
				case 383468754:
				{
					if (field.equals("setDoubleBuffered")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setDoubleBuffered"))) );
					}
					
					break;
				}
				
				
				case -1242052594:
				{
					if (field.equals("getFocusTraversalPolicy")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getFocusTraversalPolicy"))) );
					}
					
					break;
				}
				
				
				case 1910920416:
				{
					if (field.equals("getRootPane")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getRootPane"))) );
					}
					
					break;
				}
				
				
				case 810219290:
				{
					if (field.equals("setFocusTraversalPolicy")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setFocusTraversalPolicy"))) );
					}
					
					break;
				}
				
				
				case -61228775:
				{
					if (field.equals("accessibleContext")) 
					{
						__temp_executeDef204 = false;
						return this.accessibleContext;
					}
					
					break;
				}
				
				
				case -1671141420:
				{
					if (field.equals("isAncestorOf")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isAncestorOf"))) );
					}
					
					break;
				}
				
				
				case -1505267854:
				{
					if (field.equals("listenerList")) 
					{
						__temp_executeDef204 = false;
						return this.listenerList;
					}
					
					break;
				}
				
				
				case 398126743:
				{
					if (field.equals("findComponentAt")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("findComponentAt"))) );
					}
					
					break;
				}
				
				
				case 3732:
				{
					if (field.equals("ui")) 
					{
						__temp_executeDef204 = false;
						return this.ui;
					}
					
					break;
				}
				
				
				case 438337848:
				{
					if (field.equals("getMousePosition")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getMousePosition"))) );
					}
					
					break;
				}
				
				
				case -1117363270:
				{
					if (field.equals("addPropertyChangeListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addPropertyChangeListener"))) );
					}
					
					break;
				}
				
				
				case 1430084328:
				{
					if (field.equals("processContainerEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("processContainerEvent"))) );
					}
					
					break;
				}
				
				
				case -679533279:
				{
					if (field.equals("applyComponentOrientation")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("applyComponentOrientation"))) );
					}
					
					break;
				}
				
				
				case 576751796:
				{
					if (field.equals("getContainerListeners")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getContainerListeners"))) );
					}
					
					break;
				}
				
				
				case -311299910:
				{
					if (field.equals("isFocusCycleRoot")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("isFocusCycleRoot"))) );
					}
					
					break;
				}
				
				
				case 1611220017:
				{
					if (field.equals("removeContainerListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeContainerListener"))) );
					}
					
					break;
				}
				
				
				case -355296716:
				{
					if (field.equals("areFocusTraversalKeysSet")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("areFocusTraversalKeysSet"))) );
					}
					
					break;
				}
				
				
				case 11100596:
				{
					if (field.equals("addContainerListener")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addContainerListener"))) );
					}
					
					break;
				}
				
				
				case 123688912:
				{
					if (field.equals("getFocusTraversalKeys")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getFocusTraversalKeys"))) );
					}
					
					break;
				}
				
				
				case -627286621:
				{
					if (field.equals("printComponents")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("printComponents"))) );
					}
					
					break;
				}
				
				
				case 3322014:
				{
					if (field.equals("list")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("list"))) );
					}
					
					break;
				}
				
				
				case -622724588:
				{
					if (field.equals("paintComponents")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("paintComponents"))) );
					}
					
					break;
				}
				
				
				case -1626201894:
				{
					if (field.equals("getComponentAt")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getComponentAt"))) );
					}
					
					break;
				}
				
				
				case 1081247188:
				{
					if (field.equals("validateTree")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("validateTree"))) );
					}
					
					break;
				}
				
				
				case -1097461934:
				{
					if (field.equals("locate")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("locate"))) );
					}
					
					break;
				}
				
				
				case 371675692:
				{
					if (field.equals("setLayout")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setLayout"))) );
					}
					
					break;
				}
				
				
				case 634939509:
				{
					if (field.equals("deliverEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("deliverEvent"))) );
					}
					
					break;
				}
				
				
				case 586292768:
				{
					if (field.equals("getLayout")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getLayout"))) );
					}
					
					break;
				}
				
				
				case 1969426795:
				{
					if (field.equals("processEvent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("processEvent"))) );
					}
					
					break;
				}
				
				
				case 1282345597:
				{
					if (field.equals("removeAll")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("removeAll"))) );
					}
					
					break;
				}
				
				
				case 1008217391:
				{
					if (field.equals("minimumSize")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("minimumSize"))) );
					}
					
					break;
				}
				
				
				case -934610812:
				{
					if (field.equals("remove")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("remove"))) );
					}
					
					break;
				}
				
				
				case -608552926:
				{
					if (field.equals("preferredSize")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("preferredSize"))) );
					}
					
					break;
				}
				
				
				case -1148905887:
				{
					if (field.equals("addImpl")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("addImpl"))) );
					}
					
					break;
				}
				
				
				case -1421272810:
				{
					if (field.equals("validate")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("validate"))) );
					}
					
					break;
				}
				
				
				case -1109967845:
				{
					if (field.equals("getComponentZOrder")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getComponentZOrder"))) );
					}
					
					break;
				}
				
				
				case -1831849669:
				{
					if (field.equals("invalidate")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("invalidate"))) );
					}
					
					break;
				}
				
				
				case -189934193:
				{
					if (field.equals("setComponentZOrder")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("setComponentZOrder"))) );
					}
					
					break;
				}
				
				
				case -1109722326:
				{
					if (field.equals("layout")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("layout"))) );
					}
					
					break;
				}
				
				
				case 96417:
				{
					if (field.equals("add")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("add"))) );
					}
					
					break;
				}
				
				
				case 185147285:
				{
					if (field.equals("doLayout")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("doLayout"))) );
					}
					
					break;
				}
				
				
				case -1183792394:
				{
					if (field.equals("insets")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("insets"))) );
					}
					
					break;
				}
				
				
				case 1052288776:
				{
					if (field.equals("getComponentCount")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getComponentCount"))) );
					}
					
					break;
				}
				
				
				case -745194740:
				{
					if (field.equals("getComponents")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getComponents"))) );
					}
					
					break;
				}
				
				
				case -754783867:
				{
					if (field.equals("countComponents")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("countComponents"))) );
					}
					
					break;
				}
				
				
				case -1409511865:
				{
					if (field.equals("getComponent")) 
					{
						__temp_executeDef204 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("getComponent"))) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef204) 
			{
				return this.__hx_lookupField(field, throwErrors, isCheck);
			}
			 else 
			{
				throw null;
			}
			
		}
		
	}
	
	
	public   double __hx_getField_f(java.lang.String field, boolean throwErrors, boolean handleProperties)
	{
		{
			{
				return this.__hx_lookupField_f(field, throwErrors);
			}
			
		}
		
	}
	
	
	public   java.lang.Object __hx_invokeField(java.lang.String field, haxe.root.Array dynargs)
	{
		{
			int __temp_hash207 = field.hashCode();
			boolean __temp_executeDef206 = true;
			switch (__temp_hash207)
			{
				case -132109047:case 1920162837:case 1053245860:case -1645115555:case -1776922004:case 1115025797:case 117596766:case 122660510:case 1229986480:case 1193982373:case -2037192787:case 564387289:case -1338154671:case -100025915:case -1126567952:case -1487536088:case -1426705793:case 619607060:case -2056434772:case -1422950858:case 101944666:case -815927391:case 585928547:case 983628083:case 586158614:case 1243066912:case 585892729:case 585890535:case 1469558098:case -2051715969:case 584549812:case 2117937310:case -1880947691:case -1262981007:case 1944745964:case 23978912:case -1240522207:case -2086501252:case -730558213:case 150256377:case -1549673046:case -910517253:case -1026988866:case 2003512819:case -25699282:case 1910206219:case 1929852986:case 33009515:case -83462098:case 2072701968:case -2119295403:case 2091349336:case -68050666:case 2108484879:case 705046738:case -292872821:case 1695089402:case 875541053:case -300913280:case -2019322395:case 675525480:case 1237998909:case -2007673976:case -2091996533:case -1150319688:case 862771373:case -737348048:case 1979010522:case -2140931520:case -1183789060:case 913594403:case -917848425:case -538855117:case -2048673644:case -746920573:case -514107969:case -2066473468:case 925942883:case 1873980194:case 346895948:case 132278872:case -1057546709:case -400630659:case -1787544022:case 1387686788:case 98192823:case -1383205195:case -934437708:case 1984958339:case 3530753:case 3357649:case -404603337:case 1901043637:case 204504438:case 975157628:case 383935836:case 598552912:case -1260721911:case -75533115:case 274796362:case -1629942492:case 902956821:case 1686708537:case 3202370:case 3529469:case -174300757:case 2105594551:case 1487521595:case -113035288:case 304683410:case 2073378034:case -103224824:case -831132833:case 1406043765:case 631903574:case 1406034786:case -75245096:case 700591008:case 1984801293:case -75308287:case -606755785:case -1708753933:case 626370347:case -44786190:case 602541344:case -1242052594:case 810219290:case -1671141420:case 398126743:case 438337848:case 1430084328:case 576751796:case 1611220017:case 11100596:case -627286621:case -622724588:case 1081247188:case 371675692:case 586292768:case 1282345597:case -934610812:case -1148905887:case -1109967845:case -189934193:case 96417:case -1183792394:case -745194740:case -1409511865:case -754783867:case 1052288776:case 185147285:case -1109722326:case -1831849669:case -1421272810:case -608552926:case 1008217391:case 1969426795:case 634939509:case -1097461934:case -1626201894:case 3322014:case 123688912:case -355296716:case -311299910:case -679533279:case -1117363270:case 1910920416:case 383468754:case 1356268992:case -209888556:case -1444703808:case -727692042:case -1567628213:case -1065055640:case -701878888:case -637180459:case -1422550772:case -894798487:case -800831894:case -509772736:case 456055999:case 470702883:case -1425362001:case -1141635146:case 1683315369:case -1691618275:case -1769313919:case 753917173:case 954363430:case 1106410311:case -1988967221:case -1795253630:case 1862577786:case 90841582:case 69241589:case 1312303337:case -1253361850:case 188673168:case 1737665796:case -1746368856:case -1834948684:case -1777533497:case -1337788934:case -2016664141:case -760205708:case -1167238055:case -1402521984:case 852008758:case -1390686654:case 1695427850:case -136014978:case -554065705:case -554065704:case 312710946:case 98093870:case -1816942124:case -2089656352:case -1605080596:case -375268882:case 217231286:case 413687348:case 1256979008:case 890536972:case -770686062:case 142938588:case -824599239:case 1704032204:case -20235056:case -1778836950:case -490374019:case 241460722:case -547981916:case 1988229040:case -658829443:case -1269752847:case -838846263:case 106428510:case 106934957:case -1726352276:case 1045381387:case 367948793:case 512222700:case -1328196916:case -1328196917:case 1984576465:case -1635067428:case -1228323959:case -146849974:case -1001125651:case 319849826:case -1166363724:case 1280029577:case -132373474:case 2087644222:case 737172192:case -726354817:case -1403787411:case -567445985:case -2116360191:case 357114811:case -2053764159:case -854558288:case 1364071551:case -1834127547:case -855811280:case 2139532042:case 786391236:case 2065058606:case -1298848381:case 1671308008:case 1097148750:case 312809899:case -75151241:case -316023509:case 3169218:case 3169219:case 1968952336:case 474985501:case -336661013:case -2036853317:case 1094177291:case -218282935:case 116955034:case 109327990:case 98245738:case 1322595613:case -133970743:case 820971262:case 1334722659:
				{
					if (( (( ( __temp_hash207 == -132109047 ) && field.equals("getComponentOrientation") )) || ( (( ( __temp_hash207 == 1920162837 ) && field.equals("setComponentOrientation") )) || ( (( ( __temp_hash207 == 1053245860 ) && field.equals("getPropertyChangeListeners") )) || ( (( ( __temp_hash207 == -1645115555 ) && field.equals("removePropertyChangeListener") )) || ( (( ( __temp_hash207 == -1776922004 ) && field.equals("toString") )) || ( (( ( __temp_hash207 == 1115025797 ) && field.equals("isFocusOwner") )) || ( (( ( __temp_hash207 == 117596766 ) && field.equals("hasFocus") )) || ( (( ( __temp_hash207 == 122660510 ) && field.equals("transferFocusUpCycle") )) || ( (( ( __temp_hash207 == 1229986480 ) && field.equals("transferFocusBackward") )) || ( (( ( __temp_hash207 == 1193982373 ) && field.equals("nextFocus") )) || ( (( ( __temp_hash207 == -2037192787 ) && field.equals("transferFocus") )) || ( (( ( __temp_hash207 == 564387289 ) && field.equals("getFocusCycleRootAncestor") )) || ( (( ( __temp_hash207 == -1338154671 ) && field.equals("getFocusTraversalKeysEnabled") )) || ( (( ( __temp_hash207 == -100025915 ) && field.equals("setFocusTraversalKeysEnabled") )) || ( (( ( __temp_hash207 == -1126567952 ) && field.equals("setFocusable") )) || ( (( ( __temp_hash207 == -1487536088 ) && field.equals("isFocusable") )) || ( (( ( __temp_hash207 == -1426705793 ) && field.equals("isFocusTraversable") )) || ( (( ( __temp_hash207 == 619607060 ) && field.equals("lostFocus") )) || ( (( ( __temp_hash207 == -2056434772 ) && field.equals("gotFocus") )) || ( (( ( __temp_hash207 == -1422950858 ) && field.equals("action") )) || ( (( ( __temp_hash207 == 101944666 ) && field.equals("keyUp") )) || ( (( ( __temp_hash207 == -815927391 ) && field.equals("keyDown") )) || ( (( ( __temp_hash207 == 585928547 ) && field.equals("mouseExit") )) || ( (( ( __temp_hash207 == 983628083 ) && field.equals("mouseEnter") )) || ( (( ( __temp_hash207 == 586158614 ) && field.equals("mouseMove") )) || ( (( ( __temp_hash207 == 1243066912 ) && field.equals("mouseUp") )) || ( (( ( __temp_hash207 == 585892729 ) && field.equals("mouseDrag") )) || ( (( ( __temp_hash207 == 585890535 ) && field.equals("mouseDown") )) || ( (( ( __temp_hash207 == 1469558098 ) && field.equals("handleEvent") )) || ( (( ( __temp_hash207 == -2051715969 ) && field.equals("processHierarchyBoundsEvent") )) || ( (( ( __temp_hash207 == 584549812 ) && field.equals("processHierarchyEvent") )) || ( (( ( __temp_hash207 == 2117937310 ) && field.equals("processInputMethodEvent") )) || ( (( ( __temp_hash207 == -1880947691 ) && field.equals("processMouseWheelEvent") )) || ( (( ( __temp_hash207 == -1262981007 ) && field.equals("processFocusEvent") )) || ( (( ( __temp_hash207 == 1944745964 ) && field.equals("processComponentEvent") )) || ( (( ( __temp_hash207 == 23978912 ) && field.equals("coalesceEvents") )) || ( (( ( __temp_hash207 == -1240522207 ) && field.equals("disableEvents") )) || ( (( ( __temp_hash207 == -2086501252 ) && field.equals("enableEvents") )) || ( (( ( __temp_hash207 == -730558213 ) && field.equals("getInputContext") )) || ( (( ( __temp_hash207 == 150256377 ) && field.equals("getInputMethodRequests") )) || ( (( ( __temp_hash207 == -1549673046 ) && field.equals("getInputMethodListeners") )) || ( (( ( __temp_hash207 == -910517253 ) && field.equals("removeInputMethodListener") )) || ( (( ( __temp_hash207 == -1026988866 ) && field.equals("addInputMethodListener") )) || ( (( ( __temp_hash207 == 2003512819 ) && field.equals("getMouseWheelListeners") )) || ( (( ( __temp_hash207 == -25699282 ) && field.equals("removeMouseWheelListener") )) || ( (( ( __temp_hash207 == 1910206219 ) && field.equals("addMouseWheelListener") )) || ( (( ( __temp_hash207 == 1929852986 ) && field.equals("getMouseMotionListeners") )) || ( (( ( __temp_hash207 == 33009515 ) && field.equals("removeMouseMotionListener") )) || ( (( ( __temp_hash207 == -83462098 ) && field.equals("addMouseMotionListener") )) || ( (( ( __temp_hash207 == 2072701968 ) && field.equals("getMouseListeners") )) || ( (( ( __temp_hash207 == -2119295403 ) && field.equals("removeMouseListener") )) || ( (( ( __temp_hash207 == 2091349336 ) && field.equals("addMouseListener") )) || ( (( ( __temp_hash207 == -68050666 ) && field.equals("getKeyListeners") )) || ( (( ( __temp_hash207 == 2108484879 ) && field.equals("removeKeyListener") )) || ( (( ( __temp_hash207 == 705046738 ) && field.equals("addKeyListener") )) || ( (( ( __temp_hash207 == -292872821 ) && field.equals("getHierarchyBoundsListeners") )) || ( (( ( __temp_hash207 == 1695089402 ) && field.equals("removeHierarchyBoundsListener") )) || ( (( ( __temp_hash207 == 875541053 ) && field.equals("addHierarchyBoundsListener") )) || ( (( ( __temp_hash207 == -300913280 ) && field.equals("getHierarchyListeners") )) || ( (( ( __temp_hash207 == -2019322395 ) && field.equals("removeHierarchyListener") )) || ( (( ( __temp_hash207 == 675525480 ) && field.equals("addHierarchyListener") )) || ( (( ( __temp_hash207 == 1237998909 ) && field.equals("getFocusListeners") )) || ( (( ( __temp_hash207 == -2007673976 ) && field.equals("removeFocusListener") )) || ( (( ( __temp_hash207 == -2091996533 ) && field.equals("addFocusListener") )) || ( (( ( __temp_hash207 == -1150319688 ) && field.equals("getComponentListeners") )) || ( (( ( __temp_hash207 == 862771373 ) && field.equals("removeComponentListener") )) || ( (( ( __temp_hash207 == -737348048 ) && field.equals("addComponentListener") )) || ( (( ( __temp_hash207 == 1979010522 ) && field.equals("postEvent") )) || ( (( ( __temp_hash207 == -2140931520 ) && field.equals("dispatchEvent") )) || ( (( ( __temp_hash207 == -1183789060 ) && field.equals("inside") )) || ( (( ( __temp_hash207 == 913594403 ) && field.equals("getIgnoreRepaint") )) || ( (( ( __temp_hash207 == -917848425 ) && field.equals("setIgnoreRepaint") )) || ( (( ( __temp_hash207 == -538855117 ) && field.equals("checkImage") )) || ( (( ( __temp_hash207 == -2048673644 ) && field.equals("prepareImage") )) || ( (( ( __temp_hash207 == -746920573 ) && field.equals("createVolatileImage") )) || ( (( ( __temp_hash207 == -514107969 ) && field.equals("createImage") )) || ( (( ( __temp_hash207 == -2066473468 ) && field.equals("imageUpdate") )) || ( (( ( __temp_hash207 == 925942883 ) && field.equals("paintAll") )) || ( (( ( __temp_hash207 == 1873980194 ) && field.equals("isCursorSet") )) || ( (( ( __temp_hash207 == 346895948 ) && field.equals("getCursor") )) || ( (( ( __temp_hash207 == 132278872 ) && field.equals("setCursor") )) || ( (( ( __temp_hash207 == -1057546709 ) && field.equals("isMaximumSizeSet") )) || ( (( ( __temp_hash207 == -400630659 ) && field.equals("isMinimumSizeSet") )) || ( (( ( __temp_hash207 == -1787544022 ) && field.equals("isPreferredSizeSet") )) || ( (( ( __temp_hash207 == 1387686788 ) && field.equals("isLightweight") )) || ( (( ( __temp_hash207 == 98192823 ) && field.equals("setBounds") )) || ( (( ( __temp_hash207 == -1383205195 ) && field.equals("bounds") )) || ( (( ( __temp_hash207 == -934437708 ) && field.equals("resize") )) || ( (( ( __temp_hash207 == 1984958339 ) && field.equals("setSize") )) || ( (( ( __temp_hash207 == 3530753 ) && field.equals("size") )) || ( (( ( __temp_hash207 == 3357649 ) && field.equals("move") )) || ( (( ( __temp_hash207 == -404603337 ) && field.equals("setLocation") )) || ( (( ( __temp_hash207 == 1901043637 ) && field.equals("location") )) || ( (( ( __temp_hash207 == 204504438 ) && field.equals("getLocationOnScreen") )) || ( (( ( __temp_hash207 == 975157628 ) && field.equals("getColorModel") )) || ( (( ( __temp_hash207 == 383935836 ) && field.equals("setLocale") )) || ( (( ( __temp_hash207 == 598552912 ) && field.equals("getLocale") )) || ( (( ( __temp_hash207 == -1260721911 ) && field.equals("isFontSet") )) || ( (( ( __temp_hash207 == -75533115 ) && field.equals("getFont") )) || ( (( ( __temp_hash207 == 274796362 ) && field.equals("isBackgroundSet") )) || ( (( ( __temp_hash207 == -1629942492 ) && field.equals("getBackground") )) || ( (( ( __temp_hash207 == 902956821 ) && field.equals("isForegroundSet") )) || ( (( ( __temp_hash207 == 1686708537 ) && field.equals("getForeground") )) || ( (( ( __temp_hash207 == 3202370 ) && field.equals("hide") )) || ( (( ( __temp_hash207 == 3529469 ) && field.equals("show") )) || ( (( ( __temp_hash207 == -174300757 ) && field.equals("enableInputMethods") )) || ( (( ( __temp_hash207 == 2105594551 ) && field.equals("isEnabled") )) || ( (( ( __temp_hash207 == 1487521595 ) && field.equals("isShowing") )) || ( (( ( __temp_hash207 == -113035288 ) && field.equals("isVisible") )) || ( (( ( __temp_hash207 == 304683410 ) && field.equals("isDisplayable") )) || ( (( ( __temp_hash207 == 2073378034 ) && field.equals("isValid") )) || ( (( ( __temp_hash207 == -103224824 ) && field.equals("getToolkit") )) || ( (( ( __temp_hash207 == -831132833 ) && field.equals("getTreeLock") )) || ( (( ( __temp_hash207 == 1406043765 ) && field.equals("getGraphicsConfiguration") )) || ( (( ( __temp_hash207 == 631903574 ) && field.equals("getDropTarget") )) || ( (( ( __temp_hash207 == 1406034786 ) && field.equals("setDropTarget") )) || ( (( ( __temp_hash207 == -75245096 ) && field.equals("getPeer") )) || ( (( ( __temp_hash207 == 700591008 ) && field.equals("getParent") )) || ( (( ( __temp_hash207 == 1984801293 ) && field.equals("setName") )) || ( (( ( __temp_hash207 == -75308287 ) && field.equals("getName") )) || ( (( ( __temp_hash207 == -606755785 ) && field.equals("transferFocusDownCycle") )) || ( (( ( __temp_hash207 == -1708753933 ) && field.equals("isFocusTraversalPolicyProvider") )) || ( (( ( __temp_hash207 == 626370347 ) && field.equals("setFocusTraversalPolicyProvider") )) || ( (( ( __temp_hash207 == -44786190 ) && field.equals("setFocusCycleRoot") )) || ( (( ( __temp_hash207 == 602541344 ) && field.equals("isFocusTraversalPolicySet") )) || ( (( ( __temp_hash207 == -1242052594 ) && field.equals("getFocusTraversalPolicy") )) || ( (( ( __temp_hash207 == 810219290 ) && field.equals("setFocusTraversalPolicy") )) || ( (( ( __temp_hash207 == -1671141420 ) && field.equals("isAncestorOf") )) || ( (( ( __temp_hash207 == 398126743 ) && field.equals("findComponentAt") )) || ( (( ( __temp_hash207 == 438337848 ) && field.equals("getMousePosition") )) || ( (( ( __temp_hash207 == 1430084328 ) && field.equals("processContainerEvent") )) || ( (( ( __temp_hash207 == 576751796 ) && field.equals("getContainerListeners") )) || ( (( ( __temp_hash207 == 1611220017 ) && field.equals("removeContainerListener") )) || ( (( ( __temp_hash207 == 11100596 ) && field.equals("addContainerListener") )) || ( (( ( __temp_hash207 == -627286621 ) && field.equals("printComponents") )) || ( (( ( __temp_hash207 == -622724588 ) && field.equals("paintComponents") )) || ( (( ( __temp_hash207 == 1081247188 ) && field.equals("validateTree") )) || ( (( ( __temp_hash207 == 371675692 ) && field.equals("setLayout") )) || ( (( ( __temp_hash207 == 586292768 ) && field.equals("getLayout") )) || ( (( ( __temp_hash207 == 1282345597 ) && field.equals("removeAll") )) || ( (( ( __temp_hash207 == -934610812 ) && field.equals("remove") )) || ( (( ( __temp_hash207 == -1148905887 ) && field.equals("addImpl") )) || ( (( ( __temp_hash207 == -1109967845 ) && field.equals("getComponentZOrder") )) || ( (( ( __temp_hash207 == -189934193 ) && field.equals("setComponentZOrder") )) || ( (( ( __temp_hash207 == 96417 ) && field.equals("add") )) || ( (( ( __temp_hash207 == -1183792394 ) && field.equals("insets") )) || ( (( ( __temp_hash207 == -745194740 ) && field.equals("getComponents") )) || ( (( ( __temp_hash207 == -1409511865 ) && field.equals("getComponent") )) || ( (( ( __temp_hash207 == -754783867 ) && field.equals("countComponents") )) || ( (( ( __temp_hash207 == 1052288776 ) && field.equals("getComponentCount") )) || ( (( ( __temp_hash207 == 185147285 ) && field.equals("doLayout") )) || ( (( ( __temp_hash207 == -1109722326 ) && field.equals("layout") )) || ( (( ( __temp_hash207 == -1831849669 ) && field.equals("invalidate") )) || ( (( ( __temp_hash207 == -1421272810 ) && field.equals("validate") )) || ( (( ( __temp_hash207 == -608552926 ) && field.equals("preferredSize") )) || ( (( ( __temp_hash207 == 1008217391 ) && field.equals("minimumSize") )) || ( (( ( __temp_hash207 == 1969426795 ) && field.equals("processEvent") )) || ( (( ( __temp_hash207 == 634939509 ) && field.equals("deliverEvent") )) || ( (( ( __temp_hash207 == -1097461934 ) && field.equals("locate") )) || ( (( ( __temp_hash207 == -1626201894 ) && field.equals("getComponentAt") )) || ( (( ( __temp_hash207 == 3322014 ) && field.equals("list") )) || ( (( ( __temp_hash207 == 123688912 ) && field.equals("getFocusTraversalKeys") )) || ( (( ( __temp_hash207 == -355296716 ) && field.equals("areFocusTraversalKeysSet") )) || ( (( ( __temp_hash207 == -311299910 ) && field.equals("isFocusCycleRoot") )) || ( (( ( __temp_hash207 == -679533279 ) && field.equals("applyComponentOrientation") )) || ( (( ( __temp_hash207 == -1117363270 ) && field.equals("addPropertyChangeListener") )) || ( (( ( __temp_hash207 == 1910920416 ) && field.equals("getRootPane") )) || ( (( ( __temp_hash207 == 383468754 ) && field.equals("setDoubleBuffered") )) || ( (( ( __temp_hash207 == 1356268992 ) && field.equals("paintImmediately") )) || ( (( ( __temp_hash207 == -209888556 ) && field.equals("isPaintingOrigin") )) || ( (( ( __temp_hash207 == -1444703808 ) && field.equals("isOptimizedDrawingEnabled") )) || ( (( ( __temp_hash207 == -727692042 ) && field.equals("getAncestorListeners") )) || ( (( ( __temp_hash207 == -1567628213 ) && field.equals("removeAncestorListener") )) || ( (( ( __temp_hash207 == -1065055640 ) && field.equals("addAncestorListener") )) || ( (( ( __temp_hash207 == -701878888 ) && field.equals("getTopLevelAncestor") )) || ( (( ( __temp_hash207 == -637180459 ) && field.equals("getVetoableChangeListeners") )) || ( (( ( __temp_hash207 == -1422550772 ) && field.equals("removeVetoableChangeListener") )) || ( (( ( __temp_hash207 == -894798487 ) && field.equals("addVetoableChangeListener") )) || ( (( ( __temp_hash207 == -800831894 ) && field.equals("fireVetoableChange") )) || ( (( ( __temp_hash207 == -509772736 ) && field.equals("getVisibleRect") )) || ( (( ( __temp_hash207 == 456055999 ) && field.equals("computeVisibleRect") )) || ( (( ( __temp_hash207 == 470702883 ) && field.equals("setOpaque") )) || ( (( ( __temp_hash207 == -1425362001 ) && field.equals("putClientProperty") )) || ( (( ( __temp_hash207 == -1141635146 ) && field.equals("getClientProperty") )) || ( (( ( __temp_hash207 == 1683315369 ) && field.equals("getTransferHandler") )) || ( (( ( __temp_hash207 == -1691618275 ) && field.equals("setTransferHandler") )) || ( (( ( __temp_hash207 == -1769313919 ) && field.equals("getAutoscrolls") )) || ( (( ( __temp_hash207 == 753917173 ) && field.equals("setAutoscrolls") )) || ( (( ( __temp_hash207 == 954363430 ) && field.equals("scrollRectToVisible") )) || ( (( ( __temp_hash207 == 1106410311 ) && field.equals("createToolTip") )) || ( (( ( __temp_hash207 == -1988967221 ) && field.equals("getPopupLocation") )) || ( (( ( __temp_hash207 == -1795253630 ) && field.equals("getToolTipLocation") )) || ( (( ( __temp_hash207 == 1862577786 ) && field.equals("getToolTipText") )) || ( (( ( __temp_hash207 == 90841582 ) && field.equals("setToolTipText") )) || ( (( ( __temp_hash207 == 69241589 ) && field.equals("processKeyBinding") )) || ( (( ( __temp_hash207 == 1312303337 ) && field.equals("processComponentKeyEvent") )) || ( (( ( __temp_hash207 == -1253361850 ) && field.equals("requestDefaultFocus") )) || ( (( ( __temp_hash207 == 188673168 ) && field.equals("getActionMap") )) || ( (( ( __temp_hash207 == 1737665796 ) && field.equals("setActionMap") )) || ( (( ( __temp_hash207 == -1746368856 ) && field.equals("getInputMap") )) || ( (( ( __temp_hash207 == -1834948684 ) && field.equals("setInputMap") )) || ( (( ( __temp_hash207 == -1777533497 ) && field.equals("resetKeyboardActions") )) || ( (( ( __temp_hash207 == -1337788934 ) && field.equals("getActionForKeyStroke") )) || ( (( ( __temp_hash207 == -2016664141 ) && field.equals("getConditionForKeyStroke") )) || ( (( ( __temp_hash207 == -760205708 ) && field.equals("getRegisteredKeyStrokes") )) || ( (( ( __temp_hash207 == -1167238055 ) && field.equals("unregisterKeyboardAction") )) || ( (( ( __temp_hash207 == -1402521984 ) && field.equals("registerKeyboardAction") )) || ( (( ( __temp_hash207 == 852008758 ) && field.equals("getDebugGraphicsOptions") )) || ( (( ( __temp_hash207 == -1390686654 ) && field.equals("setDebugGraphicsOptions") )) || ( (( ( __temp_hash207 == 1695427850 ) && field.equals("getInputVerifier") )) || ( (( ( __temp_hash207 == -136014978 ) && field.equals("setInputVerifier") )) || ( (( ( __temp_hash207 == -554065705 ) && field.equals("setAlignmentX") )) || ( (( ( __temp_hash207 == -554065704 ) && field.equals("setAlignmentY") )) || ( (( ( __temp_hash207 == 312710946 ) && field.equals("getBorder") )) || ( (( ( __temp_hash207 == 98093870 ) && field.equals("setBorder") )) || ( (( ( __temp_hash207 == -1816942124 ) && field.equals("getVerifyInputWhenFocusTarget") )) || ( (( ( __temp_hash207 == -2089656352 ) && field.equals("setVerifyInputWhenFocusTarget") )) || ( (( ( __temp_hash207 == -1605080596 ) && field.equals("grabFocus") )) || ( (( ( __temp_hash207 == -375268882 ) && field.equals("isRequestFocusEnabled") )) || ( (( ( __temp_hash207 == 217231286 ) && field.equals("setRequestFocusEnabled") )) || ( (( ( __temp_hash207 == 413687348 ) && field.equals("getNextFocusableComponent") )) || ( (( ( __temp_hash207 == 1256979008 ) && field.equals("setNextFocusableComponent") )) || ( (( ( __temp_hash207 == 890536972 ) && field.equals("isManagingFocus") )) || ( (( ( __temp_hash207 == -770686062 ) && field.equals("isPaintingForPrint") )) || ( (( ( __temp_hash207 == 142938588 ) && field.equals("isPaintingTile") )) || ( (( ( __temp_hash207 == -824599239 ) && field.equals("printBorder") )) || ( (( ( __temp_hash207 == 1704032204 ) && field.equals("printChildren") )) || ( (( ( __temp_hash207 == -20235056 ) && field.equals("printComponent") )) || ( (( ( __temp_hash207 == -1778836950 ) && field.equals("paintBorder") )) || ( (( ( __temp_hash207 == -490374019 ) && field.equals("paintChildren") )) || ( (( ( __temp_hash207 == 241460722 ) && field.equals("getComponentGraphics") )) || ( (( ( __temp_hash207 == -547981916 ) && field.equals("getComponentPopupMenu") )) || ( (( ( __temp_hash207 == 1988229040 ) && field.equals("setComponentPopupMenu") )) || ( (( ( __temp_hash207 == -658829443 ) && field.equals("getInheritsPopupMenu") )) || ( (( ( __temp_hash207 == -1269752847 ) && field.equals("setInheritsPopupMenu") )) || ( (( ( __temp_hash207 == -838846263 ) && field.equals("update") )) || ( (( ( __temp_hash207 == 106428510 ) && field.equals("paint") )) || ( (( ( __temp_hash207 == 106934957 ) && field.equals("print") )) || ( (( ( __temp_hash207 == -1726352276 ) && field.equals("getPreferredSize") )) || ( (( ( __temp_hash207 == 1045381387 ) && field.equals("getMaximumSize") )) || ( (( ( __temp_hash207 == 367948793 ) && field.equals("getMinimumSize") )) || ( (( ( __temp_hash207 == 512222700 ) && field.equals("getInsets") )) || ( (( ( __temp_hash207 == -1328196916 ) && field.equals("getAlignmentY") )) || ( (( ( __temp_hash207 == -1328196917 ) && field.equals("getAlignmentX") )) || ( (( ( __temp_hash207 == 1984576465 ) && field.equals("setFont") )) || ( (( ( __temp_hash207 == -1635067428 ) && field.equals("setFocusTraversalKeys") )) || ( (( ( __temp_hash207 == -1228323959 ) && field.equals("getListeners") )) || ( (( ( __temp_hash207 == -146849974 ) && field.equals("addNotify") )) || ( (( ( __temp_hash207 == -1001125651 ) && field.equals("removeNotify") )) || ( (( ( __temp_hash207 == 319849826 ) && field.equals("isValidateRoot") )) || ( (( ( __temp_hash207 == -1166363724 ) && field.equals("printAll") )) || ( (( ( __temp_hash207 == 1280029577 ) && field.equals("requestFocus") )) || ( (( ( __temp_hash207 == -132373474 ) && field.equals("requestFocusInWindow") )) || ( (( ( __temp_hash207 == 2087644222 ) && field.equals("getFontMetrics") )) || ( (( ( __temp_hash207 == 737172192 ) && field.equals("setPreferredSize") )) || ( (( ( __temp_hash207 == -726354817 ) && field.equals("setMaximumSize") )) || ( (( ( __temp_hash207 == -1403787411 ) && field.equals("setMinimumSize") )) || ( (( ( __temp_hash207 == -567445985 ) && field.equals("contains") )) || ( (( ( __temp_hash207 == -2116360191 ) && field.equals("getGraphics") )) || ( (( ( __temp_hash207 == 357114811 ) && field.equals("getBaseline") )) || ( (( ( __temp_hash207 == -2053764159 ) && field.equals("getBaselineResizeBehavior") )) || ( (( ( __temp_hash207 == -854558288 ) && field.equals("setVisible") )) || ( (( ( __temp_hash207 == 1364071551 ) && field.equals("setEnabled") )) || ( (( ( __temp_hash207 == -1834127547 ) && field.equals("setForeground") )) || ( (( ( __temp_hash207 == -855811280 ) && field.equals("setBackground") )) || ( (( ( __temp_hash207 == 2139532042 ) && field.equals("processKeyEvent") )) || ( (( ( __temp_hash207 == 786391236 ) && field.equals("processMouseEvent") )) || ( (( ( __temp_hash207 == 2065058606 ) && field.equals("processMouseMotionEvent") )) || ( (( ( __temp_hash207 == -1298848381 ) && field.equals("enable") )) || ( (( ( __temp_hash207 == 1671308008 ) && field.equals("disable") )) || ( (( ( __temp_hash207 == 1097148750 ) && field.equals("reshape") )) || ( (( ( __temp_hash207 == 312809899 ) && field.equals("getBounds") )) || ( (( ( __temp_hash207 == -75151241 ) && field.equals("getSize") )) || ( (( ( __temp_hash207 == -316023509 ) && field.equals("getLocation") )) || ( (( ( __temp_hash207 == 3169218 ) && field.equals("getX") )) || ( (( ( __temp_hash207 == 3169219 ) && field.equals("getY") )) || ( (( ( __temp_hash207 == 1968952336 ) && field.equals("getWidth") )) || ( (( ( __temp_hash207 == 474985501 ) && field.equals("getHeight") )) || ( (( ( __temp_hash207 == -336661013 ) && field.equals("isOpaque") )) || ( (( ( __temp_hash207 == -2036853317 ) && field.equals("firePropertyChange") )) || ( (( ( __temp_hash207 == 1094177291 ) && field.equals("repaint") )) || ( (( ( __temp_hash207 == -218282935 ) && field.equals("revalidate") )) || ( (( ( __temp_hash207 == 116955034 ) && field.equals("isDoubleBuffered") )) || ( (( ( __temp_hash207 == 109327990 ) && field.equals("setUI") )) || ( (( ( __temp_hash207 == 98245738 ) && field.equals("getUI") )) || ( (( ( __temp_hash207 == 1322595613 ) && field.equals("updateUI") )) || ( (( ( __temp_hash207 == -133970743 ) && field.equals("getUIClassID") )) || ( (( ( __temp_hash207 == 820971262 ) && field.equals("paramString") )) || field.equals("getAccessibleContext") ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) ) )) 
					{
						__temp_executeDef206 = false;
						return haxe.lang.Runtime.slowCallField(this, field, dynargs);
					}
					
					break;
				}
				
				
				case 672648767:
				{
					if (field.equals("paintComponent")) 
					{
						__temp_executeDef206 = false;
						this.paintComponent(((java.awt.Graphics) (dynargs.__get(0)) ));
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef206) 
			{
				return ((haxe.lang.Function) (this.__hx_getField(field, true, false, false)) ).__hx_invokeDynamic(dynargs);
			}
			
		}
		
		return null;
	}
	
	
	public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("ui");
		baseArr.push("listenerList");
		baseArr.push("accessibleContext");
		baseArr.push("paintFunction");
		baseArr.push("g");
	}
	
	
}


