package wings.pixel;
import wings.pixel.TPixels;
import wings.pixel.PixelShapeEnum;

class BasicPixel {

	//public var header: CanvasHeader;
	public var pixelShapes: Array<PixelShapeEnum> = new Array<PixelShapeEnum>();
	public var pixels: TPixels;
	public function new( ?wid: Int = 1024, ?hi: Int = 768 ){
		pixels = new TPixels( wid, hi, true );
	}

	public function createCircle( x: Float, y: Float, r: Float, line: Int, ?lineAlpha: Float = 1, ?fill: Int = -1, ?fillAlpha: Float = 1, w: Float = 1 ): PixelShapeEnum {
		var circle = new PixelCircle( pixels, x, y, r );
		if( fill != -1 ) circle.fill( fill, fillAlpha );
		circle.plot( line, lineAlpha, w );
		return ECircle( circle );
	}

	public function createRect( x: Float, y: Float, wid: Float, hi: Float, line: Int, ?lineAlpha: Float = 1, ?fill: Int = -1, ?fillAlpha: Float = 1, w: Float = 1 ): PixelShapeEnum {
		var rect = new PixelRectangle( pixels, x, y, wid, hi );
		if( fill != -1 ) rect.fill( fill, fillAlpha );
		rect.plot( line, lineAlpha, w );
		return ERectangle( rect );
	}

	public function createQuadratic( sx: Float, sy: Float, ax: Float, ay: Float, ex: Float, ey: Float, line: Int, ?lineAlpha: Float = 1, w: Float = 1 ): PixelShapeEnum {
		var quadratic = new PixelQuadratic( pixels, sx, sy, ax, ay, ex, ey, w );
		quadratic.plot( line, lineAlpha );
		return EQuadratic( quadratic );
	}

	public function createTri(  pointsArr:Array<Float>, line: Int, ?lineAlpha: Float = 1, ?fill: Int = -1, ?fillAlpha: Float = 1, w: Float = 1 ):PixelShapeEnum {
		var aTri = new PixelTriangle( pixels, pointsArr );
		if( fill != -1 ) aTri.fill( fill, fillAlpha );
		aTri.plot( line, lineAlpha, w );
		return ETriangle( aTri );
	}

	public function changeFill( element: PixelShapeEnum, col: Int ):Void {
		switch( element ){
			case ECircle( circle ):
				circle.fill( col, 1 );
			case ERectangle( rect ):
				rect.fill( col, 1 );
			case ETriangle( tri ):
				tri.fill( col, 1 );
			case _:
				//
		}
	}

	public function createText( x: Float, y: Float, str: String, size: Float ): PixelShapeEnum {
		// trace text not implemented!
		return ENull;
	}

	public function createLine( x1: Float, y1: Float, x2: Float, y2: Float, color: Int, w: Float, ?alpha: Float = 1 ): PixelShapeEnum {
		var aLine = new PixelLine( pixels, x1, y1, x2, y2, w );
		aLine.plot( color, alpha );
		return ELine( aLine );
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
