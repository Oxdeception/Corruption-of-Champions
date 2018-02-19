package classes.StatusEffects.BaseEffects
{
	import classes.Creature;
	import classes.EngineCore;
	import classes.StatusEffects.CombatBaseEffect;
	import classes.internals.Utils;

	//todo @Oxdeception allow for elemental typed damage
	public class DamageOverTime implements CombatBaseEffect
	{
		public static const NONE:int = 0;
		public static const PHYSICAL:int = 1;
		public static const MAGIC:int = 2;

		private var _type:int;
		private var _amount:Number;
		private var _variance:Number;

		/**
		 * DOT Effect Component. Can be used for healing, also.
		 * @param type resistance type to apply to this effect
		 * @param amount how much damage to apply per round, negative values heal
		 * @param variance max extra damage to add randomly
		 */
		public function DamageOverTime(type:int,amount:Number,variance:Number=0)
		{
			_type = type;
			_amount = amount;
			_variance = variance;
		}

		//todo @Oxdeception creature needs a heal method
		public function apply(host:Creature):void
		{
			var damage:Number = _amount + Utils.rand(_variance);
			if(damage < 0){
				host.HP += _amount;
				return;
			}
			switch(_type){
				case NONE:
					host.HP -= _amount;
					break;
				case PHYSICAL:
					host.takePhysDamage(damage,true);
					break;
				case MAGIC:
					host.takeMagicDamage(damage,true);
					break;
			}
			EngineCore.outputText("\n");
		}

		public function increase(value:*):void
		{
			_amount += value;
		}

		public function get current():*
		{
			return _amount;
		}

		public function remove(host:Creature):void
		{
		}
	}
}
