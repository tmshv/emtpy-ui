/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 30.03.13
 * Time: 17:56
 * To change this template use File | Settings | File Templates.
 */
package ru.gotoandstop.emptyui {
import flash.events.Event;
import flash.events.FocusEvent;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;

public class TextArea extends EmptyObject {
    private var _text:TextField;

    private var _value:String;
    public function get value():String {
        return _value;
    }

    private var _selectable:Boolean;
    public function get selectable():Boolean {
        return _text.selectable;
    }

    public function set selectable(value:Boolean):void {
        _selectable = value;
        if (_text) {
            _text.selectable = input ? true : _selectable;
        }
    }

    private var _input:Boolean;
    public function get input():Boolean {
        return _input;
    }

    public function set input(value:Boolean):void {
        _input = value;
        if (_text) {
            _text.type = value ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
            _text.selectable = value ? true : _selectable;
        }
    }

    private var _multiline:Boolean;

    public function get multiline():Boolean {
        return _multiline;
    }

    public function set multiline(value:Boolean):void {
        _multiline = value;
        _text.multiline = value;
    }

    public function set value(value:String):void {
        if (_value != value) {
            _value = value;
            invalidate();
        }
    }

    public function TextArea(initText:String = "") {
        _value = initText;
        super();
//        color = Skin.COLOR_BACK;
        setSize(100, 20);
    }

    override protected function init():void {
        super.init();
        _text = addChild(new TextField()) as TextField;
        _text.defaultTextFormat = new TextFormat(Skin.FONT, Skin.FONT_SIZE, Skin.COLOR_BLACK);
        input = false;
        selectable = false;

        _text.addEventListener(Event.CHANGE, onTextChange);
        _text.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
        _text.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
    }

    private function onFocusOut(event:FocusEvent):void {
        if (_input) invalidate();
    }

    private function onFocusIn(event:FocusEvent):void {
        if (_input) invalidate();
    }

    override public function draw():void {
        _text.width = width;
        _text.height = height;
        _text.text = value;

        var bc:uint = (stage && stage.focus == _text) ? Skin.COLOR_FOCUS : skin.backgroundColor;
        drawRect(_back.graphics, 0, 0, width, height, bc);
    }

    private function onTextChange(event:Event):void {
//        invalidate();
        value = _text.text;
        dispatchChange();
    }
}
}
