package classes.StatusEffects
{
	import classes.Creature;

	public interface CombatBaseEffect
	{
		function apply(host:Creature):void;
		function increase(value:*):void;
		function get current():*;
		function remove(host:Creature):void;
	}
}
