package ddls.iterators;
import ddls.data.Edge;
import ddls.data.Vertex;

class FromVertexToIncomingEdges {
    public var fromVertex( never, set ): Vertex;
    var _fromVertex: Vertex;
    var _nextEdge: Edge;
    var _resultEdge : Edge;
    
    public function new() {}
    
    function set_fromVertex( value: Vertex ): Vertex {
        _fromVertex = value;
        _nextEdge = _fromVertex.edge;
        while (!_nextEdge.isReal){
            _nextEdge = _nextEdge.rotLeftEdge;
        }
        return value;
    }
    
    
    public function next() : Edge {
        if( _nextEdge != null ) {
            _resultEdge = _nextEdge.oppositeEdge;
            do{
                _nextEdge = _nextEdge.rotLeftEdge;
                if( _nextEdge == _fromVertex.edge ){
                    _nextEdge = null;
                    break;
                }
            } while ( (!_nextEdge.isReal) );
        } else {
            _resultEdge = null;
        }
        return _resultEdge;
    }
}
