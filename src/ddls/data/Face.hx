package ddls.data;


class Face
{
    public var id(get, never) : Int;
    public var isReal(get, never) : Bool;
    public var edge(get, never) : Edge;

    
    private static var INC : Int = 0;
    private var _id : Int;
    
    private var _isReal : Bool;
    private var _edge : Edge;
    
    public var colorDebug : Int = -1;
    
    public function new(){
        _id = INC;
        INC++;
    }
    
    private function get_id(): Int {
        return _id;
    }
    
    private function get_isReal(): Bool {
        return _isReal;
    }
    
    private function set_datas( edge : Edge ): Void {
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
    
    private function get_edge(): Edge {
        return _edge;
    }
}
