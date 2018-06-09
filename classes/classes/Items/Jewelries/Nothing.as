package classes.Items.Jewelries 
{
	import classes.Creature;
	import classes.Items.Equipable;
	import classes.Items.Jewelry;

	public class Nothing extends Jewelry
	{
		public function Nothing()
		{
			super("nojewel", "nojewel", "nothing", "nothing", 0, 0, 0, "no jewelry", "ring");
		}
		
		override public function unequip(host:Creature):Equipable {
			return null; //There is nothing!
		}
	}
}