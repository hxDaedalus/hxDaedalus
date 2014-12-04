package haxe.lang;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class HaxeException extends java.lang.RuntimeException
{
	public    HaxeException(java.lang.Object obj, java.lang.String msg, java.lang.Throwable cause)
	{
		super(msg, cause);
		if (( obj instanceof haxe.lang.HaxeException )) 
		{
			haxe.lang.HaxeException _obj = ((haxe.lang.HaxeException) (obj) );
			obj = _obj.getObject();
		}
		
		this.obj = obj;
	}
	
	
	public static   java.lang.RuntimeException wrap(java.lang.Object obj)
	{
		java.lang.RuntimeException ret = null;
		if (( obj instanceof java.lang.RuntimeException )) 
		{
			ret = ((java.lang.RuntimeException) (obj) );
		}
		 else 
		{
			if (( obj instanceof java.lang.String )) 
			{
				ret = new haxe.lang.HaxeException(((java.lang.Object) (obj) ), haxe.lang.Runtime.toString(obj), ((java.lang.Throwable) (null) ));
			}
			 else 
			{
				if (( obj instanceof java.lang.Throwable )) 
				{
					ret = new haxe.lang.HaxeException(((java.lang.Object) (obj) ), haxe.lang.Runtime.toString(null), ((java.lang.Throwable) (obj) ));
				}
				 else 
				{
					ret = new haxe.lang.HaxeException(((java.lang.Object) (obj) ), haxe.lang.Runtime.toString(null), ((java.lang.Throwable) (null) ));
				}
				
			}
			
		}
		
		haxe.lang.Exceptions.exception.set(((java.lang.RuntimeException) (ret) ));
		return ret;
	}
	
	
	public  java.lang.Object obj;
	
	public   java.lang.Object getObject()
	{
		return this.obj;
	}
	
	
	@Override public   java.lang.String toString()
	{
		return ( "Haxe Exception: " + haxe.root.Std.string(this.obj) );
	}
	
	
}


