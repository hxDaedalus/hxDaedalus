package wings.jsSvg;

import js.Browser;
import js.html.Node;
import js.html.svg.SVGElement;
import js.html.Element;
import js.html.CSSStyleDeclaration;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.Element;
import js.html.BodyElement;
import js.html.ImageElement;
import wings.jsCanvas.CanvasHeader;

@:expose
class BasicSvg {
	public static var svgNameSpace: String = "http://www.w3.org/2000/svg" ;
	public var surface: CanvasRenderingContext2D;
	public var dom: Element;
	public var svgElement: SVGElement;
	public var style: CSSStyleDeclaration;
	public var body: Element;

	@:isVar public var scale(default, set):Float;

	public var header: CanvasHeader;
	public var onEnterFrame: Void -> Void;
	public var svgShapes: Array<SVGElement> = new Array<SVGElement>();

	public function new( ?wid: Int = 1024, ?hi: Int = 768, scale: Float = 1 ){

		var svgElement2 = cast Browser.document.createElementNS( svgNameSpace, 'svg' );
		header = new CanvasHeader();
		svgElement2.setAttribute( "width", Std.string( header.width ) );
		svgElement2.setAttribute( "height", Std.string( header.height ) );
		body = Browser.document.body;
		dom = cast svgElement2;
		style = dom.style;
		style.paddingLeft = "0px";
		style.paddingTop = "0px";
		style.left = Std.string( 0 + 'px' );
		style.top = Std.string( 0 + 'px' );
		style.position = "absolute";
		//style.backgroundColor = header.bgColor;
		svgElement = cast Browser.document.createElementNS( svgNameSpace, 'g' );
		svgElement2.appendChild( svgElement );
		// add hit area the bgColor
		var svgElement3 = createRect( 0, 0, header.width, header.height, 0x000000, 0, 0, 0 );
		svgElement.appendChild( svgElement3 );
		var s = Browser.document.createStyleElement();
		s.innerHTML = "@keyframes spin { from { transform:rotate( 0deg ); } to { transform:rotate( 360deg ); } }";
		Browser.document.getElementsByTagName("head")[0].appendChild( s );
		(cast s).animation = "spin 1s linear infinite";
		loop( header.frameRate );
		body.appendChild( dom );
	}

	public function set_scale( scale_: Float ):Float {
		scale = scale_;
		svgElement.setAttribute( 'transform' , 'scale(' + scale + ')' );
		return scale;
	}

	private function loop( tim: Float ):Bool
	{
		Browser.window.requestAnimationFrame( loop );
		if( onEnterFrame != null ) onEnterFrame();
		return true;
	}

