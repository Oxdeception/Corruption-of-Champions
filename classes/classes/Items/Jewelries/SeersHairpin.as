/**
 * ...
 * @author Zavos
 */
package classes.Items.Jewelries 
{
	import classes.Creature;
	import classes.Items.Equipable;
	import classes.Items.Jewelry;
	import classes.PerkLib;

	public class SeersHairpin extends Jewelry
	{
		
		public function SeersHairpin() 
		{
			super("SeerPin", "Seer’s Hairpin", "seer’s hairpin", "a seer’s hairpin", 0, 0, 1600, "This hairpin is made from silver, the tip twisted into the shape of an eye and fitted with a crystal lens. Both an ornament and a tool, this pin will empower sorcery and ki. \n\nType: Accesory (Hairpin) \nBase value: 800","Ring");
			_itemPerks.push(PerkLib.SeersInsight.create(0.2,0,0,0));
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Accesory (Hairpin)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Seer’s Insight (+20% spell effect/magical soulspell power multiplier, 20% fatigue/ki costs reduction)";
			return desc;
		}
	}
}