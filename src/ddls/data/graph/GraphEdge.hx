package ddls.data.graph;

import ddls.data.math.Potrace.EdgeData;

class GraphEdge
{
	
	private static var INC:Int = 0;
	private var _id:Int;
	
	private var _prev:GraphEdge;
	private var _next:GraphEdge;
	
	private var _rotPrevEdge:GraphEdge;
	private var _rotNextEdge:GraphEdge;
	private var _oppositeEdge:GraphEdge;
	private var _sourceNode:GraphNode;
	private var _destinationNode:GraphNode;
	
	private var _data:EdgeData;
	
	public function new()
	{
		_id = INC;
		INC++;
	}

	public var id(get, never):Int;
	private function get_id():Int { return _id; }
	
	public function dispose():Void
	{
		
	}
	
	public var prev(get, set):GraphEdge;
	private function get_prev():GraphEdge { return _prev; }
	private function set_prev(value:GraphEdge):GraphEdge { return _prev = value; }
	
	public var next(get, set):GraphEdge;
	private function get_next():GraphEdge { return _next; }
	private function set_next(value:GraphEdge):GraphEdge { return _next = value; }
	
	public var rotPrevEdge(get, set):GraphEdge;
	private function get_rotPrevEdge():GraphEdge { return _rotPrevEdge; }
	private function set_rotPrevEdge(value:GraphEdge):GraphEdge { return _rotPrevEdge = value; }
	
	public var rotNextEdge(get, set):GraphEdge;
	private function get_rotNextEdge():GraphEdge { return _rotNextEdge; }
	private function set_rotNextEdge(value:GraphEdge):GraphEdge { return _rotNextEdge = value; }
	
	public var oppositeEdge(get, set):GraphEdge;
	private function get_oppositeEdge():GraphEdge { return _oppositeEdge; }
	private function set_oppositeEdge(value:GraphEdge):GraphEdge { return _oppositeEdge = value; }
	
	public var sourceNode(get, set):GraphNode;
	private function get_sourceNode():GraphNode { return _sourceNode; }
	private function set_sourceNode(value:GraphNode):GraphNode { return _sourceNode = value; }
	
	public var destinationNode(get, set):GraphNode;
	private function get_destinationNode():GraphNode { return _destinationNode; }
	private function set_destinationNode(value:GraphNode):GraphNode { return _destinationNode = value; }
	
	public var data(get, set):EdgeData;
	private function get_data():EdgeData { return _data; }
	private function set_data(value:EdgeData):EdgeData { return _data = value; }
	
}