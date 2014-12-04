package hxDaedalus.debug;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class Debug extends haxe.lang.HxObject
{
	public    Debug(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    Debug()
	{
		hxDaedalus.debug.Debug.__hx_ctor_hxDaedalus_debug_Debug(this);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_debug_Debug(hxDaedalus.debug.Debug __temp_me40)
	{
		{
		}
		
	}
	
	
	public static   void assertTrue(boolean cond, java.lang.String message, java.lang.Object pos)
	{
		if ( ! (cond) ) 
		{
			throw haxe.lang.HaxeException.wrap(( ( ( ( haxe.lang.Runtime.toString(haxe.lang.Runtime.getField(pos, "fileName", true)) + ":" ) + ((int) (haxe.lang.Runtime.getField_f(pos, "lineNumber", true)) ) ) + ": Expected true but was false! " ) + (( (( message != null )) ? (message) : ("") )) ));
		}
		
	}
	
	
	public static   void assertFalse(boolean cond, java.lang.String message, java.lang.Object pos)
	{
		if (cond) 
		{
			throw haxe.lang.HaxeException.wrap(( ( ( ( haxe.lang.Runtime.toString(haxe.lang.Runtime.getField(pos, "fileName", true)) + ":" ) + ((int) (haxe.lang.Runtime.getField_f(pos, "lineNumber", true)) ) ) + ": Expected false but was true! " ) + (( (( message != null )) ? (message) : ("") )) ));
		}
		
	}
	
	
	public static  <T> void assertEquals(T expected, T actual, java.lang.String message, java.lang.Object pos)
	{
		if (( ! (haxe.lang.Runtime.eq(actual, expected)) )) 
		{
			throw haxe.lang.HaxeException.wrap(( ( ( ( ( ( ( ( haxe.lang.Runtime.toString(haxe.lang.Runtime.getField(pos, "fileName", true)) + ":" ) + ((int) (haxe.lang.Runtime.getField_f(pos, "lineNumber", true)) ) ) + ": Expected \'" ) + haxe.root.Std.string(expected) ) + "\' but was \'" ) + haxe.root.Std.string(actual) ) + "\' " ) + (( (( message != null )) ? (message) : ("") )) ));
		}
		
	}
	
	
	public static   void trace(java.lang.Object value, java.lang.Object pos)
	{
		haxe.Log.trace.__hx_invoke2_o(0.0, value, 0.0, pos);
	}
	
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.debug.Debug(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.debug.Debug();
	}
	
	
}


