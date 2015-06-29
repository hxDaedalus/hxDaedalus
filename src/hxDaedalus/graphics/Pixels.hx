package hxDaedalus.graphics;

import haxe.io.Bytes;


/**
 * Class abstracting pixels for various libs/targets (for easier manipulation).
 *
 * The exposed get/set methods will transparently work in ARGB format, while
 * the underlying bytes' pixel format will be automatically inferenced when one
 * of the `from_` methods is called.
 *
 * You can still override the channel mapping by setting `format` afterwards.
 *
 * NOTE: One important thing to keep in mind is that, on some targets/libs, a
 * pixel with an alpha value of zero doesn't necessarily mean that RGB will be
 * zero too (f.e. openfl with neko/cpp targets). This means that instead of
 * relying blindly on RGB values you should - in such cases - first test the
 * alpha one.
 *
 * @author azrafe7
 */
@:forward
abstract Pixels(PixelsData)
{
	static inline var CHANNEL_MASK:Int = 3;

	/**
	 * Constructor. If `alloc` is false no memory will be allocated for `bytes`,
	 * but the other properties (width, height, count) will still be set.
	 */
	inline public function new(width:Int, height:Int, alloc:Bool = true)
	{
		this = new PixelsData(width, height, alloc);
	}

	/** Returns the byte value at `i` position, as if the data were in ARGB format. */
	@:arrayAccess
	inline public function getByte(i:Int) {
		return this.bytes.get((i & ~CHANNEL_MASK) + this.format.channelMap[i & CHANNEL_MASK]);
	}

	/** Returns the pixel value (without alpha) at `x`,`y`, as if the data were in ARGB format. */
	public function getPixel(x:Int, y:Int):Pixel {
		var pos = (y * this.width + x) << 2;

		var r = this.bytes.get(pos + this.format.R) << 16;
		var g = this.bytes.get(pos + this.format.G) << 8;
		var b = this.bytes.get(pos + this.format.B);

		return cast (r | g | b);
	}

	/** Returns the pixel value (with alpha) at `x`,`y`, as if the data were in ARGB format. */
	public function getPixel32(x:Int, y:Int):Pixel {
		var pos = (y * this.width + x) << 2;

		var a = this.bytes.get(pos + this.format.A) << 24;
		var r = this.bytes.get(pos + this.format.R) << 16;
		var g = this.bytes.get(pos + this.format.G) << 8;
		var b = this.bytes.get(pos + this.format.B);

		return cast (a | r | g | b);
	}

	/** Sets the byte value at `i` pos, as if the data were in ARGB format. */
	@:arrayAccess
	inline public function setByte(i:Int, value:Int) {
		this.bytes.set((i & ~CHANNEL_MASK) + this.format.channelMap[i & CHANNEL_MASK], value);
	}

	/** Sets the pixel value (without alpha) at `x`,`y`, with `value` expressed in RGB format. */
	public function setPixel(x:Int, y:Int, value:Int) {
		var pos = (y * this.width + x) << 2;

		var r = (value >> 16) & 0xFF;
		var g = (value >> 8) & 0xFF;
		var b = (value) & 0xFF;

		this.bytes.set(pos + this.format.R, r);
		this.bytes.set(pos + this.format.G, g);
		this.bytes.set(pos + this.format.B, b);
	}

	/** Sets the pixel value (with alpha) at `x`,`y`, with `value` expressed in ARGB format. */
	public function setPixel32(x:Int, y:Int, value:Int) {
		var pos = (y * this.width + x) << 2;

		var a = (value >> 24) & 0xFF;
		var r = (value >> 16) & 0xFF;
		var g = (value >> 8) & 0xFF;
		var b = (value) & 0xFF;

		this.bytes.set((pos + this.format.A), a);
		this.bytes.set((pos + this.format.R), r);
		this.bytes.set((pos + this.format.G), g);
		this.bytes.set((pos + this.format.B), b);
	}

	public function setPixelColorAndAlpha( x: Int, y: Int, col: Int, alpha: Int ) {
		var pos = (y * this.width + x) << 2;

		var a = alpha;
		var r = (col >> 16) & 0xFF;
		var g = (col >> 8) & 0xFF;
		var b = (col) & 0xFF;

		this.bytes.set((pos + this.format.A), a);
		this.bytes.set((pos + this.format.R), r);
		this.bytes.set((pos + this.format.G), g);
		this.bytes.set((pos + this.format.B), b);

	}

		/** Fills the specified rect area, with `value` expressed in ARGB format. Doesn't do any bound checking. */
		public function fillRectColorAndPixel( x: Int, y: Int, wid: Int, hi: Int, col: Int, alpha: Int ):Void {
			var pos = (y * this.width + x) << 2;

			var stridePixels = new Pixels( wid, 1, true);
			stridePixels.format = this.format;
			var stride = wid << 2;

			for (x in 0...wid) stridePixels.setPixelColorAndAlpha(x, 0, col, alpha );
			for (y in 0...hi) {
				this.bytes.blit(pos, stridePixels.bytes, 0, stride);
				pos += this.width << 2;
			}
		}

	/** Fills the specified rect area, with `value` expressed in ARGB format. Doesn't do any bound checking. */
	public function fillRect(x:Int, y:Int, width:Int, height:Int, value:Int):Void {
		var pos = (y * this.width + x) << 2;

		var stridePixels = new Pixels(width, 1, true);
		stridePixels.format = this.format;
		var stride = width << 2;

		for (x in 0...width) stridePixels.setPixel32(x, 0, value);
		for (y in 0...height) {
			this.bytes.blit(pos, stridePixels.bytes, 0, stride);
			pos += this.width << 2;
		}
	}

	public function clone():Pixels {
		var clone:Pixels = new Pixels(this.width, this.height, true);
		clone.bytes.blit(0, this.bytes, 0, this.bytes.length);
		clone.format = this.format;
		return clone;
	}

	static public function fromBytes(bytes:Bytes, width:Int, height:Int, ?format:PixelFormat):Pixels {
		var pixels = new Pixels(width, height, false);
		if (format == null) format = PixelFormat.ARGB;
		trace( 'pixels ' + pixels );
		pixels.bytes = bytes;
		return pixels;
	}

	inline public function convertTo(format:PixelFormat):Pixels {
		return convert(cast this, format, true);
	}
	static public function convert(pixels:Pixels, toFormat:PixelFormat, inPlace:Bool = false):Pixels {
		var res = inPlace ? pixels : pixels.clone();
		if (toFormat == pixels.format) return res;
		var i = 0;
		while (i < pixels.count) {
			var pos = i << 2;
			var a = pixels.getByte(pos + 0);
			var r = pixels.getByte(pos + 1);
			var g = pixels.getByte(pos + 2);
			var b = pixels.getByte(pos + 3);
			res.bytes.set(pos + toFormat.A, a);
			res.bytes.set(pos + toFormat.R, r);
			res.bytes.set(pos + toFormat.G, g);
			res.bytes.set(pos + toFormat.B, b);
			i++;
		}
		res.format = toFormat;
		return res;
	}
#if (format) // convert from png, bmp and gif data using `HaxeFoundation/format` lib (underlying bytes in BGRA format)
	@:from static public function fromPNGData(data:format.png.Data) {
		var header = format.png.Tools.getHeader(data);
		var bytes = format.png.Tools.extract32(data);
		var pixels = new Pixels(header.width, header.height, false);
		pixels.bytes = bytes;
		trace( 'pixels ' + pixels );
		pixels.format = PixelFormat.BGRA;
		return pixels;
	}
	@:from static public function fromBMPData(data:format.bmp.Data) {
		var pixels = new Pixels(data.header.width, data.header.height, true);
		for (i in 0...pixels.count) {
			var srcPos = i * 3;
			var dstPos = i * 4;
			pixels.bytes.blit(dstPos, data.pixels, srcPos, 3);
			pixels.bytes.set(dstPos + 3, 0xFF); // alpha
		}
		pixels.format = PixelFormat.BGRA;
		return pixels;
	}
	static public function fromGIFData(data:format.gif.Data, frameIndex:Int = 0, full:Bool = true) {
		var pixels:Pixels;
		if (full) {
			pixels = new Pixels(data.logicalScreenDescriptor.width, data.logicalScreenDescriptor.height, false);
		    pixels.bytes = format.gif.Tools.extractFullBGRA(data, frameIndex);
		} else {
			var frame = format.gif.Tools.frame(data, frameIndex);
			pixels = new Pixels(frame.width, frame.height, false);
			pixels.bytes = format.gif.Tools.extractBGRA(data, frameIndex);
		}
		pixels.format = PixelFormat.BGRA;
		return pixels;
	}
#end

#if (flambe) // in flambe texture bytes are in RGBA format

	@:from static public function fromFlambeTexture(texture:flambe.display.Texture) {
		var pixels = new Pixels(texture.width, texture.height, true);
		pixels.format = PixelFormat.RGBA;

		var data = texture.readPixels(0, 0, texture.width, texture.height);
		pixels.bytes.blit(0, data, 0, data.length);

		return pixels;
	}

	#if (flambe && html) // not possible in (flambe && flash) due to Stage3D limitations
	public function applyToFlambeTexture(texture:flambe.display.Texture) {
		texture.writePixels(this.bytes, 0, 0, this.width, this.height);
	}
	#end

#end

#if (snow || luxe) // in snow/luxe texture bytes are in RGBA format (and must account for padded sizes when submitting)

	@:from static public function fromLuxeTexture(texture:phoenix.Texture) {
		var pixels = new Pixels(texture.width, texture.height, false);
		pixels.format = PixelFormat.RGBA;

		var data = new snow.api.buffers.Uint8Array(texture.width * texture.height * 4);
		texture.fetch(data);
		pixels.bytes = data.toBytes();

		return pixels;
	}

	@:from static public function fromLuxeAssetImage(assetImage:snow.types.Types.AssetImage) {
		var image:snow.types.Types.ImageInfo = assetImage.image;
		var pixels = new Pixels(image.width, image.height, true);
		pixels.format = PixelFormat.RGBA;

		var data = image.pixels.toBytes();
		var stride = image.width * 4;

		for (y in 0...image.height) {
			pixels.bytes.blit(y * stride, data, y * image.width_actual * 4, stride);
		}

		return pixels;
	}

	public function applyToLuxeTexture(texture:phoenix.Texture) {
		var data = Bytes.alloc(texture.width_actual * texture.height_actual * 4);

		var padded_width = texture.width_actual;
		var stride = this.width * 4;

		for (y in 0...this.height) {
			data.blit(y * padded_width * 4, this.bytes, y * stride, stride);
		}

		texture.submit(snow.api.buffers.Uint8Array.fromBytes(data));  // rebind texture
	}
#end

#if (flash || openfl || nme || (flambe && flash))

	@:from static public function fromBitmapData(bmd:flash.display.BitmapData) {
	#if js

		var pixels = new Pixels(bmd.width, bmd.height, false);
		pixels.format = PixelFormat.RGBA;

		// force buffer creation
		var image = @:privateAccess bmd.__image;
		lime.graphics.utils.ImageCanvasUtil.convertToCanvas(image);
		lime.graphics.utils.ImageCanvasUtil.createImageData(image);

		var data = @:privateAccess bmd.__image.buffer.data;
		pixels.bytes = Bytes.ofData(data.buffer);

	#else

		var pixels = new Pixels(bmd.width, bmd.height, false);
		pixels.format = PixelFormat.ARGB;

		var ba = bmd.getPixels(bmd.rect);

		#if flash
			pixels.bytes = Bytes.ofData(ba);
		#else
			pixels.bytes = Bytes.ofData(ba.getData());
		#end

	#end

		return pixels;
	}

	public function applyToBitmapData(bmd:flash.display.BitmapData) {
	#if js

		var image = @:privateAccess bmd.__image;

		if (@:privateAccess image.buffer.__srcImageData == null) { // NOTE: find a way to speed this up
			for (y in 0...this.height) {
				for (x in 0...this.width) {
					bmd.setPixel32(x, y, getPixel32(x, y));
				}
			}
		} else {
			image.dirty = true;
			lime.graphics.utils.ImageCanvasUtil.sync(image);
		}

	#else

		#if flash
			var ba = this.bytes.getData();
			ba.endian = flash.utils.Endian.BIG_ENDIAN;
		#else
			var ba = openfl.utils.ByteArray.fromBytes(this.bytes);
		#end

		ba.position = 0;
		bmd.setPixels(bmd.rect, ba);

	#end
	}

#end

#if java

	@:from static public function fromBufferedImage(image:java.awt.image.BufferedImage) {
		var pixels = new Pixels(image.getWidth(), image.getHeight(), true);
		pixels.format = PixelFormat.RGBA;

		var buffer = new java.NativeArray<Int>(pixels.bytes.length);
		buffer = image.getRaster().getPixels(0, 0, pixels.width, pixels.height, buffer);

		for (i in 0...buffer.length) pixels.bytes.set(i, buffer[i]);

		return pixels;
	}

	public function applyToBufferedImage(image:java.awt.image.BufferedImage) {
		var buffer = new java.NativeArray<Int>(this.bytes.length);
		for (i in 0...buffer.length) buffer[i] = this.bytes.get(i);

		image.getRaster().setPixels(0, 0, this.width, this.height, buffer);
	}

#end

#if js	// plain js - conversion from ImageData

	@:from static public function fromImageData(image:js.html.ImageData) {
		var pixels = new Pixels(image.width, image.height, true);
		pixels.format = PixelFormat.ARGB;

		var data = image.data;

		for (i in 0...data.byteLength) {
			pixels.bytes.set(i, data[i]);
		}

		return pixels;
	}

#end
}


