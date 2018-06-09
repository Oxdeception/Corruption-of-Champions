package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;

	public class Whip extends Weapon
	{
		
		public function Whip() 
		{
			super("Whip   ", "Whip", "coiled whip", "a coiled whip", "whip-crack", 5, 200, "A coiled length of leather designed to lash your foes into submission.  There's a chance the bondage inclined might enjoy it!");
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 2;
			return (5 + boost); 
		}
	}
}