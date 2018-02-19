package classes.StatusEffects.BaseEffects
{
	import classes.Creature;
	import classes.DefaultDict;
	import classes.StatusEffects;
	import classes.StatusEffects.CombatBaseEffect;

	public class FlatStatEffect implements CombatBaseEffect
	{
		private var _changed:Boolean = true;
		private var _current:Object = {"scale":false};

		/**
		 * Adds stat values to the host, removes when removed
		 * @param rest stats to modify. Uses Dynstats syntax
		 */
		public function FlatStatEffect(...rest)
		{
			_current = rest;
		}

		public function apply(host:Creature):void
		{
			if(!_changed){return;}
			remove(host);
			_current = host.dynStats.apply(_current);
		}

		public function increase(value:*):void
		{
			_changed = true;
			for (var key:String in value){
				if(key in _current){
					_current[key] += value[key];
				} else {
					_current[key] = value[key];
				}
			}
		}

		public function get current():*
		{
			return _current;
		}

		public function remove(host:Creature):void
		{
			var dsargs:Array = ['scale',false];
			for (var key:String in _current){
				dsargs.push(key,-_current[key]);
			}
			host.dynStats.apply(host,dsargs);
		}
	}
}
