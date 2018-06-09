package classes.Items.Weapons 
{
	import classes.Creature;
	import classes.Items.Weapon;
	import classes.Scenes.SceneLib;

	public class ScarredBlade extends Weapon
	{
		
		public function ScarredBlade() 
		{
			super("ScarBld", "ScarBlade", "scarred blade", "a scarred blade", "slash", 10, 800, "This saber, made from lethicite-imbued metal, eagerly seeks flesh; it resonates with disdain and delivers deep, jagged wounds as it tries to bury itself in the bodies of others. It only cooperates with the corrupt.");
		}
		
		override public function get attack():int {
			var temp:int = 10 + int((game.player.cor - 70) / 3);
			if (temp < 10) temp = 10;
			return temp; 
		}
		
		override public function canUse(host:Creature):Boolean {
			if (game.player.cor >= (66 - game.player.corruptionTolerance())) return true;
			SceneLib.sheilaScene.rebellingScarredBlade(true);
			return false;
		}
	}
}