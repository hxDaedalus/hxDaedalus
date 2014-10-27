package ddls.iterators;

import ddls.data.Edge;
import ddls.data.Face;

class FromFaceToInnerEdges
{
	
	private var _fromFace:Face;
	private var _nextEdge:Edge;
	
	public function new()
	{
		
	}
	
	public var fromFace(never, set):Face;
	private function set_fromFace(value:Face):Face
	{
		_fromFace = value;
		_nextEdge = _fromFace.edge;
		return _fromFace;
	}
	
	private var _resultEdge:Edge;
	public function next():Edge
	{
		if (_nextEdge != null)
		{
			_resultEdge = _nextEdge;
			_nextEdge = _nextEdge.nextLeftEdge;
			
			if (_nextEdge == _fromFace.edge)
				_nextEdge = null;
		}
		else
		{
			_resultEdge = null;
		}
		
		return _resultEdge;
	}
	
	
}