package hxDaedalus.graphics.pixel;
/// Curve Rasterizing Algorithm ///
typedef IPixels = hxDaedalus.graphics.Pixels;
/*interface IPixels {
    public function setPixelColorAndAlpha( x: Int, y: Int, col: Int, alpha, Int ): Void;
}*/

// @author Zingl Alois
// @date 17.12.2012
// @version 1.1
// http://members.chello.at/~easyfilter/bresenham.html
// @ported to haxe by justinfront


class BresenHamPixels {

    public static function setPixelAA( pixels: IPixels, x: Int, y: Int, i: Float, col: Int, alpha: Int ) {
        i = 1 - i/alpha;
        pixels.setPixelColorAndAlpha( x, y, col, Std.int( 255*i ) );
    }

    // Fully ported, untested
    public inline static function plotLine(     pixels:     IPixels
                                            ,   x0: Int,    y0: Int
                                            ,   x1: Int,    y1: Int
                                            ,   col: Int,   alpha: Int )
    {
        var dx: Int =  Std.int( Math.abs( x1 - x0 ) );
        var sx: Int = ( x0 < x1 )? 1 : -1;
        var dy: Int = Std.int( - Math.abs( y1 - y0 ) );
        var sy: Int = ( y0 < y1 )? 1 : -1;
        var err: Int = dx + dy;
        var e2: Int;                                                // error value e_xy
        // added safety get out as forever while's are dangerous
        var count = 0;
        while( true ){                                              // loop
            if( count > 5000 ) break;
            pixels.setPixelColorAndAlpha( x0, y0, col, alpha );
            if( x0 == x1 || y0 == y1 ) break;
            e2 = 2*err;
            if( e2 >= dy ){                                         // e_xy+e_x > 0
                err += dy;
                x0 += sx;
            }
            if( e2 <= dx ){                                         // e_xy+e_y < 0
                err += dx;
                y0 += sy;
            }
            count++;
        }
    }

    // Fully ported, untested
    public inline static function plotEllipse(  pixels:     IPixels
                                            ,   xm: Int,    ym: Int
                                            ,   a:  Int,    b:  Int
                                            ,   col: Int,   alpha: Int ){
        var x: Int = -a;
        var y: Int = 0;                         // II. quadrant from bottom left to top right
        var e2 = b*b;
        var err = x*( 2*e2 + x ) + e2;          // error of 1.step

        do {
            pixels.setPixelColorAndAlpha( xm - x, ym + y, col, alpha );     //   I. Quadrant
            pixels.setPixelColorAndAlpha( xm + x, ym + y, col, alpha );     //  II. Quadrant
            pixels.setPixelColorAndAlpha( xm + x, ym - y, col, alpha );                 // III. Quadrant
            pixels.setPixelColorAndAlpha( xm - x, ym - y, col, alpha );                 //  IV. Quadrant
            e2 = 2*err;
            if( e2 >= ( x*2 + 1 )*b*b )                           // e_xy + e_x > 0
                err += ( ++x*2 + 1 )*b*b;
            if( e2 <= ( y*2 + 1 )*a*a )                           // e_xy + e_y < 0
                err += ( ++y*2 + 1 )*a*a;
        } while( x <= 0 );

        while( y++ < b ) { // too early stop of flat ellipses a=1,
            pixels.setPixelColorAndAlpha( xm, ym + y, col, alpha ); // -> finish tip of ellipse
            pixels.setPixelColorAndAlpha( xm, ym - y, col, alpha );
        }
    }

    // Fully ported, untested
    public inline static function plotOptimizedEllipse(     pixels:     IPixels
                                                        ,   xm: Int,    ym: Int
                                                        ,   a:  Int,    b:  Int
                                                        ,   col: Int,   alpha: Int ){
        var x: Float = -a;
        var y: Float = 0;                      // II. quadrant from bottom left to top right
        var e2: Float = b;
        var dx: Float = ( 1 + 2*x )*e2*e2;     // error increment
        var dy: Float = x*x;
        var err: Float = dx + dy;              // error of 1.step

        do {
            pixels.setPixelColorAndAlpha( Std.int( xm - x ), Std.int( ym + y ), col, alpha );  //   I. Quadrant
            pixels.setPixelColorAndAlpha( Std.int( xm + x ), Std.int( ym + y ), col, alpha );  //  II. Quadrant
            pixels.setPixelColorAndAlpha( Std.int( xm + x ), Std.int( ym - y ), col, alpha );  // III. Quadrant
            pixels.setPixelColorAndAlpha( Std.int( xm - x ), Std.int( ym - y ), col, alpha );  //  IV. Quadrant
            e2 = 2*err;
            if( e2 >= dx ){ // x step
                x++;
                err += dx += 2*b*b;
            }
            if( e2 <= dy ){ // y step
                y++;
                err += dy += 2*a*a;
            }
        } while( x <= 0 );

        while( y++ < b ){ // too early stop for flat ellipses with a = 1,
            pixels.setPixelColorAndAlpha( xm, Std.int( ym + y ), col, alpha );     // -> finish tip of ellipse
            pixels.setPixelColorAndAlpha( xm, Std.int( ym - y ), col, alpha );
        }
    }

    // Fully ported, untested
    public inline static function plotCircle( pixels:   IPixels
                                            , xm: Int,  ym: Int
                                            , r:  Float
                                            , col: Int, alpha: Int ){
        var x: Float = -r;
        var y: Float = 0;
        var err: Float = 2 - 2*r;                // bottom left to top right

        do {
            pixels.setPixelColorAndAlpha( Std.int( xm - x ), Std.int( ym + y ), col, alpha );  //   I. Quadrant +x +y
            pixels.setPixelColorAndAlpha( Std.int( xm - y ), Std.int( ym - x ), col, alpha );  //  II. Quadrant -x +y
            pixels.setPixelColorAndAlpha( Std.int( xm + x ), Std.int( ym - y ), col, alpha );  // III. Quadrant -x -y
            pixels.setPixelColorAndAlpha( Std.int( xm + y ), Std.int( ym + x ), col, alpha );  //  IV. Quadrant +x -y
            r = err;
            if( r <= y ){
                err += ++y*2 + 1;               // e_xy + e_y < 0
            }
            if( r > x || err > y ){             // e_xy + e_x > 0 or no 2nd y-step
                err += ++x*2 + 1;               // -> x-step now
            }
        } while( x < 0 );
    }

    // Possibly ported, untested
    // rectangular parameter enclosing the ellipse
    public inline static function plotEllipseRect(  pixels:     IPixels
                                                ,   x0: Int,    y0: Int
                                                ,   x1: Int,    y1: Int
                                                ,   col: Int,   alpha: Int ){
        var a: Float = Math.abs( x1 - x0 );
        var b: Float = Math.abs( y1 - y0 );
        var b_: Int = cast b;
        ///// NOT SURE!!! /////
        //var b1: Float = b&1;                    // diameter
        var b1: Int =  b_&1;
        var dx: Float = 4*( 1.0 - a )*b*b;
        var dy: Float = 4*( b1 + 1 )*a*a;       // error increment
        var err: Float = dx + dy + b1*a*a;
        var e2: Float;                          // error of 1.step

        if( x0 > x1 ){
            x0 = x1;
            x1 += Std.int( a );
        }     // if called with swapped points
        if( y0 > y1 ) y0 = y1;                  // .. exchange them
        y0 += Std.int( ( b + 1 )/2 );
        y1 = y0 - b1;                           // starting pixel
        a = 8*a*a;
        var b1_ = 8*b*b;

        do {
            pixels.setPixelColorAndAlpha( x1, y0, col, alpha ); //   I. Quadrant
            pixels.setPixelColorAndAlpha( x0, y0, col, alpha ); //  II. Quadrant
            pixels.setPixelColorAndAlpha( x0, y1, col, alpha ); // III. Quadrant
            pixels.setPixelColorAndAlpha( x1, y1, col, alpha ); //  IV. Quadrant
            e2 = 2*err;
            if( e2 <= dy ){  // y step
                y0++;
                y1--;
                err += dy += a;
            }
            if (e2 >= dx || 2*err > dy) { // x step
                x0++;
                x1--;
                err += dx += b1_;
            }
        } while( x0 <= x1 );

        while( y0 - y1 <= b ) {                // too early stop of flat ellipses a=1
            pixels.setPixelColorAndAlpha( x0 - 1, y0, col, alpha );                         // -> finish tip of ellipse
            pixels.setPixelColorAndAlpha( x1 + 1, y0++, col, alpha );
            pixels.setPixelColorAndAlpha( x0 - 1, y1, col, alpha );
            pixels.setPixelColorAndAlpha( x1 + 1, y1--, col, alpha );
        }
    }

