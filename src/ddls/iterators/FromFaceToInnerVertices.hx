package DDLS.iterators
{
	import DDLS.data.DDLSEdge;
	import DDLS.data.DDLSFace;
	import DDLS.data.DDLSVertex;

	public class FromFaceToInnerVertices
	{
		
		private var _fromFace:DDLSFace;
		private var _nextEdge:DDLSEdge;
		
		public function FromFaceToInnerVertices()
		{
			
		}
		
		public function set fromFace( value:DDLSFace ):void
		{
			_fromFace = value;
			_nextEdge = _fromFace.edge;
		}
		
		private var _resultVertex:DDLSVertex;
		public function next():DDLSVertex
		{
			if (_nextEdge)
			{
				_resultVertex = _nextEdge.originVertex;
				_nextEdge = _nextEdge.nextLeftEdge;
				
				if ( _nextEdge == _fromFace.edge )
					_nextEdge = null;
			}
			else
			{
				_resultVertex = null;
			}
			
			return _resultVertex;
		}
		
	}
}