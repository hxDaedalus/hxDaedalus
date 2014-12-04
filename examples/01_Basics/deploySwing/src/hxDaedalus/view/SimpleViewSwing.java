package hxDaedalus.view;
import haxe.root.*;

@SuppressWarnings(value={"rawtypes", "unchecked"})
public  class SimpleViewSwing extends haxe.lang.HxObject
{
	public    SimpleViewSwing(haxe.lang.EmptyObject empty)
	{
		{
		}
		
	}
	
	
	public    SimpleViewSwing()
	{
		hxDaedalus.view.SimpleViewSwing.__hx_ctor_hxDaedalus_view_SimpleViewSwing(this);
	}
	
	
	public static   void __hx_ctor_hxDaedalus_view_SimpleViewSwing(hxDaedalus.view.SimpleViewSwing __temp_me48)
	{
		{
			__temp_me48.boldStroke = new java.awt.BasicStroke(((float) (2) ));
			__temp_me48.normalStroke = new java.awt.BasicStroke(((float) (1) ));
			__temp_me48.noughtFiveStroke = new java.awt.BasicStroke(((float) (0.5) ));
		}
		
	}
	
	
	public static   java.lang.Object __hx_createEmpty()
	{
		return new hxDaedalus.view.SimpleViewSwing(((haxe.lang.EmptyObject) (haxe.lang.EmptyObject.EMPTY) ));
	}
	
	
	public static   java.lang.Object __hx_create(haxe.root.Array arr)
	{
		return new hxDaedalus.view.SimpleViewSwing();
	}
	
	
	public  java.awt.BasicStroke noughtFiveStroke;
	
	public  java.awt.BasicStroke normalStroke;
	
	public  java.awt.BasicStroke boldStroke;
	
	public  hxDaedalus.data.Mesh mesh;
	
