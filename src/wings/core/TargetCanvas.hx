package wings.core;

#if flambe
typedef TargetCanvas = wings.flambe.GraphicsComponent;
#elseif format
typedef TargetCanvas = wings.pixel.BasicPixel;
#elseif (flash || openfl || nme)
typedef TargetCanvas = flash.display.Graphics;
#elseif luxe
typedef TargetCanvas = Array<phoenix.geometry.Geometry>;
#elseif svg
typedef TargetCanvas = wings.jsSvg.BasicSvg;
#elseif js
typedef TargetCanvas = wings.jsCanvas.BasicCanvas;
#elseif java
typedef TargetCanvas = wings.javaSwing.BasicSwing;
#end
