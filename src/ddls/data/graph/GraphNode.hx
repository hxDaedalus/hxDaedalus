package ddls.data.graph;
import ddls.data.math.Potrace.NodeData;


class GraphNode
{
	
	private static var INC:Int = 0;
	private var _id:Int;
	
	private var _prev:GraphNode;
	private var _next:GraphNode;
	
	private var _outgoingEdge:GraphEdge;
	private var _successorNodes:Map<GraphNode, GraphEdge>;
	
	private var _data:NodeData;
	
	public function new()
	{
		_id = INC;
		INC++;
		
		_successorNodes = new Map();
	}

	public var id(get, never):Int;
	private function get_id():Int { return _id; }
	
	public function dispose():Void
	{
		_prev = null;
		_next = null;
		_outgoingEdge = null;
		_successorNodes = null;
		_data = null;
	}
	
	public var prev(get, set):GraphNode;
	private function get_prev():GraphNode { return _prev; }
	private function set_prev(value:GraphNode):GraphNode { return _prev = value; }
	
	public var next(get, set):GraphNode;
	private function get_next():GraphNode { return _next; }
	private function set_next(value:GraphNode):GraphNode { return _next = value; }
	
	public var outgoingEdge(get, set):GraphEdge;
	private function get_outgoingEdge():GraphEdge { return _outgoingEdge; }
	private function set_outgoingEdge(value:GraphEdge):GraphEdge { return _outgoingEdge = value; }
	
	public var successorNodes(get, set):Map<GraphNode, GraphEdge>;
	private function get_successorNodes():Map<GraphNode, GraphEdge> { return _successorNodes; }
	private function set_successorNodes(value:Map<GraphNode, GraphEdge>):Map<GraphNode, GraphEdge> { return _successorNodes = value; }
	
	public var data(get, set):NodeData;
	private function get_data():NodeData { return _data; }
	private function set_data(value:NodeData):NodeData { return _data = value; }
	
}