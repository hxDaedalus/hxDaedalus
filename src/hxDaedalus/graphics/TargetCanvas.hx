package hxDaedalus.graphics;

#if flambe
typedef TargetCanvas = hxDaedalus.graphics.flambe.GraphicsComponent;
#elseif (flash || openfl || nme)
typedef TargetCanvas = flash.display.Graphics;
#elseif luxe
typedef TargetCanvas = Array<phoenix.geometry.Geometry>;
#elseif svg
typedef TargetCanvas = hxDaedalus.svg.BasicSvg;
#elseif js
typedef TargetCanvas = hxDaedalus.canvas.BasicCanvas;
#elseif java
typedef TargetCanvas = hxDaedalus.swing.BasicSwing;
#end