    // Fully ported, untested
    // plot a limited quadratic Bezier segment
    public static function plotQuadBezierSeg(    pixels:     IPixels
                                                    ,   x0: Int,    y0: Int
                                                    ,   x1: Int,    y1: Int
                                                    ,   x2: Int,    y2: Int
                                                    ,   col: Int,   alpha: Int ){
        var sx: Int = x2 - x1;
        var sy: Int = y2 - y1;
        var xx: Float = x0 - x1;
        var yy: Float = y0  -y1;
        var xy: Float;                      // relative values for checks
        var dx: Float;
        var dy: Float;
        var err: Float;
        var cur: Float = xx*sy - yy*sx;     // curvature

        // sign of gradient must not change
        if( xx*sx <= 0 && yy*sy <= 0 ) {} else { trace('failed to plotQuadBezierSeg' ); return; }

        if( sx*sx + sy*sy > xx*xx + yy*yy ) {      // begin with longer part
            x2 = x0;
            x0 = sx + x1;
            y2 = y0;
            y0 = sy + y1;
            cur = -cur;       // swap P0 P2
        }
        if( cur != 0 ) {                                    // no straight line
            xx += sx;
            xx *= sx = ( x0 < x2 )? 1 : -1;                 // x step direction
            yy += sy;
            yy *= sy = ( y0 < y2 )? 1 : -1;                 // y step direction
            xy = 2*xx*yy;
            xx *= xx;
            yy *= yy;                                       // differences 2nd degree
            if( cur*sx*sy < 0 ) {                           // negated curvature?
                xx = -xx;
                yy = -yy;
                xy = -xy;
                cur = -cur;
            }
            dx = 4.0*sy*cur*( x1 - x0 ) + xx - xy;          // differences 1st degree
            dy = 4.0*sx*cur*( y0 - y1 ) + yy - xy;
            xx += xx;
            yy += yy;
            err = dx + dy + xy;                             // error 1st step
            do {
                pixels.setPixelColorAndAlpha( x0, y0, col, alpha ); // plot curve
                if( x0 == x2 && y0 == y2 ) return;                  // last pixel -> curve finished
                //y1 = 2*err < dx;                                    // save value for test of y step
                if( 2*err > dy ) {
                    x0 += sx;
                    dx -= xy;
                    err += dy += yy;
                }      // x step
                if( 2*err < dx ) {//y1 ){
                    y0 += sy;
                    dy -= xy;
                    err += dx += xx;
                }      // y step
            } while( dy < 0 && dx > 0 );                            // gradient negates -> algorithm fails
        }
        plotLine( pixels, x0, y0, x2, y2, col, alpha );             // plot remaining part to end
    }

    // Fully ported, untested
    // plot any quadratic Bezier curve
    public static function plotQuadBezier(  pixels:     IPixels
                                        ,   x0: Int,    y0: Int
                                        ,   x1: Int,    y1: Int
                                        ,   x2: Int,    y2: Int
                                        ,   col: Int,   alpha: Int ){
        var x: Int = x0 - x1;
        var y: Int = y0 - y1;
        var t: Float = x0 - 2*x1 + x2;
        var r: Float;

        if( x*( x2 - x1 ) > 0 ) {                                               // horizontal cut at P4?
            if( y*( y2 - y1 ) > 0 )                                             // vertical cut at P6 too?
                if( Math.abs( ( y0 - 2*y1 + y2 ) / t*x ) > Math.abs( y ) ) {    // which first?
                    x0 = x2;
                    x2 = x + x1;
                    y0 = y2;
                    y2 = y + y1;                                                // swap points
                }                                                               // now horizontal cut at P4 comes first
            t = ( x0 - x1 )/t;
            r = ( 1 - t )*( ( 1 - t )*y0 + 2.0*t*y1 ) + t*t*y2;                 // By( t = P4 )
            t = ( x0*x2 - x1*x1 )*t/( x0 - x1 );                                // gradient dP4/dx=0
            x = Math.floor( t + 0.5 );
            y = Math.floor( r + 0.5 );
            r = ( y1 - y0 )*( t - x0 )/( x1 - x0 ) + y0;                        // intersect P3 | P0 P1
            plotQuadBezierSeg( pixels, x0, y0, x, Math.floor( r + 0.5 ), x, y, col, alpha );
            r = ( y1 - y2 )*( t - x2 )/( x1 - x2 ) + y2;                        // intersect P4 | P1 P2
            x0 = x1 = x;
            y0 = y;
            y1 = Math.floor( r + 0.5 );                                         // P0 = P4, P1 = P8
        }
        if( ( y0 - y1 )*( y2 - y1 ) > 0 ) {                                     // vertical cut at P6?
            t = y0 - 2*y1 + y2;
            t = ( y0 - y1 )/t;
            r = ( 1 - t )*( ( 1 - t )*x0 + 2.0*t*x1 ) + t*t*x2;                 // Bx(t=P6)
            t = ( y0*y2 - y1*y1 )*t/( y0 - y1 );                                // gradient dP6/dy=0
            x = Math.floor( r + 0.5 );
            y = Math.floor( t + 0.5 );
            r = ( x1 - x0 )*( t - y0 )/( y1 - y0 ) + x0;                        // intersect P6 | P0 P1
            plotQuadBezierSeg( pixels, x0, y0, Math.floor( r + 0.5 ), y, x, y, col, alpha );
            r = ( x1 - x2 )*( t - y2 )/( y1 - y2 )+x2;                          // intersect P7 | P1 P2
            x0 = x;
            x1 = Math.floor( r + 0.5 );
            y0 = y1 = y;                                                        // P0 = P6, P1 = P7
        }
        plotQuadBezierSeg( pixels, x0, y0, x1, y1, x2, y2, col, alpha );        // remaining part
    }

    // Fully ported, untested
    // plot a limited rational Bezier segment, squared weight
    public static function plotQuadRationalBezierSeg(   pixels:     IPixels
                                                    ,   x0: Int,    y0: Int
                                                    ,   x1: Int,    y1: Int
                                                    ,   x2: Int,    y2: Int
                                                    ,   w: Float
                                                    ,   col: Int,   alpha: Int ){
        var sx: Int = x2 - x1;
        var sy: Int = y2 - y1;                  // relative values for checks
        var dx: Float = x0 - x2;
        var dy: Float = y0 - y2;
        var xx: Float = x0 - x1;
        var yy: Float = y0 - y1;
        var xy: Float = xx*sy + yy*sx;
        var cur: Float = xx*sy - yy*sx;
        var err: Float;                         // curvature

        if( xx*sx <= 0.0 && yy*sy <= 0.0 ) {    // sign of gradient must not change
        } else { trace( 'failed to plotQuadRationalBeierSeg'); return; }

        if(cur != 0.0 && w > 0.0) {                  // no straight line
            if( sx*sx + sy*sy > xx*xx + yy*yy ) {    // begin with longer part
                x2 = x0;
                x0 -= Std.int( dx );
                y2 = y0;
                y0 -= Std.int( dy );
                cur = -cur;                         // swap P0 P2
            }
            xx = 2.0*( 4.0*w*sx*xx + dx*dx );       // differences 2nd degree
            yy = 2.0*( 4.0*w*sy*yy + dy*dy );
            sx = ( x0 < x2 )? 1 : -1;               // x step direction
            sy = ( y0 < y2 )? 1 : -1;               // y step direction
            xy = -2.0*sx*sy*( 2.0*w*xy + dx*dy );

            if( cur*sx*sy < 0.0) {                  // negated curvature?
                xx = -xx;
                yy = -yy;
                xy = -xy;
                cur = -cur;
            }
            dx = 4.0*w*( x1 - x0 )*sy*cur + xx/2.0 + xy;  // differences 1st degree
            dy = 4.0*w*( y0 - y1 )*sx*cur + yy/2.0 + xy;

            if( w < 0.5 && ( dy > xy || dx < xy ) ) {    // flat ellipse, algorithm fails
                cur = ( w + 1.0 )/2.0;
                w = Math.sqrt( w );
                xy = 1.0/( w + 1.0 );
                sx = Math.floor( ( x0 + 2.0*w*x1 + x2 )*xy/2.0 + 0.5 );    // subdivide curve in half
                sy = Math.floor( ( y0 + 2.0*w*y1 + y2 )*xy/2.0 + 0.5 );
                dx = Math.floor( ( w*x1 + x0 )*xy + 0.5 );
                dy = Math.floor( ( y1*w + y0 )*xy + 0.5 );
                plotQuadRationalBezierSeg( pixels, x0, y0, Std.int( dx ), Std.int( dy ), sx, sy, cur, col, alpha );// plot separately
                dx = Math.floor( ( w*x1 + x2 )*xy + 0.5 );
                dy = Math.floor( ( y1*w + y2 )*xy + 0.5 );
                plotQuadRationalBezierSeg( pixels, sx, sy, Std.int( dx ), Std.int( dy ), x2, y2, cur, col, alpha );
                return;
            }
            err = dx + dy - xy;                                                 // error 1.step
            do {
                pixels.setPixelColorAndAlpha( x0, y0, col, alpha );     // plot curve
                if (x0 == x2 && y0 == y2) return;                               // last pixel -> curve finished
                x1 = (2*err > dy)? 1 :0;
                y1 = (2*( err + yy) < -dy)? 1: 0;                                       // save value for test of x step
                if( ( 2*err < dx ) || ( y1 == 1 ) ) {                                         // y step
                    y0 += sy;
                    dy += xy;
                    err += dx += xx;
                }
                if(2*err > dx || ( x1 == 1 ) ) {
                    x0 += sx; dx += xy; err += dy += yy; }                      // x step
            } while (dy <= xy && dx >= xy);                                     // gradient negates -> algorithm fails
        }
        plotLine( pixels, x0, y0, x2, y2, col, alpha );                         // plot remaining needle to end
    }

