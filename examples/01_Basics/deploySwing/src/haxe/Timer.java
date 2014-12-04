package haxe;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class Timer extends haxe.lang.HxObject
{
	public    Timer(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    Timer(int time_ms)
	{
		haxe.Timer.__hx_ctor_haxe_Timer(this, time_ms);
	}
	
	
	public static   void __hx_ctor_haxe_Timer(haxe.Timer __temp_me7, int time_ms)
	{
		__temp_me7.run = ( (( haxe.Timer___hx_ctor_haxe_Timer_113__Fun.__hx_current != null )) ? (haxe.Timer___hx_ctor_haxe_Timer_113__Fun.__hx_current) : (haxe.Timer___hx_ctor_haxe_Timer_113__Fun.__hx_current = ((haxe.Timer___hx_ctor_haxe_Timer_113__Fun) (new haxe.Timer___hx_ctor_haxe_Timer_113__Fun()) )) );
		__temp_me7.timer = new java.util.Timer();
		__temp_me7.timer.scheduleAtFixedRate(((java.util.TimerTask) (__temp_me7.task = new haxe._Timer.TimerTask(((haxe.Timer) (__temp_me7) ))) ), ((long) (time_ms) ), ((long) (time_ms) ));
	}
	
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new haxe.Timer(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new haxe.Timer(((int) (haxe.lang.Runtime.toInt(arr.__get(0))) ));
	}
	
	
	public  java.util.Timer timer;
	
	public  java.util.TimerTask task;
	
	public  haxe.lang.Function run;
	
	@Override public   java.lang.Object __hx_setField(java.lang.String field, java.lang.Object value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef86 = true;
			switch (field.hashCode())
			{
				case 113291:
				{
					if (field.equals("run")) 
					{
						__temp_executeDef86 = false;
						this.run = ((haxe.lang.Function) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 110364485:
				{
					if (field.equals("timer")) 
					{
						__temp_executeDef86 = false;
						this.timer = ((java.util.Timer) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 3552645:
				{
					if (field.equals("task")) 
					{
						__temp_executeDef86 = false;
						this.task = ((java.util.TimerTask) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef86) 
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
			boolean __temp_executeDef87 = true;
			switch (field.hashCode())
			{
				case 113291:
				{
					if (field.equals("run")) 
					{
						__temp_executeDef87 = false;
						return this.run;
					}
					
					break;
				}
				
				
				case 110364485:
				{
					if (field.equals("timer")) 
					{
						__temp_executeDef87 = false;
						return this.timer;
					}
					
					break;
				}
				
				
				case 3552645:
				{
					if (field.equals("task")) 
					{
						__temp_executeDef87 = false;
						return this.task;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef87) 
			{
				return super.__hx_getField(field, throwErrors, isCheck, handleProperties);
			}
			 else 
			{
				throw null;
			}
			
		}
		
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("run");
		baseArr.push("task");
		baseArr.push("timer");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


