/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 27.03.13
 * Time: 0:39
 * To change this template use File | Settings | File Templates.
 */
package ru.gotoandstop.emptyui {
import flash.display.Sprite;
import flash.geom.Rectangle;

import ru.gotoandstop.emptyui.Skin;

public class ProgressBar extends EmptyObject {
    protected var _face:Sprite;

    private var _value:Number;
    public function get value():Number {
        return _value;
    }

    public function set value(value:Number):void {
        if(_value != value) {
            value = Math.min(1, value);
            value = Math.max(0, value);
            _value = value;
            invalidate();
            dispatchChange();
        }
    }

    public function ProgressBar(value:Number = 0) {
        this.value = value;
        direction = DirectionType.HORIZONTAL;
        super();
    }

    override protected function init():void {
        super.init();
        _face = addChild(new Sprite()) as Sprite;
    }

    override public function draw():void {
        drawRect(_back.graphics, 0, 0, width, height, Skin.COLOR_BACK);
        var r:Rectangle = calcProgressRectangle(value);
        drawRect(_face.graphics, r.x, r.y, r.width, r.height, skin.focusColor);
    }

    protected function calcProgressRectangle(value:Number):Rectangle{
        var ho:Boolean = isHorizontal();
        var ve:Boolean = isVertical();
        var w:uint = ho ? width * value : width;
        var h:uint = ve ? height * value : height;
        var y:uint = ho ? 0 : height - h;
        return new Rectangle(0, y, w, h);
    }

    override protected function drawBack():void {
        drawRect(_back.graphics, 0, 0, width, height, Skin.COLOR_BACK);
    }
}
}
