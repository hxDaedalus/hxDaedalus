package haxe._Timer;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class TimerTask extends java.util.TimerTask
{
	public    TimerTask(haxe.Timer timer)
	{
		super();
		this.timer = timer;
	}
	
	
	public  haxe.Timer timer;
	
	public   void run()
	{
		this.timer.run.__hx_invoke0_o();
	}
	
	
}


