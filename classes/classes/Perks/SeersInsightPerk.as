/**
 * ...
 * @author Zavos
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class SeersInsightPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "Increase spell/magical soulskills power and lower specials fatigue/ki cost by " + (params.value1 * 100) + "%.";
		}

		public function SeersInsightPerk() 
		{
			super("Seer’s Insight", "Seer’s Insight",
					"Your equipment boost your spells/magical soulskills power and lowering costs of specials/soulskills!");
		}
		
	}

}