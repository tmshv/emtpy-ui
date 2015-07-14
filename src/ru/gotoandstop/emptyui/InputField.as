/**
 * Created by tmshv on 28/10/13.
 */
package ru.gotoandstop.emptyui {
public class InputField extends TextArea{
    public var label:Label;

    public function InputField(name:String) {
        super();

        input = true;

        label = new Label(name);
        label.x = -label.width;
        label.y -= 5;
        addChild(label);
    }
}
}