	public   void drawMesh(java.awt.Graphics2D g, hxDaedalus.data.Mesh mesh_)
	{
		if (( mesh_ != null )) 
		{
			this.mesh = mesh_;
		}
		
		g.setPaint(((java.awt.Paint) (new java.awt.Color(((int) (16711680) ))) ));
		g.setStroke(((java.awt.Stroke) (this.noughtFiveStroke) ));
		int __temp_stmt213 = 0;
		{
			double x = this.mesh.get_width();
			__temp_stmt213 = ((int) (x) );
		}
		
		int __temp_stmt214 = 0;
		{
			double x1 = this.mesh.get_height();
			__temp_stmt214 = ((int) (x1) );
		}
		
		g.drawRect(((int) (0) ), ((int) (0) ), ((int) (__temp_stmt213) ), ((int) (__temp_stmt214) ));
		hxDaedalus.data.Vertex vertex = null;
		hxDaedalus.data.Edge incomingEdge = null;
		hxDaedalus.data.Face holdingFace = null;
		hxDaedalus.iterators.FromMeshToVertices iterVertices = null;
		iterVertices = new hxDaedalus.iterators.FromMeshToVertices();
		iterVertices.set_fromMesh(this.mesh);
		hxDaedalus.iterators.FromVertexToIncomingEdges iterEdges = null;
		iterEdges = new hxDaedalus.iterators.FromVertexToIncomingEdges();
		haxe.ds.ObjectMap<hxDaedalus.data.Vertex, java.lang.Object> dictVerticesDone = new haxe.ds.ObjectMap<hxDaedalus.data.Vertex, java.lang.Object>();
		java.awt.geom.GeneralPath gpath = null;
		while (( (vertex = iterVertices.next()) != null ))
		{
			{
				dictVerticesDone.set(vertex, true);
				boolean __temp_expr215 = true;
			}
			
			if ( ! (this.vertexIsInsideAABB(vertex, this.mesh)) ) 
			{
				continue;
			}
			
			g.setPaint(((java.awt.Paint) (new java.awt.Color(((int) (255) ))) ));
			g.fillOval(((int) (( vertex.get_pos().x - 0.5 )) ), ((int) (( vertex.get_pos().y - 0.5 )) ), ((int) (1) ), ((int) (1) ));
			iterEdges.set_fromVertex(vertex);
			while (( (incomingEdge = iterEdges.next()) != null ))
			{
				java.lang.Object __temp_stmt216 = null;
				{
					hxDaedalus.data.Vertex key = incomingEdge.get_originVertex();
					__temp_stmt216 = dictVerticesDone.get(key);
				}
				
				if (( ! (haxe.lang.Runtime.toBool(__temp_stmt216)) )) 
				{
					if (incomingEdge.get_isConstrained()) 
					{
						g.setPaint(((java.awt.Paint) (new java.awt.Color(((int) (16711680) ))) ));
						g.setStroke(((java.awt.Stroke) (this.boldStroke) ));
						gpath = new java.awt.geom.GeneralPath();
						gpath.moveTo(((double) (incomingEdge.get_originVertex().get_pos().x) ), ((double) (incomingEdge.get_originVertex().get_pos().y) ));
						gpath.lineTo(((double) (incomingEdge.get_destinationVertex().get_pos().x) ), ((double) (incomingEdge.get_destinationVertex().get_pos().y) ));
						g.draw(((java.awt.Shape) (gpath) ));
					}
					 else 
					{
						g.setPaint(((java.awt.Paint) (new java.awt.Color(((int) (10066329) ))) ));
						g.setStroke(((java.awt.Stroke) (this.noughtFiveStroke) ));
						gpath = new java.awt.geom.GeneralPath();
						gpath.moveTo(((double) (incomingEdge.get_originVertex().get_pos().x) ), ((double) (incomingEdge.get_originVertex().get_pos().y) ));
						gpath.lineTo(((double) (incomingEdge.get_destinationVertex().get_pos().x) ), ((double) (incomingEdge.get_destinationVertex().get_pos().y) ));
						g.draw(((java.awt.Shape) (gpath) ));
					}
					
				}
				
			}
			
		}
		
	}
	
	
	public   void drawEntity(java.awt.Graphics2D g, hxDaedalus.ai.EntityAI entity)
	{
		g.setPaint(((java.awt.Paint) (new java.awt.Color(((int) (65280) ))) ));
		g.setStroke(((java.awt.Stroke) (this.noughtFiveStroke) ));
		double r = entity.get_radius();
		double r2 = ( r * 2 );
		g.fillOval(((int) (( entity.x - r )) ), ((int) (( entity.y - r )) ), ((int) (r2) ), ((int) (r2) ));
	}
	
	
	public   void drawEntities(java.awt.Graphics2D g, haxe.root.Array<hxDaedalus.ai.EntityAI> vEntities)
	{
		g.setStroke(((java.awt.Stroke) (this.noughtFiveStroke) ));
		g.setPaint(((java.awt.Paint) (new java.awt.Color(((int) (65280) ))) ));
		{
			int _g1 = 0;
			int _g = vEntities.length;
			while (( _g1 < _g ))
			{
				int i = _g1++;
				g.setPaint(((java.awt.Paint) (new java.awt.Color(((int) (65280) ))) ));
				double r = vEntities.__get(i).get_radius();
				double r2 = ( r * 2 );
				g.fillOval(((int) (( vEntities.__get(i).x - r )) ), ((int) (( vEntities.__get(i).y - r )) ), ((int) (r2) ), ((int) (r2) ));
			}
			
		}
		
	}
	
	
	public   void drawPath(java.awt.Graphics2D g, haxe.root.Array<java.lang.Object> path)
	{
		if (( path.length == 0 )) 
		{
			return ;
		}
		
		g.setStroke(((java.awt.Stroke) (this.boldStroke) ));
		g.setPaint(((java.awt.Paint) (new java.awt.Color(((int) (16760848) ))) ));
		java.awt.geom.GeneralPath gpath = new java.awt.geom.GeneralPath();
		gpath.moveTo(((double) (haxe.lang.Runtime.toDouble(path.__get(0))) ), ((double) (haxe.lang.Runtime.toDouble(path.__get(1))) ));
		int i = 2;
		while (( i < path.length ))
		{
			gpath.lineTo(((double) (haxe.lang.Runtime.toDouble(path.__get(i))) ), ((double) (haxe.lang.Runtime.toDouble(path.__get(( i + 1 )))) ));
			gpath.moveTo(((double) (haxe.lang.Runtime.toDouble(path.__get(i))) ), ((double) (haxe.lang.Runtime.toDouble(path.__get(( i + 1 )))) ));
			i += 2;
		}
		
		g.draw(((java.awt.Shape) (gpath) ));
	}
	
	
	public   boolean vertexIsInsideAABB(hxDaedalus.data.Vertex vertex, hxDaedalus.data.Mesh mesh)
	{
		if (( ( ( ( vertex.get_pos().x < 0 ) || ( vertex.get_pos().x > mesh.get_width() ) ) || ( vertex.get_pos().y < 0 ) ) || ( vertex.get_pos().y > mesh.get_height() ) )) 
		{
			return false;
		}
		 else 
		{
			return true;
		}
		
	}
	
	
	@Override public   java.lang.Object __hx_setField(java.lang.String field, java.lang.Object value, boolean handleProperties)
	{
		{
			boolean __temp_executeDef217 = true;
			switch (field.hashCode())
			{
				case 3347949:
				{
					if (field.equals("mesh")) 
					{
						__temp_executeDef217 = false;
						this.mesh = ((hxDaedalus.data.Mesh) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -1666039479:
				{
					if (field.equals("noughtFiveStroke")) 
					{
						__temp_executeDef217 = false;
						this.noughtFiveStroke = ((java.awt.BasicStroke) (value) );
						return value;
					}
					
					break;
				}
				
				
				case -554572515:
				{
					if (field.equals("boldStroke")) 
					{
						__temp_executeDef217 = false;
						this.boldStroke = ((java.awt.BasicStroke) (value) );
						return value;
					}
					
					break;
				}
				
				
				case 151229951:
				{
					if (field.equals("normalStroke")) 
					{
						__temp_executeDef217 = false;
						this.normalStroke = ((java.awt.BasicStroke) (value) );
						return value;
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef217) 
			{
				return super.__hx_setField(field, value, handleProperties);
			}
			 else 
			{
				throw null;
			}
			
		}
		
	}
	
	
	@Override public   java.lang.Object __hx_getField(java.lang.String field, boolean throwErrors, boolean isCheck, boolean handleProperties)
	{
		{
			boolean __temp_executeDef218 = true;
			switch (field.hashCode())
			{
				case 37005034:
				{
					if (field.equals("vertexIsInsideAABB")) 
					{
						__temp_executeDef218 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("vertexIsInsideAABB"))) );
					}
					
					break;
				}
				
				
				case -1666039479:
				{
					if (field.equals("noughtFiveStroke")) 
					{
						__temp_executeDef218 = false;
						return this.noughtFiveStroke;
					}
					
					break;
				}
				
				
				case -827014263:
				{
					if (field.equals("drawPath")) 
					{
						__temp_executeDef218 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("drawPath"))) );
					}
					
					break;
				}
				
				
				case 151229951:
				{
					if (field.equals("normalStroke")) 
					{
						__temp_executeDef218 = false;
						return this.normalStroke;
					}
					
					break;
				}
				
				
				case 1366185253:
				{
					if (field.equals("drawEntities")) 
					{
						__temp_executeDef218 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("drawEntities"))) );
					}
					
