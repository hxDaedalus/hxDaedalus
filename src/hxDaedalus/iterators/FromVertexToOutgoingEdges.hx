package hxDaedalus.iterators;


import hxDaedalus.data.Edge;
import hxDaedalus.data.Vertex;

@:expose
class FromVertexToOutgoingEdges
{
    public var fromVertex(never, set) : Vertex;

    
     var _fromVertex : Vertex;
     var _nextEdge : Edge;
    
    public var realEdgesOnly : Bool = true;
    
    public function new()
    {
        
        
    }
    
     function set_fromVertex(value : Vertex) : Vertex
    {
        _fromVertex = value;
        _nextEdge = _fromVertex.edge;
        while (realEdgesOnly && !_nextEdge.isReal)
        {
            _nextEdge = _nextEdge.rotLeftEdge;
        }
        return value;
    }
    
     var _resultEdge : Edge;
    
    public function next() : Edge
    {
        if (_nextEdge != null) 
        {
            _resultEdge = _nextEdge;
            do
            {
                _nextEdge = _nextEdge.rotLeftEdge;
                if (_nextEdge == _fromVertex.edge) 
                {
                    _nextEdge = null;
                    break;
                }
            }            while ((realEdgesOnly && !_nextEdge.isReal));
        }
        else 
        {
            _resultEdge = null;
        }
        
        return _resultEdge;
    }
}
