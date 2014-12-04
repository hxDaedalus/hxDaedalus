package hxDaedalus.data.math;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class Intersection extends haxe.lang.Enum
{
	static 
	{
		hxDaedalus.data.math.Intersection.constructs = new haxe.root.Array<java.lang.String>(new java.lang.String[]{"EVertex", "EEdge", "EFace", "ENull"});
		hxDaedalus.data.math.Intersection.ENull = new hxDaedalus.data.math.Intersection(((int) (3) ), ((haxe.root.Array<java.lang.Object>) (new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{})) ));
	}
	public    Intersection(int index, haxe.root.Array<java.lang.Object> params)
	{
		super(index, params);
	}
	
	
	public static  haxe.root.Array<java.lang.String> constructs;
	
	public static   hxDaedalus.data.math.Intersection EVertex(hxDaedalus.data.Vertex vertex)
	{
		return new hxDaedalus.data.math.Intersection(((int) (0) ), ((haxe.root.Array<java.lang.Object>) (new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{vertex})) ));
	}
	
	
	public static   hxDaedalus.data.math.Intersection EEdge(hxDaedalus.data.Edge edge)
	{
		return new hxDaedalus.data.math.Intersection(((int) (1) ), ((haxe.root.Array<java.lang.Object>) (new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{edge})) ));
	}
	
	
	public static   hxDaedalus.data.math.Intersection EFace(hxDaedalus.data.Face face)
	{
		return new hxDaedalus.data.math.Intersection(((int) (2) ), ((haxe.root.Array<java.lang.Object>) (new haxe.root.Array<java.lang.Object>(new java.lang.Object[]{face})) ));
	}
	
	
	public static  hxDaedalus.data.math.Intersection ENull;
	
}


