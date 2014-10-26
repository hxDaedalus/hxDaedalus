package ddls.data;


class ConstraintShape{
    public var id( get, never ) : Int;
    public var segments : Array<ConstraintSegment>;
    static var INC : Int = 0;
    var _id : Int;
    
    public function new(){
        _id = INC;
        INC++;
        segments = new Array<ConstraintSegment>();
    }
    
    private function get_id(): Int {
        return _id;
    }
    
    public function dispose(): Void {
        while ( segments.length > 0 ) segments.pop().dispose();
        segments = null;
    }
}
