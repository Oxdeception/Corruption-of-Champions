package classes.Scenes.Areas.HighMountains
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.GlobalFlags.*;
import classes.Scenes.Combat.CombatAction.ActionRoll;
import classes.Scenes.SceneLib;
import classes.StatusEffects.Combat.BasiliskSlowDebuff;
import classes.internals.ChainedDrop;

/**
	 * ...
	 * @author ...
	 */
	public class Basilisk extends Monster 
	{

		public static function basiliskSpeed(player:Player,amount:Number = 0):void {
			var bse:BasiliskSlowDebuff = player.createOrFindStatusEffect(StatusEffects.BasiliskSlow) as BasiliskSlowDebuff;
			bse.applyEffect(amount);
		}

		//special 1: basilisk mental compulsion attack
		//(Check vs. Intelligence/Sensitivity, loss = recurrent speed loss each
		//round, one time lust increase):
		private function compulsion():void {
			outputText("The basilisk opens its mouth and, staring at you, utters words in its strange, dry, sibilant tongue.  The sounds bore into your mind, working and buzzing at the edges of your resolve, suggesting, compelling, then demanding you look into the basilisk's eyes.  ");
			//Success:
			if (player.inte / 5 + rand(20) < 24) {
				//Immune to Basilisk?
				if (player.hasPerk(PerkLib.BasiliskResistance)) {
					outputText("You can't help yourself... you glimpse the reptile's grey, slit eyes. However, no matter how much you look into the eyes, you do not see anything wrong. All you can see is the basilisk. The basilisk curses as he finds out that you're immune!");
				}
				else {
					outputText("You can't help yourself... you glimpse the reptile's grey, slit eyes. You look away quickly, but you can picture them in your mind's eye, staring in at your thoughts, making you feel sluggish and unable to coordinate. Something about the helplessness of it feels so good... you can't banish the feeling that really, you want to look in the basilisk's eyes forever, for it to have total control over you.");
					player.dynStats("lus", 3);
					//apply status here
					basiliskSpeed(player,20);
					player.createStatusEffect(StatusEffects.BasiliskCompulsion,0,0,0,0);
					if (player.hasPerk(PerkLib.GorgonsEyes)) flags[kFLAGS.BASILISK_RESISTANCE_TRACKER] += 4;
					else flags[kFLAGS.BASILISK_RESISTANCE_TRACKER] += 2;
				}
			}
			//Failure:
			else {
				outputText("You concentrate, focus your mind and resist the basilisk's psychic compulsion.");
			}
		}
		
		
		override protected function intercept(roll:ActionRoll, actor:Creature, phase:String, type:String):void {
			if (phase == ActionRoll.Phases.PREPARE && type == ActionRoll.Types.PERFORM) {
				if (!actor.hasPerk(PerkLib.BasiliskResistance) && !actor.isWieldingRangedWeapon()) {
					if (hasStatusEffect(StatusEffects.Blind) || hasStatusEffect(StatusEffects.InkBlind)) {
						outputText("Blind basilisk can't use his eyes, so you can actually aim your strikes!  ");
					} else if(actor.inte/5 + rand(20) < 25) {
						//basilisk counter attack (block attack, significant speed loss):
						outputText("Holding the basilisk in your peripheral vision, you charge forward to strike it.  Before the moment of impact, the reptile shifts its posture, dodging and flowing backward skillfully with your movements, trying to make eye contact with you. You find yourself staring directly into the basilisk's face!  Quickly you snap your eyes shut and recoil backwards, swinging madly at the lizard to force it back, but the damage has been done; you can see the terrible grey eyes behind your closed lids, and you feel a great weight settle on your bones as it becomes harder to move.");
						actor.addCombatBuff('spe', -20);
						actor.removeStatusEffect(StatusEffects.FirstAttack);
						flags[kFLAGS.BASILISK_RESISTANCE_TRACKER] += 2;
						roll.cancel();
					} else {
						//Counter attack fails: (random chance if PC int > 50 spd > 60; PC takes small physical damage but no block or spd penalty)
						outputText("Holding the basilisk in your peripheral vision, you charge forward to strike it.  Before the moment of impact, the reptile shifts its posture, dodging and flowing backward skillfully with your movements, trying to make eye contact with you. You twist unexpectedly, bringing your [weapon] up at an oblique angle; the basilisk doesn't anticipate this attack!  ");
					}
				}
			}
		}
		
		//Special 3: basilisk tail swipe (Small physical damage):
		private function basiliskTailSwipe():void {
			outputText("The basilisk suddenly whips its tail at you, swiping your [feet] from under you!  You quickly stagger upright, being sure to hold the creature's feet in your vision.  ");
			if(damage == 0) outputText("The fall didn't harm you at all.  ");
			var damage:Number = int((str + 20) - Math.random()*(player.tou+player.armorDef));
			damage = player.takePhysDamage(damage, true);			
		}

		//basilisk physical attack: With lightning speed, the basilisk slashes you with its index claws!
		//Noun: claw

		override protected function performCombatAction():void
		{
			if(!player.hasStatusEffect(StatusEffects.BasiliskCompulsion) && rand(3) == 0 && !hasStatusEffect(StatusEffects.Blind)) compulsion();
			else if(rand(3) == 0) basiliskTailSwipe();
			else eAttack();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.highMountains.basiliskScene.defeatBasilisk();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe basilisk smirks, but waits for you to finish...");
				doNext(combat.endLustLoss);
			} else {
				SceneLib.highMountains.basiliskScene.loseToBasilisk();
			}
		}

		override public function endRoundChecks():Function {
			var res:Function = super.endRoundChecks();
			if (res != null){return res;}
			if (player.spe <= 1) {return curry(doNext, combat.endHpLoss);}
			return null;
		}

		public function Basilisk()
		{
			this.a = "the ";
			this.short = "basilisk";
			this.imageName = "basilisk";
			this.long = "You are fighting a basilisk!  From what you can tell while not looking directly at it, the basilisk is a male reptilian biped standing a bit over 6' tall.  He has a thin but ropy build, his tightly muscled yellow underbelly the only part of his frame not covered in those deceptive, camouflaging grey-green scales.  A long, whip-like tail flits restlessly through the dirt behind his skinny legs, and sharp sickle-shaped index claws decorate each hand and foot.  You don't dare to look at his face, but you have the impression of a cruel jaw, a blunt lizard snout and a crown of dull spines.";
			// this.plural = false;
			this.createCock(6,2);
			this.balls = 2;
			this.ballSize = 2;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 6*12+2;
			this.hips.type = Hips.RATING_SLENDER + 1;
			this.butt.type = Butt.RATING_AVERAGE;
			this.lowerBody = LowerBody.LIZARD;
			this.skin.growCoat(Skin.SCALES,{color:"gray"},Skin.COVERAGE_COMPLETE);
			this.hairColor = "none";
			this.hairLength = 0;
			initStrTouSpeInte(98, 107, 45, 80);
			initWisLibSensCor(80, 50, 35, 60);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 38;
			this.armorName = "scales";
			this.armorDef = 18;
			this.armorPerk = "";
			this.armorValue = 70;
			this.bonusHP = 200;
			this.bonusLust = 10;
			this.lust = 30;
			this.lustVuln = .5;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 24;
			this.gems = rand(20) + 40;
			this.drop = new ChainedDrop().add(useables.EBONBLO,1/20)
					.elseDrop(consumables.REPTLUM);
			this.tailType = Tail.COW;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
