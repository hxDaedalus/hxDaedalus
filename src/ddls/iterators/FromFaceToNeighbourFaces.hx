package DDLS.iterators
{
	import DDLS.data.DDLSEdge;
	import DDLS.data.DDLSFace;

	public class FromFaceToNeighbourFaces
	{
		
		private var _fromFace:DDLSFace;
		private var _nextEdge:DDLSEdge;
		
		public function FromFaceToNeighbourFaces()
		{
			
		}
		
		public function set fromFace( value:DDLSFace ):void
		{
			_fromFace = value;
			_nextEdge = _fromFace.edge;
		}
		
		private var _resultFace:DDLSFace;
		public function next():DDLSFace
		{
			if (_nextEdge)
			{
				do
				{
					_resultFace = _nextEdge.rightFace;
					_nextEdge = _nextEdge.nextLeftEdge;
					if ( _nextEdge == _fromFace.edge )
					{
						_nextEdge = null;
						if ( ! _resultFace.isReal )
							_resultFace = null;
						break;
					}
				}
				while ( ! _resultFace.isReal )
				
			}
			else
			{
				_resultFace = null;
			}
			
			return _resultFace;
		}
		
	}
}