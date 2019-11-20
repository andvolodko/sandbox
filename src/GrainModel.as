/**
 * Created with IntelliJ IDEA.
 * User: Andrey
 * Date: 17.11.13
 * Time: 23:20
 * To change this template use File | Settings | File Templates.
 */
package {
public class GrainModel {
    public var x:int = 0;
    public var y:int = 0;
    public var type:int = 0;
    public var color:uint = 0;
    public var speed:Number = 0;
    public var slipSpeed:Number = 0;
    public var fall:Boolean = false;
    public var slipRight:Boolean = false;
    public var prev:GrainModel = null;
    public var next:GrainModel = null;
    public var updated:int = 0;
    public var removed:Boolean = false;
    public function GrainModel(x:int, y:int, type:int, color:uint) {
        this.x = x;
        this.y = y;
        this.type = type;
        this.color = color;
    }
}
}
