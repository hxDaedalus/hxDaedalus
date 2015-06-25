package hxDaedalus.graphics.pixel;
import hxDaedalus.graphics.Pixels;
import hxDaedalus.graphics.pixel.PixelShapeEnum;
class BasicPixel {

	//public var header: CanvasHeader;
	public var pixelShapes: Array<PixelShapeEnum> = new Array<PixelShapeEnum>();
	public var pixels: Pixels;
	public function new( ?wid: Int = 1024, ?hi: Int = 768 ){
		pixels = new Pixels( wid, hi, true );
	}

	public function createCircle( x: Float, y: Float, r: Float, line: Int, ?lineAlpha: Float = 1, ?fill: Int = -1, ?fillAlpha: Float = 1, w: Float = 1 ): PixelShapeEnum {
		var circle = new PixelCircle( pixels, x, y, r );
		if( fill != -1 ) circle.fill( fill, fillAlpha );
		circle.plot( line, lineAlpha, width );
		return PixelShapeEnum( circle );
	}

	public function createRect( x: Float, y: Float, wid: Float, hi: Float, line: Int, ?lineAlpha: Float = 1, ?fill: Int = -1, ?fillAlpha: Float = 1, w: Float = 1 ): PixelShapeEnum {
		var rect = new PixelRectangle( pixels, x, y, wid, hi );
		if( fill != -1 ) rect.fill( fill, fillAlpha );
		rect.plot( line, lineAlpha, width );
		return PixelShapeEnum( rect );
	}

	public function createTri(  pointsArr:Array<Float>, line: Int, ?lineAlpha: Float = 1, ?fill: Int = -1, ?fillAlpha: Float = 1, w: Float = 1 ):PixelShapeEnum {
		var aTri = new PixelTriangle( pixels, pointsArr );
		if( fill != -1 ) aTri.fill( fill, fillAlpha );
		aTri.plot( line, lineAlpha );
		return PixelShapeEnum( aTri );
	}

	public function changeFill( element: PixelShapeEnum, col: Int ):Void {
		switch( PixelShape ){
			case PixelCircle( circle ):
				circle.fill( col, 1 );
			case PixelRect( rect ):
				rect.fill( col, 1 );
			case PixelTriangel( tri ):
				tri.fill( col, 1 );
			case _:
				//
		}
	}

	public function createText( x: Float, y: Float, str: String, size: Float ): PixelShapeEnum {
		// trace text not implemented!
		return PixelShapeEnum( null );
	}

	public function createLine( x1: Float, y1: Float, x2: Float, y2: Float, color: Int, w: Float, ?alpha: Float = 1 ):PixelShapeEnum {
		var aLine = new PixelLine( x1, y1, x2, y2 );
		aLine.plot( color, alpha, w );
		return PixelShapeEnum( aLine );
	}

	public function add( element: PixelShapeEnum ):Void {
		pixelShapes.push( element );
	}

	public function remove( element: PixelShapeEnum ): Void {
		pixelShapes.remove( element );
	}

	public function clear(){
		while( pixelShapes.length != 0 ){
			remove( pixelShapes.pop() );
		}
	}

	public function repaint(){
		for( all in pixelShapes ) {
			// Not implemented
			//pixelShapes.render();
		}
	}
}
