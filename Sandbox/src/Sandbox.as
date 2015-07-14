package {

import flash.display.Sprite;

import ru.gotoandstop.emptyui.EmptyController;
import ru.gotoandstop.emptyui.EmptyObject;
import ru.gotoandstop.emptyui.IEmpty;
import ru.gotoandstop.emptyui.Label;
import ru.gotoandstop.emptyui.Matrix;
import ru.gotoandstop.emptyui.PushButton;
import ru.gotoandstop.emptyui.Skin;
import ru.gotoandstop.emptyui.Slider;
import ru.gotoandstop.emptyui.Toggle;

[SWF(width=1000, height=700, frameRate=100)]
public class Sandbox extends Sprite {
    public var toggle:Toggle;
    public var matrix:Matrix;
    public var emptyObject:EmptyObject;
    public var label:Label;
    public var slider:Slider;
    public var push:PushButton;

    public function Sandbox() {
        emptyObject = new EmptyObject();
        emptyObject.skin.backgroundColor = 0xa859b9;
        addChild(emptyObject);

//        var e:IEmpty = new EmptyController(this);
//        e.click

        matrix = new Matrix(5);
        for (var i:uint; i < 10; i++) {
            var tc:EmptyObject = new EmptyObject();
            tc.skin.backgroundColor = Math.random() * 0x1000000;
            matrix.add(tc);
        }
        matrix.x = 100;
        matrix.y = 100;
        addChild(matrix);

        toggle = new Toggle();
        toggle.x = 200;
        addChild(toggle);

        label = new Label("Hellolo");
//        label.skin.fontName = "Open Sans";
        label.skin.textColor = 0x000000;
        label.skin.fontSize = 14;
        label.x = 300;
        label.y = 100;
        addChild(label);

        slider = new Slider();
        slider.x = 10;
        slider.y = 400;
        addChild(slider);

        push = new PushButton("Push me!");
        push.x = 200;
        push.y = 400;
        addChild(push);
    }
}
}
