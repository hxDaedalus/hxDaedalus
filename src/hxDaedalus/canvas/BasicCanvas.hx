package hxDaedalus.canvas;

import js.Browser;
import js.html.Element;
import js.html.CSSStyleDeclaration;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.Element;
import js.html.BodyElement;
import js.html.ImageElement;

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
        surface.fill();
    }
    public function lineStyle( wid: Float, col: Int )
    {
        surface.lineWidth = wid;
        surface.strokeStyle = '#' + StringTools.hex( col, 6 );
    }
    
    
    public function beginFill( col: Int ){
        surface.fillStyle = '#' + StringTools.hex( col, 6 );
        surface.beginPath();
    }
    
    public function endDraw():Void {
        surface.stroke();
        surface.closePath();
        surface.fill();
    }
}