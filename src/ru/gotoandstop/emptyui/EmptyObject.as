/**
 * User: Roman Timashev
 * Date: 27.03.13
 * Time: 0:39
 */
package ru.gotoandstop.emptyui {
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class EmptyObject extends Sprite {
    protected var _focus:Boolean;
    protected var _mouseOver:Boolean;
    protected var _mouseDown:Boolean;
    protected var _width:Number = 0;
    protected var _height:Number = 0;
    protected var _back:Sprite;

    private var _skin:Skin;
    public function get skin():Skin {
        return _skin;
    }

    public function set skin(value:Skin):void {
        _skin = value;
        invalidate();
    }

    protected var _id:String = "";
    public function set id(value:String):void {
        _id = value;
    }

    public function get id():String {
        return _id;
    }

    protected var _enabled:Boolean = true;
    public function set enabled(value:Boolean):void {
        _enabled = value;
        mouseEnabled = value;
        mouseChildren = value;
        tabEnabled = value;
    }

    public function get enabled():Boolean {
        return _enabled;
    }

    private var _direction:uint;
    public function get direction():uint {
        return _direction;
    }

    public function set direction(value:uint):void {
        if (_direction != value) {
            _direction = value;
            invalidate();
        }
    }

    private var _callback:Function;
    public function get callback():Function {
        return _callback;
    }
    public function set callback(value:Function):void {
        _callback = value;
    }

    public function EmptyObject() {
        super();
        _skin = Skin.createDefault();

        setSize(25, 25);
        init();
    }

    protected function init():void {
        invalidate();
        _back = addChild(new Sprite()) as Sprite;
    }

    protected function dispatchChange():void{
        if(_callback != null) _callback(this);
        dispatchEvent(new Event(Event.CHANGE));
    }

    public function enableMouse():void {
        addEventListener(MouseEvent.CLICK, onClick);
        addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
        addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
        addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        addEventListener(MouseEvent.RELEASE_OUTSIDE, onMouseUp);
    }

    public function disableMouse():void {
        removeEventListener(MouseEvent.CLICK, onClick);
        removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
        removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        removeEventListener(MouseEvent.RELEASE_OUTSIDE, onMouseUp);
        _mouseOver = false;
    }

    public function addListener(listener:Function, useCapture:Boolean=false, priority:uint = 0, useWeakReference:Boolean=false):void{
        addEventListener(Event.CHANGE, listener, useCapture, priority, useWeakReference);
    }

    public function removeListener(listener):void{
        removeEventListener(Event.CHANGE, listener);
    }

    protected function onClick(event:MouseEvent):void{

    }

    protected function onMouseOver(event:MouseEvent):void{
        _mouseOver = true;
        _focus = true;
        invalidate();
    }

    protected function onMouseOut(event:MouseEvent):void {
        _mouseOver = false;
        _focus = false;
        invalidate();
    }

    protected function onMouseDown(event:MouseEvent):void{
        _mouseDown = true;
        _focus = true;
        invalidate();
    }

    protected function onMouseUp(event:MouseEvent):void {
        _mouseDown = false;
        _focus = false;
        invalidate();
    }

    public function draw():void {
        drawBack();
    }

    protected function drawBack():void{
        drawRect(_back.graphics, 0, 0, width, height, skin.backgroundColor);
    }

    protected function invalidate():void {
        addEventListener(Event.ENTER_FRAME, onInvalidate);
    }

    protected function onInvalidate(event:Event):void {
        removeEventListener(Event.ENTER_FRAME, onInvalidate);
        draw();
    }

    public function setSize(w:Number, h:Number):void {
        _width = w;
        _height = h;
    }

    public function isHorizontal():Boolean {
        return direction == DirectionType.HORIZONTAL;
    }

    public function isVertical():Boolean {
        return direction == DirectionType.VERTICAL;
    }

    /**
     * Sets/gets the width of the component.
     */
    override public function set width(w:Number):void {
        _width = w;
        invalidate();
        dispatchEvent(new Event(Event.RESIZE));
    }

    override public function get width():Number {
        return _width;
    }

    /**
     * Sets/gets the height of the component.
     */
    override public function set height(h:Number):void {
        _height = h;
        invalidate();
        dispatchEvent(new Event(Event.RESIZE));
    }

    override public function get height():Number {
        return _height;
    }


    /**
     * Overrides the setter for x to always place the component on a whole pixel.
     */
    override public function set x(value:Number):void {
        super.x = Math.round(value);
    }

    /**
     * Overrides the setter for y to always place the component on a whole pixel.
     */
    override public function set y(value:Number):void {
        super.y = Math.round(value);
    }

    protected function drawRect(canvas:Graphics, x:uint, y:uint, width:uint, height:uint, color:uint, clear:Boolean = true):void {
        if (clear) canvas.clear();
        canvas.beginFill(color);
        canvas.drawRect(x, y, width, height);
        canvas.endFill();
    }

    protected function invertColor(rgbColor:uint):uint {
        return 0xffffff ^ rgbColor;
    }
}
}
