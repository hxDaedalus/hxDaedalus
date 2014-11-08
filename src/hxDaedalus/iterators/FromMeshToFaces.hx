package hxDaedalus.iterators;
import hxDaedalus.data.Face;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Vertex;

class FromMeshToFaces {
    public var fromMesh(never, set): Mesh;
    var _fromMesh : Mesh;
    var _currIndex : Int;
    var _resultFace : Face;
    
    public function new(){}
    
    function setFromMesh( value: Mesh ): Mesh {
        _fromMesh = value;
        _currIndex = 0;
        return value;
    }
    
    public function next(): Face
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
