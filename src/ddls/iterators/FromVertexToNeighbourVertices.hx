package ddls.iterators;
import ddls.data.Edge;
import ddls.data.Vertex;
class FromVertexToNeighbourVertices {
    public var fromVertex( never, set ) : Vertex;
    var _fromVertex : Vertex;
    var _nextEdge : Edge;
    var _resultVertex : Vertex;
    
    public function new(){}
    
    function setFromVertex( value: Vertex ) : Vertex {
        _fromVertex = value;
        _nextEdge = _fromVertex.edge;
        return value;
    }
    
    public function next() : Vertex {
        if (_nextEdge != null) {
            _resultVertex = _nextEdge.oppositeEdge.originVertex;
            do{
                _nextEdge = _nextEdge.rotLeftEdge;
            } while ( (!_nextEdge.isReal) );
            
            if( _nextEdge == _fromVertex.edge )  _nextEdge = null;
        } else {
            _resultVertex = null;
        }
        
        return _resultVertex;
    }
}
