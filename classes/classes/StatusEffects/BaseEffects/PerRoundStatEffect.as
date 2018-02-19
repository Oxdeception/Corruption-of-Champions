package classes.StatusEffects.BaseEffects
{
	import classes.Creature;
	import classes.StatusEffects.CombatBaseEffect;

	public class PerRoundStatEffect implements CombatBaseEffect
	{
		private var _stat:String;
		private var _change:Number;

		/**
		 * A periodic stat change, does not scale
		 * @param stat the stat to change, uses Dynstats syntax
		 * @param value how much to change the stat by per round
		 */
		public function PerRoundStatEffect(stat:String,value:Number)
		{
			_stat = stat;
			_change = value;
		}

		public function apply(host:Creature):void
		{
			host.dynStats(_stat,_change,"scale",false);
		}

		public function increase(value:*):void
		{
			_change += value;
		}

		public function get current():*
		{
			return {Stat:_stat,Value:_change};
		}

		public function remove(host:Creature):void
		{

		}
	}
}
