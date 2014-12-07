package;

import hxDaedalus.ai.EntityAI;
import hxDaedalus.ai.PathFinder;
import hxDaedalus.ai.trajectory.LinearPathSampler;
import hxDaedalus.data.Mesh;
import hxDaedalus.data.Object;
import hxDaedalus.factories.BitmapObject;
import hxDaedalus.factories.RectMesh;
import graphics.SimpleView;
import graphics.swing.BasicSwing;
import graphics.swing.SimpleDrawingContext;

import haxe.Timer;

import java.awt.Graphics2D;
import java.javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import javax.swing.ImageIcon;
import javax.swing.JLabel;
import java.awt.event.*;


class BitmapPathfindingJava extends BasicSwing {

	var mouseX:Float;
	var mouseY:Float;
	
	var _mesh:  Mesh;
	var _view:  SimpleView;
	var _entityAI: EntityAI;
	var _pathfinder:PathFinder;
	var _path: Array<Float>;
	var _pathSampler: LinearPathSampler;
	var _object: Object;
	var _bmp:BufferedImage;
	var _overlay: BufferedImage;

    var _newPath:Bool = false;

	public static function main(): Void {
		new BitmapPathfindingJava();
	}

	public function new() {
		super();
		
		// build a rectangular 2 polygons mesh
		_mesh = RectMesh.buildRectangle( 1024, 780 );
		
		// load images
		try {
			_bmp = ImageIO.read(new java.io.File("../assets/galapagosBW.png"));
			_overlay = ImageIO.read(new java.io.File("../assets/galapagosColor.png"));
		} catch (e:Dynamic) {
			throw e;
		}
		
		// show the source bmp
		getContentPane().add(new JLabel(new ImageIcon(_bmp)));
		
		// show the image bmp
		add(new JLabel(new ImageIcon(_overlay)));

		_view = new SimpleView(new SimpleDrawingContext(this));
		surface.paintFunction = paintFunction;
		
		// create an object from bitmap
		_object = BitmapObject.buildFromBmpData( _bmp, 1.8 );
		_object.x = 0;
		_object.y = 0;
		var s = haxe.Timer.stamp();
		_mesh.insertObject( _object );
		//trace("meshInsert: " + (haxe.Timer.stamp() - s));
		
		// display result mesh
		
		// draw the mesh
		//_view.drawMesh( _mesh );
		
		// stamp it on the overlay bitmap
		//_overlay.bitmapData.draw(_view.surface);
		
		// hide vertices, edges and contraints (so they don't have to be redrawn every frame)
		//_view.vertices.visible = false;
		//_view.edges.visible = false;
		//_view.constraints.visible = false;
		
		// we need an entity
		_entityAI = new EntityAI();
		
		// set radius size for your entity
		_entityAI.radius = 4;
		
		// set a position
		_entityAI.x = 50;
		_entityAI.y = 50;
		mouseX = Std.int(_entityAI.x);
		mouseY = Std.int(_entityAI.y);
		
		// show entity on screen
		//_view.drawEntity( _entityAI );
		
		// now configure the pathfinder
		_pathfinder = new PathFinder();
		_pathfinder.entity = _entityAI; // set the entity
		_pathfinder.mesh = _mesh; // set the mesh
		
		// we need a vector to store the path
		_path = new Array<Float>();
		
		// then configure the path sampler
		_pathSampler = new LinearPathSampler();
		_pathSampler.entity = _entityAI;
		_pathSampler.samplingDistance = 10;
		_pathSampler.path = _path;

        var timer = new Timer( Math.floor( 1000/30 ) );
        timer.run = _onEnterFrame;
    }
    
    function _onEnterFrame():Void {
		
        surface.repaint();
    }
    
    function paintFunction( g: Graphics2D ):Void {
        var graphics:SimpleDrawingContext = cast _view.graphics;
		graphics.refreshGraphics2D( g );
		
		g.drawImage(_overlay, null, 0, 0);
        _view.drawMesh( _mesh );
        
		if ( _newPath ) {
			// find path !
            _pathfinder.findPath( mouseX, mouseY, _path );
            
			// show path on screen
            _view.drawPath( _path );
            
			// reset the path sampler to manage new generated path
            _pathSampler.reset();
        }
        
        // animate !
        if ( _pathSampler.hasNext ) {
			// move entity
            _pathSampler.next();            
            
        }
		// show entity new position on screen
		_view.drawEntity( _entityAI);
    }
	
    override public function mouseReleased(e:MouseEvent) {
		_newPath = false;
    }
    
    override public function mousePressed(e:MouseEvent) {
        _newPath = true;
    }
    
	override public function mouseMoved(e:MouseEvent) {
		mouseX = e.getPoint().getX();
		mouseY = e.getPoint().getY();
	}
	
	override public function keyPressed(e:KeyEvent) {
		if (e.getKeyCode() == KeyEvent.VK_ESCAPE) {
			Sys.exit(1);
		}
 	}
}