package ddls.iterators;
import ddls.data.Face;
import ddls.data.Mesh;
import ddls.data.Vertex;

class FromMeshToFaces {
    public var fromMesh(never, set) : Mesh;
    var _fromMesh : Mesh;
    var _currIndex : Int;
    var _resultFace : Face;
    
    public function new(){}
    
    function setFromMesh( value: Mesh ): Mesh {
        _fromMesh = value;
        _currIndex = 0;
        return value;
    }
    
    public function next() : Face
    {
        do {
            if( _currIndex < _fromMesh._faces.length ){
                _resultFace = _fromMesh._faces[ _currIndex ];
                _currIndex++;
            } else {
                _resultFace = null;
                break;
            }
        } while ( (!_resultFace.isReal) );
        return _resultFace;
    }
}
