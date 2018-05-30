﻿//CoC Creature.as
package classes
{

	import classes.BodyParts.Antennae;
	import classes.BodyParts.Arms;
	import classes.BodyParts.Beard;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Claws;
	import classes.BodyParts.Ears;
	import classes.BodyParts.Eyes;
	import classes.BodyParts.Face;
	import classes.BodyParts.Gills;
	import classes.BodyParts.Hair;
	import classes.BodyParts.Hips;
	import classes.BodyParts.Horns;
	import classes.BodyParts.IOrifice;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.RearBody;
	import classes.BodyParts.Skin;
	import classes.BodyParts.Tail;
	import classes.BodyParts.Tongue;
	import classes.BodyParts.UnderBody;
	import classes.BodyParts.Wings;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Jewelry;
	import classes.Items.JewelryLib;
	import classes.Items.WeaponLib;
	import classes.Scenes.Camp.CampMakeWinions;
	import classes.Scenes.Places.TelAdre.UmasShop;
	import classes.Stats.BuffableStat;
	import classes.Stats.PrimaryStat;
	import classes.StatusEffects.Combat.CombatInteBuff;
	import classes.StatusEffects.Combat.CombatSpeBuff;
	import classes.StatusEffects.Combat.CombatStrBuff;
	import classes.StatusEffects.Combat.CombatTouBuff;
	import classes.StatusEffects.Combat.CombatWisBuff;
	import classes.internals.Utils;
	import classes.lists.BreastCup;
	import classes.lists.Gender;

	import flash.errors.IllegalOperationError;

	public class Creature extends Utils
	{


        public function get game():CoC {
			return CoC.instance;
		}
		public function get flags():DefaultDict {
			return game.flags;
		}

		public static function damage_PHYS(creature:Creature, damage:Number):Number {
			return creature.takePhysDamage(damage);
		}

		public static function damage_LUST(creature:Creature, damage:Number):Number {
			return creature.takeLustDamage(damage)
		}

		public static function damage_MAGIC(creature:Creature, damage:Number):Number {
			return creature.takeMagicDamage(damage);
		}

		//Variables
		
		//Short refers to player name and monster name. BEST VARIABLE NAME EVA!
		//"a" refers to how the article "a" should appear in text.
		private var _short:String = "You";
		private var _a:String = "a ";
		public function get short():String { return _short; }
		public function set short(value:String):void { _short = value; }
		public function get a():String { return _a; }
		public function set a(value:String):void { _a = value; }
		public function get capitalA():String {
			if (_a.length == 0) return "";
			return _a.charAt(0).toUpperCase() + _a.substr(1);
		}

		//Weapon melee
		public function get weaponName():String { return ""; }
		public function get weaponVerb():String { return ""; }
		public function get weaponAttack():Number { return 0; }
		public function get weaponPerk():String { return ""; }
		public function get weaponValue():Number { return 0; }
		//Weapon range
		public function get weaponRangeName():String { return ""; }
		public function get weaponRangeVerb():String { return ""; }
		public function get weaponRangeAttack():Number { return 0; }
		public function get weaponRangePerk():String { return ""; }
		public function get weaponRangeValue():Number { return 0; }
		//Clothing/Armor
		public function get armorName():String { return ""; }
		public function get armorDef():Number { return 0; }
		public function get armorPerk():String { return ""; }
		public function get armorValue():Number { return 0; }
		//Jewelry!
		public function get jewelryName():String { return ""; }
		public function get jewelryEffectId():Number { return 0; }
		public function get jewelryEffectMagnitude():Number { return 0; }
		public function get jewelryPerk():String { return ""; }
		public function get jewelryValue():Number { return 0; }
		//Shield!
		public function get shieldName():String { return ""; }
		public function get shieldBlock():Number { return 0; }
		public function get shieldPerk():String { return ""; }
		public function get shieldValue():Number { return 0; }
		//Undergarments!
		public function get upperGarmentName():String { return ""; }
		public function get upperGarmentPerk():String { return ""; }
		public function get upperGarmentValue():Number { return 0; }

		public function get lowerGarmentName():String { return ""; }
		public function get lowerGarmentPerk():String { return ""; }
		public function get lowerGarmentValue():Number { return 0; }
		
		/*
		
		   [   S T A T S   ]
		
		 */
		public var stats:Object = {};// [index:string]:IStat
		
		//Primary stats
		public var strStat:PrimaryStat = new PrimaryStat("str",stats);
		public var touStat:PrimaryStat = new PrimaryStat("tou",stats);
		public var speStat:PrimaryStat = new PrimaryStat("spe",stats);
		public var intStat:PrimaryStat = new PrimaryStat("int",stats);
		public var wisStat:PrimaryStat = new PrimaryStat("wis",stats);
		public var libStat:PrimaryStat = new PrimaryStat("lib",stats);
		public function get str():Number {
			return strStat.value;
		}
		public function get tou():Number {
			return touStat.value;
		}
		public function get spe():Number {
			return speStat.value;
		}
		public function get inte():Number {
			return intStat.value;
		}
		public function get wis():Number {
			return wisStat.value;
		}
		public function get lib():Number {
			return libStat.value;
		}
		public var sens:Number = 0;
		public var cor:Number = 0;
		public var fatigue:Number = 0;
		public var mana:Number = 0;
		public var ki:Number = 0;
		
		//Combat Stats
		public var HP:Number = 0;
		public var lust:Number = 0;
		public var wrath:Number = 0;
		
		//Level Stats
		public var XP:Number = 0;
		public var level:Number = 0;
		public var gems:Number = 0;
		public var additionalXP:Number = 0;
		
		public function get str100():Number { return 100*str/getMaxStats('str'); }
		public function get tou100():Number { return 100*tou/getMaxStats('tou'); }
		public function get spe100():Number { return 100*spe/getMaxStats('spe'); }
		public function get inte100():Number { return 100*inte/getMaxStats('inte'); }
		public function get wis100():Number { return 100*wis/getMaxStats('wis'); }
		public function get lib100():Number { return 100*lib/getMaxStats('lib'); }
		public function get sens100():Number { return 100*sens/getMaxStats('sens'); }
		public function get fatigue100():Number { return 100*fatigue/maxFatigue(); }
		public function get hp100():Number { return 100*HP/maxHP(); }
		public function get wrath100():Number { return 100*wrath/maxWrath(); }
		public function get mana100():Number { return 100*mana/maxMana(); }
		public function get ki100():Number { return 100*ki/maxKi(); }
		public function get lust100():Number { return 100*lust/maxLust(); }
		
		public function minLust():Number {
			return 0;
		}
		public function minSens():Number {
			return 10;
		}

		protected function maxHP_base():Number {
			var max:Number = 0;
			max += int(tou * 2 + 50);
			var under100: int = Math.floor(Math.min(tou, 100) / 20);
			var over100: int = Math.floor(Math.max(tou - 100, 0) / 50);
			max += tou * (over100 + under100);
			if (hasPerk(PerkLib.Tank)) max += Math.round(tou*3);
			if (hasPerk(PerkLib.ElementalBondFlesh)) {
				for each (var status:StatusEffectType in CampMakeWinions.summon_statuses){
					if(hasStatusEffect(status)){
						max += 25 * statusEffectv2(status);
					}
				}
			}
			if (hasPerk(PerkLib.JobGuardian)) max += 30;
			if (hasPerk(PerkLib.ChiReflowDefense)) max += UmasShop.NEEDLEWORK_DEFENSE_EXTRA_HP;
			max += level * 15;
			if (jewelryEffectId == JewelryLib.MODIFIER_HP) max += jewelryEffectMagnitude;
			return max;
		}
		protected function maxLust_base():Number {
			var max:Number = 100;
			if (hasPerk(PerkLib.ElementalBondUrges)) {
				for each (var status:StatusEffectType in CampMakeWinions.summon_statuses){
					if(hasStatusEffect(status)){
						max += 5 * statusEffectv2(status);
					}
				}
			}
			if (hasPerk(PerkLib.BroBody) || hasPerk(PerkLib.BimboBody) || hasPerk(PerkLib.FutaForm)) max += 20;
			if (hasPerk(PerkLib.OmnibusGift)) max += 15;
			if (hasPerk(PerkLib.JobCourtesan)) max += 20;
			if (hasPerk(PerkLib.JobSeducer)) max += 10;
			return max;
		}
		protected function maxHP_mult():Number {
			return 1 + (countCockSocks("green") * 0.02);
		}
		protected function maxLust_mult():Number {
			return 1;
		}
		public function maxHP():Number {
			var max:Number = Math.round(maxHP_base()*maxHP_mult());
			return Math.min(199999,max);
		}
		public function maxLust():Number {
			var max:Number = Math.round(maxLust_base()*maxLust_mult());
			return Math.min(24499,max);
		}
		public function maxFatigue():Number {
			return 100;
		}
		public function maxWrath():Number {
			return 250;
		}
		public function maxKi():Number {
			return 0;
		}
		public function maxMana():Number {
			return 100;
		}
		public function getMaxStats(stats:String):int {
			var obj:Object = getAllMaxStats();
			if (stats == "str" || stats == "strength") return obj.str;
			else if (stats == "tou" || stats == "toughness") return obj.tou;
			else if (stats == "spe" || stats == "speed") return obj.spe;
			else if (stats == "inte" || stats == "int" || stats == "intelligence") return obj.inte;
			else if (stats == "wis" || stats == "wisdom") return obj.wis;
			else if (stats == "lib" || stats == "libido") return obj.lib;
			else if (stats == "sens" || stats == "sen" || stats == "sensitivity") return obj.sen;
			else return 100;
		}
		/**
		 * @return keys: str, tou, spe, inte, wis, lib, sens, cor
		 */
		public function getAllMaxStats():Object {
			return {
				str:strStat.max,
				tou:touStat.max,
				spe:speStat.max,
				inte:intStat.max,
				wis:wisStat.max,
				lib:libStat.max,
				sens:100,
				cor:100
			};
		}
		public function getAllMinStats():Object {
			return {
				str:strStat.min,
				tou:touStat.min,
				spe:speStat.min,
				inte:intStat.min,
				wis:wisStat.min,
				lib:libStat.min,
				sens:10,
				cor:0
			};
		}
		/**
		 * Called regularly to [re]apply all effects and statuses lacking proper hook
		 */
		public function updateStats():void {
			Begin("Creature","updateStats");
			var racialScores:* = this.racialScores();
			var racials:* = racialBonuses();
			
			Begin("Creature","updateStats.perks");
			//Alter max speed if you have oversized parts. (Realistic mode)
			if (flags[kFLAGS.HUNGER_ENABLED] >= 1) {
				//Balls
				var tempSpeedPenalty:Number = 0;
				var lim:int = isTaur() ? 9 : 4;
				if (ballSize > lim && balls > 0) tempSpeedPenalty += Math.round((ballSize - lim) / 2);
				//Breasts
				lim = isTaur() ? BreastCup.I : BreastCup.G;
				if (hasBreasts() && biggestTitSize() > lim) tempSpeedPenalty += ((biggestTitSize() - lim) / 2);
				//Cocks
				lim = isTaur() ? 72 : 24;
				if (biggestCockArea() > lim) tempSpeedPenalty += ((biggestCockArea() - lim) / 6);
				//Min-cap
				var penaltyMultiplier:Number = 1;
				penaltyMultiplier -= str * 0.1;
				penaltyMultiplier -= (tallness - 72) / 168;
				if (penaltyMultiplier < 0.4) penaltyMultiplier = 0.4;
				tempSpeedPenalty *= penaltyMultiplier;
				if (tempSpeedPenalty > 50) tempSpeedPenalty = 50;
				speStat.bonus.addOrReplaceBuff('oversized',-tempSpeedPenalty,{
					save:false,
					text:'Oversized!'
				});
			} else {
				speStat.bonus.removeBuff('oversized');
			}
			//Perks ahoy
			var perk:PerkClass = getPerk(PerkLib.GorgonsEyes);
			if (hasPerk(PerkLib.BasiliskResistance) && perk) {
				perk.buffHost(this,'spe',-5);
			} else {
				speStat.bonus.removeBuff(PerkLib.BasiliskResistance.id);
			}
			//Caps strength from Uma's needlework.
			setPerkStatEffect(PerkLib.ChiReflowSpeed,'strMult',UmasShop.NEEDLEWORK_SPEED_STRENGTH_MULT);
			//Caps speed from Uma's needlework.
			setPerkStatEffect(PerkLib.ChiReflowDefense,'speMult',UmasShop.NEEDLEWORK_DEFENSE_SPEED_MULT);
			setPerkStatEffect(PerkLib.BimboBrains,'intMult',-0.60);
			setPerkStatEffect(PerkLib.BroBrains,'intMult',-0.60);
			setPerkStatEffect(PerkLib.FutaForm,'intMult',-0.60);
			setPerkStatEffect(PerkLib.FutaForm,'libMult',+0.50);
			perk = getPerk(PerkLib.ProductivityDrugs);
			if (perk) {
				perk.buffHost(this, 'lib', perk.value1);
			} else {
				libStat.removeEffect(PerkLib.ProductivityDrugs.id);
			}
			End("Creature","updateStats.perks");
			
			Begin("Creature","updateStats.racial");
			strStat.mult.addOrReplaceBuff('race', racials[Race.BonusName_str] / 100, {save:false,text:'Racial'});
			touStat.mult.addOrReplaceBuff('race', racials[Race.BonusName_tou] / 100, {save:false,text:'Racial'});
			speStat.mult.addOrReplaceBuff('race', racials[Race.BonusName_spe] / 100, {save:false,text:'Racial'});
			intStat.mult.addOrReplaceBuff('race', racials[Race.BonusName_int] / 100, {save:false,text:'Racial'});
			wisStat.mult.addOrReplaceBuff('race', racials[Race.BonusName_wis] / 100, {save:false,text:'Racial'});
			libStat.mult.addOrReplaceBuff('race', racials[Race.BonusName_lib] / 100, {save:false,text:'Racial'});
			if (isNaga()) {
				strStat.mult.addOrReplaceBuff('naga',0.15,{save:false, text:'Naga'});
				speStat.mult.addOrReplaceBuff('naga',0.15,{save:false, text:'Naga'});
			} else {
				strStat.mult.removeBuff('naga');
				speStat.mult.removeBuff('naga');
			}
			if (isTaur()) {
				speStat.mult.addOrReplaceBuff('taur',0.20,{save:false, text:'Taur'});
			} else {
				speStat.mult.removeBuff('taur');
			}
			if (isDrider()) {
				touStat.mult.addOrReplaceBuff('drider',0.15,{save:false, text:'Drider'});
				speStat.mult.addOrReplaceBuff('drider',0.15,{save:false, text:'Drider'});
			} else {
				touStat.mult.removeBuff('drider');
				speStat.mult.removeBuff('drider');
			}
			if (isScylla()) {
				strStat.mult.addOrReplaceBuff('scylla',0.30,{save:false, text:'Scylla'});
			} else {
				strStat.mult.removeBuff('scylla');
			}
			if (racialScores[Race.GARGOYLE.name] >= 21) {
				if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) {
					strStat.mult.addOrReplaceBuff('gargoyle',0.20,{save:false, text:'Gargoyle'});
					intStat.mult.removeBuff('gargoyle');
				} else if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) {
					strStat.mult.removeBuff('gargoyle');
					intStat.mult.addOrReplaceBuff('gargoyle',0.20,{save:false, text:'Gargoyle'});
				} else {
					strStat.mult.removeBuff('gargoyle');
					intStat.mult.removeBuff('gargoyle');
				}
			} else {
				strStat.mult.removeBuff('gargoyle');
				intStat.mult.removeBuff('gargoyle');
			}
			var ics:Number = internalChimeraScore();
			if (ics >= 1) {
				strStat.mult.addOrReplaceBuff('chimera', 0.05 * ics,{save:false, text:'Chimera'});
				touStat.mult.addOrReplaceBuff('chimera', 0.05 * ics,{save:false, text:'Chimera'});
				speStat.mult.addOrReplaceBuff('chimera', 0.05 * ics,{save:false, text:'Chimera'});
				intStat.mult.addOrReplaceBuff('chimera', 0.05 * ics,{save:false, text:'Chimera'});
				wisStat.mult.addOrReplaceBuff('chimera', 0.05 * ics,{save:false, text:'Chimera'});
				libStat.mult.addOrReplaceBuff('chimera', 0.05 * ics,{save:false, text:'Chimera'});
			} else {
				removeStatEffects('chimera');
			}
			End("Creature","updateStats.racial");
			
			Begin("Creature","updateStats.perks2");
			setPerkStatEffect(PerkLib.ChimericalBodyInitialStage, 'touMult', 0.05);
			setPerkStatEffect(PerkLib.ChimericalBodyInitialStage, 'libMult', 0.05);
			setPerkStatEffect(PerkLib.ChimericalBodyBasicStage, 'strMult', +0.05);
			setPerkStatEffect(PerkLib.ChimericalBodyBasicStage, 'speMult', +0.05);
			setPerkStatEffect(PerkLib.ChimericalBodyBasicStage, 'intMult', +0.05);
			setPerkStatEffect(PerkLib.ChimericalBodyBasicStage, 'wisMult', +0.05);
			setPerkStatEffect(PerkLib.ChimericalBodyAdvancedStage, 'strMult', +0.10);
			setPerkStatEffect(PerkLib.ChimericalBodyAdvancedStage, 'touMult', +0.10);
			setPerkStatEffect(PerkLib.ChimericalBodyAdvancedStage, 'speMult', +0.10);
			setPerkStatEffect(PerkLib.ChimericalBodyPerfectStage, 'intMult', +0.10);
			setPerkStatEffect(PerkLib.ChimericalBodyPerfectStage, 'wisMult', +0.10);
			setPerkStatEffect(PerkLib.ChimericalBodyPerfectStage, 'libMult', +0.10);
			setPerkStatEffect(PerkLib.ChimericalBodyUltimateStage, 'strMult', +0.10);
			setPerkStatEffect(PerkLib.ChimericalBodyUltimateStage, 'touMult', +0.10);
			setPerkStatEffect(PerkLib.ChimericalBodyUltimateStage, 'speMult', +0.10);
			setPerkStatEffect(PerkLib.ChimericalBodyUltimateStage, 'intMult', +0.10);
			setPerkStatEffect(PerkLib.ChimericalBodyUltimateStage, 'wisMult', +0.10);
			setPerkStatEffect(PerkLib.ChimericalBodyUltimateStage, 'libMult', +0.10);
			setPerkStatEffect(PerkLib.SalamanderAdrenalGlands, 'touMult', +0.05);
			setPerkStatEffect(PerkLib.SalamanderAdrenalGlands, 'libMult', +0.05);
			setPerkStatEffect(PerkLib.SalamanderAdrenalGlandsEvolved, 'strMult', +0.05);
			setPerkStatEffect(PerkLib.SalamanderAdrenalGlandsEvolved, 'touMult', +0.05);
			setPerkStatEffect(PerkLib.SalamanderAdrenalGlandsEvolved, 'speMult', +0.05);
			setPerkStatEffect(PerkLib.SalamanderAdrenalGlandsEvolved, 'libMult', +0.05);
			setPerkStatEffect(PerkLib.ScyllaInkGlands, 'strMult', +0.10);
			perk = getPerk(PerkLib.MantislikeAgility);
			if (perk) {
				var perk2:PerkClass = getPerk(PerkLib.MantislikeAgilityEvolved);
				var mult:Number = 1.0;
				if (perk2) {
					mult = 2.0;
					perk = perk2;
					speStat.mult.removeBuff(PerkLib.MantislikeAgility.id);
				} else {
					speStat.mult.removeBuff(PerkLib.MantislikeAgilityEvolved.id);
				}
				if (hasCoatOfType(Skin.CHITIN) && hasPerk(PerkLib.ThickSkin)) perk.buffHost(this,'speMult', +0.20*mult);
				else if ((skinType == Skin.SCALES && hasPerk(PerkLib.ThickSkin)) || hasCoatOfType(Skin.CHITIN)) perk.buffHost(this,'speMult', +0.15*mult);
				else if (skinType == Skin.SCALES) perk.buffHost(this, 'speMult', +0.10*mult);
				else if (hasPerk(PerkLib.ThickSkin)) perk.buffHost(this, 'speMult', +0.05*mult);
			} else {
				speStat.mult.removeBuff(PerkLib.MantislikeAgility.id);
				speStat.mult.removeBuff(PerkLib.MantislikeAgilityEvolved.id);
			}
			setPerkStatEffect(PerkLib.DraconicLungs, 'speMult', +0.05);
			setPerkStatEffect(PerkLib.DraconicLungsEvolved, 'touMult', +0.05);
			setPerkStatEffect(PerkLib.DraconicLungsEvolved, 'speMult', +0.05);
			setPerkStatEffect(PerkLib.KitsuneThyroidGland, 'speMult', +0.05);
			setPerkStatEffect(PerkLib.KitsuneThyroidGlandEvolved, 'speMult', +0.05);
			setPerkStatEffect(PerkLib.KitsuneThyroidGlandEvolved, 'wisMult', +0.05);
			setPerkStatEffect(PerkLib.CatlikeNimblenessEvolved, 'speMult', +0.10);
			setPerkStatEffect(PerkLib.GargoylePure, 'wisMult', +0.80);
			setPerkStatEffect(PerkLib.GargoylePure, 'libMult', -0.10);
			setPerkStatEffect(PerkLib.GargoyleCorrupted, 'wisMult', -0.10);
			setPerkStatEffect(PerkLib.GargoyleCorrupted, 'libMult', +0.80);

			setPerkStatEffect(PerkLib.JobCourtesan, 'libMult', +0.15);
			setPerkStatEffect(PerkLib.JobDervish, 'speMult', +0.10);
			setPerkStatEffect(PerkLib.JobDefender, 'touMult', +0.15);
			setPerkStatEffect(PerkLib.JobElementalConjurer, 'wisMult', +0.05);
			setPerkStatEffect(PerkLib.JobEnchanter, 'intMult', +0.15);
			setPerkStatEffect(PerkLib.JobEromancer, 'intMult', +0.05);
			setPerkStatEffect(PerkLib.JobEromancer, 'libMult', +0.05);
			setPerkStatEffect(PerkLib.JobGuardian, 'touMult', +0.05);
			setPerkStatEffect(PerkLib.JobHunter, 'speMult', +0.10);
			setPerkStatEffect(PerkLib.JobHunter, 'intMult', +0.05);
			setPerkStatEffect(PerkLib.JobKnight, 'touMult', +0.10);
			setPerkStatEffect(PerkLib.AdvancedJobMonk, 'wisMult', +0.15);
			setPerkStatEffect(PerkLib.JobRanger, 'speMult', +0.05);
			setPerkStatEffect(PerkLib.JobSeducer, 'libMult', +0.05);
			setPerkStatEffect(PerkLib.JobSorcerer, 'intMult', +0.05);
			setPerkStatEffect(PerkLib.JobWarrior, 'strMult', +0.05);
			setPerkStatEffect(PerkLib.PrestigeJobArcaneArcher, 'speMult', +0.40);
			setPerkStatEffect(PerkLib.PrestigeJobArcaneArcher, 'intMult', +0.40);
			setPerkStatEffect(PerkLib.PrestigeJobBerserker, 'strMult', +0.60);
			setPerkStatEffect(PerkLib.PrestigeJobBerserker, 'touMult', +0.20);
			setPerkStatEffect(PerkLib.PrestigeJobSentinel, 'strMult', +0.20);
			setPerkStatEffect(PerkLib.PrestigeJobSentinel, 'touMult', +0.60);
			setPerkStatEffect(PerkLib.PrestigeJobKiArtMaster, 'strMult', +0.40);
			setPerkStatEffect(PerkLib.PrestigeJobKiArtMaster, 'wisMult', +0.40);
			setPerkStatEffect(PerkLib.WeaponMastery, 'strMult', +0.05);
			setPerkStatEffect(PerkLib.ElementalConjurerResolve, 'strMult', -0.15);
			setPerkStatEffect(PerkLib.ElementalConjurerResolve, 'touMult', -0.15);
			setPerkStatEffect(PerkLib.ElementalConjurerResolve, 'speMult', -0.15);
			setPerkStatEffect(PerkLib.ElementalConjurerResolve, 'intMult', +0.20);
			setPerkStatEffect(PerkLib.ElementalConjurerResolve, 'wisMult', +0.30);
			setPerkStatEffect(PerkLib.ElementalConjurerDedication, 'strMult', -0.30);
			setPerkStatEffect(PerkLib.ElementalConjurerDedication, 'touMult', -0.30);
			setPerkStatEffect(PerkLib.ElementalConjurerDedication, 'speMult', -0.30);
			setPerkStatEffect(PerkLib.ElementalConjurerDedication, 'intMult', +0.40);
			setPerkStatEffect(PerkLib.ElementalConjurerDedication, 'wisMult', +0.60);
			setPerkStatEffect(PerkLib.ElementalConjurerSacrifice, 'strMult', -0.45);
			setPerkStatEffect(PerkLib.ElementalConjurerSacrifice, 'touMult', -0.45);
			setPerkStatEffect(PerkLib.ElementalConjurerSacrifice, 'speMult', -0.45);
			setPerkStatEffect(PerkLib.ElementalConjurerSacrifice, 'intMult', +0.60);
			setPerkStatEffect(PerkLib.ElementalConjurerSacrifice, 'wisMult', +0.90);
			End("Creature","updateStats.perks2");
			
			End("Creature","updateStats");
		}
		/**
		 * Modify stats.
		 *
		 * Arguments should come in pairs nameOp:String, value:Number/Boolean <br/>
		 * where nameOp is ( stat_name + [operator] ) and value is operator argument<br/>
		 * valid operators are "=" (set), "+", "-", "*", "/", add is default.<br/>
		 * valid stat_names are "str", "tou", "spe", "int", "wis", "lib", "sen", "lus", "cor" or their full names;
		 * also "scaled"/"scale"/"sca" (default true: apply resistances, perks; false - force values)
		 *
		 * @return Object of (newStat-oldStat) with keys str, tou, spe, inte, wis, lib, sens, lust, cor
		 * */
		public function dynStats(... args):Object {
			Begin("Creature","dynStats");
			var argz:Object = parseDynStatsArgs(this, args);
			var prevStr:Number  = str;
			var prevTou:Number  = tou;
			var prevSpe:Number  = spe;
			var prevInte:Number  = inte;
			var prevWis:Number  = wis;
			var prevLib:Number  = lib;
			var prevSens:Number  = sens;
			var prevLust:Number  = lust;
			var prevCor:Number  = cor;
			modStats(argz.str, argz.tou, argz.spe, argz.inte, argz.wis, argz.lib, argz.sens, argz.lust, argz.cor, argz.scale);
			End("Creature","dynStats");
			trace("dynStats("+args.join(", ")+") => ("+[str,tou,spe,inte,wis,lib,sens,lust,cor].join(", ")+")");
			return {
				str:str-prevStr,
				tou:tou-prevTou,
				spe:spe-prevSpe,
				inte:inte-prevInte,
				wis:wis-prevWis,
				lib:lib-prevLib,
				sens:sens-prevSens,
				lust:lust-prevLust,
				cor:cor-prevCor
			};
		}
		public function drainStat(statname:String, damage:Number):Number {
			var stat:BuffableStat = stats[statname + 'Bonus'];
			if (!stat) {
				// TODO report error
				return NaN;
			}
			if (damage == 0) return 0;
			var delta:Number = -damage;
			var current:Number = stat.valueOfBuff('drain');
			if (delta > 0 && delta+current > 0) delta = -current;
			stat.addOrIncreaseBuff('drain', delta,{text:'Drain'});
			return damage;
		}
		public function removeStatEffects(tag:String):void {
			for (var statname:String in stats) {
				var stat:BuffableStat = stats[statname] as BuffableStat;
				if (!stat) continue;
				stat.removeBuff(tag);
			}
		}
		/**
		 * If perk is present, add/replace stat buff. If not, remove stat buff
 		 */
		public function setPerkStatEffect(ptype:PerkType,statname:String,value:Number):void {
			var stat:BuffableStat = (stats[statname] as BuffableStat) || (stats[statname] as PrimaryStat).bonus;
			var perk:PerkClass    = getPerk(ptype);
			if (perk) {
				stat.addOrReplaceBuff(ptype.id,value,{save:false,text:ptype.name});
			} else {
				stat.removeBuff(ptype.id);
			}
		}
		public function modStats(dstr:Number, dtou:Number, dspe:Number, dinte:Number, dwis:Number, dlib:Number, dsens:Number, dlust:Number, dcor:Number, scale:Boolean):void {
			var maxes:Object;
			maxes = getAllMaxStats();
			maxes.lust = maxLust();
			var mins:Object = getAllMinStats();
			mins.lust = minLust();
			var oldHPratio:Number = hp100/100;
			drainStat('str', -dstr);
			drainStat('tou', -dtou);
			drainStat('spe', -dspe);
			drainStat('int', -dinte);
			drainStat('wis', -dwis);
			drainStat('lib', -dlib);
			updateStats();
			sens = Utils.boundFloat(mins.sens, sens + dsens, maxes.sens);
			lust = Utils.boundFloat(mins.lust, lust + dlust, maxes.lust);
			cor  = Utils.boundFloat(mins.cor, cor + dcor, maxes.cor);
			
			// old_hp / old_max = new_hp / new_max
			HP = oldHPratio * maxHP();
			
			// Keep values in bounds (lust and HP handled above)
			fatigue = Math.min(fatigue, maxFatigue());
			mana = Math.min(mana, maxMana());
			ki = Math.min(ki, maxKi());
			wrath = Math.min(wrath,maxWrath());
		}
		// Lust gain, in % (100 = receive as is, 25 = receive one fourth, 0 = immune)
		public function lustPercent():Number {
			return 100;
		}
		public function takePhysDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeMagicDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeLustDamage(lustDmg:Number, display:Boolean = true, applyRes:Boolean = true):Number{
			if (applyRes) lustDmg *= lustPercent()/100;
			lust = boundFloat(minLust(),lust+Math.round(lustDmg),maxLust());
			return (lustDmg > 0 && lustDmg < 1) ? 1 : lustDmg;
		}
		/**
		 * Get the remaining fatigue of the Creature.
		 * @return maximum amount of fatigue that still can be used
		 */
		public function fatigueLeft():Number
		{
			return maxFatigue() - fatigue;
		}

		/*
		
		[    A P P E A R A N C E    ]
		
		*/
		
		//Appearance Variables
		//Gender 1M, 2F, 3H
		public function get gender():int {
			if (hasCock() && hasVagina()) return Gender.GENDER_HERM;
			if (hasCock()) return Gender.GENDER_MALE;
			if (hasVagina()) return Gender.GENDER_FEMALE;
			return Gender.GENDER_NONE;
		}
		private var _tallness:Number = 0;
		public function get tallness():Number { return _tallness; }
		public function set tallness(value:Number):void { _tallness = value; }

		/*Hairtype
		0- normal
		1- feather
		2- ghost
		3- goo!
		4- anemononeoenoeneo!*/
		public var hairType:Number = Hair.NORMAL;
		private var _hairColor:String = "no";
		public var hairLength:Number = 0;
		public function get hairColor():String {
			return _hairColor;
		}
		public function set hairColor(value:String):void {
			_hairColor = value;
			if (!skin.hasCoat()) skin.coat.color = value;
		}

		public function get coatColor():String {
			if (!skin.hasCoat()) return hairColor;
			return skin.coat.color;
		}
		public function set coatColor(value:String):void {
			if (!skin.hasCoat()) trace("[WARNING] set coatColor() called with no coat");
			skin.coat.color = value;
		}

		public var beardStyle:Number = Beard.NORMAL;
		public var beardLength:Number = 0;
				
		public var skin:Skin;
		public function get skinType():Number { return skin.type; }
	//	[Deprecated]
		public function set skinType(value:Number):void {
			trace("[DEPRECATED] set skinType");
			skin.type = value;
		}
		public function get skinTone():String { return skin.tone; }
		public function hasCoat():Boolean { return skin.hasCoat(); }
		public function hasFullCoat():Boolean { return skin.hasFullCoat(); }
		/**
		 * @return -1 if hasCoat(), skin.coat.type otherwise
		 */
		public function coatType():int { return skin.coatType(); }
		public function hasCoatOfType(...types:Array):Boolean { return skin.hasCoatOfType.apply(skin,types); }
		public function hasFullCoatOfType(...types:Array):Boolean { return skin.hasFullCoatOfType.apply(skin,types); }
	//	[Deprecated]
		public function set skinTone(value:String):void {
			trace("[DEPRECATED] set skinTone");
			if (skin.coverage >= Skin.COVERAGE_HIGH) skin.coat.color = value;
			else skin.base.color = value;
		}
		public function get skinDesc():String { return skin.desc; }
	//	[Deprecated]
		public function set skinDesc(value:String):void {
			trace("[DEPRECATED] set skinDesc");
			if (skin.coverage >= Skin.COVERAGE_HIGH) skin.coat.desc = value;
			else skin.base.desc = value;
		}
		public function get skinAdj():String { return skin.adj; }
	//	[Deprecated]
		public function set skinAdj(value:String):void {
			trace("[DEPRECATED] set skinAdj");
			if (skin.coverage >= Skin.COVERAGE_HIGH) skin.coat.adj = value;
			else skin.base.adj = value;
		}
		
		public var facePart:Face;
		public function get faceType():Number { return facePart.type; }
		public function set faceType(value:Number):void { facePart.type = value; }

		// <mod name="Predator arms" author="Stadler76">
		public var clawsPart:Claws;
		public function get clawTone():String { return this.clawsPart.tone; }
		public function set clawTone(value:String):void { this.clawsPart.tone = value; }
		public function get clawType():int{ return this.clawsPart.type ; }
		public function set clawType(value:int):void { this.clawsPart.type = value; }
		// </mod>
		public var underBody:UnderBody;
		public var ears:Ears = new Ears();
		public var horns:Horns = new Horns();
		public var wings:Wings = new Wings();
		
		/* lowerBody: see LOWER_BODY_TYPE_ */
		public var lowerBodyPart:LowerBody;
		public function get lowerBody():int { return lowerBodyPart.type; }
		public function set lowerBody(value:int):void { lowerBodyPart.type = value; }
		public function get legCount():int { return lowerBodyPart.legCount; }
		public function set legCount(value:int):void{ lowerBodyPart.legCount = value; }

		public var tail:Tail;
		public function get tailType():int { return tail.type; }
		public function get tailVenom():int { return tail.venom; }
		public function get tailCount():Number { return tail.count; }
		public function get tailRecharge():Number { return tail.recharge; }
		public function set tailType(value:int):void { tail.type = value; }
		public function set tailVenom(value:int):void { tail.venom = value; }
		public function set tailCount(value:Number):void { tail.count = value; }
		public function set tailRecharge(value:Number):void { tail.recharge = value; }
		

		public var hips:Hips = new Hips();
		public var butt:Butt = new Butt();
		
		//Piercings
		//TODO: Pull this out into it's own class and enum.
		public var nipplesPierced:Number = 0;
		public var nipplesPShort:String = "";
		public var nipplesPLong:String = "";
		public var lipPierced:Number = 0;
		public var lipPShort:String = "";
		public var lipPLong:String = "";
		public var tonguePierced:Number = 0;
		public var tonguePShort:String = "";
		public var tonguePLong:String = "";
		public var eyebrowPierced:Number = 0;
		public var eyebrowPShort:String = "";
		public var eyebrowPLong:String = "";
		public var earsPierced:Number = 0;
		public var earsPShort:String = "";
		public var earsPLong:String = "";
		public var nosePierced:Number = 0;
		public var nosePShort:String = "";
		public var nosePLong:String = "";

		//Head ornaments. Definitely need to convert away from hard coded types.
		public var antennae:Antennae = new Antennae();
		public var eyes:Eyes = new Eyes();
		public var tongue:Tongue = new Tongue();
		public var arms:Arms = new Arms();
		
		public var gills:Gills = new Gills();
		public function hasGills():Boolean { return gills.type != Gills.NONE; }
		
		public var rearBody:RearBody = new RearBody();

		//Sexual Stuff		
		//MALE STUFF
		//public var cocks:Array;
		//TODO: Tuck away into Male genital class?
		public var cocks:Array;
		//balls
		public var balls:Number = 0;
		public var cumMultiplier:Number = 1;
		public var ballSize:Number = 0;
		
		private var _hoursSinceCum:Number = 0;
		public function get hoursSinceCum():Number { return _hoursSinceCum; }
		public function set hoursSinceCum(v:Number):void {
			/*if (v == 0)
			{
				trace("noop");
			}*/
			_hoursSinceCum = v;
		}
		
		//FEMALE STUFF
		//TODO: Box into Female genital class?
		public var vaginas:Vector.<VaginaClass>;
		//Fertility is a % out of 100.
		public var fertility:Number = 10;
		public var nippleLength:Number = .25;
		public var breastRows:/*BreastRowClass*/Array;
		public var ass:AssClass = new AssClass();

		public function get clitLength():Number {
			if (vaginas.length==0) {
				trace("[ERROR] get clitLength called with no vaginas present");
				return VaginaClass.DEFAULT_CLIT_LENGTH;
			}
			return vaginas[0].clitLength;
		}

		public function set clitLength(value:Number):void {
			if (vaginas.length==0) {
				trace("[ERROR] set clitLength called with no vaginas present");
				return;
			}
			vaginas[0].clitLength = value;
		}

		//Constructor
		public function Creature()
		{
			skin = new Skin(this);
			underBody = new UnderBody(this);
			lowerBodyPart = new LowerBody(this);
			clawsPart = new Claws(this);
			facePart = new Face(this);
			tail = new Tail(this);
			//cocks = new Array();
			//The world isn't ready for typed Arrays just yet.
			cocks         = [];
			vaginas       = new Vector.<VaginaClass>();
			ass           = new AssClass();
			ass.host      = this;
			breastRows    = [];
			_perks        = [];
			statusEffects = [];
			//keyItems = new Array();
		}

		/**
		 * Check if the Creature has a vagina. If not, throw an informative Error.
		 * This should be more informative than the usual RangeError (Out of bounds).
		 * @throws IllegalOperationError if no vagina is present
		 */
		private function checkVaginaPresent():void {
			if (!hasVagina()) {
				throw new IllegalOperationError("Creature does not have vagina.")
			}
		}

		/**
		 * Change the clit length by the given amount. If the resulting length drops below 0, it will be set to 0 instead.
		 * @param	delta the amount to change, can be positive or negative
		 * @param	vaginaIndex the vagina whose clit will be changed
		 * @return the updated clit length
		 * @throws IllegalOperationError if the Creature does not have a vagina
		 * @throws RangeError if the selected vagina cannot be found
		 */
		public function changeClitLength(delta:Number, vaginaIndex:int = 0):Number {
			checkVaginaPresent();
			var newClitLength:Number = vaginas[vaginaIndex].clitLength += delta;
			return newClitLength < 0 ? 0 : newClitLength;
		}

		private var _femininity:Number = 50;
		public function get femininity():Number {
			var fem:Number                 = _femininity;
			const effect:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (effect != null && effect.value1 == UmasShop.MASSAGE_MODELLING_BONUS) {
				fem += effect.value2;
			}
			if (fem > 100)
				fem = 100;
			return fem;
		}
		public function set femininity(value:Number):void
		{
			if (value > 100)
				value = 100;
			else if (value < 0)
				value = 0;
			_femininity = value;
		}

		public function validate():String
		{
			var error:String = "";
			// 2. Value boundaries etc
			// 2.1. non-negative Number fields
			error += Utils.validateNonNegativeNumberFields(this,"Monster.validate",[
				"balls", "ballSize", "cumMultiplier", "hoursSinceCum",
				"tallness", "hips.type", "butt.type", "lowerBody", "arms.type",
				"hairLength", "hairType",
				"faceType", "ears.type", "tongue.type", "eyes.type",
				"str", "tou", "spe", "inte", "wis", "lib", "sens", "cor",
				// Allow weaponAttack to be negative as a penalty to strength-calculated damage
				// Same with armorDef, bonusHP, additionalXP
				"weaponValue", "armorValue",
				"lust", "fatigue", "ki", "mana", "wrath",
				"level", "gems",
				"tailCount", "tailVenom", "tailRecharge", "horns.type",
				"HP", "XP"
			]);
			// 2.2. non-empty String fields
			error += Utils.validateNonEmptyStringFields(this,"Monster.validate",[
				"short",
				"skinDesc", "eyes.colour",
				"weaponName", "weaponVerb", "armorName"
			]);
			// 3. validate members
			for each (var cock:Cock in cocks) {
				error += cock.validate();
			}
			for each (var vagina:VaginaClass in vaginas) {
				error += vagina.validate();
			}
			for each (var row:BreastRowClass in breastRows) {
				error += row.validate();
			}
			error += ass.validate();
			// 4. Inconsistent fields
			// 4.1. balls
			if (balls>0 && ballSize<=0){
				error += "Balls are present but ballSize = "+ballSize+". ";
			}
			if (ballSize>0 && balls<=0){
				error += "No balls but ballSize = "+ballSize+". ";
			}
			// 4.2. hair
			if (hairLength <= 0) {
				if (hairType != Hair.NORMAL) error += "No hair but hairType = " + hairType + ". ";
			}
			// 4.3. tail
			if (tailType == Tail.NONE) {
				if (tailCount != 0) error += "No tail but tailCount = "+tailCount+". ";
			}
			// 4.4. horns
			if (horns.type == Horns.NONE){
				if (horns.count > 0) error += "horns > 0 but horns.type = NONE. ";
			} else {
				if (horns.count == 0) error += "Has horns but their number 'horns' = 0. ";
			}
			return error;
		}
		
		public function racialScore(race:Race):int {
			Begin("Creature","racialScore",race.name);
			var score:int = race.scoreFor(this,Race.MetricsFor(this));
			End("Creature","racialScore");
			return score;
		}
		public function racialScores():* {
			return Race.AllScoresFor(this);
		}
		public function racialBonuses():* {
			return Race.AllBonusesFor(this);
		}
		
		
		
		//Determine Chimera Race Rating
		public function chimeraScore():Number {
			Begin("Player","racialScore","chimera");
			var chimeraCounter:Number = 0;
			var racialScores:* = this.racialScores();
			if (racialScores[Race.CAT.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.LIZARD.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.DRAGON.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.RACCOON.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.DOG.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.WOLF.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.WEREWOLF.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.FOX.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.FERRET.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.KITSUNE.name] >= 5)
				chimeraCounter++;
			if (racialScores[Race.HORSE.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.MINOTAUR.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.COW.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.BEE.name] >= 5)
				chimeraCounter++;
			if (racialScores[Race.GOBLIN.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.DEMON.name] >= 5)
				chimeraCounter++;
			if (racialScores[Race.DEVILKIN.name] >= 7)
				chimeraCounter++;
			if (racialScores[Race.SHARK.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.ORCA.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.ONI.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.ELF.name] >= 5)
				chimeraCounter++;
			if (racialScores[Race.RAIJU.name] >= 5)
				chimeraCounter++;
			if (racialScores[Race.BUNNY.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.HARPY.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.SPIDER.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.KANGA.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.MOUSE.name] >= 3)
				chimeraCounter++;
			if (racialScores[Race.SCORPION.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.MANTIS.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.SALAMANDER.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.NAGA.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.PHOENIX.name] >= 10)
				chimeraCounter++;
			if (racialScores[Race.SCYLLA.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.PLANT.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.PIG.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.SATYR.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.RHINO.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.ECHIDNA.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.DEER.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.MANTICORE.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.REDPANDA.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.SIREN.name] >= 10)
				chimeraCounter++;
			if (racialScores[Race.YETI.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.BAT.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.VAMPIRE.name] >= 6)
				chimeraCounter++;
			if (racialScores[Race.JABBERWOCKY.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.AVIAN.name] >= 4)
				chimeraCounter++;
			if (racialScores[Race.GARGOYLE.name] >= 21)
				chimeraCounter++;
			if (racialScores[Race.GOO.name] >= 4)
				chimeraCounter++;
			
			End("Player","racialScore");
			return chimeraCounter;
		}
		
		//Determine Grand Chimera Race Rating
		public function grandchimeraScore():Number {
			Begin("Player","racialScore","grandchimera");
			var grandchimeraCounter:Number = 0;
			var racialScores:* = this.racialScores();
			if (racialScores[Race.CAT.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.NEKOMATA.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.CHESHIRE.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.LIZARD.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.DRAGON.name] >= 10)
				grandchimeraCounter++;
			/*			if (racialScores[Race.RACCOON.name] >= 4)
							grandchimeraCounter++;
						if (racialScores[Race.DOG.name] >= 4)
							grandchimeraCounter++;
						if (racialScores[Race.WOLF.name] >= 6)
							grandchimeraCounter++;
			*/			if (racialScores[Race.WEREWOLF.name] >= 12)
				grandchimeraCounter++;
			if (racialScores[Race.FOX.name] >= 7)
				grandchimeraCounter++;
//			if (racialScores[Race.FERRET.name] >= 4)
//				grandchimeraCounter++;
			if (racialScores[Race.KITSUNE.name] >= 6 && tailType == 13 && tailCount >= 2)
				grandchimeraCounter++;
			if (racialScores[Race.HORSE.name] >= 7)
				grandchimeraCounter++;
			if (racialScores[Race.UNICORN.name] >= 9)
				grandchimeraCounter++;
			if (racialScores[Race.ALICORN.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.CENTAUR.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.MINOTAUR.name] >= 9)
				grandchimeraCounter++;
			if (racialScores[Race.COW.name] >= 9)
				grandchimeraCounter++;
			if (racialScores[Race.BEE.name] >= 9)
				grandchimeraCounter++;
//			if (racialScores[Race.GOBLIN.name] >= 4)
//				grandchimeraCounter++;
			if (racialScores[Race.DEMON.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.DEVILKIN.name] >= 10)
				grandchimeraCounter++;
			if (racialScores[Race.SHARK.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.ORCA.name] >= 12)
				grandchimeraCounter++;
			if (racialScores[Race.ONI.name] >= 12)
				grandchimeraCounter++;
			if (racialScores[Race.ELF.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.RAIJU.name] >= 10)
				grandchimeraCounter++;
//			if (racialScores[Race.BUNNY.name] >= 4)
//				grandchimeraCounter++;
			if (racialScores[Race.HARPY.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.SPIDER.name] >= 7)
				grandchimeraCounter++;
			/*			if (racialScores[Race.KANGA.name] >= 4)
							grandchimeraCounter++;
						if (racialScores[Race.MOUSE.name] >= 3)
							grandchimeraCounter++;
						if (racialScores[Race.SCORPION.name] >= 4)
							grandchimeraCounter++;
			*/			if (racialScores[Race.MANTIS.name] >= 12)
				grandchimeraCounter++;
			if (racialScores[Race.SALAMANDER.name] >= 7)
				grandchimeraCounter++;
			if (racialScores[Race.NAGA.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.GORGON.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.VOUIVRE.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.COUATL.name] >= 11)
				grandchimeraCounter++;
			if (racialScores[Race.PHOENIX.name] >= 10)
				grandchimeraCounter++;
			if (racialScores[Race.SCYLLA.name] >= 7)
				grandchimeraCounter++;
//			if (racialScores[Race.PLANT.name] >= 6)
//				grandchimeraCounter++;
			if (racialScores[Race.ALRAUNE.name] >= 10)
				grandchimeraCounter++;
			if (racialScores[Race.YGGDRASIL.name] >= 10)
				grandchimeraCounter++;
			/*			if (racialScores[Race.PIG.name] >= 4)
							grandchimeraCounter++;
						if (racialScores[Race.SATYR.name] >= 4)
							grandchimeraCounter++;
						if (racialScores[Race.RHINO.name] >= 4)
							grandchimeraCounter++;
						if (racialScores[Race.ECHIDNA.name] >= 4)
							grandchimeraCounter++;
						if (racialScores[Race.DEER.name] >= 4)
							grandchimeraCounter++;
			*/			if (racialScores[Race.MANTICORE.name] >= 12)
				grandchimeraCounter += 2;
			if (racialScores[Race.REDPANDA.name] >= 8)
				grandchimeraCounter++;
			if (racialScores[Race.SIREN.name] >= 10)
				grandchimeraCounter++;
			if (racialScores[Race.YETI.name] >= 12)
				grandchimeraCounter++;
			if (racialScores[Race.BAT.name] >= 10)
				grandchimeraCounter++;
			if (racialScores[Race.VAMPIRE.name] >= 10)
				grandchimeraCounter++;
			if (racialScores[Race.JABBERWOCKY.name] >= 10)
				grandchimeraCounter++;
			if (racialScores[Race.AVIAN.name] >= 9)
				grandchimeraCounter++;
			if (racialScores[Race.GARGOYLE.name] >= 21)
				grandchimeraCounter++;
			if (racialScores[Race.GOO.name] >= 8)
				grandchimeraCounter++;
			
			End("Player","racialScore");
			return grandchimeraCounter;
		}
		
		//Determine Inner Chimera Score
		public function internalChimeraScore():Number {
			Begin("Player","racialScore","internalChimeraScore");
			var internalChimeraCounter:Number = 0;
			if (hasPerk(PerkLib.BlackHeart))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.CatlikeNimbleness))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.CatlikeNimblenessEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.DraconicLungs))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.DraconicLungsEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.GorgonsEyes))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.KitsuneThyroidGland))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.KitsuneThyroidGlandEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.LizanMarrow))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.LizanMarrowEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.ManticoreMetabolism))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.MantislikeAgility))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.MantislikeAgilityEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.SalamanderAdrenalGlands))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.SalamanderAdrenalGlandsEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.ScyllaInkGlands))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.TrachealSystem))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.TrachealSystemEvolved))
				internalChimeraCounter++;
			if (hasPerk(PerkLib.TrachealSystemFinalForm))
				internalChimeraCounter++;
			//	if (hasPerk(PerkLib.TrachealSystemEvolved))
			//		internalChimeraCounter++;
			
			End("Player","racialScore");
			return internalChimeraCounter;
		}
		
		//Determine Inner Chimera Rating
		public function internalChimeraRating():Number {
			Begin("Player","racialScore","internalChimeraRating");
			var internalChimeraRatingCounter:Number = 0;
			if (hasPerk(PerkLib.BlackHeart))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.CatlikeNimbleness))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.CatlikeNimblenessEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.DraconicLungs))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.DraconicLungsEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.GorgonsEyes))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.KitsuneThyroidGland))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.KitsuneThyroidGlandEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.LizanMarrow))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.LizanMarrowEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.ManticoreMetabolism))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.MantislikeAgility))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.MantislikeAgilityEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.SalamanderAdrenalGlands))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.SalamanderAdrenalGlandsEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.ScyllaInkGlands))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.TrachealSystem))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.TrachealSystemEvolved))
				internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.TrachealSystemFinalForm))
				internalChimeraRatingCounter++;
			//	if (hasPerk(PerkLib.TrachealSystemEvolved))
			//		internalChimeraRatingCounter++;
			if (hasPerk(PerkLib.ChimericalBodyInitialStage))
				internalChimeraRatingCounter -= 2;
			if (hasPerk(PerkLib.ChimericalBodyBasicStage))
				internalChimeraRatingCounter -= 3;
			if (hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				internalChimeraRatingCounter -= 4;
			if (hasPerk(PerkLib.ChimericalBodySemiPerfectStage))
				internalChimeraRatingCounter -= 5;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				internalChimeraRatingCounter -= 6;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage))
				internalChimeraRatingCounter -= 7;
			End("Player","racialScore");
			return internalChimeraRatingCounter;
		}
		
		/*
		
		[        P E R K S          ]
		
		*/
		//Monsters have few perks, which I think should be a status effect for clarity's sake.
		//TODO: Move perks into monster status effects.
		private var _perks:Array;
		public function perk(i:int):PerkClass{
			return _perks[i];
		}
		public function get perks():Array {
			return _perks;
		}
		public function get numPerks():int {
			return _perks.length;
		}
		//Current status effects. This has got very muddy between perks and status effects. Will have to look into it.
		//Someone call the grammar police!
		//TODO: Move monster status effects into perks. Needs investigation though.
		public var statusEffects:Array;


		//Functions

		//Create a perk
		public function createPerk(ptype:PerkType, value1:Number, value2:Number, value3:Number, value4:Number):PerkClass
		{
			var newPerk:PerkClass = new PerkClass(ptype, value1, value2, value3, value4);
			perks.push(newPerk);
			perks.sortOn("perkName");
			return newPerk;
		}

		/**
		 * Remove perk. Return true if there was such perk
		 */
		public function removePerk(ptype:PerkType):Boolean
		{
			var counter:Number = perks.length;
			//Various Errors preventing action
			if (perks.length <= 0)
			{
				return false;
			}
			if (perkv4(ptype) > 0)
			{
				// trace('ERROR! Attempted to remove permanent "' + ptype.name + '" perk.');
				return false;
			}
			while (counter > 0)
			{
				counter--;
				if (perk(counter).ptype == ptype)
				{
					perks.splice(counter, 1);
					//trace("Attempted to remove \"" + perkName + "\" perk.");
					return true;
				}
			}
			return false;
		}

		//has perk?
		[Deprecated(replacement="hasPerk:Boolean or getPerk:PerkClass")]
		public function findPerk(ptype:PerkType):Number
		{
			if (perks.length <= 0)
				return -2;
			for (var counter:int = 0; counter<perks.length; counter++)
			{
				if (perk(counter).ptype == ptype)
					return counter;
			}
			return -1;
		}

		public function hasPerk(ptype:PerkType):Boolean {
			return getPerk(ptype) != null;
		}

		public function getPerk(ptype:PerkType):PerkClass {
			for each(var pk:PerkClass in perks){
				if(pk.ptype == ptype){
					return pk;
				}
			}
			return null;
		}

		//Duplicate perk
		//Deprecated?
		public function perkDuplicated(ptype:PerkType):Boolean
		{
			var timesFound:int = 0;
			if (perks.length <= 0)
				return false;
			for (var counter:int = 0; counter<perks.length; counter++)
			{
				if (perk(counter).ptype == ptype)
					timesFound++;
			}
			return (timesFound > 1);
		}

		//remove all perks
		public function removePerks():void
		{
			_perks = [];
		}

		public function addPerkValue(ptype:PerkType, valueIdx:Number = 1, bonus:Number = 0): void
		{
			var pk:PerkClass = getPerk(ptype);
			if (!pk) {
				trace("ERROR? Looking for perk '" + ptype + "' to change value " + valueIdx + ", and player does not have the perk.");
				return;
			}
			switch(valueIdx){
				case 1: pk.value1 += bonus; break;
				case 2: pk.value2 += bonus; break;
				case 3: pk.value3 += bonus; break;
				case 4: pk.value4 += bonus; break;
				default:
					return CoC_Settings.error("addPerkValue(" + ptype.id + ", " + valueIdx + ", " + bonus + ").");
			}
		}

		public function setPerkValue(ptype:PerkType, valueIdx:Number = 1, newNum:Number = 0): void
		{
			var pk:PerkClass = getPerk(ptype);
			if (!pk) {
				trace("ERROR? Looking for perk '" + ptype + "' to change value " + valueIdx + ", and player does not have the perk.");
				return;
			}
			switch(valueIdx){
				case 1: pk.value1 = newNum; break;
				case 2: pk.value2 = newNum; break;
				case 3: pk.value3 = newNum; break;
				case 4: pk.value4 = newNum; break;
				default:
					return CoC_Settings.error("setPerkValue(" + ptype.id + ", " + valueIdx + ", " + newNum + ").");
			}
		}

		public function perkval(ptype:PerkType, valIdx:int = 1):Number {
			var pk:PerkClass = getPerk(ptype);
			if(!pk) {return 0;}
			switch(valIdx){
				case 1: return pk.value1;
				case 2: return pk.value2;
				case 3: return pk.value3;
				case 4: return pk.value4;
				default: CoC_Settings.error("perkval("+ptype.id+", "+valIdx+")");
					return 0;
			}
		}

		public function perkv1(ptype:PerkType):Number
		{
			return perkval(ptype, 1);
		}

		public function perkv2(ptype:PerkType):Number
		{
			return perkval(ptype, 2);
		}

		public function perkv3(ptype:PerkType):Number
		{
			return perkval(ptype, 3);
		}

		public function perkv4(ptype:PerkType):Number
		{
			return perkval(ptype, 4);
		}
		
		/*
		
		[    S T A T U S   E F F E C T S    ]
		
		*/
		//{region StatusEffects
		public function createOrFindStatusEffect(stype:StatusEffectType):StatusEffectClass
		{
			var sec:StatusEffectClass = statusEffectByType(stype);
			if (!sec) sec = createStatusEffect(stype,0,0,0,0);
			return sec;
		}
		//Create a status
		public function createStatusEffect(stype:StatusEffectType, value1:Number, value2:Number, value3:Number, value4:Number, fireEvent:Boolean = true):StatusEffectClass
		{
			var newStatusEffect:StatusEffectClass = stype.create(value1,value2,value3,value4);
			statusEffects.push(newStatusEffect);
			newStatusEffect.addedToHostList(this,fireEvent);
			return newStatusEffect;
		}
		public function addStatusEffect(sec:StatusEffectClass/*,fireEvent:Boolean = true*/):void {
			if (sec.host != this) {
				sec.remove();
				sec.attach(this/*,fireEvent*/);
			} else {
				statusEffects.push(sec);
				sec.addedToHostList(this,true);
			}
		}
		//Remove a status
		public function removeStatusEffect(stype:StatusEffectType/*, fireEvent:Boolean = true*/):StatusEffectClass
		{
			var counter:Number = indexOfStatusEffect(stype);
			if (counter < 0) return null;
			var sec:StatusEffectClass = statusEffects[counter];
			statusEffects.splice(counter, 1);
			sec.removedFromHostList(true);
			return sec;
		}
		public function removeStatusEffectInstance(sec:StatusEffectClass/*, fireEvent:Boolean = true*/):void {
			var i:int = statusEffects.indexOf(sec);
			if (i < 0) return;
			statusEffects.splice(i, 1);
			sec.removedFromHostList(true);
		}
		
		public function indexOfStatusEffect(stype:StatusEffectType):int {
			for (var counter:int = 0; counter < statusEffects.length; counter++) {
				if ((statusEffects[counter] as StatusEffectClass).stype == stype)
					return counter;
			}
			return -1;
		}
		public function statusEffectByType(stype:StatusEffectType):StatusEffectClass {
			var idx:int = indexOfStatusEffect(stype);
			return idx<0 ? null : statusEffects[idx];
		}
		public function hasStatusEffect(stype:StatusEffectType):Boolean {
			return indexOfStatusEffect(stype) >= 0;
		}
		//}endregion


		public function changeStatusValue(stype:StatusEffectType, statusValueNum:Number = 1, newNum:Number = 0):void
		{
			if (statusValueNum < 1 || statusValueNum > 4) {
				CoC_Settings.error("ChangeStatusValue called with invalid status value number.");
				return;
			}
			var sac:StatusEffectClass = statusEffectByType(stype);
			//Various Errors preventing action
			if (!sac)return;
			if (statusValueNum == 1) sac.value1 = newNum;
			if (statusValueNum == 2) sac.value2 = newNum;
			if (statusValueNum == 3) sac.value3 = newNum;
			if (statusValueNum == 4) sac.value4 = newNum;
		}

		public function addStatusValue(stype:StatusEffectType, statusValueNum:Number = 1, bonus:Number = 0):void
		{
			if (statusValueNum < 1 || statusValueNum > 4) {
				CoC_Settings.error("ChangeStatusValue called with invalid status value number.");
				return;
			}
			var sac:StatusEffectClass = statusEffectByType(stype);
			//Various Errors preventing action
			if (!sac)return;
			if (statusValueNum == 1) sac.value1 += bonus;
			if (statusValueNum == 2) sac.value2 += bonus;
			if (statusValueNum == 3) sac.value3 += bonus;
			if (statusValueNum == 4) sac.value4 += bonus;
		}

		public function statusEffectByIndex(idx:int):StatusEffectClass {
			return statusEffects[idx];
		}

		public function statusEffectv1(stype:StatusEffectType):Number
		{
			var sac:StatusEffectClass = statusEffectByType(stype);
			return sac?sac.value1:0;
		}

		public function statusEffectv2(stype:StatusEffectType):Number
		{
			var sac:StatusEffectClass = statusEffectByType(stype);
			return sac?sac.value2:0
		}

		public function statusEffectv3(stype:StatusEffectType):Number
		{
			var sac:StatusEffectClass = statusEffectByType(stype);
			return sac?sac.value3:0
		}

		public function statusEffectv4(stype:StatusEffectType):Number
		{
			var sac:StatusEffectClass = statusEffectByType(stype);
			return sac?sac.value4:0
		}

		public function removeStatuses():void
		{
			statusEffects = [];
		}
		
		/**
		 * Applies (creates or increases) a combat-long debuff to stat.
		 * Stat is fully restored after combat.
		 * Different invocations are indistinguishable - do not use this if you need
		 * to check for _specific_ debuff source (poison etc) mid-battle
		 * @param stat 'str','spe','tou','inte','wis'
		 * @param buff Creature stat is decremented by this value.
		 */
		public function addCombatBuff(stat:String, buff:Number):void {
			switch(stat) {
				case 'str':
					(createOrFindStatusEffect(StatusEffects.GenericCombatStrBuff)
							as CombatStrBuff).applyEffect(buff);
					break;
				case 'spe':
					(createOrFindStatusEffect(StatusEffects.GenericCombatSpeBuff)
							as CombatSpeBuff).applyEffect(buff);
					break;
				case 'tou':
					(createOrFindStatusEffect(StatusEffects.GenericCombatTouBuff)
							as CombatTouBuff).applyEffect(buff);
					break;
				case 'int':
				case 'inte':
					(createOrFindStatusEffect(StatusEffects.GenericCombatInteBuff)
							as CombatInteBuff).applyEffect(buff);
					break;
				case 'wis':
					(createOrFindStatusEffect(StatusEffects.GenericCombatWisBuff)
							as CombatWisBuff).applyEffect(buff);
					break;
			}
			trace("/!\\ ERROR: addCombatBuff('"+stat+"', "+buff+")");
		}

		public var availableActions:Array = [];
		public function addAction(action:Object):void {
			if(availableActions.indexOf(action) < 0){
				availableActions.push(action);
			}
		}

		public function removeAction(action:Object):void {
			var i:int = availableActions.indexOf(action);
			if(i >=0){
				availableActions.removeAt(i);
			}
		}

		private function damageLimit(value:Number):Number {
			return Utils.boundFloat(-2.00, value, 3.00);
		}
		private var damageResist:DefaultDict = new DefaultDict(0);
		public function setDamageResist(dtype:String, value:Number = 0):void {
			damageResist[dtype] = damageLimit(value)
		}
		public function addDamageResist(dtype:String, value:Number):void {
			damageResist[dtype] = damageLimit(damageResist[dtype] + value);
		}
		public function getDamageResist(dtype:String):int {
			return damageResist[dtype];
		}

		private var damageMod:DefaultDict = new DefaultDict(1.00);
		public function setDamageMod(dtype:String, value:int = 1.00):void {
			damageMod[dtype] = damageLimit(value);
		}
		public function addDamageMod(dtype:String, value:int):void {
			damageMod[dtype] = damageLimit(damageMod[dtype] + value);
		}
		public function getDamageMod(dtype:String):int {
			return damageMod[dtype];
		}

		/*
		
		[    ? ? ?    ]
		
		*/
		public function biggestTitSize():Number
		{
			if (breastRows.length == 0)
				return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (breastRows[index].breastRating < breastRows[counter].breastRating)
					index = counter;
			}
			return breastRows[index].breastRating;
		}

		public function cockArea(i_cockIndex:Number):Number
		{
			if (i_cockIndex >= cocks.length || i_cockIndex < 0)
				return 0;
			return (cocks[i_cockIndex].cockThickness * cocks[i_cockIndex].cockLength);
		}

		public function biggestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			return cocks[biggestCockIndex()].cockLength;
		}

		public function biggestCockArea():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			return cockArea(index);
		}

		//Find the second biggest dick and it's area.
		public function biggestCockArea2():Number
		{
			if (cocks.length <= 1)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = -1;
			//Find the biggest
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//Is this spot claimed by the biggest?
				if (counter != index)
				{
					//Not set yet?
					if (index2 == -1)
						index2 = counter;
					//Is the stored value less than the current one?
					if (cockArea(index2) < cockArea(counter))
					{
						index2 = counter;
					}
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2)
				return 0;
			return cockArea(index2);
		}

		public function longestCock():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockLength < cocks[counter].cockLength)
					index = counter;
			}
			return index;
		}

		public function longestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockLength < cocks[counter].cockLength)
					index = counter;
			}
			return cocks[index].cockLength;
		}

		public function longestHorseCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if ((cocks[index].cockType != CockTypesEnum.HORSE && cocks[counter].cockType == CockTypesEnum.HORSE) || (cocks[index].cockLength < cocks[counter].cockLength && cocks[counter].cockType == CockTypesEnum.HORSE))
					index = counter;
			}
			return cocks[index].cockLength;
		}

		public function twoDickRadarSpecial(width:int):Boolean
		{
			//No two dicks?  FUCK OFF
			if (cockTotal() < 2)
				return false;

			//Set up vars
			//Get thinnest, work done already
			var thinnest:int = thinnestCockIndex();
			var thinnest2:int = 0;
			//For ze loop
			var temp:int = 0;
			//Make sure they arent the same at initialization
			if (thinnest2 == thinnest)
				thinnest2 = 1;
			//Loop through to find 2nd thinnest
			while (temp < cocks.length)
			{
				if (cocks[thinnest2].cockThickness > cocks[temp].cockThickness && temp != thinnest)
					thinnest2 = temp;
				temp++;
			}
			//If the two thicknesses added together are less than the arg, true, else false
			return cocks[thinnest].cockThickness + cocks[thinnest2].cockThickness < width;
		}

		public function totalCockThickness():Number
		{
			var thick:Number = 0;
			var counter:Number = cocks.length;
			while (counter > 0)
			{
				counter--;
				thick += cocks[counter].cockThickness;
			}
			return thick;
		}

		public function thickestCock():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockThickness < cocks[counter].cockThickness)
					index = counter;
			}
			return index;
		}

		public function thickestCockThickness():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockThickness < cocks[counter].cockThickness)
					index = counter;
			}
			return cocks[index].cockThickness;
		}

		public function thinnestCockIndex():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockThickness > cocks[counter].cockThickness)
					index = counter;
			}
			return index;
		}

		public function smallestCockIndex():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) > cockArea(counter))
				{
					index = counter;
				}
			}
			return index;
		}

		public function smallestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			return cocks[smallestCockIndex()].cockLength;
		}

		public function shortestCockIndex():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockLength > cocks[counter].cockLength)
					index = counter;
			}
			return index;
		}

		public function shortestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockLength > cocks[counter].cockLength)
					index = counter;
			}
			return cocks[index].cockLength;
		}

		//Find the biggest cock that fits inside a given range
		public function cockThatFits(i_fits:Number, type:String = "area", i_min:Number = 0):Number
		{
			if (cocks.length <= 0)
				return -1;
			var i:int = cocks.length;
			//Current largest fitter
			var best:int = -1;
			while (i > 0)
			{
				i--;
				var ival:Number;
				var bestval:Number;
				if (type == "area") {
					ival   = cockArea(i);
					bestval = best==-1?0:cockArea(best);
				} else if (type == "length") {
					ival = cocks[i].cockLength;
					bestval = best==-1?0:cocks[best].cockLength;
				}
				if (i_min <= ival && ival <= i_fits)
				{
					//If one already fits
					if (best >= 0)
					{
						//See if the newcomer beats the saved small guy
						if (ival > bestval)
							best = i;
					}
					//Store the index of fitting dick
					else
						best = i;
				}
			}
			return best;
		}

		//Find the 2nd biggest cock that fits inside a given value
		public function cockThatFits2(fits:Number = 0):Number
		{
			if (cockTotal() == 1)
				return -1;
			var counter:Number = cocks.length;
			//Current largest fitter
			var index:Number = -1;
			var index2:Number = -1;
			while (counter > 0)
			{
				counter--;
				//Does this one fit?
				if (cockArea(counter) <= fits)
				{
					//If one already fits
					if (index >= 0)
					{
						//See if the newcomer beats the saved small guy
						if (cockArea(counter) > cockArea(index))
						{
							//Save old wang
							if (index != -1)
								index2 = index;
							index = counter;
						}
						//If this one fits and is smaller than the other great
						else
						{
							if ((cockArea(index2) < cockArea(counter)) && counter != index)
							{
								index2 = counter;
							}
						}
						if (index >= 0 && index == index2)
							trace("FUCK ERROR COCKTHATFITS2 SHIT IS BROKED!");
					}
					//Store the index of fitting dick
					else
						index = counter;
				}
			}
			return index2;
		}

		public function smallestCockArea():Number
		{
			if (cockTotal() == 0)
				return -1;
			return cockArea(smallestCockIndex());
		}

		public function smallestCock():Number
		{
			return cockArea(smallestCockIndex());
		}

		public function biggestCockIndex():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			return index;
		}

		//Find the second biggest dick's index.
		public function biggestCockIndex2():Number
		{
			if (cocks.length <= 1)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = 0;
			//Find the biggest
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//Make sure index2 doesn't get stuck
				//at the same value as index1 if the
				//initial location is biggest.
				if (index == index2 && counter != index)
					index2 = counter;
				//Is the stored value less than the current one?
				if (cockArea(index2) < cockArea(counter))
				{
					//Make sure we don't set index2 to be the same
					//as the biggest dick.
					if (counter != index)
						index2 = counter;
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2)
				return 0;
			return index2;
		}

		public function smallestCockIndex2():Number
		{
			if (cocks.length <= 1)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = 0;
			//Find the smallest
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) > cockArea(counter))
					index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//Make sure index2 doesn't get stuck
				//at the same value as index1 if the
				//initial location is biggest.
				if (index == index2 && counter != index)
					index2 = counter;
				//Is the stored value less than the current one?
				if (cockArea(index2) > cockArea(counter))
				{
					//Make sure we don't set index2 to be the same
					//as the biggest dick.
					if (counter != index)
						index2 = counter;
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2)
				return 0;
			return index2;
		}

		//Find the third biggest dick index.
		public function biggestCockIndex3():Number
		{
			if (cocks.length <= 2)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = -1;
			var index3:Number = -1;
			//Find the biggest
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//If this index isn't used already
				if (counter != index)
				{
					//Has index been set to anything yet?
					if (index2 == -1)
						index2 = counter;
					//Is the stored value less than the current one?
					else if (cockArea(index2) < cockArea(counter))
					{
						index2 = counter;
					}
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2 || index2 == -1)
				index2 = 0;
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//If this index isn't used already
				if (counter != index && counter != index2)
				{
					//Has index been set to anything yet?
					if (index3 == -1)
						index3 = counter;
					//Is the stored value less than the current one?
					else if (cockArea(index3) < cockArea(counter))
					{
						index3 = counter;
					}
				}
			}
			//If it fails for some reason.
			if (index3 == -1)
				index3 = 0;
			return index3;
		}


		public function cockDescript(cockIndex:int = 0):String
		{
			return Appearance.cockDescript(this, cockIndex);
		}

		public function cockAdjective(index:Number = -1):String {
			if (index < 0) index = biggestCockIndex();
			var isPierced:Boolean = (cocks.length == 1) && (cocks[index].isPierced); //Only describe as pierced or sock covered if the creature has just one cock
			var hasSock:Boolean = (cocks.length == 1) && (cocks[index].sock != "");
			var isGooey:Boolean = (skin.type == Skin.GOO);
			return Appearance.cockAdjective(cocks[index].cockType, cocks[index].cockLength, cocks[index].cockThickness, lust, cumQ(), isPierced, hasSock, isGooey);
		}

		public function wetness():Number
		{
			if (vaginas.length == 0)
				return 0;
			else
				return vaginas[0].vaginalWetness;
		}

		public function vaginaType(newType:int = -1):int
		{
			if (!hasVagina())
				return -1;
			if (newType != -1)
			{
				vaginas[0].type = newType;
			}
			return vaginas[0].type;
		}

		public function looseness(vag:Boolean = true):Number
		{
			if (vag)
			{
				if (vaginas.length == 0)
					return 0;
				else
					return vaginas[0].vaginalLooseness;
			}
			else
			{
				return ass.analLooseness;
			}
		}

		public function vaginalCapacity():Number
		{
			//If the player has no vaginas
			if (vaginas.length == 0)
				return 0;
			var total:Number;
			var bonus:Number = 0;
			//Centaurs = +50 capacity
			if (isTaur())
				bonus = 50;
			//Naga = +20 capacity
			else if (lowerBody == 3)
				bonus = 20;
			//Wet pussy provides 20 point boost
			if (hasPerk(PerkLib.WetPussy))
				bonus += 20;
			if (hasPerk(PerkLib.HistorySlut))
				bonus += 20;
			if (hasPerk(PerkLib.OneTrackMind))
				bonus += 10;
			if (hasPerk(PerkLib.Cornucopia))
				bonus += 30;
			if(hasPerk(PerkLib.FerasBoonWideOpen))
				bonus += 25;
			if(hasPerk(PerkLib.FerasBoonMilkingTwat))
				bonus += 40;
			total = (bonus + statusEffectv1(StatusEffects.BonusVCapacity) + 8 * vaginas[0].vaginalLooseness * vaginas[0].vaginalLooseness) * (1 + vaginas[0].vaginalWetness / 10);
			return total;
		}

		public function analCapacity():Number
		{
			var bonus:Number = 0;
			//Centaurs = +30 capacity
			if (isTaur())
				bonus = 30;
			if (hasPerk(PerkLib.HistorySlut))
				bonus += 20;
			if (hasPerk(PerkLib.Cornucopia))
				bonus += 30;
			if (hasPerk(PerkLib.OneTrackMind))
				bonus += 10;
			if (ass.analWetness > 0)
				bonus += 15;
			return ((bonus + statusEffectv1(StatusEffects.BonusACapacity) + 6 * ass.analLooseness * ass.analLooseness) * (1 + ass.analWetness / 10));
		}

		public function hasFuckableNipples():Boolean
		{
			var counter:Number = breastRows.length;
			while (counter > 0)
			{
				counter--;
				if (breastRows[counter].fuckable)
					return true;
			}
			return false;
		}

		public function hasBreasts():Boolean
		{
			if (breastRows.length > 0)
			{
				if (biggestTitSize() >= 1)
					return true;
			}
			return false;
		}

		public function hasNipples():Boolean
		{
			var counter:Number = breastRows.length;
			while (counter > 0)
			{
				counter--;
				if (breastRows[counter].nipplesPerBreast > 0)
					return true;
			}
			return false;
		}

		public function lactationSpeed():Number
		{
			//Lactation * breastSize x 10 (milkPerBreast) determines scene
			return biggestLactation() * biggestTitSize() * 10;
		}

		public function biggestLactation():Number
		{
			if (breastRows.length == 0)
				return 0;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (breastRows[index].lactationMultiplier < breastRows[counter].lactationMultiplier)
					index = counter;
			}
			return breastRows[index].lactationMultiplier;
		}
		public function milked():void
		{
			if (hasStatusEffect(StatusEffects.LactationReduction))
				changeStatusValue(StatusEffects.LactationReduction, 1, 0);
			if (hasStatusEffect(StatusEffects.LactationReduc0))
				removeStatusEffect(StatusEffects.LactationReduc0);
			if (hasStatusEffect(StatusEffects.LactationReduc1))
				removeStatusEffect(StatusEffects.LactationReduc1);
			if (hasStatusEffect(StatusEffects.LactationReduc2))
				removeStatusEffect(StatusEffects.LactationReduc2);
			if (hasStatusEffect(StatusEffects.LactationReduc3))
				removeStatusEffect(StatusEffects.LactationReduc3);
			if (hasPerk(PerkLib.Feeder))
			{
				//You've now been milked, reset the timer for that
				addStatusValue(StatusEffects.Feeder,1,1);
				changeStatusValue(StatusEffects.Feeder, 2, 0);
			}
		}
		public function boostLactation(todo:Number):Number
		{
			if (breastRows.length == 0)
				return 0;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			var changes:Number = 0;
			var temp2:Number = 0;
			//Prevent lactation decrease if lactating.
			if (todo >= 0)
			{
				if (hasStatusEffect(StatusEffects.LactationReduction))
					changeStatusValue(StatusEffects.LactationReduction, 1, 0);
				if (hasStatusEffect(StatusEffects.LactationReduc0))
					removeStatusEffect(StatusEffects.LactationReduc0);
				if (hasStatusEffect(StatusEffects.LactationReduc1))
					removeStatusEffect(StatusEffects.LactationReduc1);
				if (hasStatusEffect(StatusEffects.LactationReduc2))
					removeStatusEffect(StatusEffects.LactationReduc2);
				if (hasStatusEffect(StatusEffects.LactationReduc3))
					removeStatusEffect(StatusEffects.LactationReduc3);
			}
			if (todo > 0)
			{
				while (todo > 0)
				{
					counter = breastRows.length;
					todo -= .1;
					while (counter > 0)
					{
						counter--;
						if (breastRows[index].lactationMultiplier > breastRows[counter].lactationMultiplier)
							index = counter;
					}
					temp2 = .1;
					if (breastRows[index].lactationMultiplier > 1.5)
						temp2 /= 2;
					if (breastRows[index].lactationMultiplier > 2.5)
						temp2 /= 2;
					if (breastRows[index].lactationMultiplier > 3)
						temp2 /= 2;
					changes += temp2;
					breastRows[index].lactationMultiplier += temp2;
				}
			}
			else
			{
				while (todo < 0)
				{
					counter = breastRows.length;
					index = 0;
					if (todo > -.1)
					{
						while (counter > 0)
						{
							counter--;
							if (breastRows[index].lactationMultiplier < breastRows[counter].lactationMultiplier)
								index = counter;
						}
						//trace(biggestLactation());
						breastRows[index].lactationMultiplier += todo;
						if (breastRows[index].lactationMultiplier < 0)
							breastRows[index].lactationMultiplier = 0;
						todo = 0;
					}
					else
					{
						todo += .1;
						while (counter > 0)
						{
							counter--;
							if (breastRows[index].lactationMultiplier < breastRows[counter].lactationMultiplier)
								index = counter;
						}
						temp2 = todo;
						changes += temp2;
						breastRows[index].lactationMultiplier += temp2;
						if (breastRows[index].lactationMultiplier < 0)
							breastRows[index].lactationMultiplier = 0;
					}
				}
			}
			return changes;
		}

		public function averageLactation():Number
		{
			if (breastRows.length == 0)
				return 0;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				index += breastRows[counter].lactationMultiplier;
			}
			return Math.floor(index / breastRows.length);
		}

		//Calculate bonus virility rating!
		//anywhere from 5% to 100% of normal cum effectiveness thru herbs!
		public function virilityQ():Number
		{
			if (!hasCock())
				return 0;
			var percent:Number = 0.01;
			if (cumQ() >= 250)
				percent += 0.01;
			if (cumQ() >= 800)
				percent += 0.01;
			if (cumQ() >= 1600)
				percent += 0.02;
			if (hasPerk(PerkLib.BroBody))
				percent += 0.05;
			if (hasPerk(PerkLib.MaraesGiftStud))
				percent += 0.15;
			if (hasPerk(PerkLib.FerasBoonAlpha))
				percent += 0.10;
			if (perkv1(PerkLib.ElvenBounty) > 0)
				percent += 0.05;
			if (hasPerk(PerkLib.FertilityPlus))
				percent += 0.03;
			if (hasPerk(PerkLib.FertilityMinus) && lib < 25) //Reduces virility by 3%.
				percent -= 0.03;
			if (hasPerk(PerkLib.PiercedFertite))
				percent += 0.03;
			if (hasPerk(PerkLib.OneTrackMind))
				percent += 0.03;
			if (hasPerk(PerkLib.MagicalVirility))
				percent += 0.05 + (perkv1(PerkLib.MagicalVirility) * 0.01);
			//Messy Orgasms?
			if (hasPerk(PerkLib.MessyOrgasms))
				percent += 0.03;
			//Satyr Sexuality
			if (hasPerk(PerkLib.SatyrSexuality))
				percent += 0.10;
			//Fertite ring bonus!
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY)
				percent += (jewelryEffectMagnitude / 100);
			if (percent > 1)
				percent = 1;
			if (percent < 0)
				percent = 0;

			return percent;
		}

		//Calculate cum return
		public function cumQ():Number
		{
			if (!hasCock())
				return 0;
			var quantity:Number = 0;
			//Base value is ballsize*ballQ*cumefficiency by a factor of 2.
			//Other things that affect it:
			//lust - 50% = normal output.  0 = half output. 100 = +50% output.
			//trace("CUM ESTIMATE: " + int(1.25*2*cumMultiplier*2*(lust + 50)/10 * (hoursSinceCum+10)/24)/10 + "(no balls), " + int(ballSize*balls*cumMultiplier*2*(lust + 50)/10 * (hoursSinceCum+10)/24)/10 + "(withballs)");
			var lustCoefficient:Number = (lust + 50) / 10;
			//If realistic mode is enabled, limits cum to capacity.
			if (flags[kFLAGS.HUNGER_ENABLED] >= 1)
			{
				lustCoefficient = (lust + 50) / 5;
				if (hasPerk(PerkLib.PilgrimsBounty)) lustCoefficient = 30;
				var percent:Number = 0;
				percent = lustCoefficient + (hoursSinceCum + 10);
				if (percent > 100)
					percent = 100;
				if (quantity > cumCapacity())
					quantity = cumCapacity();
				return (percent / 100) * cumCapacity();
			}
			//Pilgrim's bounty maxes lust coefficient
			if (hasPerk(PerkLib.PilgrimsBounty))
				lustCoefficient = 150 / 10;
			if (balls == 0)
				quantity = int(1.25 * 2 * cumMultiplier * 2 * lustCoefficient * (hoursSinceCum + 10) / 24) / 10;
			else
				quantity = int(ballSize * balls * cumMultiplier * 2 * lustCoefficient * (hoursSinceCum + 10) / 24) / 10;
			if (hasPerk(PerkLib.BroBody))
				quantity *= 1.3;
			if (hasPerk(PerkLib.FertilityPlus))
				quantity *= 1.5;
			if (hasPerk(PerkLib.FertilityMinus) && lib < 25)
				quantity *= 0.7;
			if (hasPerk(PerkLib.MessyOrgasms))
				quantity *= 1.5;
			if (hasPerk(PerkLib.OneTrackMind))
				quantity *= 1.1;
			if (hasPerk(PerkLib.MaraesGiftStud))
				quantity += 350;
			if (hasPerk(PerkLib.FerasBoonAlpha))
				quantity += 200;
			if (hasPerk(PerkLib.MagicalVirility))
				quantity += 200 + (perkv1(PerkLib.MagicalVirility) * 100);
			if(hasPerk(PerkLib.FerasBoonSeeder))
				quantity += 1000;
			if (hasPerk(PerkLib.ProductivityDrugs))
				quantity += (perkv3(PerkLib.ProductivityDrugs));
			//if(hasPerk("Elven Bounty") >= 0) quantity += 250;;
			quantity += perkv1(PerkLib.ElvenBounty);
			if (hasPerk(PerkLib.BroBody))
				quantity += 200;
			if (hasPerk(PerkLib.SatyrSexuality))
				quantity += 50;
			quantity += statusEffectv1(StatusEffects.Rut);
			quantity *= (1 + (2 * perkv1(PerkLib.PiercedFertite)) / 100);
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY)
				quantity *= (1 + (jewelryEffectMagnitude / 100));
			//trace("Final Cum Volume: " + int(quantity) + "mLs.");
			//if (quantity < 0) trace("SOMETHING HORRIBLY WRONG WITH CUM CALCULATIONS");
			if (quantity < 2)
				quantity = 2;
			if (quantity > int.MAX_VALUE)
				quantity = int.MAX_VALUE;
			return quantity;
		}

		//Limits how much cum you can produce. Can be altered with perks, ball size, and multiplier. Only applies to realistic mode.
		public function cumCapacity():Number
		{
			if (!hasCock()) return 0;
			var cumCap:Number = 0;
			//Alter capacity by balls.
			var balls:Number = this.balls;
			var ballSize:Number = this.ballSize;
			if (balls == 0) {
				balls = 2;
				ballSize = 1;
			}
			cumCap += Math.pow(((4 / 3) * Math.PI * (ballSize / 2)), 3) * balls;// * cumMultiplier
			// * cumMultiplier
			//Alter capacity by perks.
			if (hasPerk(PerkLib.BroBody)) cumCap *= 1.3;
			if (hasPerk(PerkLib.FertilityPlus)) cumCap *= 1.5;
			if (hasPerk(PerkLib.FertilityMinus) && lib < 25) cumCap *= 0.7;
			if (hasPerk(PerkLib.MessyOrgasms)) cumCap *= 1.5;
			if (hasPerk(PerkLib.OneTrackMind)) cumCap *= 1.1;
			if (hasPerk(PerkLib.MaraesGiftStud)) cumCap += 350;
			if (hasPerk(PerkLib.FerasBoonAlpha)) cumCap += 200;
			if (hasPerk(PerkLib.MagicalVirility)) cumCap += 200;
			if (hasPerk(PerkLib.FerasBoonSeeder)) cumCap += 1000;
			cumCap += perkv1(PerkLib.ElvenBounty);
			if (hasPerk(PerkLib.BroBody)) cumCap += 200;
			cumCap += statusEffectv1(StatusEffects.Rut);
			cumCap *= (1 + (2 * perkv1(PerkLib.PiercedFertite)) / 100);
			//Alter capacity by accessories.
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY) cumCap *= (1 + (jewelryEffectMagnitude / 100));

			cumCap *= cumMultiplier;
			cumCap = Math.round(cumCap);
			if (cumCap > int.MAX_VALUE)
				cumCap = int.MAX_VALUE;
			return cumCap;
		}

		public function countCocksOfType(type:CockTypesEnum):int {
			if (cocks.length == 0) return 0;
			var counter:int = 0;
			for (var x:int = 0; x < cocks.length; x++) {
				if (cocks[x].cockType == type) counter++;
			}
			return counter;
		}

		public function anemoneCocks():int { //How many anemonecocks?
			return countCocksOfType(CockTypesEnum.ANEMONE);
		}

		public function catCocks():int { //How many catcocks?
			return countCocksOfType(CockTypesEnum.CAT);
		}

		public function demonCocks():int { //How many demoncocks?
			return countCocksOfType(CockTypesEnum.DEMON);
		}

		public function displacerCocks():int { //How many displacerCocks?
			return countCocksOfType(CockTypesEnum.DISPLACER);
		}

		// Note: DogCocks/FoxCocks are functionally identical. They actually change back and forth depending on some
		// of the PC's attributes, and this is recaluculated every hour spent at camp.
		// As such, delineating between the two is kind of silly.
		public function dogCocks():int { //How many dogCocks
			if (cocks.length == 0) return 0;
			var counter:int = 0;
			for (var x:int = 0; x < cocks.length; x++) {
				if (cocks[x].cockType == CockTypesEnum.DOG || cocks[x].cockType == CockTypesEnum.FOX || cocks[x].cockType == CockTypesEnum.WOLF) counter++;
			}
			return counter;
		}

		public function dragonCocks():int { //How many dragonCocks?
			return countCocksOfType(CockTypesEnum.DRAGON);
		}

		public function foxCocks():int { //How many foxCocks
			return countCocksOfType(CockTypesEnum.FOX);
		}

		public function wolfCocks():int { //How many wolfCocks
			return countCocksOfType(CockTypesEnum.WOLF);
		}

		public function horseCocks():int { //How many horsecocks?
			return countCocksOfType(CockTypesEnum.HORSE);
		}

		public function kangaCocks():int { //How many kangawangs?
			return countCocksOfType(CockTypesEnum.KANGAROO);
		}

		public function lizardCocks():int { //How many lizard/snake-cocks?
			return countCocksOfType(CockTypesEnum.LIZARD);
		}

		public function pigCocks():int { //How many lizard/snake-cocks?
			return countCocksOfType(CockTypesEnum.PIG);
		}

		public function normalCocks():int { //How many normalCocks?
			return countCocksOfType(CockTypesEnum.HUMAN);
		}

		public function tentacleCocks():int { //How many tentaclecocks?
			return countCocksOfType(CockTypesEnum.TENTACLE);
		}

		public function stamenCocks():int { //How many stamencocks?
			return countCocksOfType(CockTypesEnum.STAMEN);
		}

		public function avianCocks():int { //How many aviancocks?
			return countCocksOfType(CockTypesEnum.AVIAN);
		}

		public function gryphonCocks():int { //How many gryphoncocks?
			return countCocksOfType(CockTypesEnum.GRYPHON);
		}


		public function findFirstCockType(ctype:CockTypesEnum):Number
		{
			var index:Number = 0;
			//if (cocks[index].cockType == ctype)
			//	return index;
			for (index = 0; index < cocks.length; index++) {
				if (cocks[index].cockType == ctype)
					return index;
			}
			//trace("Creature.findFirstCockType ERROR - searched for cocktype: " + ctype + " and could not find it.");
			return 0;
		}

		/*public function findFirstCockType(type:Number = 0):Number
		{
			var index:Number = 0;
			if (cocks[index].cockType == type)
				return index;
			while (index < cocks.length)
			{
				index++;
				if (cocks[index].cockType == type)
					return index;
			}
			//trace("Creature.findFirstCockType ERROR - searched for cocktype: " + type + " and could not find it.");
			return 0;
		}*/

		//Change first normal cock to horsecock!
		//Return number of affected cock, otherwise -1
		public function addHorseCock():Number
		{
			var counter:Number = cocks.length;
			while (counter > 0)
			{
				counter--;
				//Human - > horse
				if (cocks[counter].cockType == CockTypesEnum.HUMAN)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Dog - > horse
				if (cocks[counter].cockType == CockTypesEnum.DOG)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Wolf - > horse
				if (cocks[counter].cockType == CockTypesEnum.WOLF)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Tentacle - > horse
				if (cocks[counter].cockType == CockTypesEnum.TENTACLE)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Demon -> horse
				if (cocks[counter].cockType == CockTypesEnum.DEMON)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Catch-all
				if (cocks[counter].cockType.Index > 4)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
			}
			return -1;
		}
		//How many cocks?
		public function cockTotal():Number
		{
			return (cocks.length);
		}

		//BOolean alternate
		public function hasCock():Boolean
		{
			return cocks.length >= 1;

		}

		public function hasSockRoom():Boolean
		{
			var index:int = cocks.length;
			while (index > 0)
			{
				index--;
				if (cocks[index].sock == "")
					return true;
			}
			return false
		}

	//	[Deprecated]
		public function hasSock(arg:String = ""):Boolean
		{
			var index:int = cocks.length;

			while (index > 0)
			{
				index--;
				if (cocks[index].sock != "")
				{
				if (arg == "" || cocks[index].sock == arg)
					return true;
				}
			}
			return false
		}
		public function countCockSocks(type:String):int
		{
			var count:int = 0;

			for (var i:Number = 0; i < cocks.length; i++) {
				if (cocks[i].sock == type) {
					count++
				}
			}
			//trace("countCockSocks found " + count + " " + type);
			return count;
		}

		public function canAutoFellate():Boolean
		{
			if (!hasCock())
				return false;
			return (cocks[0].cockLength >= 20);
		}

		public static const canFlyWings:Array = [
			Wings.BEE_LIKE_LARGE,
			Wings.BAT_LIKE_LARGE,
			Wings.BAT_LIKE_LARGE_2,
			Wings.FEATHERED_LARGE,
			Wings.FEATHERED_PHOENIX,
			Wings.DRACONIC_LARGE,
			Wings.DRACONIC_HUGE,
			Wings.GIANT_DRAGONFLY,
			Wings.MANTIS_LIKE_LARGE,
			Wings.MANTIS_LIKE_LARGE_2,
			Wings.MANTICORE_LIKE_LARGE,
			Wings.GARGOYLE_LIKE_LARGE,
			Wings.BAT_ARM,
			Wings.VAMPIRE,
			Wings.FEY_DRAGON_WINGS,
			Wings.FEATHERED_AVIAN,
			Wings.FEATHERED_SPHINX,
			//WING_TYPE_IMP_LARGE,
		];

		//PC can fly?
		public function canFly():Boolean
		{
			//web also makes false!
			if (hasStatusEffect(StatusEffects.Web))
				return false;
			return canFlyWings.indexOf(wings.type) != -1;
		}

		public static const canPounceLeg:Array = [
			LowerBody.CAT,
			LowerBody.LION,
			LowerBody.WOLF,
		];

		public static const canPounceArms:Array = [
			Arms.CAT,
			Arms.LION,
			Arms.SPHINX,
			Arms.WOLF,
		];

		public function canPounce():Boolean
		{
			return canPounceLeg.indexOf(lowerBody) != -1 && canPounceArms.indexOf(arms.type) != -1;
		}


		//PC can swim underwater?
		public function canSwimUnderwater():Boolean
		{
			return gills.type != Gills.NONE;

		}

		//Naked
		public function isNaked():Boolean
		{
			return armorName == "nothing" && upperGarmentName == "nothing" && lowerGarmentName == "nothing";
		}

		//Crit immunity
		public function isImmuneToCrits():Boolean
		{
			return hasPerk(PerkLib.EnemyConstructType) || hasPerk(PerkLib.EnemyPlantType);

		}
		//check for vagoo
		public function hasVagina():Boolean
		{
			return vaginas.length > 0;

		}

		public function hasVirginVagina():Boolean
		{
			if (vaginas.length > 0)
				return vaginas[0].virgin;
			return false;
		}

		//GENDER IDENTITIES
		public function genderText(male:String = "man", female:String = "woman", futa:String = "herm", eunuch:String = "eunuch"):String
		{
			if (vaginas.length > 0) {
				if (cocks.length > 0) return futa;
				return female;
			}
			else if (cocks.length > 0) {
				return male;
			}
			return eunuch;
		}

		public function manWoman(caps:Boolean = false):String
		{
			//Dicks?
			if (cockTotal() > 0)
			{
				if (hasVagina())
				{
					if (caps)
						return "Futa";
					else
						return "futa";
				}
				else
				{
					if (caps)
						return "Man";
					else
						return "man";
				}
			}
			else
			{
				if (hasVagina())
				{
					if (caps)
						return "Woman";
					else
						return "woman";
				}
				else
				{
					if (caps)
						return "Eunuch";
					else
						return "eunuch";
				}
			}
		}

		public function mfn(male:String, female:String, neuter:String):String
		{
			if (gender == 0)
				return neuter;
			else
				return mf(male, female);
		}
		public function looksMale():Boolean {
			return !looksFemale();
		}
		
		public function looksFemale():Boolean {
			var tits:Number = biggestTitSize();
			switch(gender) {
				case Gender.GENDER_HERM:
                case Gender.GENDER_NONE:
                    return ((tits >= 3 || tits == 2 && femininity >= 15 || tits == 1 && femininity >= 40 || femininity >= 65) && (flags[kFLAGS.MALE_OR_FEMALE] == 0 || flags[kFLAGS.MALE_OR_FEMALE] == 2));
				case Gender.GENDER_MALE:
                    return ((tits >= 3 && femininity >= 5 || tits == 2 && femininity >= 35 || tits == 1 && femininity >= 65 || femininity >= 95) && (flags[kFLAGS.MALE_OR_FEMALE] == 0 || flags[kFLAGS.MALE_OR_FEMALE] == 2));
                case Gender.GENDER_FEMALE:
                    return ((tits > 1 || tits == 1 && femininity >= 15 || femininity >= 45) && (flags[kFLAGS.MALE_OR_FEMALE] == 0 || flags[kFLAGS.MALE_OR_FEMALE] == 2));
				default: return false;
			}
		}
		//Rewritten!
		public function mf(male:String, female:String):String
		{
			return looksMale() ? male : female;
		}
		
		public function maleFemaleHerm(caps:Boolean = false):String
		{
			switch (gender) {
				case Gender.GENDER_NONE:   return caps ? mf("Genderless", "Fem-genderless") : mf("genderless", "fem-genderless");
				case Gender.GENDER_MALE:   return caps ? mf("Male", biggestTitSize() > BreastCup.A ? "Shemale" : "Femboy")             : mf("male", biggestTitSize() > BreastCup.A ? "shemale" : "femboy");
				case Gender.GENDER_FEMALE: return caps ? mf("Cuntboy", "Female")            : mf("cuntboy", "female");
				case Gender.GENDER_HERM:   return caps ? mf("Maleherm", "Hermaphrodite")    : mf("maleherm", "hermaphrodite");
				default: return "<b>Gender error!</b>";
			}
		}
		
		/**
		 * Checks if the creature is technically male: has cock but not vagina.
		 */
		public function isMale():Boolean
		{
			return gender == Gender.GENDER_MALE;
		}
		
		/**
		 * Checks if the creature is technically female: has vagina but not cock.
		 */
		public function isFemale():Boolean
		{
			return gender == Gender.GENDER_FEMALE;
					}

		/**
		 * Checks if the creature is technically herm: has both cock and vagina.
		 */
		public function isHerm():Boolean
					{
			return gender == Gender.GENDER_HERM;
					}

		/**
		 * Checks if the creature is technically genderless: has neither cock nor vagina.
		 */
		public function isGenderless():Boolean
				{
			return gender == Gender.GENDER_NONE;
				}

		/**
		 * Checks if the creature is technically male or herm: has at least a cock.
		 */
		public function isMaleOrHerm():Boolean
			{
			return (gender & Gender.GENDER_MALE) != 0;
				}

		/**
		 * Checks if the creature is technically female or herm: has at least a vagina.
		 */
		public function isFemaleOrHerm():Boolean
				{
			return (gender & Gender.GENDER_FEMALE) != 0;
					}

		//Create a cock. Default type is HUMAN
		public function createCock(clength:Number = 5.5, cthickness:Number = 1,ctype:CockTypesEnum=null):Boolean
		{
			if (ctype == null) ctype = CockTypesEnum.HUMAN;
			if (cocks.length >= 10)
				return false;
			var newCock:Cock = new Cock(clength, cthickness,ctype);
			newCock.host = this;
			//var newCock:cockClass = new cockClass();
			cocks.push(newCock);
			cocks[cocks.length-1].cockThickness = cthickness;
			cocks[cocks.length-1].cockLength = clength;
			return true;
		}

		//create vagoo
		public function createVagina(virgin:Boolean = true, vaginalWetness:Number = 1, vaginalLooseness:Number = 0):Boolean
		{
			if (vaginas.length >= 2)
				return false;
			var newVagina:VaginaClass = new VaginaClass(vaginalWetness,vaginalLooseness,virgin);
			newVagina.host = this;
			vaginas.push(newVagina);
			return true;
		}

		//create a row of breasts
		public function createBreastRow(size:Number=0,nipplesPerBreast:Number=1):Boolean
		{
			if (breastRows.length >= 10)
				return false;
			var newBreastRow:BreastRowClass = new BreastRowClass();
			newBreastRow.breastRating = size;
			newBreastRow.nipplesPerBreast = nipplesPerBreast;
			breastRows.push(newBreastRow);
			return true;
		}

		//Remove cocks
		public function removeCock(arraySpot:int, totalRemoved:int):void
		{
			//Various Errors preventing action
			if (arraySpot < 0 || totalRemoved <= 0)
			{
				//trace("ERROR: removeCock called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if (cocks.length == 0)
			{
				//trace("ERROR: removeCock called but cocks do not exist.");
			}
			else
			{
				if (arraySpot > cocks.length - 1)
				{
					//trace("ERROR: removeCock failed - array location is beyond the bounds of the array.");
				}
				else
				{
					try
					{
						var cock:Cock = cocks[arraySpot];
						if (cock.sock == "viridian")
						{
							removePerk(PerkLib.LustyRegeneration);
						}
						else if (cock.sock == "cockring")
						{
							var numRings:int = 0;
							for (var i:int = 0; i < cocks.length; i++)
							{
								if (cocks[i].sock == "cockring") numRings++;
							}

							if (numRings == 0) removePerk(PerkLib.PentUp);
							else setPerkValue(PerkLib.PentUp, 1, 5 + (numRings * 5));
						}
						cocks.splice(arraySpot, totalRemoved);
					}
					catch (e:Error)
					{
						trace("Argument error in Creature[" + this._short + "]: " + e.message);
					}
					//trace("Attempted to remove " + totalRemoved + " cocks.");
				}
			}
		}

		//REmove vaginas
		public function removeVagina(arraySpot:int = 0, totalRemoved:int = 1):void
		{
			//Various Errors preventing action
			if (arraySpot < -1 || totalRemoved <= 0)
			{
				//trace("ERROR: removeVagina called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if (vaginas.length == 0)
			{
				//trace("ERROR: removeVagina called but cocks do not exist.");
			}
			else
			{
				if (arraySpot > vaginas.length - 1)
				{
					//trace("ERROR: removeVagina failed - array location is beyond the bounds of the array.");
				}
				else
				{
					vaginas.splice(arraySpot, totalRemoved);
					//trace("Attempted to remove " + totalRemoved + " vaginas.");
				}
			}
		}

		//Remove a breast row
		public function removeBreastRow(arraySpot:int, totalRemoved:int):void
		{
			//Various Errors preventing action
			if (arraySpot < -1 || totalRemoved <= 0)
			{
				//trace("ERROR: removeBreastRow called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if (breastRows.length == 0)
			{
				//trace("ERROR: removeBreastRow called but cocks do not exist.");
			}
			else if (breastRows.length == 1 || breastRows.length - totalRemoved < 1)
			{
				//trace("ERROR: Removing the current breast row would break the Creature classes assumptions about breastRow contents.");
			}
			else
			{
				if (arraySpot > breastRows.length - 1)
				{
					//trace("ERROR: removeBreastRow failed - array location is beyond the bounds of the array.");
				}
				else
				{
					breastRows.splice(arraySpot, totalRemoved);
					//trace("Attempted to remove " + totalRemoved + " breastRows.");
				}
			}
		}

		// This is placeholder shit whilst I work out a good way of BURNING ENUM TO THE FUCKING GROUND
		// and replacing it with something that will slot in and work with minimal changes and not be
		// A FUCKING SHITSTAIN when it comes to intelligent de/serialization.
		public function fixFuckingCockTypesEnum():void
		{
			if (this.cocks.length > 0)
			{
				for (var i:int = 0; i < this.cocks.length; i++)
				{
					this.cocks[i].cockType = CockTypesEnum.ParseConstantByIndex(this.cocks[i].cockType.Index);
				}
			}
		}

		public function buttChangeNoDisplay(cArea:Number):Boolean {
			var stretched:Boolean = false;
			//cArea > capacity = autostreeeeetch half the time.
			if(cArea >= analCapacity() && rand(2) == 0) {
				if(ass.analLooseness >= 5) {}
				else ass.analLooseness++;
				stretched = true;
				//Reset butt stretchin recovery time
				if(hasStatusEffect(StatusEffects.ButtStretched)) changeStatusValue(StatusEffects.ButtStretched,1,0);
			}
			//If within top 10% of capacity, 25% stretch
			if(cArea < analCapacity() && cArea >= .9*analCapacity() && rand(4) == 0) {
				ass.analLooseness++;
				stretched = true;
			}
			//if within 75th to 90th percentile, 10% stretch
			if(cArea < .9 * analCapacity() && cArea >= .75 * analCapacity() && rand(10) == 0) {
				ass.analLooseness++;
				stretched = true;
			}
			//Anti-virgin
			if(ass.analLooseness == 0) {
				ass.analLooseness++;
				stretched = true;
			}
			//Delay un-stretching
			if(cArea >= .5 * analCapacity()) {
				//Butt Stretched used to determine how long since last enlargement
				if(!hasStatusEffect(StatusEffects.ButtStretched)) createStatusEffect(StatusEffects.ButtStretched,0,0,0,0);
				//Reset the timer on it to 0 when restretched.
				else changeStatusValue(StatusEffects.ButtStretched,1,0);
			}
			if(stretched) {
				trace("BUTT STRETCHED TO " + (ass.analLooseness) + ".");
			}
			return stretched;
		}

		public function cuntChangeNoDisplay(cArea:Number):Boolean{
			if(vaginas.length == 0) return false;
			var stretched:Boolean = false;
			if(!hasPerk(PerkLib.FerasBoonMilkingTwat) || vaginas[0].vaginalLooseness <= VaginaClass.LOOSENESS_NORMAL) {
			//cArea > capacity = autostreeeeetch.
			if(cArea >= vaginalCapacity()) {
				if(vaginas[0].vaginalLooseness >= VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR) {}
				else vaginas[0].vaginalLooseness++;
				stretched = true;
			}
			//If within top 10% of capacity, 50% stretch
			else if(cArea >= .9 * vaginalCapacity() && rand(2) == 0) {
				vaginas[0].vaginalLooseness++;
				stretched = true;
			}
			//if within 75th to 90th percentile, 25% stretch
			else if(cArea >= .75 * vaginalCapacity() && rand(4) == 0) {
				vaginas[0].vaginalLooseness++;
				stretched = true;
				}
			}
			//If virgin
			if(vaginas[0].virgin) {
				vaginas[0].virgin = false;
			}
			//Delay anti-stretching
			if(cArea >= .5 * vaginalCapacity()) {
				//Cunt Stretched used to determine how long since last enlargement
				if(!hasStatusEffect(StatusEffects.CuntStretched)) createStatusEffect(StatusEffects.CuntStretched,0,0,0,0);
				//Reset the timer on it to 0 when restretched.
				else changeStatusValue(StatusEffects.CuntStretched,1,0);
			}
			if(stretched) {
				trace("CUNT STRETCHED TO " + (vaginas[0].vaginalLooseness) + ".");
			}
			return stretched;
		}

		public function get inHeat():Boolean {
			return hasStatusEffect(StatusEffects.Heat);
		}

		public function get inRut():Boolean {
			return hasStatusEffect(StatusEffects.Rut);
		}

		public function bonusFertility():Number
		{
			var counter:Number = 0;
			if (inHeat)
				counter += statusEffectv1(StatusEffects.Heat);
			if (hasPerk(PerkLib.FertilityPlus))
				counter += 15;
			if (hasPerk(PerkLib.FertilityMinus) && lib < 25)
				counter -= 15;
			if (hasPerk(PerkLib.MaraesGiftFertility))
				counter += 50;
			if (hasPerk(PerkLib.FerasBoonBreedingBitch))
				counter += 30;
			if (hasPerk(PerkLib.MagicalFertility))
				counter += 10 + (perkv1(PerkLib.MagicalFertility) * 5);
			counter += perkv2(PerkLib.ElvenBounty);
			counter += perkv1(PerkLib.PiercedFertite);
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY)
				counter += jewelryEffectMagnitude;
			return counter;
		}

		public function totalFertility():Number
		{
			return (bonusFertility() + fertility);
		}

		public function hasScales():Boolean { return skin.hasScales(); }
		public function hasReptileScales():Boolean { return skin.hasReptileScales(); }
		public function hasDragonScales():Boolean { return skin.hasDragonScales(); }
		public function hasLizardScales():Boolean { return skin.hasLizardScales(); }
		public function hasNonLizardScales():Boolean { return skin.hasNonLizardScales(); }
		public function hasFur():Boolean { return skin.hasFur(); }
		public function hasChitin():Boolean { return skin.hasChitin(); }
		public function hasFeather():Boolean { return skin.hasFeather(); }
		public function hasMostlyPlainSkin():Boolean { return skin.hasMostlyPlainSkin(); }
		public function hasPlainSkinOnly():Boolean { return skin.hasPlainSkinOnly(); }
		public function hasPartialCoat(coat_type:int):Boolean { return skin.hasPartialCoat(coat_type); }
		public function hasPlainSkin():Boolean { return skin.hasPlainSkin(); }
		public function hasGooSkin():Boolean { return skin.hasGooSkin(); }
		public function isGargoyle():Boolean { return skin.hasBaseOnly(Skin.STONE); }
		public function skinDescript():String { return skin.describe('basic'); }
		public function skinFurScales():String { return skin.describe('cover'); }

		// <mod name="Predator arms" author="Stadler76">
		public function claws():String { return clawsPart.descriptionFull(); }
		// </mod>

		public function legs():String { return lowerBodyPart.legs(); }
		public function leg():String { return lowerBodyPart.leg(); }
		public function feet():String { return lowerBodyPart.feet(); }
		public function foot():String { return lowerBodyPart.foot(); }
		public function isDrider():Boolean { return lowerBodyPart.isDrider(); }
		public function isGoo():Boolean { return lowerBodyPart.isGoo(); }
		public function isBiped():Boolean { return lowerBodyPart.isBiped(); }
		public function isNaga():Boolean { return lowerBodyPart.isNaga(); }
		public function isTaur():Boolean { return lowerBodyPart.isTaur(); }
		public function isScylla():Boolean { return lowerBodyPart.isScylla(); }
		public function isAlraune():Boolean { return lowerBodyPart.isAlraune(); }
		
		public function isFlying():Boolean {
			return hasStatusEffect(StatusEffects.Flying);
		}

		public function canOvipositSpider():Boolean
		{
			return eggs() >= 10 && hasPerk(PerkLib.SpiderOvipositor) && isDrider() && tail.type == Tail.SPIDER_ADBOMEN;
		}

		public function canOvipositBee():Boolean
		{
			return eggs() >= 10 && hasPerk(PerkLib.BeeOvipositor) && tail.type == Tail.BEE_ABDOMEN;
		}

		public function canOvipositMantis():Boolean
		{
			return eggs() >= 10 && hasPerk(PerkLib.MantisOvipositor) && tail.type == Tail.MANTIS_ABDOMEN;
		}

		public function canOviposit():Boolean
		{
			return canOvipositSpider() || canOvipositBee() || canOvipositMantis();
		}

		public function eggs():int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor))
				return -1;
			else if (hasPerk(PerkLib.SpiderOvipositor))
				return perkv1(PerkLib.SpiderOvipositor);
			else if (hasPerk(PerkLib.BeeOvipositor))
				return perkv1(PerkLib.BeeOvipositor);
			else
				return perkv1(PerkLib.MantisOvipositor);
		}

		public function addEggs(arg:int = 0):int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor))
				return -1;
			else {
				if (hasPerk(PerkLib.SpiderOvipositor)) {
					addPerkValue(PerkLib.SpiderOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.SpiderOvipositor, 1, 50);
					return perkv1(PerkLib.SpiderOvipositor);
				}
				else if (hasPerk(PerkLib.BeeOvipositor)) {
					addPerkValue(PerkLib.BeeOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.BeeOvipositor, 1, 50);
					return perkv1(PerkLib.BeeOvipositor);
				}
				else {
					addPerkValue(PerkLib.MantisOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.MantisOvipositor, 1, 50);
					return perkv1(PerkLib.MantisOvipositor);
				}
			}
		}

		public function dumpEggs():void
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor))
				return;
			setEggs(0);
			//Sets fertile eggs = regular eggs (which are 0)
			fertilizeEggs();
		}

		public function setEggs(arg:int = 0):int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor))
				return -1;
			else {
				if (hasPerk(PerkLib.SpiderOvipositor)) {
					setPerkValue(PerkLib.SpiderOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.SpiderOvipositor, 1, 50);
					return perkv1(PerkLib.SpiderOvipositor);
				}
				else if (hasPerk(PerkLib.BeeOvipositor)) {
					setPerkValue(PerkLib.BeeOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.BeeOvipositor, 1, 50);
					return perkv1(PerkLib.BeeOvipositor);
				}
				else {
					setPerkValue(PerkLib.MantisOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.MantisOvipositor, 1, 50);
					return perkv1(PerkLib.MantisOvipositor);
				}
			}
		}

		public function fertilizedEggs():int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor))
				return -1;
			else if (hasPerk(PerkLib.SpiderOvipositor))
				return perkv2(PerkLib.SpiderOvipositor);
			else if (hasPerk(PerkLib.BeeOvipositor))
				return perkv2(PerkLib.BeeOvipositor);
			else
				return perkv2(PerkLib.MantisOvipositor);
		}

		public function fertilizeEggs():int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor))
				return -1;
			else if (hasPerk(PerkLib.SpiderOvipositor))
				setPerkValue(PerkLib.SpiderOvipositor, 2, eggs());
			else if (hasPerk(PerkLib.BeeOvipositor))
				setPerkValue(PerkLib.BeeOvipositor, 2, eggs());
			else
				setPerkValue(PerkLib.MantisOvipositor, 2, eggs());
			return fertilizedEggs();
		}

		public function breastCup(rowNum:Number):String
		{
			return Appearance.breastCup(breastRows[rowNum].breastRating);
		}

		public function bRows():Number
		{
			return breastRows.length;
		}

		public function totalBreasts():Number
		{
			var counter:Number = breastRows.length;
			var total:Number = 0;
			while (counter > 0) {
				counter--;
				total += breastRows[counter].breasts;
			}
			return total;
		}

		public function totalNipples():Number
		{
			var counter:Number = breastRows.length;
			var total:Number = 0;
			while (counter > 0) {
				counter--;
				total += breastRows[counter].nipplesPerBreast * breastRows[counter].breasts;
			}
			return total;
		}

		public function smallestTitSize():Number
		{
			if (breastRows.length == 0)
				return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breastRating > breastRows[counter].breastRating)
					index = counter;
			}
			return breastRows[index].breastRating;
		}

		public function smallestTitRow():Number
		{
			if (breastRows.length == 0)
				return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breastRating > breastRows[counter].breastRating)
					index = counter;
			}
			return index;
		}

		public function biggestTitRow():Number
		{
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breastRating < breastRows[counter].breastRating)
					index = counter;
			}
			return index;
		}

		public function averageBreastSize():Number
		{
			var counter:Number = breastRows.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += breastRows[counter].breastRating;
			}
			if (breastRows.length == 0)
				return 0;
			return (average / breastRows.length);
		}

		public function averageCockThickness():Number
		{
			var counter:Number = cocks.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += cocks[counter].cockThickness;
			}
			if (cocks.length == 0)
				return 0;
			return (average / cocks.length);
		}

		public function averageNippleLength():Number
		{
			var counter:Number = breastRows.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += (breastRows[counter].breastRating / 10 + .2);
			}
			return (average / breastRows.length);
		}

		public function averageVaginalLooseness():Number
		{
			var counter:Number = vaginas.length;
			var average:Number = 0;
			//If the player has no vaginas
			if (vaginas.length == 0)
				return 2;
			while (counter > 0) {
				counter--;
				average += vaginas[counter].vaginalLooseness;
			}
			return (average / vaginas.length);
		}

		public function averageVaginalWetness():Number
		{
			//If the player has no vaginas
			if (vaginas.length == 0)
				return 2;
			var counter:Number = vaginas.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += vaginas[counter].vaginalWetness;
			}
			return (average / vaginas.length);
		}

		public function averageCockLength():Number
		{
			var counter:Number = cocks.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += cocks[counter].cockLength;
			}
			if (cocks.length == 0)
				return 0;
			return (average / cocks.length);
		}

		public function canTitFuck():Boolean
		{
			if (breastRows.length == 0) return false;

			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breasts < breastRows[counter].breasts && breastRows[counter].breastRating > 3)
					index = counter;
			}
			return breastRows[index].breasts >= 2 && breastRows[index].breastRating > 3;

		}

		public function mostBreastsPerRow():Number
		{
			if (breastRows.length == 0) return 2;

			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breasts < breastRows[counter].breasts)
					index = counter;
			}
			return breastRows[index].breasts;
		}

		public function averageNipplesPerBreast():Number
		{
			var counter:Number = breastRows.length;
			var breasts:Number = 0;
			var nipples:Number = 0;
			while (counter > 0) {
				counter--;
				breasts += breastRows[counter].breasts;
				nipples += breastRows[counter].nipplesPerBreast * breastRows[counter].breasts;
			}
			if (breasts == 0)
				return 0;
			return Math.floor(nipples / breasts);
		}

		public function allBreastsDescript():String
		{
			return Appearance.allBreastsDescript(this);
		}

		//Simplified these cock descriptors and brought them into the creature class
		public function sMultiCockDesc():String {
			return (cocks.length > 1 ? "one of your " : "your ") + cockMultiLDescriptionShort();
		}

		public function SMultiCockDesc():String {
			return (cocks.length > 1 ? "One of your " : "Your ") + cockMultiLDescriptionShort();
		}

		public function oMultiCockDesc():String {
			return (cocks.length > 1 ? "each of your " : "your ") + cockMultiLDescriptionShort();
		}

		public function OMultiCockDesc():String {
			return (cocks.length > 1 ? "Each of your " : "Your ") + cockMultiLDescriptionShort();
		}

		private function cockMultiLDescriptionShort():String {
			if (cocks.length < 1) {
				CoC_Settings.error("<b>ERROR: NO WANGS DETECTED for cockMultiLightDesc()</b>");
				return "<b>ERROR: NO WANGS DETECTED for cockMultiLightDesc()</b>";
			}
			if (cocks.length == 1) { //For a songle cock return the default description
				return Appearance.cockDescript(this, 0);
			}
			switch (cocks[0].cockType) { //With multiple cocks only use the descriptions for specific cock types if all cocks are of a single type
				case CockTypesEnum.ANEMONE:
				case CockTypesEnum.WOLF:
				case CockTypesEnum.CAT:
				case CockTypesEnum.DEMON:
				case CockTypesEnum.DISPLACER:
				case CockTypesEnum.DRAGON:
				case CockTypesEnum.HORSE:
				case CockTypesEnum.KANGAROO:
				case CockTypesEnum.LIZARD:
				case CockTypesEnum.PIG:
				case CockTypesEnum.TENTACLE:
					if (countCocksOfType(cocks[0].cockType) == cocks.length) return Appearance.cockNoun(cocks[0].cockType) + "s";
					break;
				case CockTypesEnum.DOG:
				case CockTypesEnum.FOX:
					if (dogCocks() == cocks.length) return Appearance.cockNoun(CockTypesEnum.DOG) + "s";
			}
			return Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
		}

		public function hasSheath():Boolean {
			if (cocks.length == 0) return false;
			for (var x:int = 0; x < cocks.length; x++) {
				switch (cocks[x].cockType) {
					case CockTypesEnum.CAT:
					case CockTypesEnum.DISPLACER:
					case CockTypesEnum.DOG:
					case CockTypesEnum.WOLF:
					case CockTypesEnum.FOX:
					case CockTypesEnum.HORSE:
					case CockTypesEnum.KANGAROO:
					case CockTypesEnum.AVIAN:
					case CockTypesEnum.ECHIDNA:
						return true; //If there's even one cock of any of these types then return true
					default:
				}
			}
			return false;
		}

		public function sheathDescription():String {
			if (hasSheath()) return "sheath";
			return "base";
		}

		public function vaginaDescript(idx:int = 0):String
		{
			return Appearance.vaginaDescript(this, 0);
		}
		public function assholeDescript():String{
			return Appearance.assholeDescript(this);
		}

		public function nippleDescript(rowIdx:int):String
		{
			return Appearance.nippleDescription(this, rowIdx);
		}

		public function chestDesc():String
		{
			if (biggestTitSize() < 1) return "chest";
			return Appearance.biggestBreastSizeDescript(this);
//			return Appearance.chestDesc(this);
		}

		public function allChestDesc():String {
			if (biggestTitSize() < 1) return "chest";
			return allBreastsDescript();
		}

		public function clitDescript():String {
			return Appearance.clitDescription(this);
		}

		public function cockHead(cockNum:int = 0):String {
			if (cockNum < 0 || cockNum > cocks.length - 1) {
				CoC_Settings.error("");
				return "ERROR";
			}
			switch (cocks[cockNum].cockType) {
				case CockTypesEnum.CAT:
					if (rand(2) == 0) return "point";
					return "narrow tip";
				case CockTypesEnum.DEMON:
					if (rand(2) == 0) return "tainted crown";
					return "nub-ringed tip";
				case CockTypesEnum.DISPLACER:
					switch (rand(5)) {
						case  0: return "star tip";
						case  1: return "blooming cock-head";
						case  2: return "open crown";
						case  3: return "alien tip";
						default: return "bizarre head";
					}
				case CockTypesEnum.DOG:
				case CockTypesEnum.WOLF:
				case CockTypesEnum.FOX:
					if (rand(2) == 0) return "pointed tip";
					return "narrow tip";
				case CockTypesEnum.HORSE:
					if (rand(2) == 0) return "flare";
					return "flat tip";
				case CockTypesEnum.KANGAROO:
					if (rand(2) == 0) return "tip";
					return "point";
				case CockTypesEnum.LIZARD:
					if (rand(2) == 0) return "crown";
					return "head";
				case CockTypesEnum.TENTACLE:
					if (rand(2) == 0) return "mushroom-like tip";
					return "wide plant-like crown";
				case CockTypesEnum.PIG:
					if (rand(2) == 0) return "corkscrew tip";
					return "corkscrew head";
				case CockTypesEnum.RHINO:
					if (rand(2) == 0) return "flared head";
					return "rhinoceros dickhead";
				case CockTypesEnum.ECHIDNA:
					if (rand(2) == 0) return "quad heads";
					return "echidna quad heads";
				default:
			}
			if (rand(2) == 0) return "crown";
			if (rand(2) == 0) return "head";
			return "cock-head";
		}

		//Short cock description. Describes length or girth. Supports multiple cocks.
		public function cockDescriptShort(i_cockIndex:int = 0):String
		{
			// catch calls where we're outside of combat, and eCockDescript could be called.
			if (cocks.length == 0)
				return "<B>ERROR. INVALID CREATURE SPECIFIED to cockDescriptShort</B>";

			var description:String = "";
			var descripted:Boolean = false;
			//Discuss length one in 3 times
			if (rand(3) == 0) {
				if (cocks[i_cockIndex].cockLength >= 30)
					description = "towering ";
				else if (cocks[i_cockIndex].cockLength >= 18)
					description = "enormous ";
				else if (cocks[i_cockIndex].cockLength >= 13)
					description = "massive ";
				else if (cocks[i_cockIndex].cockLength >= 10)
					description = "huge ";
				else if (cocks[i_cockIndex].cockLength >= 7)
					description = "long ";
				else if (cocks[i_cockIndex].cockLength >= 5)
					description = "average ";
				else
					description = "short ";
				descripted = true;
			}
			else if (rand(2) == 0) { //Discuss girth one in 2 times if not already talked about length.
				//narrow, thin, ample, broad, distended, voluminous
				if (cocks[i_cockIndex].cockThickness <= .75) description = "narrow ";
				if (cocks[i_cockIndex].cockThickness > 1 && cocks[i_cockIndex].cockThickness <= 1.4) description = "ample ";
				if (cocks[i_cockIndex].cockThickness > 1.4 && cocks[i_cockIndex].cockThickness <= 2) description = "broad ";
				if (cocks[i_cockIndex].cockThickness > 2 && cocks[i_cockIndex].cockThickness <= 3.5) description = "fat ";
				if (cocks[i_cockIndex].cockThickness > 3.5) description = "distended ";
				descripted = true;
			}
//Seems to work better without this comma:			if (descripted && cocks[i_cockIndex].cockType != CockTypesEnum.HUMAN) description += ", ";
			description += Appearance.cockNoun(cocks[i_cockIndex].cockType);

			return description;
		}

		public function assholeOrPussy():String
		{
			return Appearance.assholeOrPussy(this);
		}

		public function multiCockDescriptLight():String
		{
			return Appearance.multiCockDescriptLight(this);
		}

		public function multiCockDescript():String
		{
			return Appearance.multiCockDescript(this);
		}

		public function ballsDescriptLight(forcedSize:Boolean = true):String
		{
			return Appearance.ballsDescription(forcedSize, true, this);
		}

		public function sackDescript():String
		{
			return Appearance.sackDescript(this);
		}

		public function breastDescript(rowNum:int):String {
			//ERROR PREVENTION
			if (breastRows.length - 1 < rowNum) {
				CoC_Settings.error("");
				return "<b>ERROR, breastDescript() working with invalid breastRow</b>";
			}
			if (breastRows.length == 0) {
				CoC_Settings.error("");
				return "<b>ERROR, breastDescript() called when no breasts are present.</b>";
			}
			return BreastStore.breastDescript(breastRows[rowNum].breastRating, breastRows[rowNum].lactationMultiplier);
		}

		private function breastSize(val:Number):String
		{
			return Appearance.breastSize(val);
		}

		/**
		 * Echidna 1 ft long (i'd consider it barely qualifying), demonic 2 ft long, draconic 4 ft long
		 */
		public function hasLongTongue():Boolean {
			return tongue.type == Tongue.DEMONIC || tongue.type == Tongue.DRACONIC || tongue.type == Tongue.ECHIDNA;
		}
		
		public function hairOrFur():String
		{
			return Appearance.hairOrFur(this);
		}
		
		public function hairDescript():String
		{
			return Appearance.hairDescription(this);
		}
		
		public function beardDescript():String
		{
			return Appearance.beardDescription(this);
		}
		
		public function hipDescript():String
		{
			return Appearance.hipDescription(this);
		}
		
		public function assDescript():String
		{
			return buttDescript();
		}
		
		public function buttDescript():String
		{
			return Appearance.buttDescription(this);
		}
		
		public function tongueDescript():String
		{
			return Appearance.tongueDescription(this);
		}
		
		public function hornDescript():String
		{
			return Horns.Types[horns.type].name + " horns";
		}
		
		public function tailDescript():String
		{
			return Appearance.tailDescript(this);
		}
		
		public function oneTailDescript():String
		{
			return Appearance.oneTailDescript(this);
		}
		
		public function wingsDescript():String
		{
			return Appearance.wingsDescript(this);
		}
		
		public function eyesDescript():String
		{
			return Appearance.eyesDescript(this);
		}
		
		public function earsDescript():String
		{
			return Appearance.earsDescript(this);
		}

		public function damageToughnessModifier(displayMode:Boolean = false):Number {
			var temp:Number = 0;
			temp += tou / 20;
			if (temp > (20 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]))) temp = 20 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			//displayMode is for stats screen.
			if (displayMode) return temp;
			else return rand(temp);
		}
		public function damageIntelligenceModifier(displayMode:Boolean = false):Number {
			var temp:Number = 0;
			temp += inte / 20;
			if (temp > (10 + (2.5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]))) temp = 10 + (2.5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			//displayMode is for stats screen.
			if (displayMode) return temp;
			else return rand(temp);
		}
		public function damageWisdomModifier(displayMode:Boolean = false):Number {
			var temp:Number = 0;
			temp += wis / 20;
			if (temp > (10 + (2.5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]))) temp = 10 + (2.5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			//displayMode is for stats screen.
			if (displayMode) return temp;
			else return rand(temp);
		}

		public function damagePercent(displayMode:Boolean = false, applyModifiers:Boolean = false):Number {
			var mult:Number = 100;
			var armorMod:Number = armorDef;
			//--BASE--
			//Toughness modifier.
			if (!displayMode) {
				mult -= damageToughnessModifier();
				if (mult < 70) mult = 70;
			}
			//Modify armor rating based on weapons.
			if (applyModifiers) {
				if (game.player.weapon == game.weapons.JRAPIER || game.player.weapon == game.weapons.Q_GUARD || game.player.weapon == game.weapons.B_WIDOW || game.player.weapon == game.weapons.SPEAR || game.player.weapon == game.weapons.SESPEAR || game.player.weapon == game.weapons.DSSPEAR || game.player.weapon == game.weapons.LANCE
				 || game.player.weaponRange == game.weaponsrange.SHUNHAR || game.player.weaponRange == game.weaponsrange.KSLHARP || game.player.weaponRange == game.weaponsrange.LEVHARP || (game.player.weaponName.indexOf("staff") != -1 && game.player.hasPerk(PerkLib.StaffChanneling))) armorMod = 0;
				if (game.player.weapon == game.weapons.KATANA) armorMod -= 5;
				if (game.player.weapon == game.weapons.HALBERD) armorMod *= 0.6;
				if (game.player.weapon == game.weapons.GUANDAO) armorMod *= 0.4;
				if (game.player.hasPerk(PerkLib.LungingAttacks)) armorMod /= 2;
				if (armorMod < 0) armorMod = 0;
			}
			mult -= armorMod;
			//--PERKS--
			//Take damage you masochist!
			if (hasPerk(PerkLib.Masochist) && lib >= 60) {
				mult -= 0.2;
				if (short == game.player.short && !displayMode) game.player.dynStats("lus", (2 * (1 + game.player.newGamePlusMod())));
			}
			if (hasPerk(PerkLib.FenrirSpikedCollar)) {
				mult -= 0.15;
			}
			if (hasPerk(PerkLib.Juggernaut) && tou >= 100 && armorPerk == "Heavy") {
				mult -= 0.1;
			}
			if (hasPerk(PerkLib.ImmovableObject) && tou >= 75) {
				mult -= 0.1;
			}
			if (hasPerk(PerkLib.HeavyArmorProficiency) && tou >= 75 && armorPerk == "Heavy") {
				mult -= 0.1;
			}
			if (hasPerk(PerkLib.NakedTruth) && spe >= 75 && lib >= 60 && (armorName == "arcane bangles" || armorName == "practically indecent steel armor" || armorName == "revealing chainmail bikini" || armorName == "slutty swimwear" || armorName == "barely-decent bondage straps" || armorName == "nothing")) {
				mult -= 0.1;
			}
			//--STATUS AFFECTS--
			//Black cat beer = 25% reduction!
			if (statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
				mult -= 0.25;
			}
			if (statusEffectv1(StatusEffects.OniRampage) > 0) {
				mult -= 0.2;
			}
			if (statusEffectv1(StatusEffects.EarthStance) > 0) {
				mult -= 0.3;
			}
			//Defend = 35-95% reduction
			if (hasStatusEffect(StatusEffects.Defend)) {
				mult -= 0.35;
			}
			// Uma's Massage bonuses
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac && sac.value1 == UmasShop.MASSAGE_RELAXATION) {
				mult -= sac.value2;
			}
			//Caps damage reduction at 80/99%.
			if (!hasStatusEffect(StatusEffects.Defend) && mult < 20) mult = 20;
			return mult;
		}
		public function damageMagicalPercent(displayMode:Boolean = false, applyModifiers:Boolean = false):Number {
			var mult:Number = 100;
			//--BASE--
			//Intelligence/Wisdom modifier.
			if (!displayMode) {
				mult -= damageIntelligenceModifier();
				mult -= damageWisdomModifier();
				if (mult < 70) mult = 70;
			}
			if (hasPerk(PerkLib.NakedTruth)) mult -= 0.45 + (5 * game.player.newGamePlusMod());
			//--PERKS--
			if (hasPerk(PerkLib.NakedTruth) && spe >= 75 && lib >= 60 && (armorName == "arcane bangles" || armorName == "practically indecent steel armor" || armorName == "revealing chainmail bikini" || armorName == "slutty swimwear" || armorName == "barely-decent bondage straps" || armorName == "nothing")) {
				mult -= 0.1;
			}
			//--STATUS AFFECTS--
			//Defend = 35-95% reduction
			if (hasStatusEffect(StatusEffects.Defend)) {
				mult -= 0.35;
			}
			// Uma's Massage bonuses
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac && sac.value1 == UmasShop.MASSAGE_RELAXATION) {
				mult -= sac.value2;
			}
			//Caps damage reduction at 80/99%.
			if (!hasStatusEffect(StatusEffects.Defend) && mult < 20) mult = 20;
			return mult;
		}

		/**
		* Look into perks and special effects and @return summery extra chance to avoid attack granted by them.
		*/
		public function getEvasionChance():Number
		{
			var chance:Number = 0;
			if (hasPerk(PerkLib.Evade)) chance += 10;
			if (hasPerk(PerkLib.Flexibility)) chance += 6;
			if (hasPerk(PerkLib.Misdirection) && armorName == "red, high-society bodysuit") chance += 10;
			//if (hasPerk(PerkLib.Unhindered) && meetUnhinderedReq()) chance += 10;
			if (hasPerk(PerkLib.Unhindered) && (game.player.armorName == "arcane bangles" || game.player.armorName == "practically indecent steel armor" || game.player.armorName == "revealing chainmail bikini" || game.player.armorName == "slutty swimwear" || game.player.armorName == "barely-decent bondage straps" || game.player.armorName == "nothing")) chance += 10;
			if (hasPerk(PerkLib.JunglesWanderer)) chance += 35;
			if (hasStatusEffect(StatusEffects.Illusion)) chance += 10;
			if (hasStatusEffect(StatusEffects.Flying)) chance += 20;
			if (hasStatusEffect(StatusEffects.HurricaneDance)) chance += 25;
			if (hasStatusEffect(StatusEffects.BladeDance)) chance += 30;
			if (game.player.cheshireScore() >= 11) {
				if (hasStatusEffect(StatusEffects.EverywhereAndNowhere)) chance += 80;
				else chance += 30;
			}
			return chance;
		}

		public const EVASION_SPEED:String = "Speed"; // enum maybe?
		public const EVASION_EVADE:String = "Evade";
		public const EVASION_FLEXIBILITY:String = "Flexibility";
		public const EVASION_MISDIRECTION:String = "Misdirection";
		public const EVASION_UNHINDERED:String = "Unhindered";
		public const EVASION_JUNGLESWANDERER:String = "Jungle's Wanderer";
		public const EVASION_ILLUSION:String = "Illusion";
		public const EVASION_FLYING:String = "Flying";
		public const EVASION_CHESHIRE_PHASING:String = "Phasing";

		/**
	    * Try to avoid and @return a reason if successfull or null if failed to evade.
		*
		* If attacker is null then you can specify attack speed for enviromental and non-combat cases. If no speed and attacker specified and then only perks would be accounted.
		*
		* This does NOT account blind!
	    */
		public function getEvasionReason(useMonster:Boolean = true, attackSpeed:int = int.MIN_VALUE):String
		{
			// speed
			if (useMonster && game.monster != null && attackSpeed == int.MIN_VALUE) attackSpeed = game.monster.spe;
			if (attackSpeed != int.MIN_VALUE && spe - attackSpeed > 0 && int(Math.random() * (((spe - attackSpeed) / 4) + 80)) > 80) return "Speed";
			//note, Player.speedDodge is still used, since this function can't return how close it was

			var roll:Number = rand(100);

			// perks
			if (hasPerk(PerkLib.Evade) && (roll < 10)) return "Evade";
			if (hasPerk(PerkLib.Flexibility) && (roll < 6)) return "Flexibility";
			if (hasPerk(PerkLib.Misdirection) && armorName == "red, high-society bodysuit" && (roll < 10)) return "Misdirection";
			//if (hasPerk(PerkLib.Unhindered) && meetUnhinderedReq() && (roll < 10)) return "Unhindered";
			if (hasPerk(PerkLib.Unhindered) && (armorName == "arcane bangles" || armorName == "practically indecent steel armor" || armorName == "revealing chainmail bikini" || armorName == "slutty swimwear" || armorName == "barely-decent bondage straps" || armorName == "nothing") && (roll < 10)) return "Unhindered";
			if (hasPerk(PerkLib.JunglesWanderer) && (roll < 35)) return "Jungle's Wanderer";
			if (hasStatusEffect(StatusEffects.Illusion) && (roll < 10)) return "Illusion";
			if (hasStatusEffect(StatusEffects.Flying) && (roll < 20)) return "Flying";
			if (hasStatusEffect(StatusEffects.HurricaneDance) && (roll < 25)) return "Hurricane Dance";
			if (hasStatusEffect(StatusEffects.BladeDance) && (roll < 30)) return "Blade Dance";
			if (game.player.cheshireScore() >= 11 && ((!hasStatusEffect(StatusEffects.EverywhereAndNowhere) && (roll < 30)) || (hasStatusEffect(StatusEffects.EverywhereAndNowhere) && (roll < 80)))) return "Phasing";
			return null;
		}

		public function getEvasionRoll(useMonster:Boolean = true, attackSpeed:int = int.MIN_VALUE):Boolean
		{
			return getEvasionReason(useMonster, attackSpeed) != null;
		}

		public function get vagorass():IOrifice {
			return hasVagina() ? vaginas[0] : ass;
		}
		
		
		// returns OLD OP VAL
		public static function applyOperator(old:Number, op:String, val:Number):Number {
			switch(op) {
				case "=":
					return val;
				case "+":
					return old + val;
				case "-":
					return old - val;
				case "*":
					return old * val;
				case "/":
					return old / val;
				default:
					trace("applyOperator(" + old + ",'" + op + "'," + val + ") unknown op");
					return old;
			}
		}
		/**
		 * Generate increments for stats
		 *
		 * @return Object of (newStat-oldStat) with keys str, tou, spe, inte, wis, lib, sens, lust, cor
		 * and flag 'scale'
		 * */
		public static function parseDynStatsArgs(c:Creature, args:Array):Object {
			// Check num of args, we should have a multiple of 2
			if ((args.length % 2) != 0)
			{
				trace("dynStats aborted. Keys->Arguments could not be matched");
				return {str:0,tou:0,spe:0,inte:0,wis:0,lib:0,sens:0,lust:0,cor:0,scale:true};
			}
			var argDefs:Object = { //[value, operator]
				str: [ 0, "+"],
				tou: [ 0, "+"],
				spe: [ 0, "+"],
				int: [ 0, "+"],
				wis: [ 0, "+"],
				lib: [ 0, "+"],
				sen: [ 0, "+"],
				lus: [ 0, "+"],
				cor: [ 0, "+"],
				scale: [ true, "="]
			};
			var aliases:Object = {
				"strength":"str",
				"toughness": "tou",
				"speed": "spe",
				"intellect": "int",
				"inte": "int",
				"libido": "lib",
				"sensitivity": "sen",
				"sens": "sen",
				"lust": "lus",
				"corruption": "cor",
				"sca": "scale",
				"scaled": "scale",
				"res": "scale",
				"resisted": "scale",
				"wisdom": "wis"
			};
			
			for (var i:int = 0; i < args.length; i += 2)
			{
				if (typeof(args[i]) == "string")
				{
					// Make sure the next arg has the POSSIBILITY of being correct
					if ((typeof(args[i + 1]) != "number") && (typeof(args[i + 1]) != "boolean"))
					{
						trace("dynStats aborted. Next argument after argName is invalid! arg is type " + typeof(args[i + 1]));
						continue;
					}
					var argOp:String = "";
					// Figure out which array to search
					var argsi:String = (args[i] as String);
					if ("+-*/=".indexOf(argsi.charAt(argsi.length - 1)) != -1) {
						argOp = argsi.charAt(argsi.length - 1);
						argsi = argsi.slice(0, argsi.length - 1);
					}
					if (argsi in aliases) argsi = aliases[argsi];
					
					if (argsi in argDefs) {
						argDefs[argsi][0] = args[i + 1];
						if (argOp) argDefs[argsi][1] = argOp;
					} else {
						trace("Couldn't find the arg name " + argsi + " in the index arrays. Welp!");
					}
				}
				else
				{
					trace("dynStats aborted. Expected a key and got SHIT");
				}
			}
			// Got this far, we have values to statsify
			var newStr:Number = applyOperator(c.str, argDefs.str[1], argDefs.str[0]);
			var newTou:Number = applyOperator(c.tou, argDefs.tou[1], argDefs.tou[0]);
			var newSpe:Number = applyOperator(c.spe, argDefs.spe[1], argDefs.spe[0]);
			var newInte:Number = applyOperator(c.inte, argDefs.int[1], argDefs.int[0]);
			var newWis:Number = applyOperator(c.wis, argDefs.wis[1], argDefs.wis[0]);
			var newLib:Number = applyOperator(c.lib, argDefs.lib[1], argDefs.lib[0]);
			var newSens:Number = applyOperator(c.sens, argDefs.sen[1], argDefs.sen[0]);
			var newLust:Number = applyOperator(c.lust, argDefs.lus[1], argDefs.lus[0]);
			var newCor:Number = applyOperator(c.cor, argDefs.cor[1], argDefs.cor[0]);
			// Because lots of checks and mods are made in the stats(), calculate deltas and pass them. However, this means that the '=' operator could be resisted
			// In future (as I believe) stats() should be replaced with dynStats(), and checks and mods should be made here
			return {
				str     : newStr - c.str,
				tou     : newTou - c.tou,
				spe     : newSpe - c.spe,
				inte    : newInte - c.inte,
				wis     : newWis - c.wis,
				lib     : newLib - c.lib,
				sens    : newSens - c.sens,
				lust    : newLust - c.lust,
				cor     : newCor - c.cor,
				scale   : argDefs.scale[0]
			};
		}

		public function kiPowerCostMod():Number {
			var mod:int = 1;
			if(hasPerk(PerkLib.WizardsAndDaoistsEndurance)){
				mod -= (0.01 * perkv2(PerkLib.WizardsAndDaoistsEndurance))
			}
			if(hasPerk(PerkLib.SeersInsight)){
				mod -= perkv1(PerkLib.SeersInsight);
			}
			if(jewelryName == game.jewelries.FOXHAIR.name){
				mod -= 0.2;
			}

			var mult:Number = 1;
			if(mod > 1) {
				mult += (mod - 1) * 0.1;
			}
			for(var i:int = 24, j:int = 0; i < level; i+=18, j++){
				if(wis >= 80 + (60 * j)){
					mult++;
				}
			}
			return Math.max(0.1,mod) * mult;
		}

		public function kiPowerMod(physical:Boolean=false):Number {
			var mod:Number = 1;
			if(physical){
				if(hasPerk(PerkLib.BodyCultivatorsFocus)) {mod += perkv1(PerkLib.BodyCultivatorsFocus);}
			} else {
				if(hasPerk(PerkLib.WizardsAndDaoistsFocus)) {mod += perkv2(PerkLib.WizardsAndDaoistsFocus);}
				if(hasPerk(PerkLib.SeersInsight)) {mod += perkv1(PerkLib.SeersInsight);}
				if(shieldName == CoC.instance.shields.SPI_FOC.name){
					mod += 0.2;
				}
			}
			return mod;
		}

		private function touSpeStrScale(stat:int):Number{
			var scale:Number = 0;
			for(var i:int = 20; (i <= 80) && (i <= stat); i += 20){
				scale += stat - i;
			}
			for(i = 100; (i <= 2000) && (i <= stat); i += 50){
				scale += stat - i;
			}
			return scale;
		}

		private function inteWisLibScale(stat:int):Number{
			var scale:Number = 6.75;
			var changeBy:Number = 0.50;
			if(stat <= 2000){
				if(stat <= 100){
					scale = (2/6) + ((int(stat/100)/20) * (1/6));
					changeBy = 0.25;
				} else {
					scale = 1 + (int((stat - 100)/50) * 0.25);
				}
			}
			return (stat * scale) + rand(stat * (scale + changeBy));
		}

		public function scalingBonusToughness():Number {
			return touSpeStrScale(tou);
		}

		public function scalingBonusSpeed():Number {
			return touSpeStrScale(spe);
		}

		public function scalingBonusStrength():Number {
			return touSpeStrScale(str);
		}

		public function scalingBonusWisdom():Number {
			return touSpeStrScale(wis);
		}

		public function scalingBonusIntelligence():Number {
			return touSpeStrScale(inte);
		}

		public function scalingBonusLibido():Number {
			return inteWisLibScale(lib);
		}

		public function isFistOrFistWeapon():Boolean
		{
			var w:WeaponLib = game.weapons;
			var weaponArr:Array = [
				"fists", w.S_GAUNT.name, w.H_GAUNT.name,
				w.MASTGLO.name, w.KARMTOU.name, w.YAMARG.name,
				w.CLAWS.name
			];
			for each(var weap:String in weaponArr) {
				if(weaponName == weap){return true}
			}
			return false;
		}
	}
}
