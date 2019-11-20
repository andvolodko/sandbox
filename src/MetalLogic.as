/**
 * Created with IntelliJ IDEA.
 * User: Andrey
 * Date: 17.11.13
 * Time: 23:27
 * To change this template use File | Settings | File Templates.
 */
package {

public class MetalLogic extends BaseLogic{
    public function MetalLogic(grainsPos:Vector.<Vector.<GrainModel>>, interactionManager:InteractionManager) {
        super(grainsPos, interactionManager);
        color = 0xffCCCCCC;
    }

    override public function update(grain:GrainModel):void {
//        super.update(grain);
    }
}
}
