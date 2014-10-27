package ddls.data;

class ConstraintSegment
{
	
	private static var INC:Int = 0;
	private var _id:Int;
	
	private var _edges:Array<Edge>;
	private var _fromShape:ConstraintShape;
	
	public function new()
	{
		_id = INC;
		INC++;
		
		_edges = new Array<Edge>();
	}
	
	public var id(get, never):Int;
	private function get_id():Int { return _id; }
	
	public var fromShape(get, set):ConstraintShape;
	private function get_fromShape():ConstraintShape { return _fromShape; }
	private function set_fromShape(value:ConstraintShape):ConstraintShape { return _fromShape = value; }
	
	public function addEdge(edge:Edge):Void
	{
		if (_edges.indexOf(edge) == -1 && _edges.indexOf(edge.oppositeEdge) == -1)
			_edges.push(edge);
	}
	
	public function removeEdge(edge:Edge):Void
	{
		var index:Int;
		index = _edges.indexOf(edge);
		if (index == -1)
			index = _edges.indexOf(edge.oppositeEdge);
		
		if (index != -1)
			_edges.splice(index, 1);
	}
	
	public var edges(get, never):Array<Edge>;
	private function get_edges():Array<Edge> { return _edges; }
	
	public function dispose():Void
	{
		_edges = null;
		_fromShape = null;
	}
	
	public function toString():String
	{
		return "seg_id " + _id;
	}
	
}