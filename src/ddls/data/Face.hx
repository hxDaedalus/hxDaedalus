package ddls.data;

class Face
{
	
	private static var INC:Int = 0;
	private var _id:Int;
	
	private var _isReal:Bool;
	private var _edge:Edge;
	
	public var colorDebug:Int = -1;
	
	public function new()
	{
		_id = INC;
		INC++;
	}
	
	public var id(get, never):Int;
	private function get_id():Int { return _id; }
	
	public var isReal(get, never):Bool;
	private function get_isReal():Bool { return _isReal; }
	
	public function setDatas(edge:Edge, isReal:Bool=true):Void
	{
		_isReal = isReal;
		_edge = edge;
	}
	
	public function dispose():Void
	{
		_edge = null;
	}
	
	public var edge(get, never):Edge;
	private function get_edge():Edge { return _edge; }
	
}