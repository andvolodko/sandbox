/**
 * Created with IntelliJ IDEA.
 * User: Andrey
 * Date: 17.11.13
 * Time: 23:27
 * To change this template use File | Settings | File Templates.
 */
package {

public class WaterLogic extends BaseLogic{
    public function WaterLogic(grainsPos:Vector.<Vector.<GrainModel>>, interactionManager:InteractionManager) {
        super(grainsPos, interactionManager);
        color = 0xff217CDE;
    }

    override public function init(grain:GrainModel):void {
        super.init(grain);
        generateSlip(grain);
    }

    private function generateSlip(grain:GrainModel):void {
        if(grain.updated % 300 || grain.updated < 1) {
            if(Math.random() > 0.5) {
                grain.slipRight = true;
            } else {
                grain.slipRight = false;
            }
            grain.slipSpeed = 1 + Math.random() * 10;
        }
    }

    override public function update(grain:GrainModel):void {
        super.update(grain);
        if(!grain.removed) checkEmersion(grain);
        grain.updated++;
    }


     override public function checkSlip(grain:GrainModel):void {
        if (!grain.fall) {
            if(grain.slipRight) {
                var newX:int = grain.x + grain.slipSpeed;
                var newY:int = grain.y;
            } else {
                newX = grain.x - grain.slipSpeed;
                newY = grain.y;
            }
            var checkX:int = grain.x;
            var checkAgain:Boolean = true;
            do {
                if(grain.slipRight) {
                    checkX++;
                } else {
                    checkX--;
                }
                if(inRange(checkX, newY)) {
                    if(interactionManager.interact(grain, checkX, newY) == InteractionManager.FREE) {
                        grainsPos[grain.y][grain.x] = null;
                        grain.y = newY;
                        grain.x = checkX;
                        grainsPos[grain.y][grain.x] = grain;
                    } else {
                        generateSlip(grain);
                        checkAgain = false;
                    }
                } else {
                    generateSlip(grain);
                    checkAgain = false;
                }
                if(checkX == newX) checkAgain = false;
            } while (checkAgain);
        }
    }


    private function checkEmersion(grain:GrainModel):void {
        if (!grain.fall) {
            var newY:int = grain.y - 1;
            if(newY < 0) newY = 0;
            var topGrain:GrainModel = grainsPos[newY][grain.x];
            if (newY >= 0 && newY < grainsPos.length && topGrain) {
//                grain.y = newY;
                if(grainsPos[newY][grain.x].type != SandBoxManager.GRAIN_TYPE_WATER &&
                        grainsPos[newY][grain.x].type != SandBoxManager.GRAIN_TYPE_METAL) {
                    grainsPos[grain.y][grain.x] = null;
                    grain.y = newY;
                }
            }
        }
    }

}
}
