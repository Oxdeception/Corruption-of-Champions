/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ocean 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
	import classes.Scenes.Combat.Combat;
	import classes.Scenes.SceneLib;
	import classes.StatusEffects.BaseEffects.DamageOverTime;
	import classes.StatusEffects.CombatStatusEffect;
	import classes.internals.*;

public class UnderwaterTigersharkGirl extends Monster
	{
		private function sharkTease():void {
			game.spriteSelect(70);
			if(rand(2) == 0) {
				outputText("You charge at the shark girl, prepared to strike again, but stop dead in your tracks when she turns around and wiggles her toned ass towards you. It distracts you long enough for her tail to swing out and smack you. She coos, \"<i>Aw... You really do like me!</i>\" ");
				//(Small health damage, medium lust build).
				player.takePhysDamage(12+rand(12), true);
				player.dynStats("lus", (12+(player.lib/10)));
			}
			else {
				outputText("You pull your [weapon] back, getting a swimming start to land another attack. The Shark girl smirks and pulls up her bikini top, shaking her perky breasts in your direction. You stop abruptly, aroused by the sight just long enough for the shark girl to kick you across the face and knock you away.  She teases, \"<i>Aw, don't worry baby, you're gonna get the full package in a moment!</i>\" ");
				//(Small health damage, medium lust build)
				player.takePhysDamage(12+rand(12), true);
				player.dynStats("lus", (6+(player.lib/5)));
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
				status.addEffect(new DamageOverTime(DamageOverTime.NONE,player.maxHP() * 0.1,10));
				status.removeString = "<b>You sigh with relief; your hemorrhage has slowed considerably.</b>\n\n";
				status.updateString = "<b>You gasp and wince in pain, feeling fresh blood pump from your wounds. </b>";
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.sharkgirlScene.oceanTigerSharkWinChoices();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.sharkgirlScene.tigersharksharkLossOceanRape();
		}
		
		public function UnderwaterTigersharkGirl() 
		{
			this.a = "the ";
			this.short = "tiger shark-girl";
			this.imageName = "izma";
			this.long = "The tiger shark girl is menacingly circling you, waiting for the opportunity to strike. These creatures clearly look way more deadly in the water then out of it!";
			// this.plural = false;
			this.createCock(15,2.2);
			this.balls = 4;
			this.ballSize = 3;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 45, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 5*12+5;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_NOTICEABLE;
			this.skinTone = "striped orange";
			this.hairColor = "silver";
			this.hairLength = 20;
			initStrTouSpeInte(250, 170, 205, 110);
			initWisLibSensCor(110, 120, 25, 40);
			this.weaponName = "shark teeth";
			this.weaponVerb="bite";
			this.weaponAttack = 66;
			this.armorName = "tough skin";
			this.armorDef = 20;
			this.bonusHP = 500;
			this.bonusLust = 20;
			this.lust = 20;
			this.lustVuln = .20;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 56;
			this.gems = rand(15) + 10;
			this.drop = new WeightedDrop().
					add(consumables.L_DRAFT,3).
					add(armors.S_SWMWR,1).
					add(consumables.TSTOOTH,5).
					add(null,1);
			this.special1 = sharkTease;
			this.special2 = sharkBiteAttack;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}