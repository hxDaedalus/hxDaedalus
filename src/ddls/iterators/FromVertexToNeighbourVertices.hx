package DDLS.iterators
{
	import DDLS.data.DDLSEdge;
	import DDLS.data.DDLSVertex;

	public class FromVertexToNeighbourVertices
	{
		
		private var _fromVertex:DDLSVertex;
		private var _nextEdge:DDLSEdge;
		
		public function FromVertexToNeighbourVertices()
		{
			
		}
		
		public function set fromVertex( value:DDLSVertex ):void
		{
			_fromVertex = value;
			_nextEdge = _fromVertex.edge;
		}
		
		private var _resultVertex:DDLSVertex;
		public function next():DDLSVertex
		{
			if (_nextEdge)
			{
				_resultVertex = _nextEdge.oppositeEdge.originVertex;
				do
				{
					_nextEdge = _nextEdge.rotLeftEdge;
				}
				while ( ! _nextEdge.isReal )
				
				if ( _nextEdge == _fromVertex.edge )
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