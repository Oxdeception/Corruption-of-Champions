package classes.Items.Consumables
{
import classes.BaseContent;
import classes.Creature;
	import classes.EngineCore;
	import classes.Items.Consumable;

	/**
	 * Item that increases STR and/or VIT
	 */
	public class VitalityTincture extends Consumable
	{
		private static const ITEM_VALUE:int = 15;
		
		public function VitalityTincture()
		{
			super("Vital T", "Vitality T.", "a vitality tincture", ITEM_VALUE, "This potent tea is supposedly good for the strengthening the body.");
		}
		
		override public function useItem(host:Creature):Boolean
		{
			player.slimeFeed();
			clearOutput();
			player.slimeFeed();
			outputText("You down the contents of the bottle. The liquid is thick and tastes remarkably like cherries. Within moments, you feel much more healthy.");
			BaseContent.buffOrRecover("tou",5+rand(5),tagForBuffs,shortName);
			if (EngineCore.HPChange(50, false)) outputText("  Any aches, pains and bruises you have suffered no longer hurt and you feel much better.");
			player.refillHunger(10);
			
			return false;
		}
	}
}
