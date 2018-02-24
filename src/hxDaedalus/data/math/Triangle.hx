package hxDaedalus.data.math;
import hxDaedalus.data.Vertex;
import hxDaedalus.data.Edge;
import hxDaedalus.data.Face;
import hxDaedalus.data.math.Point2D;
@:expose
class Triangle {
    public var a: Point2D;
    public var b: Point2D;
    public var c: Point2D;
    public function new( va: Vertex, vb: Vertex, vc: Vertex ){
        a = va.pos;
        b = vb.pos;
        c = vc.pos;
    }
    public function isSolid():Bool { // clockWise / antiClockwise used to decide to fill
        return ( (a.x * b.y - b.x * a.y) + (b.x * c.y - c.x * b.y) + (c.x * a.y - a.x * c.y) )<0;
    }
    public static function fromFace( face: Face ): Triangle {
        return face.edge.triangle;
    }
}