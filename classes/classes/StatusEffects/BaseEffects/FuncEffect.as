package classes.StatusEffects.BaseEffects
{
	import classes.Creature;
	import classes.StatusEffects.CombatBaseEffect;

	public class FuncEffect implements CombatBaseEffect
	{
		private var _f:Function;

		/**
		 * A function to call every round, mainly used for things like silence
		 * @param lockFunc the function to be called every round
		 */
		public function FuncEffect(lockFunc:Function)
		{
			_f = lockFunc;
		}

		public function apply(host:Creature):void
		{
			_f();
		}

		public function increase(value:*):void
		{
		}

		public function get current():*
		{
			return _f;
		}

		public function remove(host:Creature):void
		{
		}
	}
}
