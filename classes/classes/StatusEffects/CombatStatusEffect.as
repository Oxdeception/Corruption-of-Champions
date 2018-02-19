/**
 * Created by aimozg on 31.01.14.
 */
package classes.StatusEffects
{
	import classes.EngineCore;
	import classes.StatusEffectClass;
import classes.StatusEffectType;

public class CombatStatusEffect extends StatusEffectClass
{
	private var _duration:int = -1;
	private var _updateString:String;
	private var _removeString:String;
	private var _manualString:String;
	private var _effects:Vector.<CombatBaseEffect> = new Vector.<CombatBaseEffect>();

	public function CombatStatusEffect(stype:StatusEffectType)
	{
		super(stype);
	}

	override public function onCombatEnd():void {
		remove();
	}

	override public function onCombatRound():void {
		durationTick();
	}

	/**
	 * Reduces the duration of the effect by one tick.
	 * If the duration is 0 the effect is removed.
	 * Effects with durations of -1 are not removed until end of combat.
	 */
	public function durationTick(manual:Boolean = false):void{
		if(_duration == 0){
			if(_removeString){
				EngineCore.outputText(_removeString);
			}
			remove();
			return;
		}
		if(manual && _manualString){
			EngineCore.outputText(_manualString);
		}
		else if(_updateString){
			EngineCore.outputText(_updateString);
		}
		for each (var effect:CombatBaseEffect in _effects){
			effect.apply(host);
		}
		if(_duration < 0) {return;}
		_duration--;
	}

	public function set duration(value:int):void
	{
		_duration = value;
	}

	public function increase(value:int):void{
		_duration += value;
	}

	/**
	 * The string to display when the duration of the effect ticks down.
	 * @param value
	 */
	public function set updateString(value:String):void
	{
		_updateString = value;
	}

	/**
	 * The string to display when the effect duration expires.
	 * @param value
	 */
	public function set removeString(value:String):void
	{
		_removeString = value;
	}

	public function set manualString(value:String):void
	{
		_manualString = value;
	}

	public function set effects(value:Vector.<CombatBaseEffect>):void
	{
		_effects = value;
	}

	public function addEffect(value:CombatBaseEffect):void
	{
		if(value in _effects){
			_effects[_effects.indexOf(value)].increase(value.current);
		} else {
			_effects.push(value);
		}
	}

	override public function onRemove():void{
		for each (var effect:CombatBaseEffect in _effects){
			effect.remove(host);
		}
		super.onRemove();
	}
}
}
