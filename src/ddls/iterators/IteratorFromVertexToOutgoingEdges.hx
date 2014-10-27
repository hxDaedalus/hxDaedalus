package ddls.iterators;

import ddls.data.Edge;
import ddls.data.Vertex;

class FromVertexToOutgoingEdges
{
	
	private var _fromVertex:Vertex;
	private var _nextEdge:Edge;
	
	public var realEdgesOnly:Bool = true;
	
	public function new()
	{
		
	}
	
	public var fromVertex(never, set):Vertex;
	private function set_fromVertex(value:Vertex):Vertex
	{
		_fromVertex = value;
		_nextEdge = _fromVertex.edge;
		while (realEdgesOnly && !_nextEdge.isReal)
		{
			_nextEdge = _nextEdge.rotLeftEdge;
		}
		return _fromVertex;
	}
	
	private var _resultEdge:Edge;
	public function next():Edge
	{
		if (_nextEdge != null)
		{
			_resultEdge = _nextEdge;
			do
			{
				_nextEdge = _nextEdge.rotLeftEdge;
				if (_nextEdge == _fromVertex.edge)
				{
					_nextEdge = null;
					break;
				}
			}
			while (realEdgesOnly && !_nextEdge.isReal);
		}
		else
		{
			_resultEdge = null;
		}
		
		return _resultEdge;
	}
	
}