	public function createCircle( x: Float, y: Float, r: Float, line: Int, ?lineAlpha: Float = 1, ?fill: Int = -1, ?fillAlpha: Float = 1, w: Float = 1 ): SVGElement {
		var svgCircle: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'circle' );
		svgCircle.setAttribute( "cx", Std.string( x ) );
		svgCircle.setAttribute( "cy", Std.string( y ) );
		svgCircle.setAttribute( "r", Std.string( r ) );
		if( fill != -1 ) svgCircle.setAttribute( "fill", getColor( fill, fillAlpha ) );
		svgCircle.setAttribute('stroke', getColor( line, lineAlpha ) );
		svgCircle.setAttribute('stroke-width', Std.string( w ) );
		return svgCircle;
	}

	public function createRect( x: Float, y: Float, wid: Float, hi: Float, line: Int, ?lineAlpha: Float = 1, ?fill: Int = -1, ?fillAlpha: Float = 1, w: Float = 1 ): SVGElement {
		var svgRect: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'rect' );
		svgRect.setAttribute( "x", Std.string( x ) );
		svgRect.setAttribute( "y", Std.string( y ) );
		svgRect.setAttribute( "width", Std.string( wid ) );
		svgRect.setAttribute( "height", Std.string( hi ) );
		svgRect.setAttribute( "fill", getColor( fill, fillAlpha ) );
		svgRect.setAttribute('stroke', getColor( line, lineAlpha ) );
		svgRect.setAttribute('stroke-width', Std.string( w ) );
		return svgRect;
	}

	public function createEquilateralTriangle(  x: Float, y: Float, r: Float, direction: Float, line: Int, ?lineAlpha: Float = 1, ?fill: Int = -1, ?fillAlpha: Float = 1, w: Float = 1 ):SVGElement {
		var aTri: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'polygon');
		var third = (Math.PI * 2) / 3;
		var points = '';
		var x1: Float;
		var y1: Float;
		for( i in 0...3 ){
			x1 = x + r * Math.cos( direction + i*third );
			y1 = y + r * Math.sin( direction + i * third );
			points += Std.string( x1 ) + ',' + Std.string( y1 ) + ' ';
		}
		aTri.setAttribute('points', points );
		if( fill != -1 ) aTri.setAttribute( "fill", getColor( fill, fillAlpha ) );
		aTri.setAttribute('stroke', getColor( line, lineAlpha ) );
		aTri.setAttribute('stroke-width', Std.string( w ) );
		return aTri;
	}

	public function createTri(  pointsArr:Array<Float>, line: Int, ?lineAlpha: Float = 1, ?fill: Int = -1, ?fillAlpha: Float = 1, w: Float = 1 ):SVGElement {
		var aTri: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'polygon');
		var points = '';
		var x1: Float;
		var y1: Float;
		var i: Int = 0;
		while( i < pointsArr.length ){
			points += Std.string( pointsArr[i] ) + ',' + Std.string( pointsArr[i+1] ) + ' ';
			i+=2;
		}
		aTri.setAttribute('points', points );
		if( fill != -1 ) aTri.setAttribute( "fill", getColor( fill, fillAlpha ) );
		aTri.setAttribute('stroke', getColor( line, lineAlpha ) );
		aTri.setAttribute('stroke-width', Std.string( w ) );
		return aTri;
	}

	public function changeFill( element: SVGElement, col: Int ):Void {
		element.setAttribute( "fill", getColor( col ) );
	}

	public function createText( x: Float, y: Float, str: String, size: Float ): SVGElement {
		var svgText: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'text' );
		svgText.setAttribute( "x", Std.string( x ) );
		svgText.setAttribute( "y", Std.string( y  ) );
		svgText.setAttribute( "font-size", Std.string( size ) );
		var textNode = cast Browser.document.createTextNode( str );
		svgText.appendChild( textNode );
		return svgText;
	}

	public function createLine( x1: Float, y1: Float, x2: Float, y2: Float, color: Int, w: Float, ?alpha: Float = 1 ):SVGElement {
		var aLine: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'line');
		aLine.setAttribute('x1', Std.string( x1 ) );
		aLine.setAttribute('y1', Std.string(y1) );
		aLine.setAttribute('x2', Std.string(x2) );
		aLine.setAttribute('y2', Std.string(y2) );
		aLine.setAttribute('stroke', getColor( color, alpha ) );
		aLine.setAttribute('stroke-width', Std.string( w ) );
		return aLine;
	}

	public function createPath(  d: String, line: Int, ?lineAlpha: Float = 1, ?fill: Int = -1, ?fillAlpha: Float = 1, w: Float = 1, ?strokeMiterlimit:String = '' ):SVGElement {
		var aPath: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'path' );
		aPath.setAttribute('d', d );
		if ( strokeMiterlimit != '' ) {
		} else {
			aPath.setAttribute(  "stroke-miterlimit", strokeMiterlimit );
		}
		if( fill != -1 ) aPath.setAttribute( "fill", getColor( fill, fillAlpha ) );
		aPath.setAttribute('stroke', getColor( line, lineAlpha ) );
		aPath.setAttribute('stroke-width', Std.string( w ) );
		return aPath;
	}

	public function add( element: SVGElement ):Void {
		var node: Node = cast element;
		svgElement.appendChild( node );
		svgShapes.push( element );
	}

	public function remove( element: SVGElement ): Void {
		if ( !svgElement.hasChildNodes() ) return;
		var node: Node = cast element;
		svgElement.removeChild( element );
	}

	public function clear(){
		while( svgShapes.length != 0 ){
			remove( svgShapes.pop() );
		}
	}

	public function repaint(){
		for( all in svgShapes ) {
			var node: Node = cast all;
			svgElement.appendChild( node );
		}
	}

	public function getColor( col: Int, ?alpha:Float ):String{
		if( alpha != null && alpha != 1.0 ){
			var r = (col >> 16) & 0xFF;
			var g = (col >> 8) & 0xFF;
			var b = (col) & 0xFF;
			 return 'rgba($r,$g,$b,$alpha)';
		} else {
			return '#' + StringTools.hex( col, 6 );
		}
	}
}
