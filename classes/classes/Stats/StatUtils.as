/**
 * Coded by aimozg on 01.06.2018.
 */
package classes.Stats {
import classes.Creature;
import classes.internals.Utils;

import coc.script.Eval;

public class StatUtils {
	public function StatUtils() {
	}
	
	/**
	 * Warning: can cause infinite recursion if called from owner.findStat() unchecked
	 */
	public static function findStatByPath(owner:IStatHolder, path:String):IStat {
		var parts:Array = path.split(/\./);
		var s:IStat;
		for (var i:int = 0; i<parts.length; i++) {
			if (!owner) break;
			s = owner.findStat(parts[i]);
			owner = s as IStatHolder;
		}
		return s;
	}
	
	public static function explainBuff(stat:String,value:Number):String {
		var signum:String  = (value < 0 ? '' : '+');
		var x:String       = signum + value;
		
		if (stat in PlainNumberStats) {
			return PlainNumberStats[stat]+' '+x;
		}
		var percent:String = signum + Math.floor(value * 100) + '%';
		if (stat in PercentageStats) {
			return PercentageStats[stat]+' '+percent;
		}
		trace('[WARN] Unexplainable stat '+stat);
		return stat+' '+x;
	}
	public static function nameOfStat(stat:String):String {
		if (stat in PlainNumberStats) {
			return PlainNumberStats[stat];
		} else if (stat in PercentageStats) {
			return PercentageStats[stat];
		} else {
			trace('[WARN] Unknown stat '+stat);
			return stat;
		}
	}
	public static const PlainNumberStats:Object = Utils.createMapFromPairs([
		['str','Strength'],
		['tou','Toughness'],
		['spe','Speed'],
		['int','Intellect'],
		['wis','Wisdom'],
		['lib','Libido'],
		['str.bonus','Strength'],
		['tou.bonus','Toughness'],
		['spe.bonus','Speed'],
		['int.bonus','Intellect'],
		['wis.bonus','Wisdom'],
		['lib.bonus','Libido'],
		
		['sensMin','Min Sensitivity'],
		['sensMax','Max Sensitivity'],
		['lustMin','Min Lust'],
		['lustMax','Max Lust'],
		['hpMax','Max HP'],
		['staminaMax','Max Stamina'],
		['kiMax','Max Ki'],
		
		['defense','Defense'],
		['hpPerTou','HP per Toughness'],
	]);
	public static const PercentageStats:Object = Utils.createMapFromPairs([
			['str.mult','Strength'],
			['tou.mult','Toughness'],
			['spe.mult','Speed'],
			['int.mult','Intellect'],
			['wis.mult','Wisdom'],
			['lib.mult','Libido'],
			['spellPower','Spellpower']
	]);
}
}
