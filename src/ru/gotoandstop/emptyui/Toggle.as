/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 30.03.13
 * Time: 11:52
 * To change this template use File | Settings | File Templates.
 */
package ru.gotoandstop.emptyui {
import flash.events.MouseEvent;

import ru.gotoandstop.emptyui.Skin;

public class Toggle extends EmptyObject {
    private var _value:Boolean;
    public function get value():Boolean {
        return _value;
    }

    public function set value(value:Boolean):void {
        if (_value != value) {
            _value = value;
            invalidate();
            dispatchChange();
        }
    }

    public function Toggle(initValue:Boolean = false) {
        _value = initValue;
        direction = DirectionType.HORIZONTAL;
        super();
        setSize(20, 20);
        enableMouse();
    }

    override public function draw():void {
        var c:uint = _focus ? skin.focusColor : (value ? skin.backgroundColor : Skin.COLOR_BACK);
        drawRect(_back.graphics, 0, 0, width, height, c);
    }

    override protected function init():void {
        super.init();
    }

    override protected function onClick(event:MouseEvent):void {
        super.onClick(event);
        toggle();
    }

    public function toggle():void {
        value = !value;
    }

    public function toggleYes():void {
        value = true;
    }

    public function toggleNo():void {
        value = false;
    }
}
}
