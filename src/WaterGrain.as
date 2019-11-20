/**
 * Created with IntelliJ IDEA.
 * User: Andrey
 * Date: 17.11.13
 * Time: 3:18
 * To change this template use File | Settings | File Templates.
 */
package {

public class WaterGrain extends Grain {

    private var slipRight:Boolean = false;
    public function WaterGrain(x:int, y:int, grainsPos:Vector.<Vector.<int>>) {
        super(x, y, grainsPos);
        color = 0xff217CDE;
        generateSlip();
    }


    override public function checkSlip():void {
        if (!fall) {
            if(slipRight) {
                var newX:int = x + 1;
                var newY:int = y;
            } else {
                newX = x - 1;
                newY = y;
            }

            if (newX >= 0 && newY >= 0 && newX < grainsPos[0].length && newY < grainsPos.length && !grainsPos[newY][newX] == 1) {
                grainsPos[y][x] = 0;
                y = newY;
                x = newX;
                grainsPos[y][x] = 1;
            } else generateSlip();
        }
    }

    private function generateSlip():void {
        if(Math.random() > 0.5) {
            slipRight = true;
        } else {
            slipRight = false;
        }
    }

}
}
