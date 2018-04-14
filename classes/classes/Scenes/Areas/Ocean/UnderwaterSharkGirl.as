/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ocean 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
	import classes.StatusEffects.BaseEffects.DamageOverTime;
	import classes.StatusEffects.CombatStatusEffect;
	import classes.internals.*;

public class UnderwaterSharkGirl extends Monster
	{
		private function sharkTease():void {
			game.spriteSelect(70);
			if(rand(2) == 0) {
				outputText("You charge at the shark girl, prepared to strike again, but stop dead in your tracks when she turns around and wiggles her toned ass towards you. It distracts you long enough for her tail to swing out and smack you. She coos, \"<i>Aw... You really do like me!</i>\" ");
				//(Small health damage, medium lust build).
				player.takePhysDamage(10+rand(10), true);
				player.dynStats("lus", (10+(player.lib/10)));
			}
			else {
				outputText("You pull your [weapon] back, getting a swimming start to land another attack. The Shark girl smirks and pulls up her bikini top, shaking her perky breasts in your direction. You stop abruptly, aroused by the sight just long enough for the shark girl to kick you across the face and knock you away.  She teases, \"<i>Aw, don't worry baby, you're gonna get the full package in a moment!</i>\" ");
				//(Small health damage, medium lust build)
				player.takePhysDamage(10+rand(10), true);
				player.dynStats("lus", (5+(player.lib/5)));
			}
		}
		private function sharkBiteAttack():void {
			game.spriteSelect(70);
			outputText("Your opponent takes a turn and charges at you at high speed, jaw open as she goes in for the kill, viciously biting you. You start to bleed in abundance the water around you turning red. ");
			var damage:Number = 0;
			damage += eBaseDamage();
			player.takePhysDamage(damage, true);
			var status:CombatStatusEffect;
			if (player.hasStatusEffect(StatusEffects.Hemorrhage)){
				status = player.statusEffectByType(StatusEffects.Hemorrhage) as CombatStatusEffect;
				status.increase(1);
			} else {
				status = player.createStatusEffect(StatusEffects.Hemorrhage,3,0.05,0,0) as CombatStatusEffect;
				status.duration = 3;
				status.addEffect(new DamageOverTime(DamageOverTime.NONE,player.maxHP() * 0.05,5));
				status.removeString = "<b>You sigh with relief; your hemorrhage has slowed considerably.</b>\n\n";
				status.updateString = "<b>You gasp and wince in pain, feeling fresh blood pump from your wounds. </b>";
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.sharkgirlScene.oceanSharkWinChoices();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.sharkgirlScene.sharkLossOceanRape();
		}
		
		public function UnderwaterSharkGirl() 
		{
			this.a = "the ";
			this.short = "shark-girl";
			this.imageName = "sharkgirl";
			this.long = "The shark girl is menacingly circling you, waiting for the opportunity to strike. These creatures clearly look way more deadly in the water then out of it!";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 15, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,40,0,0,0);
			this.tallness = 5*12+5;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.skinTone = "gray";
			this.hairColor = "silver";
			this.hairLength = 16;
			initStrTouSpeInte(200, 140, 160, 90);
			initWisLibSensCor(90, 100, 35, 40);
			this.weaponName = "shark teeth";
			this.weaponVerb="bite";
			this.weaponAttack = 30;
			this.armorName = "tough skin";
			this.armorDef = 20;
			this.bonusHP = 100;
			this.bonusLust = 20;
			this.lust = 40;
			this.lustVuln = .9;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 52;
			this.gems = rand(30) + 25;
			this.drop = new WeightedDrop().
					add(consumables.L_DRAFT,3).
					add(armors.S_SWMWR,1).
					add(consumables.SHARK_T,5).
					add(null,1);
			this.special1 = sharkTease;
			this.special2 = sharkBiteAttack;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}