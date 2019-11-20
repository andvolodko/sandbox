/**
 * Created with IntelliJ IDEA.
 * User: Andrey
 * Date: 23.11.13
 * Time: 1:12
 * To change this template use File | Settings | File Templates.
 */
package {
public class InteractionManager {

    static public const FREE:int = 1;
    static public const BUSY:int = 2;
    static public const REMOVED:int = 3;

    private var sandBoxManager:SandBoxManager;
    private var grainsPos:Vector.<Vector.<GrainModel>>;
    public function InteractionManager(sandBoxManager:SandBoxManager, grainsPos:Vector.<Vector.<GrainModel>>) {
        this.sandBoxManager = sandBoxManager;
        this.grainsPos = grainsPos;
    }

    public function interact(grain:GrainModel, x:int, y:int, ignore:int = -1):int {
        var grainOther:GrainModel = grainsPos[y][x];
        if(grainOther == null) return FREE;
        else  {
//            if(grainOther.fall) return true;
            if(grainOther.type == ignore) return FREE;
            switch(grain.type) {
                case SandBoxManager.GRAIN_TYPE_SAND:
                        switch(grainOther.type) {
                            case SandBoxManager.GRAIN_TYPE_SAND:
                                return BUSY;
                            break;
                            case SandBoxManager.GRAIN_TYPE_WATER:
                                return FREE;
                                break;
                            case SandBoxManager.GRAIN_TYPE_ACID:
                                sandBoxManager.removeGrain(grain);
                                sandBoxManager.removeGrain(grainOther);
                                return REMOVED;
                                break;
                        }
                break;
                case SandBoxManager.GRAIN_TYPE_WATER:
                    switch(grainOther.type) {
                        case SandBoxManager.GRAIN_TYPE_SAND:
                            return BUSY;
                            break;
                        case SandBoxManager.GRAIN_TYPE_WATER:
                            return BUSY;
                            break;
                        case SandBoxManager.GRAIN_TYPE_ACID:
                            sandBoxManager.removeGrain(grain);
                            sandBoxManager.removeGrain(grainOther);
                            return REMOVED;
                            break;
                    }
                    break;
                case SandBoxManager.GRAIN_TYPE_ACID:
                    switch(grainOther.type) {
                        case SandBoxManager.GRAIN_TYPE_ACID:
                            return BUSY;
                            break;
                        default:
                            sandBoxManager.removeGrain(grain);
                            sandBoxManager.removeGrain(grainOther);
                            return REMOVED;
                    }
                    break;
            }
        }
        return BUSY;
    }

}
}