@:allow(hxPixels.Pixels)
private class PixelsData
{
	inline static public var BYTES_PER_PIXEL:Int = 4;

	/** Total number of pixels. */
	public var count(default, default):Int;

	/** Bytes representing the pixels (in `format` pixel format). */
	public var bytes(default, default):Bytes;

	/** Width of the source image. */
	public var width(default, default):Int;

	/** Height of the source image. */
	public var height(default, default):Int;

	/** Internal pixel format. */
	public var format:PixelFormat;

	/**
	 * Constructor. If `alloc` is false no memory will be allocated for `bytes`,
	 * but the other properties (width, height, count) will still be set.
	 *
	 * `format` defaults to ARGB.
	 */
	public function new(width:Int, height:Int, alloc:Bool = true, format:PixelFormat = null)
	{
		this.count = width * height;

		if (alloc) bytes = Bytes.alloc(this.count << 2);

		this.width = width;
		this.height = height;
		this.format = format != null ? format : PixelFormat.ARGB;
	}
}

class PixelFormat {

	static public var ARGB(default, null):PixelFormat;
	static public var RGBA(default, null):PixelFormat;
	static public var BGRA(default, null):PixelFormat;

	public var channelMap(default, null):Array<Channel>;

	var name:String;

	static function __init__():Void {
		ARGB = new PixelFormat(CH_0, CH_1, CH_2, CH_3, "ARGB");
		RGBA = new PixelFormat(CH_3, CH_0, CH_1, CH_2, "RGBA");
		BGRA = new PixelFormat(CH_3, CH_2, CH_1, CH_0, "BGRA");
	}

