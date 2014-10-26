package ddls.iterators;
import ddls.data.Edge;
import ddls.data.Face;
class FromFaceToInnerEdges {
    public var fromFace( never, set ): Face;
    var _fromFace: Face;
    var _nextEdge: Edge;
    var _resultEdge: Edge;
    
    public function new(){}
    
    function set_fromFace( value: Face ): Face {
        _fromFace = value;
        _nextEdge = _fromFace.edge;
        return value;
    }
    
    public function next(): Edge {
        if( _nextEdge != null ){
            _resultEdge = _nextEdge;
            _nextEdge = _nextEdge.nextLeftEdge;
            if (_nextEdge == _fromFace.edge) _nextEdge = null;
        } else {
            _resultEdge = null;
        }
        return _resultEdge;
    }
}
