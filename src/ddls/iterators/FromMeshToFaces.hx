package DDLS.iterators
{
	import DDLS.data.DDLSFace;
	import DDLS.data.DDLSMesh;
	import DDLS.data.DDLSVertex;
	
	public class FromMeshToFaces
	{
		
		private var _fromMesh:DDLSMesh;
		private var _currIndex:int;
		
		public function FromMeshToFaces()
		{
			
		}
		
		public function set fromMesh(value:DDLSMesh):void
		{
			_fromMesh = value;
			_currIndex = 0;
		}
		
		private var _resultFace:DDLSFace;
		public function next():DDLSFace
		{
			do
			{
				if (_currIndex < _fromMesh.__faces.length)
				{
					_resultFace = _fromMesh.__faces[_currIndex];
					_currIndex++;
				}
				else
				{
					_resultFace = null;
					break;
				}
			}
			while (! _resultFace.isReal)
			
			return _resultFace;
		}
		
	}
}