	public function new(a:Channel, r:Channel, g:Channel, b:Channel, name:String = "PixelFormat"):Void {
		this.channelMap = [a, r, g, b];
		this.name = name;
	}

	public var A(get, null):Int;
	inline private function get_A():Int {
		return channelMap[0];
	}

	public var R(get, null):Int;
	inline private function get_R():Int {
		return channelMap[1];
	}

	public var G(get, null):Int;
	inline private function get_G():Int {
		return channelMap[2];
	}

	public var B(get, null):Int;
	inline private function get_B():Int {
		return channelMap[3];
	}

	public function toString():String {
		return name;
	}
}

@:enum abstract Channel(Int) to Int {
	var CH_0 = 0;
	var CH_1 = 1;
	var CH_2 = 2;
	var CH_3 = 3;

	@:op(A + B) static function add(a:Int, b:Channel):Int;
}

/**
 * Abstracts an ARGB pixel over Int.
 *
 * NOTE: it's just a convenience class to easily access ARGB channels' values (wrapping bit math).
 * Since it's built on top of a primitive (value) type, be careful with what you expect when
 * assigning to it. In particular consider that:
 *
 *   `pixels.getPixel32(10, 10).R = 0xFF;`
 *
 * will NOT modify the actual pixel (but just an Int copy/representation of it!)
 *
 * What you really want is probably:
 *
 *   `var pixel = pixels.getPixel32(10, 10);
 *    pixel.R = 0xFF;
 *    pixels.setPixel32(10, 10, pixel);`
 *
 */
@:forward
abstract Pixel(Int) from Int to Int
{
	public var A(get, set):Int;
	inline private function get_A():Int {
		return (this >> 24) & 0xFF;
	}
	inline private function set_A(a:Int):Int {
		a = a & 0xFF;
		this = (this & 0x00FFFFFF) | (a << 24);
		return a;
	}

	public var R(get, set):Int;
	inline private function get_R():Int {
		return (this >> 16) & 0xFF;
	}
	inline private function set_R(r:Int):Int {
		r = r & 0xFF;
		this = (this & 0xFF00FFFF) | (r << 16);
		return r;
	}

	public var G(get, set):Int;
	inline private function get_G():Int {
		return (this >> 8) & 0xFF;
	}
	inline private function set_G(g:Int):Int {
		g = g & 0xFF;
		this = (this & 0xFFFF00FF) | (g << 8);
		return g;
	}

	public var B(get, set):Int;
	inline private function get_B():Int {
		return this & 0xFF;
	}
	inline private function set_B(b:Int):Int {
		b = b & 0xFF;
		this = (this & 0xFFFFFF00) | b;
		return b;
	}
}
