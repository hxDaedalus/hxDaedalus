package ddls.iterators;

import ddls.data.Edge;
import ddls.data.Face;
import ddls.data.Vertex;

class VertexToHoldingFaces
{
	
	private var _fromVertex:Vertex;
	private var _nextEdge:Edge;
	
	public function new()
	{
		
	}
	
	public var fromVertex(never, set):Vertex;
	private function set_fromVertex(value:Vertex):Vertex
	{
		_fromVertex = value;
		_nextEdge = _fromVertex.edge;
		return _fromVertex;
	}
	
	
	private var _resultFace:Face;
	public function next():Face
	{
		if (_nextEdge != null)
		{
			do
			{
				_resultFace = _nextEdge.leftFace;
				_nextEdge = _nextEdge.rotLeftEdge;
				if (_nextEdge == _fromVertex.edge)
				{
					_nextEdge = null;
					if (!_resultFace.isReal)
						_resultFace = null;
					break;
				}
			}
			while (!_resultFace.isReal);
		}
		else
		{
			_resultFace = null;
		}
		
		return _resultFace;
	}
	
}