    // Fully ported, untested
    // plot any quadratic rational Bezier curve
    public inline static function plotQuadRationalBezier(   pixels:     IPixels
                                                        ,   x0: Int,    y0: Int
                                                        ,   x1: Int,    y1: Int
                                                        ,   x2: Int,    y2: Int
                                                        ,   w:  Float
                                                        ,   col: Int, alpha: Int ){
        var x: Int = x0- 2 *x1 + x2;
        var y: Int = y0 - 2*y1 + y2;
        var xx: Float = x0 - x1;
        var yy: Float = y0 - y1;
        var ww: Float;
        var t: Float;
        var q: Float;

        if( w >= 0.0 ){} else{ trace( 'Failed to plotQuadRationalBezier' ); return; }

        if( xx*( x2 - x1 ) > 0 ) {                             // horizontal cut at P4?
            if( yy*( y2 - y1 ) > 0 )                           // vertical cut at P6 too?
                if ( Math.abs( xx*y ) > Math.abs( yy*x ) ) {   // which first?
                    x0 = x2;
                    x2 = Std.int( xx + x1 );
                    y0 = y2;
                    y2 = Std.int( yy + y1 );                               // swap points
                }                                               // now horizontal cut at P4 comes first
            if( x0 == x2 || w == 1.0 ){
                 t = ( x0 - x1 )/x;
            } else {                                            // non-rational or rational case
                q = Math.sqrt( 4.0*w*w*( x0 - x1 )*( x2 - x1 ) + ( x2 - x0 )*( x2 - x0 ) );
                if( x1 < x0 ) q = -q;
                t = ( 2.0*w*( x0 - x1 ) - x0 + x2 + q )/( 2.0*( 1.0 - w )*( x2 - x0 ) );  // t at P4
            }
            q = 1.0/( 2.0*t*( 1.0 - t )*( w - 1.0 ) + 1.0 );                              // sub-divide at t
            xx = ( t*t*( x0 - 2.0*w*x1 + x2 ) + 2.0*t*( w*x1 - x0 ) + x0 )*q;             // = P4
            yy = ( t*t*( y0 - 2.0*w*y1 + y2 ) + 2.0*t*( w*y1 - y0 ) + y0 )*q;
            ww = t*( w - 1.0 ) + 1.0;
            ww *= ww*q;                                                                   // squared weight P3
            w = (( 1.0 - t )*( w - 1.0 ) + 1.0 )*Math.sqrt( q );                          // weight P8
            x = Math.floor( xx + 0.5 );
            y = Math.floor( yy + 0.5 );                                                   // P4
            yy = ( xx - x0 )*( y1 - y0 )/( x1 - x0 ) + y0;                                // intersect P3 | P0 P1
            plotQuadRationalBezierSeg( pixels, x0, y0, x, Math.floor( yy + 0.5 ), x, y, ww, col, alpha );
            yy = ( xx - x2 )*( y1 - y2 )/( x1 - x2 ) + y2;                                // intersect P4 | P1 P2
            y1 = Math.floor( yy + 0.5 );
            x0 = x1 = x;
            y0 = y;                                                                       // P0 = P4, P1 = P8
        }
        if( ( y0 - y1 )*( y2 - y1 ) > 0 ) {                                               // vertical cut at P6?
            if( y0 == y2 || w == 1.0 ) {
                t = ( y0 - y1 )/( y0 - 2.0*y1 + y2 );
            } else {                                                                      // non-rational or rational case
                q = Math.sqrt( 4.0*w*w*( y0 - y1 )*( y2 - y1 ) + ( y2 - y0 )*( y2 - y0 ) );
                if( y1 < y0 ) q = -q;
                t = ( 2.0*w*( y0 - y1 ) - y0 + y2 + q )/( 2.0*( 1.0 - w )*( y2 - y0 ) );  // t at P6
            }
            q = 1.0/( 2.0*t*( 1.0 - t )*( w - 1.0 ) + 1.0 );                              // sub-divide at t
            xx = ( t*t*( x0 - 2.0*w*x1 + x2 ) + 2.0*t*( w*x1 - x0 ) + x0 )*q;             // = P6
            yy = ( t*t*( y0 - 2.0*w*y1 + y2 ) + 2.0*t*( w*y1 - y0 ) + y0 )*q;
            ww = t*( w - 1.0 ) + 1.0;
            ww *= ww*q;                                                                   // squared weight P5
            w = (( 1.0 - t )*( w - 1.0 ) + 1.0 )*Math.sqrt( q );                          // weight P7
            x = Math.floor( xx + 0.5 );
            y = Math.floor( yy + 0.5 );                                                   // P6
            xx = ( x1 - x0 )*( yy - y0 )/( y1 - y0 ) + x0;                                // intersect P6 | P0 P1
            plotQuadRationalBezierSeg( pixels, x0, y0, Math.floor( xx + 0.5 ), y, x, y, ww, col, alpha );
            xx = ( x1 - x2 )*( yy - y2 )/( y1 - y2 ) + x2;                                // intersect P7 | P1 P2
            x1 = Math.floor( xx + 0.5 );
            x0 = x;
            y0 = y1 = y;                                                                  // P0 = P6, P1 = P7
        }

        plotQuadRationalBezierSeg( pixels, x0, y0, x1, y1, x2, y2, w*w, col, alpha );          // remaining
    }

    // Fully ported, untested
    // plot ellipse rotated by angle (radian)
    public inline static function plotRotatedEllipse(   pixels:     IPixels
                                                    ,   x: Int,     y: Int
                                                    ,   a: Int,     b: Int
                                                    ,   angle:      Float
                                                    ,   col: Int,   alpha: Int ){
        var xd: Float = a*a;
        var yd: Float = b*b;
        var s: Float = Math.sin( angle );
        var v: Float;
        var zd: Float = ( xd - yd )*s;                  // ellipse rotation
        var xd = Math.sqrt( xd - zd*s );
        var yd = Math.sqrt( yd + zd*s );                // surrounding rectangle
        a = Std.int( xd + 0.5 );
        b = Std.int( yd + 0.5 );
        zd = zd*a*b/( xd*yd );                          // scale to integer
        plotRotatedEllipseRect( pixels, x - a, y - b, x + a, y + b, 4*zd*Math.cos( angle ), col, alpha );
    }

    // Fully ported, untested
    // rectangle enclosing the ellipse, integer rotation angle
    public static function plotRotatedEllipseRect( pixels:    IPixels
                                                        , x0: Int,   y0: Int
                                                        , x1: Int,   y1: Int
                                                        , zd: Float
                                                        , col: Int,  alpha: Int ){
        var xd: Int = x1 - x0;
        var yd: Int = y1 - y0;
        var w: Float = xd*yd;

        if( zd == 0 ) return plotEllipseRect( pixels, x0, y0, x1, y1, col, alpha );                     // looks nicer
        if( w != 0.0 ) w = ( w - zd )/( w + w );                                                        // squared weight of P1
        if( w <= 1.0 && w >= 0.0 ) {} else { trace( 'Failed to plotRotatedEllipseRect' ); return; }     // limit angle to |zd|<=xd*yd
        xd = Math.floor( xd*w + 0.5 );
        yd = Math.floor( yd*w + 0.5 );                                                                  // snap xe,ye to int
        plotQuadRationalBezierSeg( pixels, x0, y0 + yd, x0, y0, x0 + xd, y0, 1.0 - w, col, alpha );
        plotQuadRationalBezierSeg( pixels, x0, y0 + yd, x0, y1, x1 - xd, y1, w, col, alpha );
        plotQuadRationalBezierSeg( pixels, x1, y1 - yd, x1, y1, x1 - xd, y1, 1.0 - w, col, alpha );
        plotQuadRationalBezierSeg( pixels, x1, y1 - yd, x1, y0, x0 + xd, y0, w, col, alpha );
    }

