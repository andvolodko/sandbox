/**
 * Created with IntelliJ IDEA.
 * User: Andrey
 * Date: 17.11.13
 * Time: 0:09
 * To change this template use File | Settings | File Templates.
 */
package {
public class Grain {

    static protected const GRAVITY:Number = 1.03;
    static protected const START_SPEED:Number = 7;
    //
    public var x:int;
    public var y:int;
    public var color:uint = 0;
    protected var grainsPos:Vector.<Vector.<int>>;
    //
    protected var speed:Number = START_SPEED;
    protected var fall:Boolean = false;
    //
    public function Grain(x:int, y:int, grainsPos:Vector.<Vector.<int>>) {
        this.x = x;
        this.y = y;
        this.grainsPos = grainsPos;
        init();
    }

    private function init():void {
        grainsPos[y][x] = 1;
        fall = true;
        speed = START_SPEED;
    }

    private function moveDown():void {
        checkFall();
        //
        if (fall) {
            speed *= GRAVITY;
            var newYPos:int = y + speed;
        }
        //
        var moved:Boolean = false;
        for (var checkY:int = y; checkY <= newYPos; checkY++) {
            if (checkY >= 0 && checkY < grainsPos.length && !grainsPos[checkY][x] == 1) {
                grainsPos[y][x] = 0;
                y = checkY;
                grainsPos[y][x] = 1;
                moved = true;
            }
        }
        if (!moved) {
            fall = false;
            speed = START_SPEED;
        }
    }

    public function checkSlip():void {
        if (!fall) {
            if(Math.random() > 0.5) {
                var newX:int = x + 1;
                var newY:int = y + 1;
            } else {
                newX = x - 1;
                newY = y + 1;
            }

            if (newX >= 0 && newY >= 0 && newX < grainsPos[0].length && newY < grainsPos.length && !grainsPos[newY][newX] == 1) {
                grainsPos[y][x] = 0;
                y = newY;
                x = newX;
                grainsPos[y][x] = 1;
            }
        }
    }

    private function checkFall():void {
        if (!fall) {
            var checkFallY:int = y + 1;
            if (checkFallY < grainsPos.length && !grainsPos[checkFallY][x] == 1) {
                fall = true;
            }
        }
    }

    public function update():void {
        moveDown();
    }

    public function remove():void {
        grainsPos[y][x] = 0;
    }
}
}
