package wings.jsCanvas;

import js.html.Uint8ClampedArray;
import js.html.CanvasRenderingContext2D;

@:expose
class CanvasPixelMatrix{

	var data: Uint8ClampedArray;

	public var width: Int;
	public var height: Int;
	public var lookup: Array<Array<Int>>;

	public static function createCanvasPixelMatrixFromContext( context: CanvasRenderingContext2D, w_: Int, h_: Int )
	{
		var imageData = context.getImageData( 0, 0, w_, h_);
		var dataIn: Uint8ClampedArray = imageData.data;
		return new CanvasPixelMatrix( dataIn, w_, h_ );
	}

	public function new( data_: Uint8ClampedArray, w_: Int, h_: Int ){
		data = data_;
		width = w_;
		height = h_;
		lookup = [];
		var count = 0;
		for( i in  0...height )
		{
			lookup[i] = [];
			for( j in 0...width )
			{
				//count++;
				lookup[i][j] = Std.int( count*4 ) ;
				count++;

			}

		}
	}
	// argb
	public function getPixel32(w_:Int, h_:Int):Int{
		var offset = lookup[h_][w_];
		// a | r | g | b
		return ( data[ offset + 3 ] << 24 ) | ( data[ offset + 0 ] << 16 ) | ( data[ offset + 1 ] << 8 ) | ( data[ offset + 2 ] );
	}

	public function setPixel32( w_:Int, h_:Int, value: Int ){
		var offset = lookup[h_][w_];
		data[ offset + 3 ] = (value >> 24) & 0xFF;	// a
		data[ offset ] = (value >> 16) & 0xFF;		// r
		data[ offset + 1 ] = (value >> 8) & 0xFF;	// g
		data[ offset + 2 ] = (value) & 0xFF;		// b
	}
	public function setPixel( w_: Int, h_: Int, value: Int ){
		var offset = lookup[h_][w_];
		data[ offset ] = (value >> 16) & 0xFF;		// r
		data[ offset + 1 ] = (value >> 8) & 0xFF;	// g
		data[ offset + 2 ] = (value) & 0xFF;		// b
	}
	public function getPixel( w_:Int, h_: Int ):Int{
		var offset = lookup[h_][w_];
		// r | g | b
		return ( data[ offset + 0 ] << 16 ) | ( data[ offset + 1 ] << 8 ) | ( data[ offset + 2 ] );
	}

}