    // Issue Porting  var *pxy;  and unknown exit command?  also &xy also overly complex for loop !
    // plot limited cubic Bezier segment
    public static function plotCubicBezierSeg( pixels:  IPixels
                                                    , x0:      Int,    y0:     Int
                                                    , x1:      Float,  y1:     Float
                                                    , x2:      Float,  y2:     Float
                                                    , x3:      Int,    y3:     Int
                                                    , col:     Int,    alpha:  Int ){
        var f: Int;
        var fx: Int;
        var fy: Int;
        var leg: Int = 1;
        var sx: Int = ( x0 < x3 )? 1 : -1;
        var sy: Int = ( y0 < y3 )? 1 : -1;        // step direction

        var xc: Float = -Math.abs( x0 + x1 - x2 - x3);
        var xa: Float = xc-4*sx*( x1 - x2 );
        var xb: Float = sx*( x0 - x1 - x2 + x3);
        var yc: Float = -Math.abs( y0 + y1 - y2 - y3 );
        var ya: Float = yc - 4*sy*( y1 - y2 );
        var yb: Float = sy*( y0 - y1 - y2 + y3 );
        var ab: Float;
        var ac: Float;
        var bc: Float;
        var cb: Float;
        var xx: Float;
        var xy: Float;
        var yy: Float;
        var dx: Float;
        var dy: Float;
        var ex: Float;
        var pxy;
        var EP: Float = 0.01;

        // check for curve restrains
        // slope P0-P1 == P2-P3    and  (P0-P3 == P1-P2      or   no slope change)
        if( ( x1 - x0 )*( x2 - x3 ) < EP && (( x3 - x0 )*( x1 - x2 ) < EP || xb*xb < xa*xc + EP ) ){} else { trace( 'Failed to plotCubicBezierSeg' ); return; }
        if( ( y1 - y0 )*( y2 - y3 ) < EP && ( ( y3 - y0 )*( y1 - y2 ) < EP || yb*yb < ya*yc + EP ) ){} else { trace( 'Failed to plotCubicBezierSeg' ); return; }

        if( xa == 0 && ya == 0 ){                                       // quadratic Bezier
            sx = Math.floor( ( 3*x1 - x0 + 1 )/2 );
            sy = Math.floor( ( 3*y1 - y0 + 1)/2 );                      // new midpoint
            return plotQuadBezierSeg( pixels, x0, y0, sx, sy, x3, y3, col, alpha );
        }
        x1 = ( x1 - x0 )*( x1 - x0 ) + ( y1 - y0 )*( y1 - y0 ) + 1;     // line lengths
        x2 = ( x2 - x3 )*( x2 - x3 ) + ( y2 - y3 )*( y2 - y3 ) + 1;
        do {                                                            // loop over both ends
            ab = xa*yb - xb*ya;
            ac = xa*yc - xc*ya;
            bc = xb*yc - xc*yb;
            ex = ab*( ab + ac - 3*bc ) + ac*ac;       // P0 part of self-intersection loop?
            f = ( ex > 0 )? 1 : Std.int( Math.sqrt( 1 + 1024/x1 ) );               // calculate resolution
            //// What do I da Here!! /////
            ab *= f;
            ac *= f;
            bc *= f;
            ex *= f*f;            // increase resolution
            xy = 9*( ab + ac + bc )/8;
            cb = 8*( xa - ya );  // init differences of 1st degree
            dx = 27*( 8*ab*( yb*yb - ya*yc ) + ex*( ya + 2*yb + yc ) )/64 - ya*ya*( xy - ya );
            dy = 27*( 8*ab*( xb*xb - xa*xc ) - ex*( xa + 2*xb + xc ) )/64 - xa*xa*( xy + xa );
                                            // init differences of 2nd degree
            xx = 3*( 3*ab*( 3*yb*yb - ya*ya - 2*ya*yc ) - ya*( 3*ac*( ya + yb ) + ya*cb ) )/4;
            yy = 3*( 3*ab*( 3*xb*xb - xa*xa - 2*xa*xc ) - xa*( 3*ac*( xa + xb ) + xa*cb ) )/4;
            xy = xa*ya*(6*ab+6*ac-3*bc+cb);
            ac = ya*ya;
            cb = xa*xa;
            xy = 3*( xy + 9*f*( cb*yb*yc - xb*xc*ac ) - 18*xb*yb*ab )/8;

            if( ex < 0 ) {         // negate values if inside self-intersection loop
                dx = -dx;
                dy = -dy;
                xx = -xx;
                yy = -yy;
                xy = -xy;
                ac = -ac;
                cb = -cb;
            }                                     // init differences of 3rd degree
            ab = 6*ya*ac;
            ac = -6*xa*ac;
            bc = 6*ya*cb;
            cb = -6*xa*cb;
            dx += xy;
            ex = dx + dy;
            dy += xy;                    // error of 1st step
            pxy = 0;
            fx = fy = f;
            while( x0 != x3 && y0 != y3 ){
                pixels.setPixelColorAndAlpha( x0, y0, col, alpha );  // plot curve
                do {                                  // move sub-steps of one pixel
                    if (pxy == 0) if (dx > xy || dy < xy) return;    // confusing
                    if (pxy == 1) if (dx > 0 || dy < 0) return;         // values
                    y1 = 2*ex - dy;                    // save value for test of y step
                    if( 2*ex >= dx){                                   // x sub-step
                        fx--;
                        ex += dx += xx;
                        dy += xy += ac;
                        yy += bc;
                        xx += ab;
                    } else { return; }
                    if( y1 <= 0 ){                                      // y sub-step
                        fy--;
                        ex += dy += yy;
                        dx += xy += bc;
                        xx += ac;
                        yy += cb;
                    }
                } while ( fx > 0 && fy > 0 );                       // pixel complete?
                if( 2*fx <= f ) {
                    x0 += sx;
                    fx += f;
                }                      // x step
                if( 2*fy <= f ){
                    y0 += sy;
                    fy += f;
                }                      // y step
                if( pxy == 0 && dx < 0 && dy > 0) pxy = 1;  // pixel ahead valid
            }
            xx = x0;
            x0 = x3;
            x3 = Std.int( xx );
            sx = -sx;
            xb = -xb;             // swap legs
            yy = y0;
            y0 = y3;
            y3 = Std.int( yy );
            sy = -sy;
            yb = -yb;
            x1 = x2;
        } while ( leg-- != 0 );                                          // try other end
        plotLine( pixels, x0, y0, x3, y3, col, alpha );       // remaining part in case of cusp or crunode
    }

    // Fully ported
    // plot any cubic Bezier curve
    public inline static function plotCubicBezier(  pixels:     IPixels
                                                ,   x0: Int,    y0: Int
                                                ,   x1: Int,    y1: Int
                                                ,   x2: Int,    y2: Int
                                                ,   x3: Int,    y3: Int
                                                ,   col: Int,   alpha: Int ){
        var n: Int = 0;
        var i: Int = 0;
        var xc: Float = x0 + x1 - x2 - x3;
        var xa: Float = xc - 4*( x1 - x2 );
        var xb: Float = x0 - x1 - x2 + x3;
        var xd: Float = xb + 4*( x1 + x2 );
        var yc: Float = y0 + y1 - y2 - y3;
        var ya: Float = yc - 4*( y1 - y2 );
        var yb: Float = y0 - y1 - y2 + y3;
        var yd: Float = yb + 4*( y1 + y2 );
        var fx0: Float = x0;
        var fx1: Float;
        var fx2: Float;
        var fx3: Float;
        var fy0: Float = y0;
        var fy1: Float;
        var fy2: Float;
        var fy3: Float;
        var t1: Float = xb*xb - xa*xc;
        var t2: Float;
        /// What!!! /////
        var t = new haxe.ds.Vector(5);
        // sub-divide curve at gradient sign changes
        if( xa == 0 ){                                               // horizontal
            if( Math.abs( xc ) < 2*Math.abs( xb ) ) t[ n++ ] = xc/( 2.0*xb );            // one change
        } else if( t1 > 0.0 ){                                      // two changes
            t2 = Math.sqrt( t1 );
            t1 = ( xb - t2 )/xa;
            if( Math.abs( t1 ) < 1.0 ) t[n++] = t1;
            t1 = ( xb + t2 )/xa;
            if( Math.abs( t1 ) < 1.0) t[n++] = t1;
        }
        t1 = yb*yb - ya*yc;
        if( ya == 0 ){                                                 // vertical
            if( Math.abs( yc ) < 2*Math.abs( yb ) ) t[n++] = yc/(2.0*yb);            // one change
        } else if( t1 > 0.0 ) {                                      // two changes
            t2 = Math.sqrt( t1 );
            t1 = ( yb - t2 )/ya;
            if( Math.abs( t1 ) < 1.0 ) t[n++] = t1;
            t1 = ( yb + t2 )/ya;
            if( Math.abs( t1 ) < 1.0) t[n++] = t1;
        }

        for( i in 1...n )  {                       // bubble sort of 4 points
            if( ( t1 = t[ i - 1 ]) > t[ i ]) {
                t[ i - 1 ] = t[ i ];
                t[ i ] = t1;
                ////i = 0;  !!!!!
            }
        }
        t1 = -1.0;
        t[ n ] = 1.0;                                // begin / end point
        for( i in 0...(n + 1) ){                 // plot each segment separately
            t2 = t[i];                                // sub-divide at t[i-1], t[i]
            fx1 = ( t1*( t1*xb - 2*xc ) - t2*( t1*( t1*xa - 2*xb ) + xc ) + xd )/8 - fx0;
            fy1 = ( t1*( t1*yb - 2*yc ) - t2*( t1*( t1*ya - 2*yb ) + yc ) + yd )/8 - fy0;
            fx2 = ( t2*( t2*xb - 2*xc ) - t1*( t2*( t2*xa - 2*xb ) + xc ) + xd )/8 - fx0;
            fy2 = ( t2*( t2*yb - 2*yc ) - t1*( t2*( t2*ya - 2*yb ) + yc ) + yd )/8 - fy0;
            fx0 -= fx3 = ( t2*( t2*( 3*xb - t2*xa ) - 3*xc ) + xd )/8;
            fy0 -= fy3 = ( t2*( t2*( 3*yb - t2*ya ) - 3*yc ) + yd )/8;
            x3 = Math.floor( fx3 + 0.5 );
            y3 = Math.floor( fy3 + 0.5 );        // scale bounds to int
            if( fx0 != 0.0 ){
                fx1 *= fx0 = ( x0 - x3 )/fx0;
                fx2 *= fx0;
            }
            if( fy0 != 0.0 ){
                fy1 *= fy0 = ( y0 - y3 )/fy0;
                fy2 *= fy0;
            }
            if( x0 != x3 || y0 != y3 ){                            // segment t1 - t2
                plotCubicBezierSeg( pixels, x0,y0, x0 + fx1, y0 + fy1, x0 + fx2, y0 + fy2, x3, y3, col, alpha );
            }
            x0 = x3;
            y0 = y3;
            fx0 = fx3;
            fy0 = fy3;
            t1 = t2;
        }
    }

