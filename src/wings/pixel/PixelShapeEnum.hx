package wings.pixel;
//http://members.chello.at/~easyfilter/bresenham.html
enum PixelShapeEnum {
    ECircle( circle: PixelCircle );
    ELine( line: PixelLine );
    EQuadratic( quatratic: PixelQuadratic );
    ETriangle( triangle: PixelTriangle );
    ERectangle( rectangle: PixelRectangle );
    EQuad( quadratic: PixelQuadratic );
    EGroup( group: Array<PixelShapeEnum> );
    ENull( );
}
