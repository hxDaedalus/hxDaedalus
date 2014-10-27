package ddls.iterators;

import ddls.data.Face;
import ddls.data.Mesh;
import ddls.data.Vertex;

class FromMeshToVertices
{
	
	private var _fromMesh:Mesh;
	private var _currIndex:Int;
	
	public function new()
	{
		
	}
	
	public var fromMesh(never, set):Mesh;
	private function set_fromMesh(value:Mesh):Mesh
	{
		_fromMesh = value;
		_currIndex = 0;
		return _fromMesh;
	}
	
	private var _resultVertex:Vertex;
	public function next():Vertex
	{
		do
		{
			if (_currIndex < _fromMesh.__vertices.length)
			{
				_resultVertex = _fromMesh.__vertices[_currIndex];
				_currIndex++;
			}
			else
			{
				_resultVertex = null;
				break;
			}
		}
		while (!_resultVertex.isReal);
		
		return _resultVertex;
	}
	
}