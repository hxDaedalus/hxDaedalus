package hxDaedalus.iterators;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
class FromFaceToNeighbourFaces {
    public var fromFace(never, set) : Face;
    var _fromFace : Face;
    var _nextEdge : Edge;
    var _resultFace : Face;
    
    public function new(){}
    
     function setFromFace( value: Face ): Face{
        _fromFace = value;
        _nextEdge = _fromFace.edge;
        return value;
    }
    
    public function next() : Face
    {
        if( _nextEdge != null ){
            do {
                _resultFace = _nextEdge.rightFace;
                _nextEdge = _nextEdge.nextLeftEdge;
                if( _nextEdge == _fromFace.edge ) {
                    _nextEdge = null;
                    if (!_resultFace.isReal) _resultFace = null;
                    break;
                }
            } while ( (!_resultFace.isReal) );
        } else {
            _resultFace = null;
        }
        return _resultFace;
    }
}