    // draw a black (0) anti-aliased line on white (255) background
    public static function plotLineAA( pixels:   Pixels
                                            , x0: Int,  y0: Int
                                            , x1: Int,  y1: Int
                                            , col: Int, alpha: Int ){
        var sx: Int = ( x0 < x1 )? 1 : -1;
        var sy: Int = ( y0 < y1 )? 1 : -1;
        var x2: Int;
        var dx: Float = Math.abs( x1 - x0 );
        var dy: Float = Math.abs( y1 - y0 );
        var err: Float = dx*dx + dy*dy;
        var num: Float = 0xffff7f / Math.sqrt( err );
        var e2: Float = if( err == 0 ){ 1; } else { num; };     // multiplication factor
        // NOT sure what to do here! //
        dx *= e2;
        dy *= e2;
        err = dx - dy;                       // error value e_xy
        var count = 0;
        while( true ){
            if( count == 5000 ) return;//safety                           // pixel loop
            setPixelAA( pixels, x0, y0, Std.int( Math.abs( err - dx + dy ) ) >> 16, col, alpha );
            e2 = err;
            x2 = x0;
            if( 2*e2 >= -dx ){                                            // x step
                if( x0 == x1 ) break;
                var ed = Std.int( e2 + dy ) >> 16;
                if( (e2 + dy) < 0xff0000 ) setPixelAA( pixels, x0, y0 + sy, ed, col, alpha );
                err -= dy;
                x0 += sx;
            }
            if( 2*e2 <= dy ) {                                             // y step
                if( y0 == y1 ) break;
                var ed = Std.int( dx - e2 ) >> 16;
                if( dx - e2 < 0xff0000 ) setPixelAA( pixels, x2 + sx, y0, ed, col, alpha );
                err += dx;
                y0 += sy;
                count++;
            }
        }
    }

    // Issue porting, not sure what to do with setPixelAA
    // draw a black anti-aliased circle on white background
    public inline static function plotCircleAA( pixels:     IPixels
                                            ,   xm: Int,    ym: Int
                                            ,   r: Int
                                            ,   col: Int,   alpha: Int ){
        var x: Int = -r;
        var y: Int = 0;           // II. quadrant from bottom left to top right
        var i: Int;
        var x2: Int;
        var e2: Int;
        var err: Int = 2 - 2*r;                             // error of 1.step
        r = 1-err;
        do {
            i = Std.int( 255*Math.abs( err - 2*( x + y ) - 2 )/r );               // get blend value of pixel
            setPixelAA( pixels, xm - x, ym + y, i, col, alpha );                             //   I. Quadrant
            setPixelAA( pixels, xm - y, ym - x, i, col, alpha );                             //  II. Quadrant
            setPixelAA( pixels, xm + x, ym - y, i, col, alpha );                             // III. Quadrant
            setPixelAA( pixels, xm + y, ym + x, i, col, alpha );                             //  IV. Quadrant
            e2 = err;
            x2 = x;                                    // remember values
            if( err + y > 0 ){                                              // x step
                i = Std.int( 255*( err - 2*x - 1 )/r );                              // outward pixel
                if( i < 256 ) {
                    setPixelAA( pixels, xm - x, ym + y + 1, i, col, alpha );
                    setPixelAA( pixels, xm - y - 1, ym - x, i, col, alpha );
                    setPixelAA( pixels, xm + x, ym - y - 1, i, col, alpha );
                    setPixelAA( pixels, xm + y + 1, ym + x, i, col, alpha );
                }
                err += ++x*2 + 1;
            }
            if( e2 + x2 <= 0 ) {                                             // y step
                i = Std.int( 255*( 2*y + 3 - e2 )/r );                                // inward pixel
                if(i < 256 ){
                    setPixelAA( pixels, xm - x2 - 1, ym + y, i, col, alpha );
                    setPixelAA( pixels, xm - y, ym - x2 - 1, i, col, alpha );
                    setPixelAA( pixels, xm + x2 + 1, ym - y, i, col, alpha );
                    setPixelAA( pixels, xm + y, ym + x2 + 1, i, col, alpha );
                }
                err += ++y*2+1;
            }
        } while ( x < 0 );
    }

    // Issues porting, b&1 is this ok?
    // draw a black anti-aliased rectangular ellipse on white background
    public static inline function plotEllipseRectAA( pixels:     IPixels
                                                ,   x0: Int,    y0: Int
                                                ,   x1: Int,    y1: Int
                                                ,   col: Int,   alpha: Int ){
        var a: Float = Math.abs( x1 - x0 );
        var b: Float = Math.abs( y1 - y0 );
        var b1: Float = Std.int( b )&1;                 // diameter
        var dx: Float = 4*( a - 1.0 )*b*b;
        var dy: Float = 4*( b1 + 1 )*a*a;            // error increment
        var ed: Float;
        var i: Float;
        var err: Float = b1*a*a - dx + dy;                        // error of 1.step
        var f: Bool;

        if( a == 0 || b == 0 ) return plotLine( pixels, x0, y0, x1, y1, col, alpha );
        if( x0 > x1 ){ // if called with swapped points
            x0 = x1;
            x1 += Std.int( a );
        }
        if( y0 > y1 ) y0 = y1;                      // .. exchange them
        y0 += Std.int(( b + 1 )/2);
        y1 = Std.int( y0 - b1 );                               // starting pixel
        a = 8*a*a;
        b1 = 8*b*b;
        while( true ){                             // approximate ed = sqrt( dx*dx + dy*dy )
            i = Math.min( dx, dy );
            ed = Math.max( dx, dy );
            if( y0 == y1 + 1 && err > dy && a > b1 ){
                ed = 255*4./a;           // x-tip
            } else {
                ed = 255/( ed + 2*ed*i*i/( 4*ed*ed + i*i ));             // approximation
            }
            i = ed*Math.abs( err + dx - dy );           // get intensity value by pixel error
            setPixelAA( pixels, x0, y0, i, col, alpha );
            setPixelAA( pixels, x0, y1, i, col, alpha );
            setPixelAA( pixels, x1, y0, i, col, alpha );
            setPixelAA( pixels, x1, y1, i, col, alpha );

            if( f = 2*err+dy >= 0 ){                  // x step, remember condition
                if( x0 >= x1 ) break;
                i = ed*( err + dx );
                if( i < 255 ) {
                    setPixelAA( pixels, x0, y0 + 1, i, col, alpha );
                    setPixelAA( pixels, x0, y1 - 1, i, col, alpha );
                    setPixelAA( pixels, x1, y0 + 1, i, col, alpha );
                    setPixelAA( pixels, x1, y1 - 1, i, col, alpha );
                }          // do error increment later since values are still needed
            }
            if( 2*err <= dx ){                                            // y step
                i = ed*(dy-err);
                if( i < 255 ){
                    setPixelAA( pixels, x0 + 1, y0, i, col, alpha );
                    setPixelAA( pixels, x1 - 1 , y0, i, col, alpha );
                    setPixelAA( pixels, x0 + 1, y1, i, col, alpha );
                    setPixelAA( pixels, x1 - 1, y1, i, col, alpha );
                }
                y0++;
                y1--;
                err += dy += a;
            }
            if(f){
                x0++;
                x1--;
                err -= dx -= b1;
            }            // x error increment
        }
        if( --x0 == x1++ ){                       // too early stop of flat ellipses
            while( y0 - y1 < b ){
                i = 255*4*Math.abs( err + dx )/b1;               // -> finish tip of ellipse
                setPixelAA( pixels, x0, ++y0, i, col, alpha );
                setPixelAA( pixels, x1, y0, i, col, alpha );
                setPixelAA( pixels, x0,--y1, i, col, alpha );
                setPixelAA( pixels, x1, y1, i, col, alpha );
                err += dy += a;
            }
        }
    }

