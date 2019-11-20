package {

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.ContextMenu;

import utils.debug.Stats;

[SWF(width='640', height='480', backgroundColor='#ffffff', frameRate='60', quality='low')]
public class SandBox extends Sprite {
    private var bd:BitmapData;
    private var bitmap:Bitmap;
    private var dummySprite:Sprite;
    private var sandManager:SandBoxManager;
    private var clicked:Boolean = false;
    private var rclicked:Boolean = false;
    public var type:int = SandBoxManager.GRAIN_TYPE_SAND;
    private var hud:HUD;
    public function SandBox() {
        init();
    }

    private function init():void {
        //
        dummySprite = new Sprite();
        addChild(dummySprite);
        //
        bd = new BitmapData(ConstVO.GRAINS_WIDTH, ConstVO.GRAINS_HEIGHT, true, 0xff000000);
        bitmap = new Bitmap(bd);
        dummySprite.addChild(bitmap);
        dummySprite.scaleX = dummySprite.scaleY = 2;
        //
        sandManager = new SandBoxManager(bd);
        hud = new HUD(this, sandManager);
        addChild(hud);
        //
        addEventListener(Event.ENTER_FRAME, enterFrame);
        addEventListener(MouseEvent.MOUSE_DOWN, mdown);
        addEventListener(MouseEvent.MOUSE_MOVE, mmove);
        addEventListener(MouseEvent.MOUSE_UP, mup);
        addEventListener(MouseEvent.MOUSE_OUT, mout);
        addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rmdown);
        addEventListener(MouseEvent.RIGHT_MOUSE_UP, rmup);
        addEventListener(MouseEvent.RIGHT_CLICK, rclick);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, kdown);
        stage.addEventListener(KeyboardEvent.KEY_UP, kup);
        //
        stage.showDefaultContextMenu = false;
        //
        addChild(new Stats(100));
    }

    private function kup(event:KeyboardEvent):void {
//        type = SandManager.GRAIN_TYPE_SAND;
    }

    private function kdown(event:KeyboardEvent):void {
//        type = SandManager.GRAIN_TYPE_WATER;
    }

    private function rclick(event:MouseEvent):void {

    }

    private function rmup(event:MouseEvent):void {
        rclicked = false;
    }

    private function rmdown(event:MouseEvent):void {
        rclicked = true;
    }

    private function mout(event:MouseEvent):void {
        clicked = false;
    }

    private function mup(event:MouseEvent):void {
        clicked = false;
//        sandManager.addGrain(event.stageX, event.stageY);
    }

    private function mmove(event:MouseEvent):void {
        if(clicked) sandManager.addGrain(event.stageX, event.stageY, 5, type);
        if(rclicked) sandManager.removeGrainByPos(event.stageX, event.stageY, 5);
    }

    private function mdown(event:MouseEvent):void {
        clicked = true;
    }

    private function enterFrame(event:Event):void {
        //trace("enterFrame");
        if(clicked) {
            sandManager.addGrain(stage.mouseX, stage.mouseY, 5, type);
        }
        if(rclicked) {
            sandManager.removeGrainByPos(stage.mouseX, stage.mouseY, 5);
        }
        //
        hud.setNumber(sandManager.grainsCount);
        //
//        sandManager.update();
//        sandManager.render(bd);
//        bitmap.bitmapData = bd;
//        bitmap.smoothing = true;
    }

}
}
