package wings.data;

@:expose
class MathPoints {
    public static inline function arcTan( p0: { x: Float, y: Float }
                                        , p1: { x: Float, y: Float }
                                        ): Float {
        return Math.atan2( p1.y - p0.y, p1.x - p0.x );
    }
    public static inline function distance(     p0: { x: Float, y: Float }
                                            ,   p1: { x: Float, y: Float }
                                            ): Float {
        var x = p0.x-p1.x;
        var y = p0.y-p1.y;
        return Math.sqrt(x*x + y*y);
    }

    public inline static function quadraticBezier(  t: Float
                                                ,   arr: Array<{ x: Float, y: Float }>
                                                ): { x: Float,y: Float } {
                                                    return {  x: _quadraticBezier( t, arr[0].x, arr[1].x, arr[2].x )
                                                            , y: _quadraticBezier( t, arr[0].y, arr[1].y, arr[2].y ) };
    }

    private inline static function _quadraticBezier ( t: Float
                                                    , startPoint: Float
                                                    , controlPoint: Float
                                                    , endPoint: Float
                                                    ): Float {
        var u = 1 - t;
        return Math.pow( u, 2) * startPoint + 2 * u * t * controlPoint + Math.pow( t, 2 ) * endPoint;
    }

    public static inline function generateMidPoints( arr: Array<{ x: Float, y: Float }>
                                                    ): Array<{ x: Float, y: Float }>{
        var out: Array<{ x: Float, y: Float }> = [];
        var a: { x: Float, y: Float };
        var b: { x: Float, y: Float };
        var len = arr.length - 2;
        for( i in 0...len ){
            a = arr[ i ];
            b = arr[ i + 1 ];
            out.push( { x: ( b.x + a.x )/2, y: ( b.y + a.y )/2 });
            out.push( { x: b.x, y: b.y } );
        }
        a = arr[0];
        out.unshift( { x: a.x, y: a.y } );
        out.unshift( { x: a.x, y: a.y } );
        b = arr[ arr.length - 1 ];
        out.push( { x: b.x, y: b.y } );
        out.push( { x: b.x, y: b.y } );
        out.push( { x: b.x, y: b.y } );
        return out;
    }
}
