/**
 * Created with IntelliJ IDEA.
 * User: Andrey
 * Date: 17.11.13
 * Time: 23:29
 * To change this template use File | Settings | File Templates.
 */
package {
public class BaseLogic {
    static protected const GRAVITY:Number = 1.03;
    static protected const START_SPEED:Number = 7;
    //
    public var color:uint = 0;
    protected var grainsPos:Vector.<Vector.<GrainModel>>;
    protected var interactionManager:InteractionManager;
    //

    public function BaseLogic(grainsPos:Vector.<Vector.<GrainModel>>, interactionManager:InteractionManager) {
        this.grainsPos = grainsPos;
        this.interactionManager = interactionManager;
    }

    public function init(grain:GrainModel):void {
        grainsPos[grain.y][grain.x] = grain;
        grain.color = color;
        grain.fall = true;
        grain.speed = START_SPEED;
    }

    public function update(grain:GrainModel):void {
        if(!grain.removed) checkSlip(grain);
        if(!grain.removed) checkFall(grain);
        //
        if (grain.fall) {
            grain.speed *= GRAVITY;
            var newYPos:int = grain.y + grain.speed;
        }
        //
        if(!grain.removed) moveTo(grain, grain.x, newYPos);
    }

    protected function moveTo(grain:GrainModel, x:int, y:int):void {
        var moved:Boolean = false;
        for (var checkY:int = grain.y + 1; checkY <= y; checkY++) {
            if (inRange(grain.x, checkY)) {
                if (interactionManager.interact(grain, grain.x, checkY) == InteractionManager.FREE) {
                    grainsPos[grain.y][grain.x] = null;
                    grain.y = checkY;
                    grainsPos[grain.y][grain.x] = grain;
                    moved = true;
                } else break;
            } else break;
        }
        if (!moved) {
            grain.fall = false;
            grain.speed = START_SPEED;
        }
    }

    public function checkSlip(grain:GrainModel):void {
        if (!grain.fall) {
            if (Math.random() > 0.5) {
                var newX:int = grain.x + 1;
                var newY:int = grain.y + 1;
            } else {
                newX = grain.x - 1;
                newY = grain.y + 1;
            }
            if (inRange(newX, newY)) {
                if(interactionManager.interact(grain, newX, newY) == InteractionManager.FREE) {
                    grainsPos[grain.y][grain.x] = null;
                    grain.y = newY;
                    grain.x = newX;
                    grainsPos[grain.y][grain.x] = grain;
                }
            }
        }
    }

    private function checkFall(grain:GrainModel):void {
        if (!grain.fall) {
            var checkFallY:int = grain.y + 1;
            if (inRange(grain.x, checkFallY) && grainsPos[checkFallY][grain.x] == null) {
                grain.fall = true;
            }
        }
    }

    protected function inRange(checkX:Number, checkY:Number):Boolean {
        if (checkX >= 0 && checkX < ConstVO.GRAINS_WIDTH && checkY >= 0 && checkY < ConstVO.GRAINS_HEIGHT)
            return true;
        else return false;
    }

    public function remove(grain:GrainModel):void {
        grainsPos[grain.y][grain.x] = null;
    }

}
}
