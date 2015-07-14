/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 29.03.13
 * Time: 1:20
 * To change this template use File | Settings | File Templates.
 */
package ru.gotoandstop.emptyui {
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class Label extends EmptyObject {
    protected var _text:TextField;

    private var _label:String;
    public function get label():String {
        return _label;
    }

    public function set label(value:String):void {
        _label = value;

        draw();
    }

    public var autoSize:Boolean = true;

    public function Label(label:String) {
        super();
        _label = label;
        disableMouse();
        enabled = false;
    }

    override protected function init():void {
        super.init();
        _text = addChild(new TextField()) as TextField;
        _text.selectable = false;
        _text.defaultTextFormat = new TextFormat(skin.fontName, skin.fontSize, skin.textColor);
        _text.border = true;
        _text.embedFonts = true;
    }

    override public function draw():void {
        _text.text = _label;

        if(autoSize) {
            _text.autoSize = TextFieldAutoSize.LEFT;
            _width = _text.width;
            _height = _text.height;
        }else{
            _text.autoSize = TextFieldAutoSize.NONE;
            _text.width = width;
            _text.height = height;
        }
        super.draw();

//        _text.x = (_width - _text.width) / 2;
//        _text.y = (_height - _text.height) / 2;
    }
}
}