/**
 * Coded by aimozg on 06.06.2017.
 */
package coc.view {
import flash.events.IEventDispatcher;
import flash.text.TextFormat;

public class UIUtils {
	public function UIUtils() {
	}
	public static function convertColor(input:Object):uint {
		return Color.convertColor(input);
	}
	public static function convertTextFormat(input:Object):TextFormat {
		if (input is TextFormat) return input as TextFormat;
		var tf:TextFormat = new TextFormat();
		setProperties(tf,input,{
			'color':Color.convertColor
		});
		return tf;
	}
	public static function convertSize(value:Object,ref100pc:Number):Number {
		if (value is Number) return Number(value);
		value = ''+value;
		if (value.indexOf('%') == value.length-1) {
			return Number(value.substr(0,value.length-1))*ref100pc/100;
		}
		return Number(value);
	}
	public static function setProperties(e:Object,options:Object,special:Object=null):Object {
		if (options) for (var key:String in options) {
			if (options.hasOwnProperty(key)) {
				var value:*      = options[key];
				if (key in e) {
					var spc:Function = special ? special[key] as Function : null;
					if (spc != null) {
						e[key] = spc(value);
					} else {
						e[key] = value;
					}
				} else if (key.substr(0, 2) == 'on' && value is Function && e is IEventDispatcher) {
					(e as IEventDispatcher).addEventListener(key.substr(2), value);
				}
			}
		}
		return e;
	}

}
}
