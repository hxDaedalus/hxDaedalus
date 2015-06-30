package wings.javaSwing;

import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.javax.swing.JPanel;

class Surface extends JPanel
{
    public var g: Graphics2D;
    public var paintFunction: Graphics2D -> Void;
    public function new(){ super( true ); }

	@:overload override public function paintComponent( g: Graphics ){
		super.paintComponent( g );
        var g2D: Graphics2D = cast g;
        var rHint = RenderingHints;
        g2D.setRenderingHint( rHint.KEY_ANTIALIASING, rHint.VALUE_ANTIALIAS_ON );
        g2D.setRenderingHint( rHint.KEY_RENDERING, rHint.VALUE_RENDER_QUALITY );
		if (this.paintFunction != null) paintFunction( g2D );
        g2D.dispose();
    }
}
