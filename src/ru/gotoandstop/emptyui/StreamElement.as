/**
 * Created by tmshv on 02/11/13.
 */
package ru.gotoandstop.emptyui {
import flash.events.Event;

public class StreamElement extends EmptyObject {
    private var _lineSpace:Number;
    public function get lineSpace():Number {
        return _lineSpace;
    }

    public function set lineSpace(value:Number):void {
        _lineSpace = value;
        invalidate();
    }

    private var _letterSpace:Number;
    public function get letterSpace():Number {
        return _letterSpace;
    }

    public function set letterSpace(value:Number):void {
        _letterSpace = value;
        invalidate();
    }

    public function get length():uint {
        return _elements.length;
    }

    private var _elements:Vector.<EmptyObject>;

    public function StreamElement() {
        super();
        _elements = new Vector.<EmptyObject>();
    }

    public function add(child:EmptyObject, index:int = -1):EmptyObject {
        if (index < 0) {
            _elements.push(child);
        } else {
            _elements.splice(index, 0, child);
        }
        child.addListener(onElementChange, false, 0, true);
        addChild(child);
        invalidate();
        return child;
    }

    public function remove(child:EmptyObject):void {
        var index:int = getIndex(child);
        if (index > -1) {
            removeAt(index);
        }
    }

    public function removeAt(index:uint):void {
        _elements.splice(index, 1);
        invalidate();
    }

    public function getIndex(child:EmptyObject):int {
        return _elements.indexOf(child);
    }

    public function getElementAt(index:uint):EmptyObject{
        if(_elements.length < index) {
            return _elements[index];
        }else{
            return null;
        }
    }

//    public function searchElement(search:ISearch):FlatElement{
//        for each(var e:FlatElement in _elements) {
//            if(search.test(e)) return e;
//        }
//        return null;
//    }

    override public function draw():void {
        var maxStrokeHeight:uint = 0;
        var cursorX:uint = 0;
        var cursorY:uint = 0;
        var strokeElements:Vector.<EmptyObject> = new Vector.<EmptyObject>();
        for each(var e:EmptyObject in _elements) {
            if ((cursorX + e.width) > width) {
                cursorX = 0;
                cursorY += maxStrokeHeight;
                cursorY += lineSpace;
                maxStrokeHeight = 0;
                strokeElements = new Vector.<EmptyObject>();
            }

            if(e.height > maxStrokeHeight) {
                maxStrokeHeight = e.height;
            }
            strokeElements.push(e);

            e.x = cursorX;
            e.y = cursorY;

            cursorX += e.width;
            cursorX += letterSpace;
        }
    }

    private function onElementChange(event:Event):void {
        invalidate();
    }
}
}