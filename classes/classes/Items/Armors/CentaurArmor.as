package classes.Items.Armors 
{
	import classes.Creature;
	import classes.Items.Armor;
	import classes.Scenes.NPCs.CelessScene;

	/**
	 * ...
	 * @author 
	 */
	public class CentaurArmor extends Armor
	{
		
		public function CentaurArmor() 
		{
			super("TaurPAr","Taur P. Armor","some taur paladin armor","a set of taur paladin armor",23,1698,"A suit of paladin's armor for centaurs.","Heavy")
		}
		override public function canUse(host:Creature):String{
			if (!host.isTaur()){
				return "The paladin armor is designed for centaurs, so it doesn't really fit you. You place the armor back in your inventory";
			}
			return super.canUse(host);
		}
		
		override public function useText(host:Creature):String {
			return CelessScene.instance.Name+" helps you put on the barding and horseshoes. Wow, taking a look at yourself, you look like those knights of legend. Fighting the wicked with this armor should be quite easy."
		}
		
		override public function removeText(host:Creature):String {
			return CelessScene.instance.Name+ "helps you remove the centaur armor. Whoa, you were starting to forget what not being weighted down by heavy armor felt like."
			+ super.removeText(host);
		}
		
		override public function get defense():int{
			var mod:int = (100-game.player.cor)/10;
			return 13 + mod;
		}
	}

}