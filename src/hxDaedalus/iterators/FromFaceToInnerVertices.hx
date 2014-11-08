package hxDaedalus.iterators;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
import hxDaedalus.data.Vertex;
class FromFaceToInnerVertices {
    public var fromFace( never, set ): Face;
    var _fromFace: Face;
    var _nextEdge: Edge;
    var _resultVertex: Vertex;
    
    public function new(){}
    
    function setFromFace( value: Face) : Face {
        _fromFace = value;
        _nextEdge = _fromFace.edge;
        return value;
    }
    
    public function next() : Vertex{
        if( _nextEdge != null ) {
            _resultVertex = _nextEdge.originVertex;
            _nextEdge = _nextEdge.nextLeftEdge;
            if( _nextEdge == _fromFace.edge ) _nextEdge = null;
        } else {
            _resultVertex = null;
        }
        return _resultVertex;
    }
}