    // Fully ported, untested
    // draw an limited anti-aliased quadratic Bezier segment
    public static function plotQuadBezierSegAA(  pixels:     IPixels
                                                    ,   x0: Int,    y0: Int
                                                    ,   x1: Int,    y1: Int
                                                    ,   x2: Int,    y2: Int
                                                    ,   col: Int,   alpha: Int ){
        var sx: Int = x2 - x1;
        var sy: Int = y2 - y1;
        var xx: Float = x0 - x1;
        var yy: Float = y0 - y1;
        var xy: Float;                      // relative values for checks
        var dx: Float;
        var dy: Float;
        var err: Float;
        var ed: Float;
        var cur: Float = xx*sy - yy*sx;     // curvature

        if( xx*sx <= 0 && yy*sy <= 0 ){} else { trace( 'Failed to plotQuadBezierSegAA' ); return; }      // sign of gradient must not change

        if( sx*sx + sy*sy > xx*xx + yy*yy ){     // begin with longer part
            x2 = x0;
            x0 = sx + x1;
            y2 = y0;
            y0 = sy + y1;
            cur = -cur;     // swap P0 P2
        }
        if( cur != 0 ){                                  // no straight line
            xx += sx;
            xx *= sx = ( x0 < x2 )? 1 : -1;              // x step direction
            yy += sy;
            yy *= sy = ( y0 < y2 )? 1 : -1;              // y step direction
            xy = 2*xx*yy;
            xx *= xx;
            yy *= yy;                                     // differences 2nd degree
            if( cur*sx*sy < 0 ){                          // negated curvature?
                xx = -xx;
                yy = -yy;
                xy = -xy;
                cur = -cur;
            }
            dx = 4.0*sy*( x1 - x0 )*cur + xx - xy;        // differences 1st degree
            dy = 4.0*sx*( y0 - y1 )*cur + yy - xy;
            xx += xx;
            yy += yy;
            err = dx + dy + xy;                                                 // error 1st step
            do {
                cur = Math.min( dx + xy, -xy -dy );
                ed = Math.max( dx + xy,-xy -dy );                               // approximate error distance
                ed += 2*ed*cur*cur/( 4*ed*ed + cur*cur );
                setPixelAA( pixels, x0, y0, 255*Math.abs( err - dx - dy - xy )/ed, col, alpha );    // plot curve
                if( x0 == x2 || y0 == y2 ) break;                               // last pixel -> curve finished
                x1 = x0;
                cur = dx - err;
                y1 = ( 2*err + dy < 0 )? 1: 0;
                if( 2*err + dx > 0 ) { // x step
                    if( err - dy < ed ){
                        setPixelAA( pixels, x0, y0 + sy, 255*Math.abs( err - dy )/ed, col, alpha );
                    }
                    x0 += sx;
                    dx -= xy;
                    err += dy += yy;
                }
                if( y1 == 1 ){ // y step
                    if( cur < ed ) setPixelAA( pixels, x1 + sx, y0, 255*Math.abs( cur )/ed, col, alpha );
                    y0 += sy;
                    dy -= xy;
                    err += dx += xx;
                }
            } while( dy < dx );                          // gradient negates -> close curves
        }
        plotLineAA( pixels, x0, y0, x2, y2, col, alpha ); // plot remaining needle to end
    }

    // draw an anti-aliased rational quadratic Bezier segment, squared weight
    public inline static function plotQuadRationalBezierSegAA(  pixels:     IPixels
                                                            ,   x0: Int,    y0: Int
                                                            ,   x1: Int,    y1: Int
                                                            ,   x2: Int,    y2: Int
                                                            ,   w: Float
                                                            ,   col: Int,   alpha: Int ){
        var sx: Int = x2 - x1;
        var sy: Int = y2 - y1;                  // relative values for checks
        var dx: Float = x0 - x2;
        var dy: Float = y0 - y2;
        var xx: Float = x0 - x1;
        var yy: Float = y0 - y1;
        var xy: Float = xx*sy + yy*sx;
        var cur: Float = xx*sy - yy*sx;
        var err: Float;
        var ed: Float;          // curvature
        var f: Bool;

        if( xx*sx <= 0.0 && yy*sy <= 0.0 ){} else { trace( 'Failed to plotQuadRationalBeizierSegAA'); return; };  // sign of gradient must not change

        if( cur != 0.0 && w > 0.0 ){                           // no straight line
            if( sx*sx + sy*sy > xx*xx + yy*yy ){  // begin with longer part
                x2 = x0;
                x0 -= Std.int( dx );
                y2 = y0;
                y0 -= Std.int( dy );
                cur = -cur;      // swap P0 P2
            }
            xx = 2.0*( 4.0*w*sx*xx + dx*dx );                 // differences 2nd degree
            yy = 2.0*( 4.0*w*sy*yy + dy*dy );
            sx = ( x0 < x2 )? 1 : -1;                              // x step direction
            sy = ( y0 < y2 )? 1 : -1;                              // y step direction
            xy = -2.0*sx*sy*( 2.0*w*xy + dx*dy );

            if( cur*sx*sy < 0) {                              // negated curvature?
                xx = -xx;
                yy = -yy;
                cur = -cur;
                xy = -xy;
            }
            dx = 4.0*w*( x1 - x0 )*sy*cur + xx/2.0 + xy;          // differences 1st degree
            dy = 4.0*w*( y0 - y1 )*sx*cur + yy/2.0 + xy;

            if( w < 0.5 && dy > dx ){              // flat ellipse, algorithm fails
                cur = ( w + 1.0)/2.0;
                w = Math.sqrt( w );
                xy = 1.0/( w + 1.0 );
                sx = Math.floor( ( x0 + 2.0*w*x1 + x2 )*xy/2.0 + 0.5 ); // subdivide curve in half
                sy = Math.floor( ( y0 + 2.0*w*y1 + y2 )*xy/2.0 + 0.5 );
                dx = Math.floor( ( w*x1 + x0 )*xy + 0.5 );
                dy = Math.floor( ( y1*w + y0 )*xy + 0.5 );
                plotQuadRationalBezierSegAA( pixels, x0, y0, Std.int( dx ), Std.int( dy ), sx, sy, cur, col, alpha ); // plot apart
                dx = Math.floor( ( w*x1 + x2 )*xy + 0.5);
                dy = Math.floor( ( y1*w + y2 )*xy + 0.5);
                return plotQuadRationalBezierSegAA( pixels, sx, sy, Std.int( dx ), Std.int( dy ), x2, y2, cur, col, alpha );
            }
            err = dx + dy - xy;                                       // error 1st step
            do {                                                      // pixel loop
                cur = Math.min( dx - xy, xy - dy );
                ed =  Math.max( dx - xy, xy - dy );
                ed += 2*ed*cur*cur/( 4.*ed*ed + cur*cur ); // approximate error distance
                x1 = Std.int( 255*Math.abs( err - dx - dy + xy )/ed );    // get blend value by pixel error
                if( x1 < 256 ) setPixelAA( pixels, x0, y0, x1, col, alpha );                   // plot curve
                if( f = 2*err + dy < 0 ){                                    // y step
                    if( y0 == y2 ) return;             // last pixel -> curve finished
                    if( dx - err < ed ){
                        setPixelAA( pixels, x0 + sx, y0, 255*Math.abs( dx - err )/ed, col, alpha );
                    }
                }
                if( 2*err + dx > 0) {                                        // x step
                    if( x0 == x2 ) return;             // last pixel -> curve finished
                    if( err - dy < ed ) setPixelAA( pixels, x0, y0 + sy, 255*Math.abs( err - dy )/ed, col, alpha );
                    x0 += sx;
                    dx += xy;
                    err += dy += yy;
                }
                if( f ){ // y step
                    y0 += sy;
                    dy += xy;
                    err += dx += xx;
                }
            } while( dy < dx );               // gradient negates -> algorithm fails
        }
        plotLineAA( pixels, x0, y0, x2, y2, col, alpha );                  // plot remaining needle to end
    }

