/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.VolcanicCrag 
{
	import classes.*;
	import classes.internals.*;
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	
	public class GolemsTrueFire extends Monster
	{
		public function backhand():void {
			outputText("The golems visage twists into a grimace of irritation, and few of them swings their hands at you in a vicious backhand.");
			var damage:Number = int (((str + weaponAttack) * 5) - rand(player.tou) - player.armorDef);
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
			if (player.hasPerk(PerkLib.FireAffinity)) damage *= 0.3;
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swings!");
			else
			{
				outputText(" They hits you square in the chest from a few different angles. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		public function overhandSmash():void {
			outputText("Raising their fists high overhead, the golems swiftly brings them down in a punishing strike!");
			
			var damage:Number = 100 + int(((str + weaponAttack) * 5) - rand(player.tou) - player.armorDef);
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
			if (player.hasPerk(PerkLib.FireAffinity)) damage *= 0.3;
			damage = Math.round(damage);
			if (damage <= 0 || rand(100) < 25 || player.getEvasionRoll()) outputText(" You're able to sidestep it just in time.");
			else
			{
				outputText(" The concussive strikes impacts you with a bonecrushing force. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (this.HPRatio() < 0.6) {
				var choice2:Number = rand(5);
				if (choice2 < 3) eAttack();
				if (choice2 == 3) backhand();
				if (choice2 == 4) overhandSmash();
			}
			else if (this.HPRatio() < 0.8) {
				var choice1:Number = rand(4);
				if (choice1 < 3) eAttack();
				if (choice1 == 3) backhand();
			}
			else eAttack();
		}
		
		public function GolemsTrueFire() 
		{
			this.a = "the ";
			this.short = "true fire golems";
			this.imageName = "true fire golems";
			this.long = "You're currently fighting true fire golems. They're all around seven feet tall without any sexual characteristics, their body covered in flames and using bare fists to smash enemies.";
			this.plural = true;
			initStrTouSpeInte(150, 120, 90, 10);
			initWisLibSensCor(10, 10, 10, 50);
			this.lustVuln = 0;
			this.tallness = 84;
			this.createBreastRow(0, 1);
			initGenderless();
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1);
			this.level = 33;
			this.bonusHP = 350;
			this.additionalXP = 350;
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 40;
			this.armorName = "flame armor";
			this.armorDef = 40;
			this.createPerk(PerkLib.Tank, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}