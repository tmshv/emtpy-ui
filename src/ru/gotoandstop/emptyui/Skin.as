/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 30.03.13
 * Time: 12:15
 * To change this template use File | Settings | File Templates.
 */
package ru.gotoandstop.emptyui {
import flash.events.Event;
import flash.events.EventDispatcher;

public class Skin extends EventDispatcher{
    [Embed(source="../../../../resources/OpenSans-Light.ttf", embedAsCFF="false", fontName="Open Sans Light", fontWeight="regular", mimeType="application/x-font")]
    private static var FontOpenSansLight:Class;

    [Embed(source="../../../../resources/OpenSans-Regular.ttf", embedAsCFF="false", fontName="Open Sans", fontWeight="regular", mimeType="application/x-font")]
    private static var FontOpenSansRegular:Class;

    public static const COLOR_BACK:uint = 0xdddddd;//0xededed; //grey light
    public static const COLOR_FOCUS:uint = 0xfaaf00;//orange
    public static const COLOR_BLACK:uint = 0x4a4a4a;      //black
    public static const COLOR_BLUE:uint = 0x549eed;//blue
//    public static const COLOR_3:uint = 0x25c956;//blue
    public static const COLOR_WHITE:uint = 0xffffff;//white

    public static const FONT:String = "Open Sans Light";

    public static const FONT_SIZE:uint = 13;

    public static function createDefault():Skin {
        var skin:Skin = new Skin();
        skin.backgroundColor = COLOR_BLUE;
        skin.focusColor = COLOR_FOCUS;
        skin.textColor = COLOR_BACK;
        skin.fontName = Skin.FONT;
        skin.fontSize = Skin.FONT_SIZE;
        return skin;
    }

    private var _backgroundColor:uint;
    public function set backgroundColor(value:uint):void {
        _backgroundColor = value;
        update();
    }
    public function get backgroundColor():uint {
        return _backgroundColor;
    }

    private var _focusColor:uint;
    public function set focusColor(value:uint):void {
        _focusColor = value;
        update();
    }
    public function get focusColor():uint {
        return _focusColor;
    }

    private var _textColor:uint;
    public function set textColor(value:uint):void {
        _textColor = value;
        update();
    }
    public function get textColor():uint {
        return _textColor;
    }

    private var _fontName:String;
    public function set fontName(value:String):void {
        _fontName = value;
        update();
    }
    public function get fontName():String {
        return _fontName;
    }

    private var _fontSize:uint;
    public function set fontSize(value:uint):void {
        _fontSize = value;
        update();
    }
    public function get fontSize():uint {
        return _fontSize;
    }

    public function update():void {
        dispatchEvent(new Event(Event.CHANGE));
    }
}
}