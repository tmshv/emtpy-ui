/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 29.03.13
 * Time: 3:15
 * To change this template use File | Settings | File Templates.
 */
package ru.gotoandstop.emptyui {
import flash.display.DisplayObject;
import flash.geom.Point;

import ru.gotoandstop.emptyui.EmptyObject;

public class Matrix extends EmptyObject {
    public static function createList(...childs):Matrix {
        return buildList(childs);
    }

    public static function createHList(...childs):Matrix {
        var tab:Matrix = buildList(childs);
        tab.direction = DirectionType.HORIZONTAL;
        return tab;
    }

    private static function buildList(childs:Array):Matrix {
        var tab:Matrix = new Matrix(1);
        for each(var c:EmptyObject in childs) {
            if (c) {
                tab.add(c);
            }
        }
        return tab;
    }

    private var _dimenstion:uint;
    public function get dimenstion():uint {
        return _dimenstion;
    }

    public function set dimenstion(value:uint):void {
        if (_dimenstion != value) {
            _dimenstion = value;
            invalidate();
        }
    }

    private var _margin:uint;
    public function get margin():uint {
        return _margin;
    }

    public function set margin(value:uint):void {
        if (_margin != value) {
            _margin = value;
            invalidate();
        }
    }

    protected var _elements:Vector.<EmptyObject>;

    override public function get numChildren():int {
        return _elements.length;
    }

    public function Matrix(dimension:uint) {
        _dimenstion = dimension;
        _margin = 1;
        _elements = new Vector.<EmptyObject>();
        direction = DirectionType.VERTICAL;
        super();
    }

    public function add(child:EmptyObject, index:int = -1):void {
        if (index < 0) {
            _elements.push(child);
        } else {
            _elements.splice(index, 0, child);
        }

        addChild(child);
        invalidate();
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

    public function get(column:uint, row:uint):EmptyObject {
        var elem:EmptyObject;
        return elem;
    }

    override public function getChildAt(index:int):DisplayObject {
        return _elements[index];
    }

    public function getIndex(child:EmptyObject):int {
        return _elements.indexOf(child);
    }

    public function getCellIndex(child:EmptyObject):Point {
        var index:int = getIndex(child);
        var r:uint;
        var c:uint;
        if (isHorizontal()) {
            c = Math.floor(index / dimenstion);
            r = index - (c * dimenstion);
        } else {
            r = Math.floor(index / dimenstion);
            c = index - (r * dimenstion);
        }
        return new Point(c, r);
    }

    public function getColumn(row:uint):Vector.<EmptyObject> {
        var elem:Vector.<EmptyObject> = new Vector.<EmptyObject>();
        return elem;
    }

    public function getRow(row:uint):Vector.<EmptyObject> {
        var elem:Vector.<EmptyObject> = new Vector.<EmptyObject>();
        return elem;
    }

    override public function draw():void {
        var length:uint = _elements.length;
        for (var i:uint = 0; i < length; i++) {
            var e:EmptyObject = _elements[i];
            var cell:Point = getCellIndex(e);
            e.x = (e.width + margin) * cell.x;
            e.y = (e.height + margin) * cell.y;
        }
    }
}
}
