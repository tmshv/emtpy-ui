/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 29.03.13
 * Time: 2:46
 * To change this template use File | Settings | File Templates.
 */
package ru.gotoandstop.emptyui {
import flash.events.MouseEvent;
import flash.geom.Rectangle;

public class Slider extends ProgressBar {
    private var _min:Number;
    public function get min():Number {
        return _min;
    }

    public function set min(value:Number):void {
        _min = value;
    }

    private var _max:Number;
    public function get max():Number {
        return _max;
    }

    public function set max(value:Number):void {
        _max = value;
    }

    public function Slider(min:Number = 0, max:Number = 1, value:Number = 0) {
        _min = min;
        _max = max;
        super(value);
        setSize(100, 20);
        enableMouse();
    }

    public function getValue():Number {
        return min + (max - min) * value;
    }

    override protected function init():void {
        super.init();
        addEventListener(MouseEvent.MOUSE_MOVE, calc);
    }

//    override public function draw():void {
//        drawRect(_back.graphics, 0, 0, width, height, FlatStyle.COLOR_BACK);
//        var r:Rectangle = calcProgressRectangle(getValue());
//        drawRect(_face.graphics, r.x, r.y, r.width, r.height, focusedColor);
//    }

    override protected function onMouseDown(event:MouseEvent):void {
        super.onMouseDown(event);
        calc(event);
    }

    private function calc(event:MouseEvent):void {
        if (_mouseDown) {
            var coord:uint;
            var base:uint;
            if (isHorizontal()) {
                coord = event.localX;
                base = width;
            } else {
                coord = height - event.localY;
                base = height;
            }
            value = coord / base;
        }
        dispatchChange();
    }
}
}