    // plot limited anti-aliased cubic Bezier segment
    public inline static function plotCubicBezierSegAA( pixels:     IPixels
                                                    ,   x0: Int,    y0: Int
                                                    ,   x1: Float,  y1: Float
                                                    ,   x2: Float,  y2: Float
                                                    ,   x3: Float,  y3: Float
                                                    ,   col: Int,   alpha: Int ){
        var f: Int;
        var fx: Int;
        var fy: Int;
        var leg: Int = 1;
        var sx: Int = ( x0 < x3 )? 1 : -1;
        var sy: Int = ( y0 < y3 )? 1 : -1;        // step direction
        var xc: Float = -Math.abs( x0 + x1 - x2 - x3 );
        var xa: Float = xc - 4*sx*( x1 - x2 );
        var xb: Float = sx*( x0 - x1 - x2 + x3 );
        var yc: Float = -Math.abs( y0 + y1 - y2 - y3 );
        var ya: Float = yc - 4*sy*( y1 - y2 );
        var yb: Float = sy*( y0 - y1 - y2 + y3 );
        var ab: Float;
        var ac: Float;
        var bc: Float;
        var ba: Float;
        var xx: Float;
        var xy: Float;
        var yy: Float;
        var dx: Float;
        var dy: Float;
        var ex: Float;
        var px: Float;
        var py: Float;
        var ed: Float;
        var ip: Float;
        var EP: Float = 0.01;

        // check for curve restrains
        // slope P0-P1 == P2-P3     and  (P0-P3 == P1-P2      or  no slope change)
        if( ( x1 - x0 )*( x2 - x3 ) < EP && ( ( x3 - x0 )*( x1 - x2 ) < EP || xb*xb < xa*xc + EP ) ) {} else { trace('Failed to plotCubicBezierSegAA' ); return; }
        if( ( y1 - y0 )*( y2 - y3 ) < EP && ( ( y3 - y0 )*( y1 - y2 ) < EP || yb*yb < ya*yc + EP ) ) {} else { trace('Failed to plotCubicBezierSegAA' ); return; }

        if( xa == 0 && ya == 0 ) {                              // quadratic Bezier
            sx = Math.floor( ( 3*x1 - x0 + 1 )/2 );
            sy = Math.floor( ( 3*y1 - y0 + 1 )/2 );   // new midpoint
            return plotQuadBezierSegAA( pixels, x0, y0, Std.int( sx ), Std.int( sy ), Std.int( x3 ), Std.int( y3 ), col, alpha );
        }
        x1 = ( x1 - x0 )*( x1 - x0 ) + ( y1 - y0 )*( y1 - y0 ) + 1;                     //line lengths
        x2 = ( x2 - x3 )*( x2 - x3 ) + ( y2 - y3 )*( y2 - y3 ) + 1;
        do {                                                // loop over both ends
            ab = xa*yb - xb*ya;
            ac = xa*yc - xc*ya;
            bc = xb*yc - xc*yb;
            ip = 4*ab*bc - ac*ac;                   // self intersection loop at all?
            ex = ab*( ab + ac - 3*bc ) + ac*ac;       // P0 part of self-intersection loop?
            f = ( ex > 0 )? 1 : Std.int( Math.sqrt( 1 + 1024/x1 ) );               // calculate resolution
            ab *= f;
            ac *= f;
            bc *= f;
            ex *= f*f;            // increase resolution
            xy = 9*( ab + ac + bc )/8;
            ba = 8*( xa - ya );  // init differences of 1st degree
            dx = 27*( 8*ab*( yb*yb - ya*yc ) + ex*( ya + 2*yb + yc ))/64 - ya*ya*( xy - ya );
            dy = 27*( 8*ab*( xb*xb - xa*xc ) - ex*( xa + 2*xb + xc ))/64 - xa*xa*( xy + xa );
            // init differences of 2nd degree
            xx = 3*( 3*ab*( 3*yb*yb - ya*ya - 2*ya*yc ) - ya*( 3*ac*( ya + yb ) + ya*ba ) )/4;
            yy = 3*( 3*ab*( 3*xb*xb - xa*xa - 2*xa*xc ) - xa*( 3*ac*( xa + xb ) + xa*ba ) )/4;
            xy = xa*ya*( 6*ab + 6*ac - 3*bc + ba );
            ac = ya*ya;
            ba = xa*xa;
            xy = 3*( xy + 9*f*( ba*yb*yc - xb*xc*ac ) - 18*xb*yb*ab )/8;

            if( ex < 0 ){         // negate values if inside self-intersection loop
                dx = -dx;
                dy = -dy;
                xx = -xx;
                yy = -yy;
                xy = -xy;
                ac = -ac;
                ba = -ba;
            }                                     // init differences of 3rd degree
            ab = 6*ya*ac;
            ac = -6*xa*ac;
            bc = 6*ya*ba;
            ba = -6*xa*ba;
            dx += xy;
            ex = dx + dy;
            dy += xy;                    // error of 1st step

            fx = fy = f;
            while( x0 != x3 && y0 != y3 ) {
                y1 = Math.min( Math.abs( xy - dx ), Math.abs( dy - xy ) );
                ed = Math.max( Math.abs( xy - dx ), Math.abs( dy - xy ) );    // approximate error distance
                ed = f*( ed + 2*ed*y1*y1/( 4*ed*ed + y1*y1 ) );
                y1 = 255*Math.abs( ex - ( f - fx + 1 )*dx - ( f - fy + 1 )*dy + f*xy )/ed;
                if( y1 < 256 ) setPixelAA( pixels, x0, y0, y1, col, alpha );                  // plot curve
                px = Math.abs( ex - ( f - fx + 1 )*dx + ( fy - 1 )*dy );       // pixel intensity x move
                py = Math.abs( ex + ( fx - 1 )*dx - ( f - fy + 1 )*dy );       // pixel intensity y move
                y2 = y0;
                do {                                  // move sub-steps of one pixel
                    if( ip >= -EP )               // intersection possible? -> check..
                        if( dx + xx > xy || dy + yy < xy) return;   // two x or y steps
                    y1 = 2*ex+dx;                    // save value for test of y step
                    if( 2*ex + dy > 0 ) {                                  // x sub-step
                        fx--;
                        ex += dx += xx;
                        dy += xy += ac;
                        yy += bc;
                        xx += ab;
                    } else if ( y1 > 0 ) return;                 // tiny nearly cusp
                    if (y1 <= 0) {                                      // y sub-step
                        fy--;
                        ex += dy += yy;
                        dx += xy += bc;
                        xx += ac;
                        yy += ba;
                    }
                } while( fx > 0 && fy > 0 );                       // pixel complete?

                if( 2*fy <= f ) {                           // x+ anti-aliasing pixel
                    if( py < ed ) setPixelAA( pixels, Std.int( x0 + sx ), y0, 255*py/ed, col, alpha );      // plot curve
                    y0 += sy;
                    fy += f;                                      // y step
                }
                if( 2*fx <= f ) {                           // y+ anti-aliasing pixel
                    if( px < ed ) setPixelAA( pixels, x0, Std.int( y2 + sy ), 255*px/ed, col, alpha );      // plot curve
                    x0 += sx; fx += f;                                      // x step
                }
            }
            //////  !!!????
            //break;                                          // finish curve by line
            if( 2*ex < dy && 2*fy <= f + 2 ) {         // round x+ approximation pixel
                if( py < ed ) setPixelAA( pixels, x0 + sx, y0, 255*py/ed, col, alpha );         // plot curve
                y0 += sy;
            }
            if( 2*ex > dx && 2*fx <= f + 2 ) {         // round y+ approximation pixel
                if( px < ed ) setPixelAA( pixels, x0, Std.int( y2 + sy ), 255*px/ed, col, alpha );         // plot curve
                x0 += sx;
            }
            xx = x0;
            x0 = Std.int( x3 );
            x3 = xx;
            sx = -sx;
            xb = -xb;             // swap legs
            yy = y0;
            y0 = Std.int( y3 );
            y3 = yy;
            sy = -sy;
            yb = -yb;
            x1 = x2;
        } while( leg-- != 0 );                                          // try other end
        plotLineAA( pixels, x0, y0, Std.int( x3 ), Std.int( y3 ), col, alpha );     // remaining part in case of cusp or crunode
    }

