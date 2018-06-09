package classes.Items.Weapons 
{
	import classes.Items.Weapon;

	public class BloodLetter extends Weapon
	{
		
		public function BloodLetter() 
		{
			super("BLDLetter", "Blood Letter", "bloodletter katana", "a bloodletter katana", "slash", 40, 3200, "This dark blade is as beautiful as it is deadly, made in black metal and decorated with crimson ruby gemstones. Lending its power to a corrupt warrior, it will strike with an unholy force, albeit, draining some blood from its wielder on the process.", "");
		}
		override public function get attack():int {
			var boost:int = 0;
			boost += (3 * (game.player.cor - 80 / 3));
			return (22 + boost); 
		}
		
	}

}