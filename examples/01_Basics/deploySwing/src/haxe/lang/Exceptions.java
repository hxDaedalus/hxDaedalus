package haxe.lang;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class Exceptions extends haxe.lang.HxObject
{
	static 
	{
		haxe.lang.Exceptions.exception = new java.lang.ThreadLocal<java.lang.RuntimeException>();
	}
	public    Exceptions(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    Exceptions()
	{
		haxe.lang.Exceptions.__hx_ctor_haxe_lang_Exceptions(this);
	}
	
	
	public static   void __hx_ctor_haxe_lang_Exceptions(haxe.lang.Exceptions __temp_me49)
	{
		{
		}
		
	}
	
	
	public static  java.lang.ThreadLocal<java.lang.RuntimeException> exception;
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new haxe.lang.Exceptions(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new haxe.lang.Exceptions();
	}
	
	
}