    // plot an anti-aliased line of width wd
    public inline static function plotLineWidth(    pixels: IPixels
                                                ,   x0: Int, y0: Int
                                                ,   x1: Int, y1: Int
                                                ,   wd: Float
                                                ,   col: Int, alpha: Int ){
        var dx: Int = Std.int( Math.abs( x1 - x0 ) );
        var sx: Int = ( x0 < x1 )? 1 : -1;
        var dy: Int = Std.int( Math.abs( y1 - y0 ) );
        var sy: Int = ( y0 < y1 )? 1 : -1;
        var err: Int = dx - dy;
        var e2: Int;
        var x2: Int;
        var y2: Int;                           // error value e_xy
        var ed: Float = ( dx + dy == 0 )? 1 : Math.sqrt( dx*dx + dy*dy );
        wd = (wd+1)/2;
        while( true ) {                                    // pixel loop
            pixels.setPixelColorAndAlpha( x0, y0, col, Std.int( Math.max( 0, 255*( Math.abs( err - dx + dy )/ed - wd + 1 ) )) );
            e2 = err;
            x2 = x0;
            if( 2*e2 >= -dx ){ // x step
                e2 += dy;
                y2 = y0;
                while( (e2 < ed*wd) && ((y1 != y2) || (dx > dy)) ){
                    pixels.setPixelColorAndAlpha( x0, y2 += sy,col, Std.int( Math.max(0,255*(Math.abs(e2)/ed-wd+1)) ));
                    e2 += dx;
                }
                if( x0 == x1 ) break;
                e2 = err;
                err -= dy;
                x0 += sx;
            }
            if( 2*e2 <= dy ){ // y step
                e2 = dx-e2;
                while( ( e2 < ed*wd ) && ( (x1 != x2) || (dx < dy)) ){
                    pixels.setPixelColorAndAlpha( x2 += sx, y0, col, Std.int( Math.max(0,255*(Math.abs(e2)/ed-wd+1)) ));
                    e2 += dy;
                }
                if( y0 == y1 ) break;
                err += dx;
                y0 += sy;
            }
        }
    }
//
    public inline static function plotQuadSpline( pixels: IPixels
                                                , n: Int
                                                , x: Array<Int>,    y: Array<Int>
                                                , col: Int,         alpha: Int ){                         // plot quadratic spline, destroys input arrays x,y
        var M_MAX: Int = 6;
        var mi: Float = 1;
        var m = new haxe.ds.Vector(6);          //m[ M_MAX ];                    // diagonal constants of matrix
        var i: Int;
        var x0: Int;
        var y0: Int;
        var x1: Int;
        var y1: Int;
        var x2: Int = x[ n ];
        var y2: Int = y[ n ];

        if( n > 1 ) {} else { trace( 'Failed to plotQuadSpline' ); return; }                        // need at least 3 points P[0]..P[n]

        x[ 1 ] = x0 = 8*x[ 1 ] - 2*x[ 0 ];                          // first row of matrix
        y[ 1 ] = y0 = 8*y[ 1 ] - 2*y[ 0 ];

        for( i in 2...n ) {                                 // forward sweep
            if( i - 2 < M_MAX ) {
                m[ i - 2 ] = mi = 1.0/( 6.0 - mi );
            }
            x[ i ] = x0 = Math.floor( 8*x[ i ] - x0*mi + 0.5 );                        // store yi
            y[ i ] = y0 = Math.floor( 8*y[ i ] - y0*mi + 0.5 );
        }
        x1 = Math.floor( ( x0 - 2*x2 )/( 5.0 - mi ) + 0.5);                 // correction last row
        y1 = Math.floor( ( y0 - 2*y2 )/( 5.0 - mi ) + 0.5 );
        /// SWAP OUT !!! ///
        var ii: Int;
        for( i in 0...n-2 ){ //= n-2; i > 0; i--) {                           // back substitution
            ii = ( n - 2 ) - i;
            if (ii <= M_MAX) mi = m[ ii - 1 ];
            x0 = Math.floor( (x[ ii ] - x1 )*mi + 0.5 );                            // next corner
            y0 = Math.floor( (y[ ii ] - y1 )*mi + 0.5 );
            plotQuadBezier( pixels, Std.int(( x0 + x1 )/2), Std.int(( y0 + y1 )/2), x1, y1, x2, y2, col, alpha );
            x2 = Std.int( ( x0 + x1 )/2 );
            x1 = x0;
            y2 = Std.int( ( y0 + y1 )/2 );
            y1 = y0;
        }
        plotQuadBezier( pixels, x[ 0 ], y[ 0 ], x1, y1, x2, y2, col, alpha );
    }

    // plot cubic spline, destroys input arrays x,y
    public inline static function plotCubicSpline(  pixels:         IPixels
                                                ,   n: Int
                                                ,   x: Array<Int>,  y: Array<Int>
                                                ,   col: Int,       alpha: Int ) {
        var M_MAX: Int = 6;
        var mi: Float = 0.25;
        var m = new haxe.ds.Vector(6);                 // diagonal constants of matrix
        var x3: Int = x[ n - 1 ];
        var y3: Int = y[ n - 1 ];
        var x4: Int = x[ n ];
        var y4: Int = y[ n ];
        var i: Int;
        var x0: Int;
        var y0: Int;
        var x1: Int;
        var y1: Int;
        var x2: Int;
        var y2: Int;
        // !!!!!
        if( n > 2 ){} else { trace( 'Failed to plotCubicSpline' ); return; }                        // need at least 4 points P[0]..P[n]

        x[ 1 ] = x0 = 12*x[ 1 ] - 3*x[ 0 ];                         // first row of matrix
        y[ 1 ] = y0 = 12*y[ 1 ] - 3*y[ 0 ];

        for( i in 2...n ){                                // foreward sweep
            if( i - 2 < M_MAX ) m[ i - 2 ] = mi = 0.25/( 2.0 - mi );
            x[ i ] = x0 = Math.floor( 12*x[ i ] - 2*x0*mi + 0.5 );
            y[ i ] = y0 = Math.floor( 12*y[ i ] - 2*y0*mi + 0.5 );
        }
        x2 = Math.floor( ( x0 - 3*x4 )/( 7 - 4*mi ) + 0.5 );                    // correct last row
        y2 = Math.floor( ( y0 - 3*y4 )/( 7 - 4*mi ) + 0.5 );
        plotCubicBezier( pixels, x3, y3, Std.int( ( x2 + x4 )/2 ), Std.int( ( y2 + y4 )/2 ), x4, y4, x4, y4, col, alpha );

        if( n-3 < M_MAX ) mi = m[ n - 3 ];
        x1 = Math.floor( ( x[ n - 2 ] - 2*x2 )*mi + 0.5 );
        y1 = Math.floor( ( y[ n - 2 ] - 2*y2 )*mi + 0.5 );
        var ii: Int;
        for( i in 0...n-3 ) {                           // back substitution
            ii = n-3 - i;
            if( ii <= M_MAX ) mi = m[ ii - 1 ];
            x0 = Math.floor( ( x[ ii ] - 2*x1 )*mi + 0.5 );
            y0 = Math.floor( ( y[ ii ] - 2*y1 )*mi + 0.5 );
            x4 = Math.floor( ( x0 + 4*x1 + x2 + 3 )/6.0);                     // reconstruct P[i]
            y4 = Math.floor( ( y0 + 4*y1 + y2 + 3 )/6.0);
            plotCubicBezier( pixels, x4, y4,
                      Math.floor( ( 2*x1 + x2 )/3 + 0.5 ), Math.floor( ( 2*y1 + y2 )/3 + 0.5 ),
                      Math.floor( ( x1 + 2*x2 )/3 + 0.5 ), Math.floor(( y1 + 2*y2 )/3 + 0.5 ),
                      x3, y3, col, alpha );
            x3 = x4;
            y3 = y4;
            x2 = x1;
            y2 = y1;
            x1 = x0;
            y1 = y0;
        }
        x0 = x[ 0 ];
        x4 = Math.floor( ( 3*x0 + 7*x1 + 2*x2 + 6 )/12.0 );        // reconstruct P[1]
        y0 = y[ 0 ];
        y4 = Math.floor( ( 3*y0 + 7*y1 + 2*y2 +6 )/12.0 );
        plotCubicBezier(    pixels, x4, y4
                        ,   Math.floor( ( 2*x1 + x2 )/3 + 0.5), Math.floor( ( 2*y1 + y2 )/3 + 0.5 )
                        ,   Math.floor( ( x1 + 2*x2 )/3 + 0.5), Math.floor( ( y1 + 2*y2 )/3 + 0.5 )
                        ,   x3, y3, col, alpha );
        plotCubicBezier( pixels, x0, y0, x0, y0, Std.int( ( x0 + x1 )/2 ), Std.int( ( y0 + y1 )/2 ), x4, y4, col, alpha );
    }

}