					break;
				}
				
				
				case -554572515:
				{
					if (field.equals("boldStroke")) 
					{
						__temp_executeDef218 = false;
						return this.boldStroke;
					}
					
					break;
				}
				
				
				case -494667193:
				{
					if (field.equals("drawEntity")) 
					{
						__temp_executeDef218 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("drawEntity"))) );
					}
					
					break;
				}
				
				
				case 3347949:
				{
					if (field.equals("mesh")) 
					{
						__temp_executeDef218 = false;
						return this.mesh;
					}
					
					break;
				}
				
				
				case -827099823:
				{
					if (field.equals("drawMesh")) 
					{
						__temp_executeDef218 = false;
						return ((haxe.lang.Function) (new haxe.lang.Closure(((java.lang.Object) (this) ), haxe.lang.Runtime.toString("drawMesh"))) );
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef218) 
			{
				return super.__hx_getField(field, throwErrors, isCheck, handleProperties);
			}
			 else 
			{
				throw null;
			}
			
		}
		
	}
	
	
	@Override public   java.lang.Object __hx_invokeField(java.lang.String field, haxe.root.Array dynargs)
	{
		{
			boolean __temp_executeDef219 = true;
			switch (field.hashCode())
			{
				case 37005034:
				{
					if (field.equals("vertexIsInsideAABB")) 
					{
						__temp_executeDef219 = false;
						return this.vertexIsInsideAABB(((hxDaedalus.data.Vertex) (dynargs.__get(0)) ), ((hxDaedalus.data.Mesh) (dynargs.__get(1)) ));
					}
					
					break;
				}
				
				
				case -827099823:
				{
					if (field.equals("drawMesh")) 
					{
						__temp_executeDef219 = false;
						this.drawMesh(((java.awt.Graphics2D) (dynargs.__get(0)) ), ((hxDaedalus.data.Mesh) (dynargs.__get(1)) ));
					}
					
					break;
				}
				
				
				case -827014263:
				{
					if (field.equals("drawPath")) 
					{
						__temp_executeDef219 = false;
						this.drawPath(((java.awt.Graphics2D) (dynargs.__get(0)) ), ((haxe.root.Array<java.lang.Object>) (dynargs.__get(1)) ));
					}
					
					break;
				}
				
				
				case -494667193:
				{
					if (field.equals("drawEntity")) 
					{
						__temp_executeDef219 = false;
						this.drawEntity(((java.awt.Graphics2D) (dynargs.__get(0)) ), ((hxDaedalus.ai.EntityAI) (dynargs.__get(1)) ));
					}
					
					break;
				}
				
				
				case 1366185253:
				{
					if (field.equals("drawEntities")) 
					{
						__temp_executeDef219 = false;
						this.drawEntities(((java.awt.Graphics2D) (dynargs.__get(0)) ), ((haxe.root.Array<hxDaedalus.ai.EntityAI>) (dynargs.__get(1)) ));
					}
					
					break;
				}
				
				
			}
			
			if (__temp_executeDef219) 
			{
				return super.__hx_invokeField(field, dynargs);
			}
			
		}
		
		return null;
	}
	
	
	@Override public   void __hx_getFields(haxe.root.Array<java.lang.String> baseArr)
	{
		baseArr.push("mesh");
		baseArr.push("boldStroke");
		baseArr.push("normalStroke");
		baseArr.push("noughtFiveStroke");
		{
			super.__hx_getFields(baseArr);
		}
		
	}
	
	
}


