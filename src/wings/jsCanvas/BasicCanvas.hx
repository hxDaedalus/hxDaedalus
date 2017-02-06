package wings.jsCanvas;

import js.Browser;
import js.html.Element;
import js.html.CSSStyleDeclaration;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.Element;
import js.html.BodyElement;
import js.html.ImageElement;

@:expose
class BasicCanvas
{
    public var surface: CanvasRenderingContext2D;
    public var dom: Element;
    public var image: ImageElement;
    public var canvas: CanvasElement;
    public var style: CSSStyleDeclaration;
    public var body: Element;
    public var onEnterFrame: Void -> Void;
    public var header: CanvasHeader;

    public function new() {
        canvas = Browser.document.createCanvasElement();
        dom = cast canvas;
        body = Browser.document.body;
        surface = canvas.getContext2d();
        style = dom.style;
        header = new CanvasHeader();
        canvas.width = header.width;
        canvas.height = header.height;
        style.paddingLeft = "0px";
        style.paddingTop = "0px";
        style.left = Std.string( 0 + 'px' );
        style.top = Std.string( 0 + 'px' );
        style.position = "absolute";
		style.backgroundColor = header.bgColor;
		surface.fillStyle = header.bgColor;
        image = cast dom;
        var s = Browser.document.createStyleElement();
        s.innerHTML = "@keyframes spin { from { transform:rotate( 0deg ); } to { transform:rotate( 360deg ); } }";
        Browser.document.getElementsByTagName("head")[0].appendChild( s );
        (cast s).animation = "spin 1s linear infinite";
        loop( header.frameRate );
        var body = Browser.document.body;
        body.appendChild( dom );
    }

    private function loop( tim: Float ):Bool
    {
        Browser.window.requestAnimationFrame( loop );
        if( onEnterFrame != null ) onEnterFrame();
        return true;
    }

    public function clear():Void {
		surface.clearRect ( 0, 0
        , header.width
        , header.height );
    }

    public function drawCircle( x: Float, y: Float, radius: Float ):Void {
        surface.beginPath();
        surface.arc( x, y, radius, 0, 2*Math.PI, false );
        surface.stroke();
        surface.closePath();
    }

	public function drawRect(x:Float, y:Float, width:Float, height:Float)
	{
        surface.beginPath();
        surface.moveTo( x, y );
		surface.lineTo(x + width, y);
		surface.lineTo(x + width, y + height);
		surface.lineTo(x, y + height);
        surface.stroke();
        surface.closePath();
	}

    public function drawTri( points: Array<Float> ){
        surface.beginPath();
        var i = 0;
        while( i < points.length ){
			if( i == 0 ){
				surface.moveTo( points[ i ], points[ i + 1 ] );
			} else {
				surface.lineTo( points[ i ], points[ i + 1 ] );
			}
			i+=2;
		}
        surface.stroke();
        surface.closePath();
    }

    public function lineStyle( wid: Float, col: Int, ?alpha: Float )
    {
        surface.lineWidth = wid;
		if( alpha != null && alpha != 1.0 )
		{
			var r = (col >> 16) & 0xFF;
			var g = (col >> 8) & 0xFF;
			var b = (col) & 0xFF;
			surface.strokeStyle = 'rgba($r,$g,$b,$alpha)';
		}else {
        	surface.strokeStyle = '#' + StringTools.hex( col, 6 );
		}
    }

	public function moveTo(x : Float, y : Float){
		surface.beginPath();
		surface.moveTo(x, y);
	}

	public function lineTo(x : Float, y : Float){
		surface.lineTo(x, y);
		surface.closePath();
		surface.stroke();
	}

    public function quadTo(cx:Float, cy:Float, ax: Float, ay: Float):Void {
		surface.quadraticCurveTo(cx, cy, ax, ay);
		surface.stroke();
	}

    public function beginFill( col: Int, ?alpha:Float ){
		if( alpha != null && alpha != 1.0 ){
			var r = (col >> 16) & 0xFF;
			var g = (col >> 8) & 0xFF;
			var b = (col) & 0xFF;
			surface.fillStyle = 'rgba($r,$g,$b,$alpha)';
		} else {
			surface.fillStyle = '#' + StringTools.hex( col, 6 );
		}

        surface.beginPath();
    }

    public function endFill():Void {
        surface.stroke();
        surface.closePath();
        surface.fill();
    }
}
