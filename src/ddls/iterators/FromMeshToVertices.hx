package ddls.iterators;
import ddls.data.Face;
import ddls.data.Mesh;
import ddls.data.Vertex;

class FromMeshToVertices {
    public var fromMesh(never, set) : Mesh;
    var _fromMesh : Mesh;
    var _currIndex : Int;
    var _resultVertex : Vertex;
    
    public function new() {}
    
    function set_fromMesh(value : Mesh) : Mesh {
        _fromMesh = value;
        _currIndex = 0;
        return value;
    }
    
    public function next(): Vertex {
        do{
            if( _currIndex < _fromMesh._vertices.length ){
                _resultVertex = _fromMesh._vertices[ _currIndex ];
                _currIndex++;
            } else {
                _resultVertex = null;
                break;
            }
        } while ( (!_resultVertex.isReal) );
        return _resultVertex;
    }
}
