/**
 * Created with IntelliJ IDEA.
 * User: Andrey
 * Date: 16.11.13
 * Time: 23:47
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.BitmapData;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class SandBoxManager {

    static public const BG_COLOR:uint = 0xff003366;

    static public const GRAIN_TYPE_SAND:int = 1;
    static public const GRAIN_TYPE_WATER:int = 2;
    static public const GRAIN_TYPE_ACID:int = 3;
    static public const GRAIN_TYPE_METAL:int = 4;

    public var grainsCount:int = 0;
    private var grainsPos:Vector.<Vector.<GrainModel>> = new Vector.<Vector.<GrainModel>>(ConstVO.GRAINS_HEIGHT, true);
    private var firstGrain:GrainModel;
    private var lastGrain:GrainModel;
    private var updateTimer:Timer;
    private var bd:BitmapData;
    private var sandLogic:SandLogic;
    private var waterLogic:WaterLogic;
    private var acidLogic:AcidLogic;
    private var metalLogic:MetalLogic;
    private var interactionManager:InteractionManager;


    public function SandBoxManager(bd:BitmapData) {
        this.bd = bd;
        init();
    }

    private function init():void {
        clear();
        //
        interactionManager = new InteractionManager(this, grainsPos);
        sandLogic = new SandLogic(grainsPos, interactionManager);
        waterLogic = new WaterLogic(grainsPos, interactionManager);
        acidLogic = new AcidLogic(grainsPos, interactionManager);
        metalLogic = new MetalLogic(grainsPos, interactionManager);
        //
        updateTimer = new Timer(60);
        updateTimer.addEventListener(TimerEvent.TIMER, timerUpdate);
        updateTimer.start();
    }

    private function clearPositions():void {
        for (var i:int = 0; i < grainsPos.length; i++) {
            grainsPos[i] = new Vector.<GrainModel>(ConstVO.GRAINS_WIDTH, true);
        }
    }

    private function timerUpdate(event:TimerEvent):void {
        update();
//        render(bd);
    }

    private function update():void {
//        grains.sort(sortGrains);
        bd.lock();
        bd.fillRect(bd.rect, BG_COLOR);
        var grain:GrainModel = firstGrain;
        if(grain) {

            do {
                if(!grain) continue;
                switch (grain.type) {
                    case GRAIN_TYPE_SAND:
                        sandLogic.update(grain);
                        break;
                    case GRAIN_TYPE_WATER:
                        waterLogic.update(grain);
                        break;
                    case GRAIN_TYPE_ACID:
                        acidLogic.update(grain);
                        break;
                    case GRAIN_TYPE_METAL:
                        metalLogic.update(grain);
                        break;
                }
                //render
                bd.setPixel(grain.x, grain.y, grain.color);
                //
                grain = grain.next;
            } while(grain);
        }
        bd.unlock();
    }

    private function sortGrains(a:GrainModel, b:GrainModel):int {
        if(!a || !b) return 0;
        if(a.y > b.y) {
            return -1;
        } else if(a.y < b.y) {
            return 1;
        } else {
            return 0;
        }
    }

    public function addGrain(x:int, y:int, count:int = 1, type:int = GRAIN_TYPE_SAND):void {
//        count = 1;
//        removeGrainByPos(x, y, count);
        x = x/2;
        y = y/2;
        var startX:int = x - count/2;
        var startY:int = y + count/2;
        if(startX < 0) startX = 0;
        if(startY < 0) startY = 0;
        for (var addY:int = startY; addY > y - count/2; addY--) {
            for (var addX:int = startX; addX < x + count/2; addX++) {
                if(addX>=0 && addY>=0 && addX < ConstVO.GRAINS_WIDTH && addY < ConstVO.GRAINS_HEIGHT &&
                        grainsPos[addY][addX] == null) {
                    var grain:GrainModel = new GrainModel(addX, addY, type, 0);
                    grainsCount++;
                    if(!firstGrain) {
                        lastGrain = firstGrain = grain;
                    } else {
                        lastGrain.next = grain;
                        grain.prev = lastGrain;
                        lastGrain = grain;
                    }
                    switch (type) {
                        case GRAIN_TYPE_SAND:
                            sandLogic.init(grain);
                            break;
                        case GRAIN_TYPE_WATER:
                            waterLogic.init(grain);
                            break;
                        case GRAIN_TYPE_ACID:
                            acidLogic.init(grain);
                            break;
                        case GRAIN_TYPE_METAL:
                            metalLogic.init(grain);
                            break;
                    }
                }
            }
        }
    }

    public function removeGrainByPos(x:int, y:int, count:int = 1):void {
        x = x/2 - count/2;
        y = y/2 - count/2;
        for (var removeY:int = 0; removeY < count/2; removeY++) {
            for (var removeX:int = 0; removeX < count/2; removeX++) {
                removeGrainOnXY(x + removeX, y + removeY);
            }
        }
    }

    public function removeGrainOnXY(x:int, y:int):void {
        var grain:GrainModel = firstGrain;
        if(grain) {
            grainsPos[y][x] = null;
            do {
                if(grain.x == x && grain.y == y) {
                    switch (grain.type) {
                        case GRAIN_TYPE_SAND:
                            sandLogic.remove(grain);
                            break;
                        case GRAIN_TYPE_WATER:
                            waterLogic.remove(grain);
                            break;
                        case GRAIN_TYPE_ACID:
                            acidLogic.remove(grain);
                            break;
                        case GRAIN_TYPE_METAL:
                            metalLogic.remove(grain);
                            break;
                    }
                    grainRemoved(grain);
                    return;
                }
                grain = grain.next;
            } while(grain);
        }
    }

    public function removeGrain(grainModel:GrainModel):void {
        var grain:GrainModel = firstGrain;
        if(grain) {
            grainsPos[grain.y][grain.x] = null;
            do {
                if(grain == grainModel) {
                    switch (grain.type) {
                        case GRAIN_TYPE_SAND:
                            sandLogic.remove(grain);
                            break;
                        case GRAIN_TYPE_WATER:
                            waterLogic.remove(grain);
                            break;
                        case GRAIN_TYPE_ACID:
                            acidLogic.remove(grain);
                            break;
                        case GRAIN_TYPE_METAL:
                            metalLogic.remove(grain);
                            break;
                    }
                    grainRemoved(grain);
                    return;
                }
                grain = grain.next;
            } while(grain);
        }
    }

    private function grainRemoved(grain:GrainModel):void {
        var grainPrev:GrainModel = grain.prev;
        var grainNext:GrainModel = grain.next;
        if(grainPrev && grainNext) {
            grainPrev.next = grainNext;
            grainNext.prev = grainPrev;
        } else if(grainPrev && !grainNext) {
            grain.prev.next = null;
        } else if(!grainPrev && grainNext) {
            grain.next.prev = null;
        }
        if(grain == lastGrain) {
            lastGrain = grain.prev;
        }
        if(grain == firstGrain) firstGrain = grain.next;
        grain.removed = true;
        grainsCount--;
        grainsPos[grain.y][grain.x] = null;
    }

    public function clear():void {
        firstGrain = lastGrain = null;
        grainsCount = 0;
        clearPositions();
    }
}
}
