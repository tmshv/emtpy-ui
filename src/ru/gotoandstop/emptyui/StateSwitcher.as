/**
 * Created with IntelliJ IDEA.
 * User: Roman
 * Date: 30.03.13
 * Time: 16:22
 * To change this template use File | Settings | File Templates.
 */
package ru.gotoandstop.emptyui {
import flash.errors.IllegalOperationError;
import flash.events.Event;

import ru.gotoandstop.emptyui.DirectionType;

import ru.gotoandstop.emptyui.EmptyObject;

import ru.gotoandstop.emptyui.Matrix;
import ru.gotoandstop.emptyui.Toggle;
import ru.gotoandstop.emptyui.Toggle;

public class StateSwitcher extends Matrix {
    private var _state:String;
    public function get state():String {
        return _state;
    }

    private var _toggleWidth:uint;
    public function get toggleWidth():uint {
        return _toggleWidth;
    }

    public function set toggleWidth(value:uint):void {
        _toggleWidth = value;
        invalidate();
    }

    private var _toggleHeight:uint;
    public function get toggleHeight():uint {
        return _toggleHeight;
    }

    public function set toggleHeight(value:uint):void {
        _toggleHeight = value;
        invalidate();
    }

    private var _activeToggle:Toggle;
    public function get activeToggle():Toggle {
        return _activeToggle;
    }

    protected var _states:Vector.<String>;

    public function StateSwitcher(dimension:uint) {
        _states = new Vector.<String>();
        _toggleWidth = 10;
        _toggleHeight = 10;
        super(dimension);
        margin = 15;
        direction = DirectionType.HORIZONTAL;
    }

    public function switchState(state:String):void {
        var new_toggle:Toggle = getToggleWithState(state);
        if (new_toggle && new_toggle !== _activeToggle) {
            if (_activeToggle) {
                _activeToggle.toggleNo();
                _activeToggle.enableMouse();
            }

            _activeToggle = new_toggle;
            _activeToggle.toggleYes();
            _activeToggle.disableMouse();

            _state = state;
            invalidate();
            dispatchChange();
        }
    }

    public function addState(toggle:Toggle):void {
        var state:String = toggle.id;
        if (hasState(state)) throw new ArgumentError("state already exist");
        _states.push(state);

//        toggle.setSize(_toggleWidth, _toggleHeight);
        toggle.addListener(onChange);
        super.add(toggle);
        if (!_state) switchState(state);
        invalidate();
    }

    public function removeState(state:String):void {
        if (!hasState(state)) throw new ArgumentError("state not exist");
        var index:int = _states.indexOf(state);
        _states.splice(index, 1);

        var toggle:Toggle = getToggleWithState(state);
        remove(toggle);
        if (_state == state && _states.length) {
            switchState(_states[0]);
        }
        invalidate();
    }

    private function getToggleWithState(state:String):Toggle {
        var toggle:Toggle;
        for (var i:uint = 0; i < _elements.length; i++) {
            var elem:EmptyObject = _elements[i];
            if (elem.id == state) {
                toggle = elem as Toggle;
                break;
            }
        }
        return toggle;
    }

    public function hasState(state:String):Boolean {
        return _states.indexOf(state) > -1;
    }

    override public function add(child:EmptyObject, index:int = -1):void {
        throw new IllegalOperationError("you cannot call method StateSwitcher::add. Use StateSwitcher::addState instead.");
        if (child is Toggle) {
            child.addListener(onChange);
            super.add(child, index);

            if (!_activeToggle) {
                _activeToggle = child as Toggle;
                _activeToggle.toggleYes();
            }
            dispatchChange();
        } else {
            throw new ArgumentError("child is not Table");
        }
    }

    protected function onChange(event:Event):void {
        var event_toggle:Toggle = event.currentTarget as Toggle;
        if (_activeToggle == event_toggle) return;
        if (event_toggle.value) {
            switchState(event_toggle.id);
        }
    }
}
}
