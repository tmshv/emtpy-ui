/**
 * Created by tmshv on 25/12/13.
 */
package ru.gotoandstop.emptyui {
import flash.display.DisplayObjectContainer;
import flash.events.EventDispatcher;

public class EmptyController extends EventDispatcher implements IEmpty {
    protected var parent:DisplayObjectContainer;

    public function EmptyController(parent:DisplayObjectContainer) {
        super();
        this.parent = parent;
    }
}
}
