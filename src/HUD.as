/**
 * Created with IntelliJ IDEA.
 * User: Andrey
 * Date: 17.11.13
 * Time: 23:13
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;
import flash.events.MouseEvent;

public class HUD extends Sprite {

    private var graphic:HUDGraphic = new HUDGraphic();
    private var sandbox:SandBox;
    private var sandboxManager:SandBoxManager;

    public function HUD(sandbox:SandBox, sandboxManager:SandBoxManager) {
        this.sandbox = sandbox;
        this.sandboxManager = sandboxManager;
        super();
        init();
    }

    private function init():void {
        addChild(graphic);
        graphic.water.addEventListener(MouseEvent.CLICK, waterClick);
        graphic.sand.addEventListener(MouseEvent.CLICK, sandClick);
        graphic.acid.addEventListener(MouseEvent.CLICK, acidClick);
        graphic.metal.addEventListener(MouseEvent.CLICK, metalClick);
        graphic.clear.addEventListener(MouseEvent.CLICK, clearClick);
    }

    private function sandClick(event:MouseEvent):void {
        sandbox.type = SandBoxManager.GRAIN_TYPE_SAND;
    }

    private function waterClick(event:MouseEvent):void {
        sandbox.type = SandBoxManager.GRAIN_TYPE_WATER;
    }

    private function acidClick(event:MouseEvent):void {
        sandbox.type = SandBoxManager.GRAIN_TYPE_ACID;
    }

    private function metalClick(event:MouseEvent):void {
        sandbox.type = SandBoxManager.GRAIN_TYPE_METAL;
    }

    private function clearClick(event:MouseEvent):void {
        sandboxManager.clear();
    }

    public function setNumber(num:int):void {
        graphic.count.text = num.toString();
    }

}
}
