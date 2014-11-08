package hxDaedalus.data;


class Face
{
    public var id(get, never) : Int;
    public var isReal(get, never) : Bool;
    public var edge(get, never) : Edge;

    
     static var INC : Int = 0;
     var _id : Int;
    
     var _isReal : Bool;
     var _edge : Edge;
    
    public var colorDebug : Int = -1;
    
    public function new(){
        _id = INC;
        INC++;
    }
    
     function get_id(): Int {
        return _id;
    }
    
     function get_isReal(): Bool {
        return _isReal;
    }
    
     function set_datas( edge : Edge ): Void {
        _isReal = true;
        _edge = edge;
    }
    
    // must use this if you want te set isReal to false
    public function setDatas( edge : Edge, isReal: Bool = true ): Void {
        _isReal = isReal;
        _edge = edge;
    }
    
    public function dispose(): Void {
        _edge = null;
    }
    
     function get_edge(): Edge {
        return _edge;
    }
}
