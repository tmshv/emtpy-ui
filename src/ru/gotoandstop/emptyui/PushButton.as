/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 30.03.13
 * Time: 17:13
 * To change this template use File | Settings | File Templates.
 */
package ru.gotoandstop.emptyui {
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;

public class PushButton extends EmptyObject{
    private var _label:String;
    public function get label():String {
        return _label;
    }

    public function set label(value:String):void {
        _label = value;
        if(_autoSize) {
            fitToLabel();
        }
    }

    private var _autoSize:Boolean = true;
    public function get autoSize():Boolean {
        return _autoSize;
    }

    public function set autoSize(value:Boolean):void {
        _autoSize = value;
        _text.autoSize = value;
    }

    public function PushButton(label:String, callback:Function=null) {
        super();
        _label = label;
        this.callback = callback;
        setSize(26, 26);
        enableMouse();
    }

    private var _text:Label;

    override protected function init():void {
        super.init();

        _text = new Label(label);
        addChild(_text);
    }

    override public function draw():void {
        _text.label = label;
        drawBack();
//        var s:uint = 2;
//        var c:int = _mouseDown ? s/2 : 0;
//        var w:uint = _mouseDown ? width - s : width;
//        var h:uint = _mouseDown ? height - s : height;
//        var g:Graphics = _back.graphics;
//        g.clear();
//        g.beginFill(skin.focusColor);
//        g.drawEllipse(c,  c, w,  h);
//        g.endFill();

        _text.label = _label;

        if(_autoSize) {
            _text.autoSize = TextFieldAutoSize.LEFT;
            _width = _text.width;
            _height = _text.height;
        }else{
            _text.autoSize = TextFieldAutoSize.NONE;
            _text.width = width;
            _text.height = height;
        }
        super.draw();
    }

    override protected function onClick(event:MouseEvent):void {
        super.onClick(event);
        dispatchChange();
    }

    private function fitToLabel():void{

    }
}
}
