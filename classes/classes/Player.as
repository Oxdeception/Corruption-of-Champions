﻿package classes
{
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.ISexyPart;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armor;
import classes.Items.ArmorLib;
import classes.Items.Jewelry;
import classes.Items.JewelryLib;
import classes.Items.Mutations;
import classes.Items.Shield;
import classes.Items.ShieldLib;
import classes.Items.Undergarment;
import classes.Items.UndergarmentLib;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Items.WeaponRange;
import classes.Items.WeaponRangeLib;
import classes.Scenes.Areas.Forest.KitsuneScene;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.Pregnancy;
import classes.Scenes.SceneLib;
import classes.StatusEffects.VampireThirstEffect;
import classes.internals.Utils;
import classes.lists.BreastCup;

use namespace CoC;

	/**
	 * ...
	 * @author Yoffy
	 */
	public class Player extends Character {
		
		public function Player() {
			//Item things
			itemSlot1 = new ItemSlotClass();
			itemSlot2 = new ItemSlotClass();
			itemSlot3 = new ItemSlotClass();
			itemSlot4 = new ItemSlotClass();
			itemSlot5 = new ItemSlotClass();
			itemSlot6 = new ItemSlotClass();
			itemSlot7 = new ItemSlotClass();
			itemSlot8 = new ItemSlotClass();
			itemSlot9 = new ItemSlotClass();
			itemSlot10 = new ItemSlotClass();
			itemSlots = [itemSlot1, itemSlot2, itemSlot3, itemSlot4, itemSlot5, itemSlot6, itemSlot7, itemSlot8, itemSlot9, itemSlot10];
		}
		
		protected final function outputText(text:String, clear:Boolean = false):void
		{
			if (clear) EngineCore.clearOutputTextOnly();
			EngineCore.outputText(text);
		}
		
		public var startingRace:String = "human";
		
		//Autosave
		public var slotName:String = "VOID";
		public var autoSave:Boolean = false;

		//Lust vulnerability
		//TODO: Kept for backwards compatibility reasons but should be phased out.
		public var lustVuln:Number = 1;

		//Teasing attributes
		public var teaseLevel:Number = 0;
		public var teaseXP:Number = 0;
		
		//Prison stats
		public var hunger:Number = 0; //Also used in survival and realistic mode
		public var obey:Number = 0;
		public var esteem:Number = 0;
		public var will:Number = 0;
		
		public var obeySoftCap:Boolean = true;
		
		//Perks used to store 'queued' perk buys
		public var perkPoints:Number = 0;
		public var statPoints:Number = 0;
		public var ascensionPerkPoints:Number = 0;

		public var tempStr:Number = 0;
		public var tempTou:Number = 0;
		public var tempSpe:Number = 0;
		public var tempInt:Number = 0;
		public var tempWis:Number = 0;
		public var tempLib:Number = 0;
		//Number of times explored for new areas
		public var explored:Number = 0;
		public var exploredForest:Number = 0;
		public var exploredDesert:Number = 0;
		public var exploredMountain:Number = 0;
		public var exploredLake:Number = 0;

		//Player pregnancy variables and functions
		private var pregnancy:Pregnancy = new Pregnancy();
		override public function pregnancyUpdate():Boolean {
			return pregnancy.updatePregnancy(); //Returns true if we need to make sure pregnancy texts aren't hidden
		}

		// Inventory
		public var itemSlot1:ItemSlotClass;
		public var itemSlot2:ItemSlotClass;
		public var itemSlot3:ItemSlotClass;
		public var itemSlot4:ItemSlotClass;
		public var itemSlot5:ItemSlotClass;
		public var itemSlot6:ItemSlotClass;
		public var itemSlot7:ItemSlotClass;
		public var itemSlot8:ItemSlotClass;
		public var itemSlot9:ItemSlotClass;
		public var itemSlot10:ItemSlotClass;
		public var itemSlots:Array;
		
		public var prisonItemSlots:Array = [];
		public var previouslyWornClothes:Array = []; //For tracking achievement.
		
		private var _weapon:Weapon = WeaponLib.FISTS;
		private var _weaponRange:WeaponRange = WeaponRangeLib.NOTHING;
		private var _armor:Armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
		private var _jewelry:Jewelry = JewelryLib.NOTHING;
		private var _shield:Shield = ShieldLib.NOTHING;
		private var _upperGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _lowerGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _modArmorName:String = "";

		//override public function set armors
		override public function set armorValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorValue.");
		}

		override public function set armorName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorName.");
		}

		override public function set armorDef(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorDef.");
		}

		override public function set armorPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorPerk.");
		}

		//override public function set weapons
		override public function set weaponName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponName.");
		}

		override public function set weaponVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponVerb.");
		}

		override public function set weaponAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponAttack.");
		}

		override public function set weaponPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponPerk.");
		}

		override public function set weaponValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponValue.");
		}

		//override public function set weapons
		override public function set weaponRangeName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeName.");
		}

		override public function set weaponRangeVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeVerb.");
		}

		override public function set weaponRangeAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeAttack.");
		}

		override public function set weaponRangePerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangePerk.");
		}

		override public function set weaponRangeValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeValue.");
		}

		//override public function set jewelries
		override public function set jewelryName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryName.");
		}
		
		override public function set jewelryEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectId.");
		}
		
		override public function set jewelryEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectMagnitude.");
		}
				
		override public function set jewelryPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryPerk.");
		}
		
		override public function set jewelryValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryValue.");
		}

		//override public function set shields
		override public function set shieldName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldName.");
		}
		
		override public function set shieldBlock(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldBlock.");
		}
		
		override public function set shieldPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldPerk.");
		}
		
		override public function set shieldValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldValue.");
		}
		
		//override public function set undergarments
		override public function set upperGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentName.");
		}
		
		override public function set upperGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentPerk.");
		}
		
		override public function set upperGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentValue.");
		}

		override public function set lowerGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentName.");
		}
		
		override public function set lowerGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentPerk.");
		}
		
		override public function set lowerGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentValue.");
		}
		
		
		public function get modArmorName():String
		{
			if (_modArmorName == null) _modArmorName = "";
			return _modArmorName;
		}

		public function set modArmorName(value:String):void
		{
			if (value == null) value = "";
			_modArmorName = value;
		}
		public function isWearingArmor():Boolean {
			return armor != ArmorLib.COMFORTABLE_UNDERCLOTHES && armor != ArmorLib.NOTHING;
		}
		//Natural Armor (need at least to partialy covering whole body)
		public function haveNaturalArmor():Boolean
		{
			return hasPerk(PerkLib.ThickSkin) || skin.hasFur() || skin.hasChitin() || skin.hasScales() || skin.hasBark() || skin.hasDragonScales() || skin.hasBaseOnly(Skin.STONE);
		}
		//Unhindered related acceptable armor types
		public function meetUnhinderedReq():Boolean
		{
			return armorName == "arcane bangles" || armorName == "practically indecent steel armor" || armorName == "revealing chainmail bikini" || armorName == "slutty swimwear" || armorName == "barely-decent bondage straps" || armor == ArmorLib.NOTHING;
		}
		//override public function get armors
		override public function get armorName():String {
			if (_modArmorName.length > 0) return modArmorName;
			else if (_armor.name == "nothing" && lowerGarmentName != "nothing") return lowerGarmentName;
			else if (_armor.name == "nothing" && lowerGarmentName == "nothing") return "gear";
			return _armor.name;
		}
		override public function get armorDef():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var armorDef:Number = _armor.def;
			armorDef += upperGarment.armorDef;
			armorDef += lowerGarment.armorDef;
			//Blacksmith history!
			if (armorDef > 0 && (hasPerk(PerkLib.HistorySmith) || hasPerk(PerkLib.PastLifeSmith))) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinArmorPolishing)) {
				armorDef = Math.round(armorDef * (1 + (statusEffectv2(StatusEffects.KonstantinArmorPolishing) / 100)));
				armorDef += 1;
			}
			//Skin armor perk
			if (hasPerk(PerkLib.ThickSkin)) {
				armorDef += (2 * newGamePlusMod);
			}
			//Stacks on top of Thick Skin perk.
			var p:Boolean = skin.isCoverLowMid();
			if (skin.hasFur()) armorDef += (p?1:2)*newGamePlusMod;
			if (skin.hasChitin()) armorDef += (p?2:4)*newGamePlusMod;
			if (skin.hasScales()) armorDef += (p?3:6)*newGamePlusMod; //bee-morph (), mantis-morph (), scorpion-morph (wpisane), spider-morph (wpisane)
			if (skin.hasBark() || skin.hasDragonScales()) armorDef += (p?4:8)*newGamePlusMod;
			if (skin.hasBaseOnly(Skin.STONE)) armorDef += (10 * newGamePlusMod);
			//'Thick' dermis descriptor adds 1!
			if (skinAdj == "smooth") armorDef += (1 * newGamePlusMod);
			//Plant score bonuses
			if (plantScore() >= 4) {
				if (plantScore() >= 7) armorDef += (10 * newGamePlusMod);
				else if (plantScore() == 6) armorDef += (8 * newGamePlusMod);
				else if (plantScore() == 5) armorDef += (4 * newGamePlusMod);
				else armorDef += (2 * newGamePlusMod);
			}
			if (yggdrasilScore() >= 10) armorDef += (10 * newGamePlusMod);
			//Dragon score bonuses
			if (dragonScore() >= 10) {
				if (dragonScore() >= 28) armorDef += (10 * newGamePlusMod);
				else if (dragonScore() >= 20) armorDef += (4 * newGamePlusMod);
				else armorDef += (1 * newGamePlusMod);
			}
			//Bonus defense
			if (arms.type == Arms.YETI) armorDef += (1 * newGamePlusMod);
			if (arms.type == Arms.SPIDER || arms.type == Arms.MANTIS || arms.type == Arms.BEE || arms.type == Arms.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (arms.type == Arms.GARGOYLE) armorDef += (8 * newGamePlusMod);
			if (arms.type == Arms.GARGOYLE_2) armorDef += (5 * newGamePlusMod);
			if (tailType == Tail.SPIDER_ADBOMEN || tailType == Tail.MANTIS_ABDOMEN || tailType == Tail.BEE_ABDOMEN) armorDef += (2 * newGamePlusMod);
			if (tailType == Tail.GARGOYLE) armorDef += (8 * newGamePlusMod);
			if (tailType == Tail.GARGOYLE_2) armorDef += (5 * newGamePlusMod);
			if (wings.type == Wings.GARGOYLE_LIKE_LARGE) armorDef += (8 * newGamePlusMod);
			if (lowerBody == LowerBody.YETI) armorDef += (1 * newGamePlusMod);
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS || lowerBody == LowerBody.BEE || lowerBody == LowerBody.MANTIS || lowerBody == LowerBody.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (lowerBody == LowerBody.DRAGON) armorDef += (3 * newGamePlusMod);
			if (lowerBody == LowerBody.DRIDER) armorDef += (4 * newGamePlusMod);
			if (lowerBody == LowerBody.GARGOYLE) armorDef += (8 * newGamePlusMod);
			if (lowerBody == LowerBody.GARGOYLE_2) armorDef += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.Lycanthropy)) armorDef += 10 * newGamePlusMod;
			//Soul Cultivators bonuses
			if (hasPerk(PerkLib.BodyCultivator)) {
				armorDef += (1 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.FleshBodyApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) armorDef += 2 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulPersonage)) armorDef += 2 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulWarrior)) armorDef += 2 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) armorDef += 3 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulScholar)) armorDef += 3 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulElder)) armorDef += 3 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyElderStage)) {
				if (hasPerk(PerkLib.SoulExalt)) armorDef += 4 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulOverlord)) armorDef += 4 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulTyrant)) armorDef += 4 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.FleshBodyOverlordStage)) {
				if (hasPerk(PerkLib.SoulKing)) armorDef += 5 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulEmperor)) armorDef += 5 * newGamePlusMod;
				if (hasPerk(PerkLib.SoulAncestor)) armorDef += 5 * newGamePlusMod;
			}
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) armorDef += 6 * newGamePlusMod;
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) armorDef += 9 * newGamePlusMod;
			//Agility boosts armor ratings!
			var speedBonus:int = 0;
			if (hasPerk(PerkLib.Agility)) {
				if (armorPerk == "Light" || _armor.name == "nothing") {
					speedBonus += Math.round(spe / 10);
				}
				else if (armorPerk == "Medium") {
					speedBonus += Math.round(spe / 25);
				}
			}
			if (hasPerk(PerkLib.ArmorMaster)) {
				if (armorPerk == "Heavy") speedBonus += Math.round(spe / 50);
			}
			armorDef += speedBonus;
			//Feral armor boosts armor ratings!
			var toughnessBonus:int = 0;
			if (hasPerk(PerkLib.FeralArmor) && haveNaturalArmor() && meetUnhinderedReq()) {
				toughnessBonus += Math.round(tou / 20);
			}
			armorDef += toughnessBonus;
			if (hasPerk(PerkLib.PrestigeJobSentinel) && armorPerk == "Heavy") armorDef += _armor.def;
			if (hasPerk(PerkLib.ShieldExpertise) && shieldName != "nothing") {
				if (shieldBlock >= 4) armorDef += Math.round(shieldBlock);
				else armorDef += 1;
			}
			//Acupuncture effect
			if (hasPerk(PerkLib.ChiReflowDefense)) armorDef *= UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI;
			if (hasPerk(PerkLib.ChiReflowAttack)) armorDef *= UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI;
			//Other bonuses
			if (hasPerk(PerkLib.ToughHide) && haveNaturalArmor()) armorDef += (2 * newGamePlusMod);
			armorDef = Math.round(armorDef);
			//Berzerking removes armor
			if (hasStatusEffect(StatusEffects.Berzerking) && !hasPerk(PerkLib.ColdFury)) {
				armorDef = 0;
			}
			if (hasStatusEffect(StatusEffects.ChargeArmor) && (!isNaked() || (isNaked() && haveNaturalArmor() && hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor)))) armorDef += Math.round(statusEffectv1(StatusEffects.ChargeArmor));
			if (hasStatusEffect(StatusEffects.StoneSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.StoneSkin));
			if (hasStatusEffect(StatusEffects.BarkSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.BarkSkin));
			if (hasStatusEffect(StatusEffects.MetalSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.MetalSkin));
			if (CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				armorDef -= CoC.instance.monster.statusEffectv1(StatusEffects.TailWhip);
				if(armorDef < 0) armorDef = 0;
			}
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			if (hasStatusEffect(StatusEffects.CrinosShape) && hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor)) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			armorDef = Math.round(armorDef);
			return armorDef;
		}
		public function get armorBaseDef():Number {
			return _armor.def;
		}
		override public function get armorPerk():String {
			return _armor.perk;
		}
		override public function get armorValue():Number {
			return _armor.value;
		}

		//Weapons for Whirlwind
		public function isWeaponForWhirlwind():Boolean
		{
			return weapon == game.weapons.BFSWORD || weapon == game.weapons.NPHBLDE || weapon == game.weapons.EBNYBLD || weapon == game.weapons.CLAYMOR || weapon == game.weapons.URTAHLB || weapon == game.weapons.KIHAAXE || weapon == game.weapons.L__AXE || weapon == game.weapons.L_HAMMR || weapon == game.weapons.TRASAXE || weapon == game.weapons.WARHAMR
			 || weapon == game.weapons.OTETSU || weapon == game.weapons.NODACHI || weapon == game.weapons.WGSWORD || weapon == game.weapons.DBFSWO || weapon == game.weapons.D_WHAM_ || weapon == game.weapons.DL_AXE_ || weapon == game.weapons.DSWORD_ || weapon == game.weapons.HALBERD || weapon == game.weapons.GUANDAO;// || weapon == game.weapons.
		}
		//Weapons for Whipping
		public function isWeaponsForWhipping():Boolean
		{
			return weapon == game.weapons.FLAIL || weapon == game.weapons.L_WHIP || weapon == game.weapons.SUCWHIP || weapon == game.weapons.PSWHIP || weapon == game.weapons.WHIP || weapon == game.weapons.PWHIP || weapon == game.weapons.NTWHIP || weapon == game.weapons.CNTWHIP || weapon == game.weapons.RIBBON || weapon == game.weapons.ERIBBON
			|| weapon == game.weapons.SNAKESW;
		}
		//1H Weapons
		public function isOneHandedWeapons():Boolean
		{
			return weaponPerk != "Dual Large" && weaponPerk != "Dual" && weaponPerk != "Staff" && weaponPerk != "Large";
		}
		//Wrath Weapons
		public function isLowGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.BFSWORD || weapon == game.weapons.NPHBLDE || weapon == game.weapons.EBNYBLD || weapon == game.weapons.OTETSU || weapon == game.weapons.POCDEST || weapon == game.weapons.DOCDEST || weapon == game.weapons.CNTWHIP;
		}
		public function isDualLowGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.DBFSWO;
		}
		//Fists and fist weapons
		override public function isFistOrFistWeapon():Boolean
		{
			return weaponName == "fists" || weapon == game.weapons.S_GAUNT || weapon == game.weapons.H_GAUNT || weapon == game.weapons.MASTGLO || weapon == game.weapons.KARMTOU || weapon == game.weapons.YAMARG || weapon == game.weapons.CLAWS;
		}
		//Natural Jouster perks req check
		public function isMeetingNaturalJousterReq():Boolean
		{
			return (((isTaur() || isDrider()) && spe >= 60) && hasPerk(PerkLib.Naturaljouster) && (!hasPerk(PerkLib.DoubleAttack) || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)))
             || (spe >= 150 && hasPerk(PerkLib.Naturaljouster) && hasPerk(PerkLib.DoubleAttack) && (!hasPerk(PerkLib.DoubleAttack) || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)));
		}
		public function isMeetingNaturalJousterMasterGradeReq():Boolean
		{
			return (((isTaur() || isDrider()) && spe >= 180) && hasPerk(PerkLib.NaturaljousterMastergrade) && (!hasPerk(PerkLib.DoubleAttack) || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)))
             || (spe >= 450 && hasPerk(PerkLib.NaturaljousterMastergrade) && hasPerk(PerkLib.DoubleAttack) && (!hasPerk(PerkLib.DoubleAttack) || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)));
		}
		public function haveWeaponForJouster():Boolean
		{
			return weaponName == "deadly spear" || weaponName == "deadly lance" || weaponName == "deadly trident" || weaponName == "seraph spear" || weaponName == "demon snake spear";
		}
		//override public function get weapons
		override public function get weaponName():String {
			return _weapon.name;
		}
		override public function get weaponVerb():String {
			return _weapon.verb;
		}
		override public function get weaponAttack():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var attack:Number = _weapon.attack;
			if (hasPerk(PerkLib.JobSwordsman) && weaponPerk == "Large") {
				if (hasPerk(PerkLib.WeaponMastery) && str >= 100) {
					if (hasPerk(PerkLib.WeaponGrandMastery) && str >= 140) attack *= 2;
					else attack *= 1.5;
				}
				else attack *= 1.25;
			}
			if (hasPerk(PerkLib.WeaponGrandMastery) && weaponPerk == "Dual Large" && str >= 140) {
				attack *= 2;
			}
			if (hasPerk(PerkLib.HiddenMomentum) && weaponPerk == "Large" && str >= 75 && spe >= 50) {
				attack += (((str + spe) - 100) * 0.1);
			}//30-70-110
			if (hasPerk(PerkLib.HiddenDualMomentum) && weaponPerk == "Dual Large" && str >= 150 && spe >= 100) {
				attack += (((str + spe) - 200) * 0.1);
			}//20-60-100
			if (hasPerk(PerkLib.LightningStrikes) && spe >= 60 && (weaponPerk != "Large" || weaponPerk != "Dual Large" || !isFistOrFistWeapon())) {
				attack += ((spe - 50) * 0.3);//wyjątek potem dodać dla daggers i innych assasins weapons i dać im lepszy przelicznik
			}//45-105-165
			if (hasPerk(PerkLib.SteelImpact)) {
				attack += ((tou - 50) * 0.3);
			}
			if (isFistOrFistWeapon()) {
				if (hasPerk(PerkLib.IronFistsI) && str >= 50) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsII) && str >= 65) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsIII) && str >= 80) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsIV) && str >= 95) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsV) && str >= 110) {
					attack += 10;
				}
				if (hasPerk(PerkLib.IronFistsVI) && str >= 125) {
					attack += 10;
				}
				if (hasPerk(PerkLib.JobBrawler) && str >= 60) {
					attack += (5 * newGamePlusMod);
				}		// && (weaponName == "hooked gauntlets" || weaponName == "spiked gauntlet")
				if (hasPerk(PerkLib.MightyFist)) {
					attack += (5 * newGamePlusMod);
				}
				if (SceneLib.combat.unarmedAttack() > 0) {
					attack += SceneLib.combat.unarmedAttack();
				}
			}
			if (arms.type == Arms.MANTIS && weaponName == "fists") {
				attack += (15 * newGamePlusMod);
			}
			if ((arms.type == Arms.YETI || arms.type == Arms.CAT) && weaponName == "fists") {
				attack += (5 * newGamePlusMod);
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinWeaponSharpening) && weaponName != "fists") {
				attack *= 1 + (statusEffectv2(StatusEffects.KonstantinWeaponSharpening) / 100);
			}
			if (hasStatusEffect(StatusEffects.Berzerking)) attack += (15 + (15 * newGamePlusMod));
			if (hasStatusEffect(StatusEffects.Lustzerking)) attack += (15 + (15 * newGamePlusMod));
			if (hasStatusEffect(StatusEffects.ChargeWeapon)) {
				if (((weaponName == "fists" && hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalWeapons)) || weaponName != "fists") && weaponPerk != "Large" && weaponPerk != "Dual Large") attack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
				if (weaponPerk == "Large" || weaponPerk == "Dual Large") attack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
			}
			attack = Math.round(attack);
			return attack;
		}
		public function get weaponBaseAttack():Number {
			return _weapon.attack;
		}
		override public function get weaponPerk():String {
			return _weapon.perk || "";
		}
		override public function get weaponValue():Number {
			return _weapon.value;
		}
		//Artifacts Bows
		public function isArtifactBow():Boolean
		{
			return weaponRange == game.weaponsrange.BOWGUID || weaponRange == game.weaponsrange.BOWHODR;
		}
		//Using Tome
		public function isUsingTome():Boolean
		{
			return weaponRangeName == "nothing" || weaponRangeName == "Inquisitor’s Tome" || weaponRangeName == "Sage’s Sketchbook";
		}
		//override public function get weapons
		override public function get weaponRangeName():String {
			return _weaponRange.name;
		}
		override public function get weaponRangeVerb():String {
			return _weaponRange.verb;
		}
		override public function get weaponRangeAttack():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var rangeattack:Number = _weaponRange.attack;
			if (hasPerk(PerkLib.Sharpshooter) && weaponRangePerk != "Bow") {
				if (inte < 201) rangeattack *= (1 + (inte / 200));
				else rangeattack *= 2;
			}
		/*	if(hasPerk(PerkLib.LightningStrikes) && spe >= 60 && weaponRangePerk != "Large") {
				rangeattack += Math.round((spe - 50) / 3);
			}
			if(hasPerk(PerkLib.IronFistsI) && str >= 50 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(hasPerk(PerkLib.IronFistsII) && str >= 65 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(hasPerk(PerkLib.IronFistsIII) && str >= 80 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(hasPerk(PerkLib.IronFistsIV) && str >= 95 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(hasPerk(PerkLib.IronFistsV) && str >= 110 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(hasPerk(PerkLib.JobBrawler) && str >= 60 && weaponRangeName == "fists") {
				rangeattack += (5 * newGamePlusMod);
			}
			if(arms.type == MANTIS && weaponRangeName == "fists") {
				rangeattack += (15 * newGamePlusMod);
			}
			if(hasStatusEffect(StatusEffects.Berzerking)) rangeattack += (30 + (15 * newGamePlusMod));
			if(hasStatusEffect(StatusEffects.Lustzerking)) rangeattack += (30 + (15 * newGamePlusMod));
			if(findPerk(PerkLib.) >= 0) rangeattack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
		*/	rangeattack = Math.round(rangeattack);
			return rangeattack;
		}
		public function get weaponRangeBaseAttack():Number {
			return _weaponRange.attack;
		}
		override public function get weaponRangePerk():String {
			return _weaponRange.perk || "";
		}
		override public function get weaponRangeValue():Number {
			return _weaponRange.value;
		}
		public function get ammo():int {
			return flags[kFLAGS.FLINTLOCK_PISTOL_AMMO];
		}
		public function set ammo(value:int):void {
			flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = value;
		}
		
		//override public function get jewelries.
		override public function get jewelryName():String {
			return _jewelry.name;
		}
		override public function get jewelryEffectId():Number {
			return _jewelry.effectId;
		}
		override public function get jewelryEffectMagnitude():Number {
			return _jewelry.effectMagnitude;
		}
		override public function get jewelryPerk():String {
			return _jewelry.perk;
		}
		override public function get jewelryValue():Number {
			return _jewelry.value;
		}
		
		//Shields for Bash
		public function isShieldsForShieldBash():Boolean
		{
			return shield == game.shields.BUCKLER || shield == game.shields.GREATSH || shield == game.shields.KITE_SH || shield == game.shields.TRASBUC || shield == game.shields.TOWERSH || shield == game.shields.DRGNSHL || shield == game.shields.SANCTYN || shield == game.shields.SANCTYL || shield == game.shields.SANCTYD;
		}
		//override public function get shields
		override public function get shieldName():String {
			return _shield.name;
		}
		override public function get shieldBlock():Number {
			var block:Number = _shield.block;
			if (hasPerk(PerkLib.JobKnight)) block += 3;
			//miejce na sposoby boostowania block value like perks or status effects
			block = Math.round(block);
			return block;
		}
		override public function get shieldPerk():String {
			return _shield.perk;
		}
		override public function get shieldValue():Number {
			return _shield.value;
		}
		public function get shield():Shield
		{
			return _shield;
		}

		//override public function get undergarment
		override public function get upperGarmentName():String {
			return _upperGarment.name;
		}
		override public function get upperGarmentPerk():String {
			return _upperGarment.perk;
		}
		override public function get upperGarmentValue():Number {
			return _upperGarment.value;
		}
		public function get upperGarment():Undergarment
		{
			return _upperGarment;
		}
		
		override public function get lowerGarmentName():String {
			return _lowerGarment.name;
		}
		override public function get lowerGarmentPerk():String {
			return _lowerGarment.perk;
		}
		override public function get lowerGarmentValue():Number {
			return _lowerGarment.value;
		}
		public function get lowerGarment():Undergarment
		{
			return _lowerGarment;
		}
		
		public function get armor():Armor
		{
			return _armor;
		}
		
		public function setArmor(newArmor:Armor):Armor {
			//Returns the old armor, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldArmor:Armor = _armor.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newArmor == null) {
				CoC_Settings.error(short + ".armor is set to null");
				newArmor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			_armor = newArmor.playerEquip(); //The armor can also choose to equip something else - useful for Ceraph's trap armor
			return oldArmor;
		}
		
		/*
		public function set armor(value:Armor):void
		{
			if (value == null){
				CoC_Settings.error(short+".armor is set to null");
				value = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setArmorHiddenField(value:Armor):void
		{
			this._armor = value;
		}

		public function get weapon():Weapon
		{
			return _weapon;
		}
		
		public function get weaponRange():WeaponRange
		{
			return _weaponRange;
		}

		public function setWeapon(newWeapon:Weapon):Weapon {
			//Returns the old weapon, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeapon:Weapon = _weapon.playerRemove(); //The weapon is responsible for removing any bonuses, perks, etc.
			if (newWeapon == null) {
				CoC_Settings.error(short + ".weapon (melee) is set to null");
				newWeapon = WeaponLib.FISTS;
			}
			_weapon = newWeapon.playerEquip(); //The weapon can also choose to equip something else
			return oldWeapon;
		}
		
		/*
		public function set weapon(value:Weapon):void
		{
			if (value == null){
				CoC_Settings.error(short+".weapon is set to null");
				value = WeaponLib.FISTS;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setWeaponHiddenField(value:Weapon):void
		{
			this._weapon = value;
		}
		
		public function setWeaponRange(newWeaponRange:WeaponRange):WeaponRange {
			//Returns the old shield, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeaponRange:WeaponRange = _weaponRange.playerRemove();
			if (newWeaponRange == null) {
				CoC_Settings.error(short + ".weapon (range) is set to null");
				newWeaponRange = WeaponRangeLib.NOTHING;
			}
			_weaponRange = newWeaponRange.playerEquip();
			return oldWeaponRange;
		}
		
		// in case you don't want to call the value.equip
		public function setWeaponRangeHiddenField(value:WeaponRange):void
		{
			this._weaponRange = value;
		}
		
		//Jewelry, added by Kitteh6660
		public function get jewelry():Jewelry
		{
			return _jewelry;
		}

		public function setJewelry(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField(value:Jewelry):void
		{
			this._jewelry = value;
		}
		
		public function setShield(newShield:Shield):Shield {
			//Returns the old shield, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldShield:Shield = _shield.playerRemove(); //The shield is responsible for removing any bonuses, perks, etc.
			if (newShield == null) {
				CoC_Settings.error(short + ".shield is set to null");
				newShield = ShieldLib.NOTHING;
			}
			_shield = newShield.playerEquip(); //The shield can also choose to equip something else.
			return oldShield;
		}
		
		// in case you don't want to call the value.equip
		public function setShieldHiddenField(value:Shield):void
		{
			this._shield = value;
		}

		public function setUndergarment(newUndergarment:Undergarment, typeOverride:int = -1):Undergarment {
			//Returns the old undergarment, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldUndergarment:Undergarment = UndergarmentLib.NOTHING;
			if (newUndergarment.type == UndergarmentLib.TYPE_UPPERWEAR || typeOverride == 0) { 
				oldUndergarment = _upperGarment.playerRemove(); //The undergarment is responsible for removing any bonuses, perks, etc.
				if (newUndergarment == null) {
					CoC_Settings.error(short + ".upperGarment is set to null");
					newUndergarment = UndergarmentLib.NOTHING;
				}
				_upperGarment = newUndergarment.playerEquip(); //The undergarment can also choose to equip something else.
			}
			else if (newUndergarment.type == UndergarmentLib.TYPE_LOWERWEAR || typeOverride == 1) { 
				oldUndergarment = _lowerGarment.playerRemove(); //The undergarment is responsible for removing any bonuses, perks, etc.
				if (newUndergarment == null) {
					CoC_Settings.error(short + ".lowerGarment is set to null");
					newUndergarment = UndergarmentLib.NOTHING;
				}
				_lowerGarment = newUndergarment.playerEquip(); //The undergarment can also choose to equip something else.
			}
			return oldUndergarment;
		}
		
		// in case you don't want to call the value.equip
		public function setUndergarmentHiddenField(value:Undergarment, type:int):void
		{
			if (type == UndergarmentLib.TYPE_UPPERWEAR) this._upperGarment = value;
			else this._lowerGarment = value;
		}
		
		public function reduceDamage(damage:Number):Number {
			var damageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) damageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) damageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) damageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) damageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) damageMultiplier *= 2;
			
			//Opponents can critical too!
			var crit:Boolean = false;
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.hasPerk(PerkLib.Tactician) && CoC.instance.monster.inte >= 50) {
				if (CoC.instance.monster.inte <= 100) critChanceMonster += (CoC.instance.monster.inte - 50) / 5;
				if (CoC.instance.monster.inte > 100) critChanceMonster += 10;
			}
			if (CoC.instance.monster.hasPerk(PerkLib.VitalShot) && CoC.instance.monster.inte >= 50) critChanceMonster += 10;
			if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			//Apply damage resistance percentage.
			damage *= damagePercent() / 100;
			if (damageMultiplier < 0.2) damageMultiplier = 0;
			return int(damage * damageMultiplier);
		}
		public function reduceMagicDamage(damage:Number):Number {
			var magicdamageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) magicdamageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) magicdamageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) magicdamageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) magicdamageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) magicdamageMultiplier *= 2;

			//Opponents can critical too!
			var crit:Boolean = false;
			var critChanceMonster:int = 5;
			/*if (CoC.instance.monster.hasPerk(PerkLib.Tactician) && CoC.instance.monster.inte >= 50) {
				if (CoC.instance.monster.inte <= 100) critChanceMonster += (CoC.instance.monster.inte - 50) / 5;
				if (CoC.instance.monster.inte > 100) critChanceMonster += 10;
			}
			if (CoC.instance.monster.hasPerk(PerkLib.VitalShot) && CoC.instance.monster.inte >= 50) critChanceMonster += 10;
			*/if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			//Apply magic damage resistance percentage.
			damage *= damageMagicalPercent() / 100;
			if (magicdamageMultiplier < 0.2) magicdamageMultiplier = 0;
			return int(damage * magicdamageMultiplier);
		}

		public override function lustPercent():Number {
			var lust:Number = 100;
			var minLustCap:Number = 25;
			
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//ADDITIVE REDUCTIONS
			//THESE ARE FLAT BONUSES WITH LITTLE TO NO DOWNSIDE
			//TOTAL IS LIMITED TO 75%!
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Corrupted Libido reduces lust gain by 10%!
			if(hasPerk(PerkLib.CorruptedLibido)) lust -= 10;
			//Acclimation reduces by 15%
			if(hasPerk(PerkLib.Acclimation)) lust -= 15;
			//Purity blessing reduces lust gain
			if(hasPerk(PerkLib.PurityBlessing)) lust -= 5;
			//Resistance = 10%
			if(hasPerk(PerkLib.ResistanceI)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceII)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceIII)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceIV)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceV)) lust -= 5;
			if(hasPerk(PerkLib.ResistanceVI)) lust -= 5;
			if((hasPerk(PerkLib.UnicornBlessing) && cor <= 20) || (hasPerk(PerkLib.BicornBlessing) && cor >= 80)) lust -= 10;
			if(hasPerk(PerkLib.ChiReflowLust)) lust -= UmasShop.NEEDLEWORK_LUST_LUST_RESIST;
			if(lust < minLustCap) lust = minLustCap;
			if(statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
				if(lust >= 80) lust = 100;
				else lust += 20;
			}
			lust += Math.round(perkv1(PerkLib.PentUp)/2);
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//MULTIPLICATIVE REDUCTIONS
			//THESE PERKS ALSO RAISE MINIMUM LUST OR HAVE OTHER
			//DRAWBACKS TO JUSTIFY IT.
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Bimbo body slows lust gains!
			if((hasStatusEffect(StatusEffects.BimboChampagne) || hasPerk(PerkLib.BimboBody)) && lust > 0) lust *= .75;
			if(hasPerk(PerkLib.BroBody) && lust > 0) lust *= .75;
			if(hasPerk(PerkLib.FutaForm) && lust > 0) lust *= .75;
			//Omnibus' Gift reduces lust gain by 15%
			if(hasPerk(PerkLib.OmnibusGift)) lust *= .85;
			//Fera Blessing reduces lust gain by 15%
			if(hasStatusEffect(StatusEffects.BlessingOfDivineFera)) lust *= .85;
			//Luststick reduces lust gain by 10% to match increased min lust
			if(hasPerk(PerkLib.LuststickAdapted)) lust *= 0.9;
			if(hasStatusEffect(StatusEffects.Berzerking)) lust *= .6;
			if (hasPerk(PerkLib.PureAndLoving)) lust *= 0.95;
			//Berseking reduces lust gains by 10%
			if (hasStatusEffect(StatusEffects.Berzerking)) lust *= 0.9;
			if (hasStatusEffect(StatusEffects.Overlimit)) lust *= 0.9;

			//Items
			if (jewelryEffectId == JewelryLib.PURITY) lust *= 1 - (jewelryEffectMagnitude / 100);
			if (armor == game.armors.DBARMOR) lust *= 0.9;
			if (weapon == game.weapons.HNTCANE) lust *= 0.75;
			if ((weapon == game.weapons.PURITAS) || (weapon == game.weapons.ASCENSU)) lust *= 0.9;
			// Lust mods from Uma's content -- Given the short duration and the gem cost, I think them being multiplicative is justified.
			// Changing them to an additive bonus should be pretty simple (check the static values in UmasShop.as)
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac)
			{
				if (sac.value1 == UmasShop.MASSAGE_RELIEF || sac.value1 == UmasShop.MASSAGE_LUST)
				{
					lust *= sac.value2;
				}
			}
			if(statusEffectv1(StatusEffects.Maleficium) > 0) {
				if(lust >= 50) lust = 100;
				else lust += 50;
			}
			lust = Math.round(lust);
			if (hasStatusEffect(StatusEffects.Lustzerking) && !hasPerk(PerkLib.ColdLust)) lust = 100;
			return lust;
		}

		public override function takePhysDamage(damage:Number, display:Boolean = false):Number{
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (hasStatusEffect(StatusEffects.ManaShield) && damage < mana) {
					mana -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('mana');
					dynStats("lus", 0); //Force display arrow.
				}
				else {
					damage = reduceDamage(damage);
					//Wrath
					var gainedWrath:Number = 0;
					gainedWrath += damage / 10;
					gainedWrath = Math.round(gainedWrath);
					wrath += gainedWrath;
					if (wrath > maxWrath()) wrath = maxWrath();
					//game.HPChange(-damage, display);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP<=0){
					HP = 0;
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}
		public override function takeMagicDamage(damage:Number, display:Boolean = false):Number{
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (hasStatusEffect(StatusEffects.ManaShield) && (damage / 2) < mana) {
					mana -= damage / 2;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('mana');
					dynStats("lus", 0); //Force display arrow.
				}
				else {
					damage = reduceMagicDamage(damage);
					//Wrath
					var gainedWrath:Number = 0;
					gainedWrath += damage / 10;
					gainedWrath = Math.round(gainedWrath);
					wrath += gainedWrath;
					if (wrath > maxWrath()) wrath = maxWrath();
					//game.HPChange(-damage, display);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP<=0){
					HP = 0;
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}

		/**
		 * @return 0: did not avoid; 1-3: avoid with varying difference between
		 * speeds (1: narrowly avoid, 3: deftly avoid)
		 */
		public function speedDodge(monster:Monster):int{
			var diff:Number = spe - monster.spe;
			var rnd:int = int(Math.random() * ((diff / 4) + 80));
			if (rnd<=80) return 0;
			else if (diff<8) return 1;
			else if (diff<20) return 2;
			else return 3;
		}

		//Body Type
		public function bodyType():String
		{
			var desc:String = "";
			//OLD STUFF
			//SUPAH THIN
			if (thickness < 10)
			{
				//SUPAH BUFF
				if (tone > 90)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 75)
					desc += "an incredibly thin, well-muscled frame";
				else if (tone > 50)
					desc += "a very thin body that has a good bit of muscle definition";
				else if (tone > 25)
					desc += "a lithe body and only a little bit of muscle definition";
				else
					desc += "a waif-thin body, and soft, forgiving flesh";
			}
			//Pretty thin
			else if (thickness < 25)
			{
				if (tone > 90)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 75)
					desc += "a narrow frame that shows off your muscles";
				else if (tone > 50)
					desc += "a somewhat lithe body and a fair amount of definition";
				else if (tone > 25)
					desc += "a narrow, soft body that still manages to show off a few muscles";
				else
					desc += "a thin, soft body";
			}
			//Somewhat thin
			else if (thickness < 40)
			{
				if (tone > 90)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 75)
					desc += "a thinner-than-average frame and great muscle definition";
				else if (tone > 50)
					desc += "a somewhat narrow body and a decent amount of visible muscle";
				else if (tone > 25)
					desc += "a moderately thin body, soft curves, and only a little bit of muscle";
				else
					desc += "a fairly thin form and soft, cuddle-able flesh";
			}
			//average
			else if (thickness < 60)
			{
				if (tone > 90)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 75)
					desc += "an average-sized frame and great musculature";
				else if (tone > 50)
					desc += "a normal waistline and decently visible muscles";
				else if (tone > 25)
					desc += "an average body and soft, unremarkable flesh";
				else
					desc += "an average frame and soft, untoned flesh with a tendency for jiggle";
			}
			else if (thickness < 75)
			{
				if (tone > 90)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 75)
					desc += "a body that's a little bit wide and has some highly-visible muscles";
				else if (tone > 50)
					desc += "a solid build that displays a decent amount of muscle";
				else if (tone > 25)
					desc += "a slightly wide frame that displays your curves and has hints of muscle underneath";
				else
					desc += "a soft, plush body with plenty of jiggle";
			}
			else if (thickness < 90)
			{
				if (tone > 90)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 75)
					desc += "a burly form and plenty of muscle definition";
				else if (tone > 50)
					desc += "a solid, thick frame and a decent amount of muscles";
				else if (tone > 25)
					desc += "a wide-set body, some soft, forgiving flesh, and a hint of muscle underneath it";
				else
				{
					desc += "a wide, cushiony body";
					if (gender >= 2 || biggestTitSize() > 3 || hips.type > 7 || butt.type > 7)
						desc += " and plenty of jiggle on your curves";
				}
			}
			//Chunky monkey
			else
			{
				if (tone > 90)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 75)
					desc += "a very wide body and enough muscle to make you look like a tank";
				else if (tone > 50)
					desc += "an extremely substantial frame packing a decent amount of muscle";
				else if (tone > 25)
				{
					desc += "a very wide body";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += ", lots of curvy jiggles,";
					desc += " and hints of muscle underneath";
				}
				else
				{
					desc += "a thick";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += ", voluptuous";
					desc += " body and plush, ";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += " jiggly curves";
					else
						desc += " soft flesh";
				}
			}
			return desc;
		}

		public function race():String
		{
			var racialScores:* = Race.AllScoresFor(this);
			//Determine race type:
			var race:String = "human";
			if (catScore() >= 4)
			{
				if (catScore() >= 8) {
					if (isTaur() && lowerBody == LowerBody.CAT) {
						race = "cat-taur";
					}
					else {
						race = "cat-morph";
						if (faceType == Face.HUMAN)
							race = "cat-" + mf("boy", "girl");
					}
				}
				else {
					if (isTaur() && lowerBody == LowerBody.CAT) {
						race = "half cat-taur";
						if (faceType == Face.HUMAN)
							race = "half sphinx-morph"; // no way to be fully feral anyway
					}
					else {
						race = " half cat-morph";
						if (faceType == Face.HUMAN)
							race = "half cat-" + mf("boy", "girl");
					}
				}
			}
			if (sphinxScore() >= 13)
			{
				race = "Sphinx";
			}
			if (nekomataScore() >= 11)
			{
				race = "Nekomanta";
			}
			if (cheshireScore() >= 11)
			{
				race = "Cheshire cat";
			}
			if (lizardScore() >= 4)
			{
				if (lizardScore() >= 8) {
					if (isTaur()) race = "lizan-taur";
					else race = "lizan";
				}
				else {
					if (isTaur()) race = "half lizan-taur";
					else race = "half lizan";
				}
			}
			if (dragonScore() >= 4)
			{
				if (dragonScore() >= 28) {
					if (isTaur()) race = "ancient dragon-taur";
					else {
						race = "ancient dragon";
						if (faceType == Face.HUMAN)
							race = "ancient dragon-" + mf("man", "girl");
					}
				}
				else if (dragonScore() >= 20) {
					if (isTaur()) race = " elder dragon-taur";
					else {
						race = "elder dragon";
						if (faceType == Face.HUMAN)
							race = "elder dragon-" + mf("man", "girl");
					}
				}
				else if (dragonScore() >= 10) {
					if (isTaur()) race = "dragon-taur";
					else {
						race = "dragon";
						if (faceType == Face.HUMAN)
							race = "dragon-" + mf("man", "girl");
					}
				}
				else {
					if (isTaur()) race = "half-dragon-taur";
					else {
						race = "half-dragon";
						if (faceType == Face.HUMAN)
							race = "half-dragon-" + mf("man", "girl");
					}
				}
			}
			if (jabberwockyScore() >= 4)
			{
				if (jabberwockyScore() >= 20) {
					if (isTaur()) race = " greater jabberwocky-taur";
					else race = "greater jabberwocky";
				}
				else if (jabberwockyScore() >= 10) {
					if (isTaur()) race = "jabberwocky-taur";
					else race = "jabberwocky";
				}
				else {
					if (isTaur()) race = "half-jabberwocky-taur";
					else race = "half-jabberwocky";
				}
			}
			if (raccoonScore() >= 4)
			{
				race = "raccoon-morph";
				if (balls > 0 && ballSize > 5)
					race = "tanuki";
			}
			if (dogScore() >= 4)
			{
				if (isTaur() && lowerBody == LowerBody.DOG)
					race = "dog-taur";
				else {
					race = "dog-morph";
					if (faceType == Face.HUMAN)
						race = "dog-" + mf("man", "girl");
				}
			}
			if (wolfScore() >= 4)
			{
				if (isTaur() && lowerBody == LowerBody.WOLF)
					race = "wolf-taur";
				else if (wolfScore() >= 10)
					race = "Fenrir";
				else if (wolfScore() >= 7 && hasFur() && coatColor == "glacial white")
					race = "winter wolf";
				else if (wolfScore() >= 6)
					race = "wolf-morph";
				else
					race = "wolf-" + mf("boy", "girl");
			}
			if (werewolfScore() >= 6)
			{
				if (werewolfScore() >= 12)
					race = "Werewolf";
				else
					race = "half werewolf";
			}
			if (foxScore() >= 4)
			{
				if (foxScore() >= 7 && isTaur() && lowerBody == LowerBody.FOX)
					race = "fox-taur";
				else if (foxScore() >= 7)
					race = "fox-morph";
				else
					race = "half fox";
			}
			if (ferretScore() >= 4)
			{
				if (hasFur())
					race = "ferret-morph";
				else
					race = "ferret-" + mf("morph", "girl");
			}
			if (kitsuneScore() >= 5)
			{
				if (tailType == 13 && tailCount >= 2 && kitsuneScore() >= 6) {
					if (kitsuneScore() >= 12) {
						if (tailCount == 9 && isTaur()) {
							race = "nine tailed kitsune-taur";
						}
						else if (tailCount == 9) {
							race = "nine tailed kitsune";
						}
						else {
							race = "kitsune";
						}
					}
					else {
						if (isTaur()) {
							race = "kitsune-taur";
						}
						else {
							race = "kitsune";
						}
					}
				}
				else {
					race = "half kitsune";
				}
			}
			if (kitshooScore() >= 6)
			{
				if (isTaur()) race = "kitshoo-taur";
				else {
					race = "kitshoo";
				}
			}
			if (horseScore() >= 4)
			{
				if (horseScore() >= 7)
					race = "equine-morph";
				else
					race = "half equine-morph";
			}
			if (unicornScore() >= 9)
			{
				if (isTaur()) race = "unicorn-taur";
				else {
					race = "unicorn";
				}
			}
			if (alicornScore() >= 11)
			{
				if (isTaur()) race = "alicorn-taur";
				else {
					race = "alicorn";
				}
			}
			if (centaurScore() >= 8)
				race = "centaur";
			if (mutantScore() >= 5 && race == "human")
				race = "corrupted mutant";
			if (minotaurScore() >= 4)
				if (minotaurScore() >= 9) race = "minotaur";
				else race = "half-minotaur";
			if (cowScore() >= 4)
			{
				if (cowScore() >= 9) {
					race = "cow-";
					race += mf("morph", "girl");
				}
				else {
					race = "half cow-";
					race += mf("morph", "girl");
				}
			}
			if (beeScore() >= 5) {
				if (beeScore() >= 9) {
					race = "bee-morph";
				}
				else {
					race = "half bee-morph";
				}
			}
			if (goblinScore() >= 4)
				race = "goblin";
			if (racialScores['human'] >= 5 && race == "corrupted mutant")
				race = "somewhat human mutant";
			if (demonScore() >= 5)
			{
				if (demonScore() >= 11) {
					if (isTaur()) {
						race = "";
						race += mf("incubi-kintaur", "succubi-kintaur");
					}
					else {
						race = "";
						race += mf("incubi-kin", "succubi-kin");
					}
				}
				else {
					if (isTaur()) {
						race = "half ";
						race += mf("incubus-taur", "succubus-taur");
					}
					else {
						race = "half ";
						race += mf("incubus", "succubus");
					}
				}
			}
			if (devilkinScore() >= 7)
			{
				if (devilkinScore() >= 10) {
					if (devilkinScore() >= 14)  {
						if (isTaur()) race = "greater devil-taur";
						else race = "greater devil";
					}
					else {
						if (isTaur()) race = "devil-taur";
						else race = "devil";
					}
				}
				else {
					if (isTaur()) race = "half devil-taur";
					else race = "half devil";
				}
			}
			if (sharkScore() >= 4)
			{
				if (sharkScore() >= 9 && vaginas.length > 0 && cocks.length > 0) {
					if (isTaur()) race = "tigershark-taur";
					else {
						race = "tigershark-morph";
					}
				}
				else if (sharkScore() >= 8) {
					if (isTaur()) race = "shark-taur";
					else {
						race = "shark-morph";
					}
				}
				else {
					if (isTaur()) race = "half shark-taur";
					else {
						race = "half shark-morph";
					}
				}
			}
			if (orcaScore() >= 6)
			{
				if (orcaScore() >= 12) {
					if (isTaur()) race = "orca-taur";
					else {
						race = "orca-morph";
					}
				}
				else {
					if (isTaur()) race = "half orca-taur";
					else {
						race = "half orca-";
						race += mf("boy", "girl");
					}
				}
			}
			if (bunnyScore() >= 4)
				race = "bunny-" + mf("boy", "girl");
			if (harpyScore() >= 4)
			{
				if (harpyScore() >= 8) {
					if (gender >= 2) {
						race = "harpy";
					}
					else {
						race = "avian";
					}
				}
				else {
					if (gender >= 2) {
						race = "half harpy";
					}
					else {
						race = "half avian";
					}
				}
			}
			if (spiderScore() >= 4)
			{
				if (spiderScore() >= 7) {
					race = "spider-morph";
					if (mf("no", "yes") == "yes")
						race = "spider-girl";
					if (isDrider())
						race = "drider";
				}
				else {
					race = "half spider-morph";
					if (mf("no", "yes") == "yes")
						race = "half spider-girl";
					if (isDrider())
						race = "half drider";
				}
			}
			if (kangaScore() >= 4)
				race = "kangaroo-morph";
			if (mouseScore() >= 3)
			{
				if (isTaur()) race = "mouse-taur";
				else {
					if (faceType != 16)
					race = "mouse-" + mf("boy", "girl");
					else
						race = "mouse-morph";
				}
			}
			if (scorpionScore() >= 4)
			{
				if (isTaur()) race = "scorpion-taur";
				else {
					race = "scorpion-morph";
				}
			}
			if (mantisScore() >= 6)
			{
				if (mantisScore() >= 12) {
					if (isTaur()) race = "mantis-taur";
					else {
						race = "mantis-morph";
					}
				}
				else {
					if (isTaur()) race = "half mantis-taur";
					else {
						race = "half mantis-morph";
					}
				}
			}
			if (salamanderScore() >= 4)
			{
				if (salamanderScore() >= 7) {
					if (isTaur()) race = "salamander-taur";
					else race = "salamander";
				}
				else {
					if (isTaur()) race = "half salamander-taur";
					else race = "half salamander";
				}
			}
			if (yetiScore() >= 6)
			{
				if (yetiScore() >= 12) {
					if (isTaur()) race = "yeti-taur";
					else race = "yeti";
				}
				else {
					if (isTaur()) race = "half yeti-taur";
					else race = "half yeti";
				}
			}
			if (couatlScore() >= 11)
			{
				if (isTaur()) race = "couatl-taur";
				else {
					race = "couatl";
				}
			}
			if (vouivreScore() >= 11)
			{
				if (isTaur()) race = "vouivre-taur";
				else {
					race = "vouivre";
				}
			}
			if (gorgonScore() >= 11)
			{
				if (isTaur()) race = "gorgon-taur";
				else {
					race = "gorgon";
				}
			}
			if (lowerBody == 3 && nagaScore() >= 4)
			{
				if (nagaScore() >= 8) race = "naga";
				else race = "half-naga";
			}

			if (phoenixScore() >= 10)
			{
				if (isTaur()) race = "phoenix-taur";
				else race = "phoenix";
			}
			if (scyllaScore() >= 4)
			{
				if (scyllaScore() >= 12) race = "kraken";
				else if (scyllaScore() >= 7) race = "scylla";
				else race = "half scylla";
			}
			if (plantScore() >= 4)
			{
				if (isTaur()) {
					if (plantScore() >= 6) race = mf("treant-taur", "dryad-taur");
					else race = "plant-taur";
				}
				else {
					if (plantScore() >= 6) race = mf("treant", "dryad");
					else race = "plant-morph";
				}
			}
			if (alrauneScore() >= 10)
			{
				race = "Alraune";
			}
			if (yggdrasilScore() >= 10)
			{
				race = "Yggdrasil";
			}
			if (oniScore() >= 6)
			{
				if (oniScore() >= 12) {
					if (isTaur()) race = "oni-taur";
					else race = "oni";
				}
				else {
					if (isTaur()) race = "half oni-taur";
					else race = "half oni";
				}
			}
			if (elfScore() >= 5)
			{
				if (elfScore() >= 11) {
					if (isTaur()) race = "elf-taur";
					else race = "elf";
				}
				else {
					if (isTaur()) race = "half elf-taur";
					else race = "half elf";
				}
			}
			if (raijuScore() >= 5)
			{
				if (raijuScore() >= 10) {
					if (isTaur()) race = "raiju-taur";
					else race = "raiju";
				}
				else {
					if (isTaur()) race = "half raiju-taur";
					else race = "half raiju";
				}
			}
			//<mod>
			if (pigScore() >= 4) 
			{
				race = "pig-morph";
				if (faceType == Face.HUMAN)
					race = "pig-" + mf("boy", "girl");
				if (faceType == 20)
					race = "boar-morph";
			}
			if (satyrScore() >= 4)
			{
				race = "satyr";
			}
			if (rhinoScore() >= 4)
			{
				race = "rhino-morph";
				if (faceType == Face.HUMAN) race = "rhino-" + mf("man", "girl");
			}
			if (echidnaScore() >= 4)
			{
				race = "echidna";
				if (faceType == Face.HUMAN) race = "echidna-" + mf("boy", "girl");
			}
			if (deerScore() >= 4)
			{
				if (isTaur()) race = "deer-taur";
				else {
					race = "deer-morph";
					if (faceType == Face.HUMAN) race = "deer-" + mf("morph", "girl");
				}
			}
			//Special, bizarre races
			if (dragonneScore() >= 6)
			{
				if (isTaur()) race = "dragonne-taur";
				else {
					race  = "dragonne";
					if (faceType == Face.HUMAN)
						race = "dragonne-" + mf("man", "girl");
				}
			}
			if (manticoreScore() >= 6)
			{
				if (isTaur() && lowerBody == LowerBody.LION) {
					if (manticoreScore() < 12)
						race = "half manticore-taur";
					if (manticoreScore() >= 12)
						race = "manticore-taur";
				}
				else if (manticoreScore() >= 12)
					race = "manticore";
				else
					race = "half manticore";
			}
			if (redpandaScore() >= 4)
			{
				if (redpandaScore() >= 8) {
					race = "red-panda-morph";
					if (faceType == Face.HUMAN)
						race = "red-panda-" + mf("boy", "girl");
					if (isTaur())
						race = "red-panda-taur";
				}
				else {
					race = "half red-panda-morph";
					if (faceType == Face.HUMAN)
						race = "half red-panda-" + mf("boy", "girl");
					if (isTaur())
						race = "half red-panda-taur";
				}
			}
			if (sirenScore() >= 10)
			{
				if (isTaur()) race = "siren-taur";
				else race = "siren";
			}
			if (gargoyleScore() >= 21)
			{
				if (hasPerk(PerkLib.GargoyleCorrupted)) race = "corrupted gargoyle";
				else race = "gargoyle";
			}
			if (batScore() >= 6){
				race = batScore() >= 10? "bat":"half bat";
				race += mf("boy","girl");
			}
			if (vampireScore() >= 6){
				race = vampireScore() >= 10 ? "vampire" : "dhampir"
			}
			if (avianScore() >= 4)
			{
				if (avianScore() >= 9)
					race = "avian-morph";
				else
					race = "half avian-morph";
			}
			//</mod>
			if (lowerBody == LowerBody.HOOFED && isTaur() && wings.type == Wings.FEATHERED_LARGE) {
				race = "pegataur";
			}
			if (lowerBody == LowerBody.PONY)
				race = "pony-kin";
			if (gooScore() >= 4)
			{
				if (gooScore() >= 8) {
					race = "goo-";
					race += mf("boi", "girl");
				}
				else {
					race = "half goo-";
					race += mf("boi", "girl");
				}
			}
			
			if (chimeraScore() >= 3)
			{
				race = "chimera";
			}
			
			if (grandchimeraScore() >= 3)
			{
				race = "grand chimera";
			}
			
			return race;
		}

		//Determine Human Rating
		public function humanScore():Number {
			Begin("Player","racialScore","human");
			var humanCounter:Number = Race.HUMAN.scoreFor(this,Race.MetricsFor(this));
			End("Player","racialScore");
			return humanCounter;
		}
		
		//Determine Chimera Race Rating
		public function chimeraScore():Number {
			Begin("Player","racialScore","chimera");
			var chimeraCounter:Number = 0;
			if (catScore() >= 4)
				chimeraCounter++;
			if (lizardScore() >= 4)
				chimeraCounter++;
			if (dragonScore() >= 4)
				chimeraCounter++;
			if (raccoonScore() >= 4)
				chimeraCounter++;
			if (dogScore() >= 4)
				chimeraCounter++;
			if (wolfScore() >= 6)
				chimeraCounter++;
			if (werewolfScore() >= 6)
				chimeraCounter++;
			if (foxScore() >= 4)
				chimeraCounter++;
			if (ferretScore() >= 4)
				chimeraCounter++;
			if (kitsuneScore() >= 5)
				chimeraCounter++;
			if (horseScore() >= 4)
				chimeraCounter++;
			if (minotaurScore() >= 4)
				chimeraCounter++;
			if (cowScore() >= 4)
				chimeraCounter++;
			if (beeScore() >= 5)
				chimeraCounter++;
			if (goblinScore() >= 4)
				chimeraCounter++;
			if (demonScore() >= 5)
				chimeraCounter++;
			if (devilkinScore() >= 7)
				chimeraCounter++;
			if (sharkScore() >= 4)
				chimeraCounter++;
			if (orcaScore() >= 6)
				chimeraCounter++;
			if (oniScore() >= 6)
				chimeraCounter++;
			if (elfScore() >= 5)
				chimeraCounter++;
			if (raijuScore() >= 5)
				chimeraCounter++;
			if (bunnyScore() >= 4)
				chimeraCounter++;
			if (harpyScore() >= 4)
				chimeraCounter++;
			if (spiderScore() >= 4)
				chimeraCounter++;
			if (kangaScore() >= 4)
				chimeraCounter++;
			if (mouseScore() >= 3)
				chimeraCounter++;
			if (scorpionScore() >= 4)
				chimeraCounter++;
			if (mantisScore() >= 6)
				chimeraCounter++;
			if (salamanderScore() >= 4)
				chimeraCounter++;
			if (nagaScore() >= 4)
				chimeraCounter++;
			if (phoenixScore() >= 10)
				chimeraCounter++;
			if (scyllaScore() >= 4)
				chimeraCounter++;
			if (plantScore() >= 6)
				chimeraCounter++;
			if (pigScore() >= 4)
				chimeraCounter++;
			if (satyrScore() >= 4)
				chimeraCounter++;
			if (rhinoScore() >= 4)
				chimeraCounter++;
			if (echidnaScore() >= 4)
				chimeraCounter++;
			if (deerScore() >= 4)
				chimeraCounter++;
			if (manticoreScore() >= 6)
				chimeraCounter++;
			if (redpandaScore() >= 4)
				chimeraCounter++;
			if (sirenScore() >= 10)
				chimeraCounter++;
			if (yetiScore() >= 6)
				chimeraCounter++;
			if (batScore() >= 6)
				chimeraCounter++;
			if (vampireScore() >= 6)
				chimeraCounter++;
			if (jabberwockyScore() >= 4)
				chimeraCounter++;
			if (avianScore() >= 4)
				chimeraCounter++;
			if (gargoyleScore() >= 21)
				chimeraCounter++;
			if (gooScore() >= 4)
				chimeraCounter++;
			
			End("Player","racialScore");
			return chimeraCounter;
		}
		
		//Determine Grand Chimera Race Rating
		public function grandchimeraScore():Number {
			Begin("Player","racialScore","grandchimera");
			var grandchimeraCounter:Number = 0;
			if (catScore() >= 8)
				grandchimeraCounter++;
			if (nekomataScore() >= 11)
				grandchimeraCounter++;
			if (cheshireScore() >= 11)
				grandchimeraCounter++;
			if (lizardScore() >= 8)
				grandchimeraCounter++;
			if (dragonScore() >= 10)
				grandchimeraCounter++;
/*			if (raccoonScore() >= 4)
				grandchimeraCounter++;
			if (dogScore() >= 4)
				grandchimeraCounter++;
			if (wolfScore() >= 6)
				grandchimeraCounter++;
*/			if (werewolfScore() >= 12)
				grandchimeraCounter++;
			if (foxScore() >= 7)
				grandchimeraCounter++;
//			if (ferretScore() >= 4)
//				grandchimeraCounter++;
			if (kitsuneScore() >= 6 && tailType == 13 && tailCount >= 2)
				grandchimeraCounter++;	
			if (horseScore() >= 7)
				grandchimeraCounter++;
			if (unicornScore() >= 9)
				grandchimeraCounter++;
			if (alicornScore() >= 11)
				grandchimeraCounter++;	
			if (centaurScore() >= 8)
				grandchimeraCounter++;
			if (minotaurScore() >= 9)
				grandchimeraCounter++;
			if (cowScore() >= 9)
				grandchimeraCounter++;
			if (beeScore() >= 9)
				grandchimeraCounter++;
//			if (goblinScore() >= 4)
//				grandchimeraCounter++;
			if (demonScore() >= 11)
				grandchimeraCounter++;
			if (devilkinScore() >= 10)
				grandchimeraCounter++;
			if (sharkScore() >= 8)
				grandchimeraCounter++;
			if (orcaScore() >= 12)
				grandchimeraCounter++;
			if (oniScore() >= 12)
				grandchimeraCounter++;
			if (elfScore() >= 11)
				grandchimeraCounter++;
			if (raijuScore() >= 10)
				grandchimeraCounter++;
//			if (bunnyScore() >= 4)
//				grandchimeraCounter++;
			if (harpyScore() >= 8)
				grandchimeraCounter++;
			if (spiderScore() >= 7)
				grandchimeraCounter++;
/*			if (kangaScore() >= 4)
				grandchimeraCounter++;
			if (mouseScore() >= 3)
				grandchimeraCounter++;
			if (scorpionScore() >= 4)
				grandchimeraCounter++;
*/			if (mantisScore() >= 12)
				grandchimeraCounter++;
			if (salamanderScore() >= 7)
				grandchimeraCounter++;
			if (nagaScore() >= 8)
				grandchimeraCounter++;
			if (gorgonScore() >= 11)
				grandchimeraCounter++;
			if (vouivreScore() >= 11)
				grandchimeraCounter++;
			if (couatlScore() >= 11)
				grandchimeraCounter++;
			if (phoenixScore() >= 10)
				grandchimeraCounter++;
			if (scyllaScore() >= 7)
				grandchimeraCounter++;
//			if (plantScore() >= 6)
//				grandchimeraCounter++;
			if (alrauneScore() >= 10)
				grandchimeraCounter++;
			if (yggdrasilScore() >= 10)
				grandchimeraCounter++;
/*			if (pigScore() >= 4)
				grandchimeraCounter++;
			if (satyrScore() >= 4)
				grandchimeraCounter++;
			if (rhinoScore() >= 4)
				grandchimeraCounter++;
			if (echidnaScore() >= 4)
				grandchimeraCounter++;
			if (deerScore() >= 4)
				grandchimeraCounter++;
*/			if (manticoreScore() >= 12)
				grandchimeraCounter += 2;
			if (redpandaScore() >= 8)
				grandchimeraCounter++;
			if (sirenScore() >= 10)
				grandchimeraCounter++;
			if (yetiScore() >= 12)
				grandchimeraCounter++;
			if (batScore() >= 10)
				grandchimeraCounter++;
			if (vampireScore() >= 10)
				grandchimeraCounter++;
			if (jabberwockyScore() >= 10)
				grandchimeraCounter++;	
			if (avianScore() >= 9)
				grandchimeraCounter++;
			if (gargoyleScore() >= 21)
				grandchimeraCounter++;
			if (gooScore() >= 8)
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

		//determine demon rating
		public function demonScore():Number {
			Begin("Player","racialScore","demon");
			var demonCounter:Number = 0;
			if (horns.type == Horns.DEMON && horns.count > 0)
				demonCounter++;
			if (cor >= 50 && horns.type == Horns.DEMON && horns.count > 4)
				demonCounter++;
			if (tailType == Tail.DEMONIC)
				demonCounter++;
			if (wings.type == Wings.BAT_LIKE_TINY)
				demonCounter++;
			if (wings.type == Wings.BAT_LIKE_LARGE)
				demonCounter += 2;
			if (wings.type == Wings.BAT_LIKE_LARGE_2)
				demonCounter += 4;
			if (tongue.type == Tongue.DEMONIC)
				demonCounter++;
			if (cor >= 50 && hasPlainSkinOnly() && skinAdj != "slippery")
				demonCounter++;
			if (cor >= 50 && faceType == Face.HUMAN)
				demonCounter++;
			if (cor >= 50 && arms.type == Arms.HUMAN)
				demonCounter++;
			if (lowerBody == LowerBody.DEMONIC_HIGH_HEELS || lowerBody == LowerBody.DEMONIC_CLAWS)
				demonCounter++;
			if (demonCocks() > 0)
				demonCounter++;
			if (hasPerk(PerkLib.BlackHeart))
				demonCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && demonCounter >= 5)
				demonCounter += 1;
			if (hasPerk(PerkLib.BlackHeart) && hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				demonCounter++;
			if (horns.type == Horns.GOAT)
				demonCounter -= 10;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				demonCounter += 10;
			if (hasPerk(PerkLib.DemonicLethicite))
				demonCounter+=1;
			End("Player","racialScore");
			return demonCounter;
		}

		//determine devil/infernal goat rating
		public function devilkinScore():Number {
			Begin("Player","racialScore","devil");
			var devilkinCounter:Number = 0;
			if (lowerBody == LowerBody.HOOFED)
				devilkinCounter++;
			if (tailType == Tail.GOAT || tailType == Tail.DEMONIC)
				devilkinCounter++;
			if (wings.type == Wings.BAT_LIKE_TINY || wings.type == Wings.BAT_LIKE_LARGE)
				devilkinCounter += 4;
			if (arms.type == Arms.DEVIL)
				devilkinCounter++;
			if (horns.type == Horns.GOAT)
				devilkinCounter++;
			if (ears.type == Ears.GOAT)
				devilkinCounter++;
			if (faceType == Face.DEVIL_FANGS)
				devilkinCounter++;
			if (eyes.type == Eyes.DEVIL)
				devilkinCounter++;
			if (tallness < 48)
				devilkinCounter++;
			if (cor >= 60)
				devilkinCounter++;
			End("Player","racialScore");
			return devilkinCounter;
		}

		//Determine minotaur rating
		public function minotaurScore():Number {
			Begin("Player","racialScore","minotaur");
			var minoCounter:Number = 0;
			if (faceType == Face.HUMAN || faceType == Face.COW_MINOTAUR)
				minoCounter++;
			if (ears.type == Ears.COW)
				minoCounter++;
			if (tailType == Tail.COW)
				minoCounter++;
			if (lowerBody == LowerBody.HOOFED)
				minoCounter++;
			if (horns.type == Horns.COW_MINOTAUR)
				minoCounter++;
			if (minoCounter >= 4) {
				if (cumQ() > 500)
					minoCounter++;
				if (hasFur() || hasPartialCoat(Skin.FUR))
					minoCounter++;
				if (tallness >= 81)
					minoCounter++;
				if (cor >= 20)
					minoCounter++;
				if (cocks.length > 0 && horseCocks() > 0)
					minoCounter++;
				if (vaginas.length > 0)
					minoCounter -= 8;
			}
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				minoCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && minoCounter >= 4)
				minoCounter += 1;
			End("Player","racialScore");
			return minoCounter;
		}

		//Determine cow rating
		public function cowScore():Number {
			Begin("Player","racialScore","cow");
			var cowCounter:Number = 0;
			if (faceType == Face.HUMAN || faceType == Face.COW_MINOTAUR)
				cowCounter++;
			if (ears.type == Ears.COW)
				cowCounter++;
			if (tailType == Tail.COW)
				cowCounter++;
			if (lowerBody == LowerBody.HOOFED)
				cowCounter++;
			if (horns.type == Horns.COW_MINOTAUR)
				cowCounter++;
			if (cowCounter >= 4) {
				if (biggestTitSize() > 4)
					cowCounter++;
				if (hasFur() || hasPartialCoat(Skin.FUR))
					cowCounter++;
				if (tallness >= 73)
					cowCounter++;
				if (cor >= 20)
					cowCounter++;
				if (vaginas.length > 0)
					cowCounter++;
				if (cocks.length > 0)
					cowCounter -= 8;
			}
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				cowCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && cowCounter >= 4)
				cowCounter += 1;
			End("Player","racialScore");
			return cowCounter;
		}

		public function sandTrapScore():int {
			Begin("Player","racialScore","sandTrap");
			var counter:int = 0;
			if (hasStatusEffect(StatusEffects.BlackNipples))
				counter++;
			if (hasStatusEffect(StatusEffects.Uniball))
				counter++;
			if (hasVagina() && vaginaType() == VaginaClass.BLACK_SAND_TRAP)
				counter++;
			if (eyes.type == Eyes.BLACK_EYES_SAND_TRAP)
				counter++;
			if (wings.type == Wings.GIANT_DRAGONFLY)
				counter++;
			if (hasStatusEffect(StatusEffects.Uniball))
				counter++;
			End("Player","racialScore");
			return counter;
		}

		//Determine Bee Rating
		public function beeScore():Number {
			Begin("Player","racialScore","bee");
			var beeCounter:Number = 0;
			if (hairColor == "shiny black")
				beeCounter++;
			if (hairColor == "black and yellow") // TODO if hairColor2 == yellow && hairColor == black
				beeCounter += 2;
			if (antennae.type == Antennae.BEE)
			{
				beeCounter++;
				if (faceType == Face.HUMAN)
					beeCounter++;
			}
			if (arms.type == Arms.BEE)
				beeCounter++;
			if (lowerBody == LowerBody.BEE)
			{
				beeCounter++;
				if (vaginas.length == 1)
					beeCounter++;
			}
			if (tailType == Tail.BEE_ABDOMEN)
				beeCounter++;
			if (wings.type == Wings.BEE_LIKE_SMALL)
				beeCounter++;
			if (wings.type == Wings.BEE_LIKE_LARGE)
				beeCounter += 2;
			if (beeCounter > 0 && hasPerk(PerkLib.TrachealSystem))
				beeCounter++;
			if (beeCounter > 4 && hasPerk(PerkLib.TrachealSystemEvolved))
				beeCounter++;
			if (beeCounter > 8 && hasPerk(PerkLib.TrachealSystemFinalForm))
				beeCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				beeCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && beeCounter >= 3)
				beeCounter += 1;
			End("Player","racialScore");
			return beeCounter;
		}
		//Determine Ferret Rating!
		public function ferretScore():Number {
			Begin("Player","racialScore","ferret");
			var counter:int = 0;
			if (faceType == Face.FERRET_MASK) counter++;
			if (faceType == Face.FERRET) counter+=2;
			if (ears.type == Ears.FERRET) counter++;
			if (tailType == Tail.FERRET) counter++;
			if (lowerBody == LowerBody.FERRET) counter++;
			if (hasFur() && counter > 0) counter++;
			
			End("Player","racialScore");
			return counter;
		}
		//Determine Dog Rating
		public function dogScore():Number {
			Begin("Player","racialScore","dog");
			var dogCounter:Number = 0;
			if (faceType == Face.DOG)
				dogCounter++;
			if (ears.type == Ears.DOG)
				dogCounter++;
			if (tailType == Tail.DOG)
				dogCounter++;
			if (lowerBody == LowerBody.DOG)
				dogCounter++;
			if (dogCocks() > 0)
				dogCounter++;
			if (breastRows.length > 1)
				dogCounter++;
			if (breastRows.length == 3)
				dogCounter++;
			if (breastRows.length > 3)
				dogCounter--;
			//Fur only counts if some canine features are present
			if (hasFur() && dogCounter > 0)
				dogCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				dogCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && dogCounter >= 3)
				dogCounter += 1;
			End("Player","racialScore");
			return dogCounter;
		}

		public function mouseScore():Number {
			Begin("Player","racialScore","mouse");
			var mouseCounter:Number = 0;
			if (ears.type == Ears.MOUSE)
				mouseCounter++;
			if (tailType == Tail.MOUSE)
				mouseCounter++;
			if (faceType == Face.BUCKTEETH)
				mouseCounter++;
			if (faceType == Face.MOUSE)
				mouseCounter += 2;
			//Fur only counts if some canine features are present
			if (hasFur() && mouseCounter > 0)
				mouseCounter++;
			if (tallness < 55 && mouseCounter > 0)
				mouseCounter++;
			if (tallness < 45 && mouseCounter > 0)
				mouseCounter++;
			
			End("Player","racialScore");
			return mouseCounter;
		}

		public function raccoonScore():Number {
			Begin("Player","racialScore","raccoon");
			var coonCounter:Number = 0;
			if (faceType == Face.RACCOON_MASK)
				coonCounter++;
			if (faceType == Face.RACCOON)
				coonCounter += 2;
			if (ears.type == Ears.RACCOON)
				coonCounter++;
			if (tailType == Tail.RACCOON)
				coonCounter++;
			if (lowerBody == LowerBody.RACCOON)
				coonCounter++;
			if (coonCounter > 0 && balls > 0)
				coonCounter++;
			//Fur only counts if some canine features are present
			if (hasFur() && coonCounter > 0)
				coonCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				coonCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && coonCounter >= 3)
				coonCounter += 1;
			
			End("Player","racialScore");
			return coonCounter;
		}

		//Determine Fox Rating
		public function foxScore():Number {
			Begin("Player","racialScore","fox");
			var foxCounter:Number = 0;
			if (faceType == Face.FOX)
				foxCounter++;
			if (eyes.type == Eyes.FOX)
				foxCounter++;
			if (ears.type == Ears.FOX)
				foxCounter++;
			if (tailType == Tail.FOX)
				foxCounter++;
			if (tailType == Tail.FOX && tailCount >= 2)
				foxCounter -= 7;
			if (arms.type == Arms.FOX)
				foxCounter++;
			if (lowerBody == LowerBody.FOX)
				foxCounter++;
			if (foxCocks() > 0 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length > 1 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 3 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 4 && foxCounter > 0)
				foxCounter++;
			//Fur only counts if some canine features are present
			if (hasFur() && foxCounter > 0)
				foxCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				foxCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && foxCounter >= 3)
				foxCounter += 1;
			End("Player","racialScore");
			return foxCounter;
		}

		//Determine cat Rating
		public function catScore():Number {
			Begin("Player","racialScore","cat");
			var catCounter:Number = 0;
			if (faceType == Face.CAT || faceType == Face.CAT_CANINES)
				catCounter++;
			if (faceType == Face.CHESHIRE || faceType == Face.CHESHIRE_SMILE)
				catCounter -= 7;
			if (eyes.type == Eyes.CAT_SLITS)
				catCounter++;
			if (ears.type == Ears.CAT)
				catCounter++;
			if (eyes.type == Eyes.FERAL)
				catCounter -= 11;
			if (tongue.type == Tongue.CAT)
				catCounter++;
			if (tailType == Tail.CAT)
				catCounter++;
			if (arms.type == Arms.CAT)
				catCounter++;
			if (lowerBody == LowerBody.CAT)
				catCounter++;
			if (catCocks() > 0)
				catCounter++;
			if (breastRows.length > 1 && catCounter > 0)
				catCounter++;
			if (breastRows.length == 3 && catCounter > 0)
				catCounter++;
			if (breastRows.length > 3)
				catCounter -= 2;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				catCounter++;
			if (hairColor == "lilac and white striped" && coatColor == "lilac and white striped")
				catCounter -= 7;
			if (horns.type == Horns.DEMON || horns.type == Horns.DRACONIC_X2 || horns.type == Horns.DRACONIC_X4_12_INCH_LONG)
				catCounter -= 2;
			if (wings.type == Wings.BAT_LIKE_TINY || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.BAT_LIKE_LARGE || wings.type == Wings.DRACONIC_LARGE || Wings.BAT_LIKE_LARGE_2 || Wings.DRACONIC_HUGE)
				catCounter -= 2;
			if (hasPerk(PerkLib.Flexibility))
				catCounter++;
			if (hasPerk(PerkLib.CatlikeNimbleness))
				catCounter++;
			if (hasPerk(PerkLib.CatlikeNimblenessEvolved))
				catCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && catCounter >= 3)
				catCounter += 1;
			if (hasPerk(PerkLib.CatlikeNimbleness) && hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				catCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				catCounter += 10;
			
			End("Player","racialScore");
			return catCounter;
		}
		//Determine nekomata Rating
		public function nekomataScore():Number {
			Begin("Player","racialScore","nekomata");
			var nekomataCounter:Number = 0;
			if (faceType == Face.CAT || faceType == Face.CAT_CANINES)
				nekomataCounter++;
			if (eyes.type == Eyes.CAT_SLITS)
				nekomataCounter++;
			if (ears.type == Ears.CAT)
				nekomataCounter++;
			if (tongue.type == Tongue.CAT)
				nekomataCounter++;
			if (tailType == Tail.CAT)
				nekomataCounter++;
			if (arms.type == Arms.CAT)
				nekomataCounter++;
			if (lowerBody == LowerBody.CAT)
				nekomataCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				nekomataCounter++;
			if (hasPerk(PerkLib.Flexibility))
				nekomataCounter++;
			if (hasPerk(PerkLib.CatlikeNimbleness))
				nekomataCounter++;
			if (hasPerk(PerkLib.CatlikeNimblenessEvolved))
				nekomataCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && nekomataCounter >= 7)
				nekomataCounter += 1;

			End("Player","racialScore");
			return nekomataCounter;
		}
		//Determine cheshire Rating
		public function cheshireScore():Number {
			Begin("Player","racialScore","cheshire");
			var cheshireCounter:Number = 0;
			if (faceType == Face.CHESHIRE || faceType == Face.CHESHIRE_SMILE)
				cheshireCounter += 2;
			if (eyes.type == Eyes.CAT_SLITS)
				cheshireCounter++;
			if (ears.type == Ears.CAT)
				cheshireCounter++;
			if (tongue.type == Tongue.CAT)
				cheshireCounter++;
			if (tailType == Tail.CAT)
				cheshireCounter++;
			if (arms.type == Arms.CAT)
				cheshireCounter++;
			if (lowerBody == LowerBody.CAT)
				cheshireCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				cheshireCounter++;
			if (hairColor == "lilac and white striped" && coatColor == "lilac and white striped")
				cheshireCounter += 2;
			if (hasPerk(PerkLib.Flexibility))
				cheshireCounter++;
			if (hasPerk(PerkLib.CatlikeNimbleness))
				cheshireCounter++;
			if (hasPerk(PerkLib.CatlikeNimblenessEvolved))
				cheshireCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && cheshireCounter >= 7)
				cheshireCounter += 1;

			End("Player","racialScore");
			return cheshireCounter;
		}

		//Determine lizard rating
		public function lizardScore():Number {
			Begin("Player","racialScore","lizard");
			var lizardCounter:Number = 0;
			if (faceType == Face.LIZARD)
				lizardCounter++;
			if (ears.type == Ears.LIZARD)
				lizardCounter++;
			if (eyes.type == Eyes.REPTILIAN)
				lizardCounter++;
			if (tailType == Tail.LIZARD)
				lizardCounter++;
			if (arms.type == Arms.LIZARD)
				lizardCounter++;
			if (lowerBody == LowerBody.LIZARD)
				lizardCounter++;
			if (horns.count > 0 && (horns.type == Horns.DRACONIC_X2 || horns.type == Horns.DRACONIC_X4_12_INCH_LONG))
				lizardCounter++;
			if (hasScales())
				lizardCounter++;
			if (lizardCocks() > 0)
				lizardCounter++;
			if (lizardCounter > 0 && hasPerk(PerkLib.LizanRegeneration))
				lizardCounter++;
			if (hasPerk(PerkLib.LizanMarrow))
				lizardCounter++;
			if (hasPerk(PerkLib.LizanMarrowEvolved))
				lizardCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				lizardCounter += 10;
			if (hasPerk(PerkLib.LizanMarrow) && hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				lizardCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && lizardCounter >= 4)
				lizardCounter += 1;
			
			End("Player","racialScore");
			return lizardCounter;
		}

		public function spiderScore():Number {
			Begin("Player","racialScore","spider");
			var spiderCounter:Number = 0;
			if (eyes.type == Eyes.FOUR_SPIDER_EYES)
				spiderCounter++;
			if (faceType == Face.SPIDER_FANGS)
				spiderCounter++;
			if (arms.type == Arms.SPIDER)
				spiderCounter++;
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS)
				spiderCounter++;
			if (lowerBody == LowerBody.DRIDER)
				spiderCounter += 2;
			if (tailType == Tail.SPIDER_ADBOMEN)
				spiderCounter++;
			if (!hasCoatOfType(Skin.CHITIN) && spiderCounter > 0)
				spiderCounter--;
			if (hasCoatOfType(Skin.CHITIN))
				spiderCounter++;
			if (spiderCounter > 0 && hasPerk(PerkLib.TrachealSystem))
				spiderCounter++;
			if (spiderCounter > 4 && hasPerk(PerkLib.TrachealSystemEvolved))
				spiderCounter++;
			if (spiderCounter > 8 && hasPerk(PerkLib.TrachealSystemFinalForm))
				spiderCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				spiderCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && spiderCounter >= 3)
				spiderCounter += 1;
			
			End("Player","racialScore");
			return spiderCounter;
		}

		//Determine Horse Rating
		public function horseScore():Number {
			Begin("Player","racialScore","horse");
			var horseCounter:Number = 0;
			if (faceType == Face.HORSE)
				horseCounter++;
			if (ears.type == Ears.HORSE)
				horseCounter++;
			if (tailType == Tail.HORSE)
				horseCounter++;
			if (lowerBody == LowerBody.HOOFED || lowerBody == LowerBody.CENTAUR)
				horseCounter++;
			if (horseCocks() > 0)
				horseCounter++;
			if (hasVagina() && vaginaType() == VaginaClass.EQUINE)
				horseCounter++;
			if (hasFur()) {
				if (arms.type == Arms.HUMAN)
					horseCounter++;
				horseCounter++;
			}
			if (isTaur())
				horseCounter -= 5;
			if (unicornScore() > 8 || alicornScore() > 10)
				horseCounter -= 5;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				horseCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && horseCounter >= 3)
				horseCounter += 1;
			
			End("Player","racialScore");
			return horseCounter;
		}

		//Determine kitsune Rating
		public function kitsuneScore():Number {
			Begin("Player","racialScore","kitsune");
			var kitsuneCounter:int = 0;
			if (eyes.type == Eyes.FOX)
				kitsuneCounter++;
			if (ears.type == Ears.FOX)
				kitsuneCounter++;
			//If the character has ears other than fox ears, -1
			if (ears.type != Ears.FOX)
				kitsuneCounter--;
			if (tailType == Tail.FOX && tailCount >= 2 && tailCount < 4)
				kitsuneCounter++;
			if (tailType == Tail.FOX && tailCount >= 4 && tailCount < 6)
				kitsuneCounter += 2;
			if (tailType == Tail.FOX && tailCount >= 6 && tailCount < 9)
				kitsuneCounter += 3;
			if (tailType == Tail.FOX && tailCount == 9)
				kitsuneCounter += 4;
			if (tailType != Tail.FOX || (tailType == Tail.FOX && tailCount < 2))
				kitsuneCounter -= 7;
			if (skin.base.pattern == Skin.PATTERN_MAGICAL_TATTOO || hasFur())
				kitsuneCounter++;
			//If the character has fur, scales, or gooey skin, -1
		//	if (skinType == FUR && !InCollection(furColor, KitsuneScene.basicKitsuneFur) && !InCollection(furColor, KitsuneScene.elderKitsuneColors))
		//		kitsuneCounter--;
			if (hasCoat() && !hasCoatOfType(Skin.FUR))
				kitsuneCounter -= 2;
			if (skin.base.type != Skin.PLAIN)
				kitsuneCounter -= 3;
			if (arms.type == Arms.HUMAN || arms.type == Arms.KITSUNE)
				kitsuneCounter++;
			if (lowerBody == LowerBody.FOX || lowerBody == LowerBody.HUMAN)
				kitsuneCounter++;
			if (lowerBody != LowerBody.HUMAN && lowerBody != LowerBody.FOX)
				kitsuneCounter--;
			//If the character has a 'vag of holding', +1
			if (vaginalCapacity() >= 8000)
				kitsuneCounter++;
			if (faceType == Face.HUMAN || faceType == Face.FOX)
				kitsuneCounter++;
			if (faceType != Face.HUMAN && faceType != Face.FOX)
				kitsuneCounter--;
			//If the character has "blonde","black","red","white", or "silver" hair, +1
		//	if (kitsuneCounter > 0 && (InCollection(furColor, KitsuneScene.basicKitsuneHair) || InCollection(furColor, KitsuneScene.elderKitsuneColors)))
		//		kitsuneCounter++;
			if (hasPerk(PerkLib.StarSphereMastery))
				kitsuneCounter++;
			//When character get Hoshi no tama
			if (hasPerk(PerkLib.KitsuneThyroidGland))
				kitsuneCounter++;
			if (hasPerk(PerkLib.KitsuneThyroidGlandEvolved))
				kitsuneCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && kitsuneCounter >= 5)
				kitsuneCounter += 1;
			if (hasPerk(PerkLib.KitsuneThyroidGland) && hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				kitsuneCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				kitsuneCounter += 10;
			
			End("Player","racialScore");
			return kitsuneCounter;
		}

		//Determine Dragon Rating
		public function dragonScore():Number {
			Begin("Player","racialScore","dragon");
			var dragonCounter:Number = 0;
			if (faceType == Face.DRAGON || faceType == Face.DRAGON_FANGS)
				dragonCounter++;
			if (faceType == Face.JABBERWOCKY || faceType == Face.BUCKTOOTH)
				dragonCounter -= 10;
			if (eyes.type == Eyes.DRAGON)
				dragonCounter++;
			if (ears.type == Ears.DRAGON)
				dragonCounter++;
			if (tailType == Tail.DRACONIC)
				dragonCounter++;
			if (tongue.type == Tongue.DRACONIC)
				dragonCounter++;
			if (wings.type == Wings.DRACONIC_SMALL)
				dragonCounter++;
			if (wings.type == Wings.DRACONIC_LARGE)
				dragonCounter += 2;
			if (wings.type == Wings.DRACONIC_HUGE)
				dragonCounter += 4;
			if (wings.type == Wings.FEY_DRAGON_WINGS)
				dragonCounter -= 10;
			if (lowerBody == LowerBody.DRAGON)
				dragonCounter++;
			if (arms.type == Arms.DRAGON)
				dragonCounter++;
			if (tallness > 120 && dragonCounter >= 10)
				dragonCounter++;
			if (skinType == Skin.DRAGON_SCALES)// FIXME: what about PARTIAL_DRAGON_SCALES?
				dragonCounter++;
			if (horns.type == Horns.DRACONIC_X4_12_INCH_LONG)
				dragonCounter += 2;
			if (horns.type == Horns.DRACONIC_X2)
				dragonCounter++;
		//	if (dragonCocks() > 0)
		//		dragonCounter++;
			if (hasPerk(PerkLib.DragonFireBreath) && dragonCounter >= 4)
				dragonCounter++;
			if (hasPerk(PerkLib.DragonIceBreath) && dragonCounter >= 4)
				dragonCounter++;
			if (hasPerk(PerkLib.DragonLightningBreath) && dragonCounter >= 4)
				dragonCounter++;
			if (hasPerk(PerkLib.DragonDarknessBreath) && dragonCounter >= 4)
				dragonCounter++;
			if (hasPerk(PerkLib.DraconicLungs))
				dragonCounter++;
			if (hasPerk(PerkLib.DraconicLungsEvolved))
				dragonCounter++;
		//	if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
		//		dragonCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && dragonCounter >= 4)
				dragonCounter += 1;
			if (hasPerk(PerkLib.DraconicLungs) && hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				dragonCounter++;
			
			End("Player","racialScore");
			return dragonCounter;
		}
		
		//Determine Jabberwocky Rating
		public function jabberwockyScore():Number {
			Begin("Player","racialScore","dragon");
			var jabberwockyCounter:Number = 0;
			if (faceType == Face.JABBERWOCKY || faceType == Face.BUCKTOOTH)
				jabberwockyCounter++;
			if (faceType == Face.DRAGON || faceType == Face.DRAGON_FANGS)
				jabberwockyCounter -= 10;
			if (eyes.type == Eyes.DRAGON)
				jabberwockyCounter++;
			if (ears.type == Ears.DRAGON)
				jabberwockyCounter++;
			if (tailType == Tail.DRACONIC)
				jabberwockyCounter++;
			if (tongue.type == Tongue.DRACONIC)
				jabberwockyCounter++;
			if (wings.type == Wings.FEY_DRAGON_WINGS)
				jabberwockyCounter += 4;
			if (wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE)
				jabberwockyCounter -= 10;
			if (lowerBody == LowerBody.DRAGON)
				jabberwockyCounter++;
			if (arms.type == Arms.DRAGON)
				jabberwockyCounter++;
			if (tallness > 120 && jabberwockyCounter >= 10)
				jabberwockyCounter++;
			if (skinType == Skin.DRAGON_SCALES)// FIXME: what about PARTIAL_DRAGON_SCALES?
				jabberwockyCounter++;
			if (horns.type == Horns.DRACONIC_X4_12_INCH_LONG)
				jabberwockyCounter += 2;
			if (horns.type == Horns.DRACONIC_X2)
				jabberwockyCounter++;
		//	if (dragonCocks() > 0)
		//		dragonCounter++;
			if (hasPerk(PerkLib.DragonFireBreath) && jabberwockyCounter >= 4)
				jabberwockyCounter++;
			if (hasPerk(PerkLib.DragonIceBreath) && jabberwockyCounter >= 4)
				jabberwockyCounter++;
			if (hasPerk(PerkLib.DragonLightningBreath) && jabberwockyCounter >= 4)
				jabberwockyCounter++;
			if (hasPerk(PerkLib.DragonDarknessBreath) && jabberwockyCounter >= 4)
				jabberwockyCounter++;
			if (hasPerk(PerkLib.DraconicLungs))
				jabberwockyCounter++;
			if (hasPerk(PerkLib.DraconicLungsEvolved))
				jabberwockyCounter++;
		//	if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
		//		dragonCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && jabberwockyCounter >= 4)
				jabberwockyCounter += 1;
			if (hasPerk(PerkLib.DraconicLungs) && hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				jabberwockyCounter++;
			
			End("Player","racialScore");
			return jabberwockyCounter;
		}

		//Goblin score
		public function goblinScore():Number
		{
			Begin("Player","racialScore","goblin");
			var goblinCounter:Number = 0;
			if (skinTone == "pale yellow" || skinTone == "grayish-blue" || skinTone == "green" || skinTone == "dark green") {	
				if (tallness < 48 && goblinCounter > 0)
					goblinCounter++;
				if (faceType == Face.HUMAN)
					goblinCounter++;
				if (hasVagina())
					goblinCounter++;
				if (lowerBody == LowerBody.HUMAN)
					goblinCounter++;
			}
			if (ears.type == Ears.ELFIN)
				goblinCounter++;
			if (skinTone == "pale yellow" || skinTone == "grayish-blue" || skinTone == "green" || skinTone == "dark green")
				goblinCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && goblinCounter >= 3)
				goblinCounter += 1;
			End("Player","racialScore");
			return goblinCounter;
		}

		//Goo score
		public function gooScore():Number
		{
			Begin("Player","racialScore","goo");
			var gooCounter:Number = 0;
			if (hairType == Hair.GOO)
				gooCounter++;
			if (hasGooSkin() && skinAdj == "slimy") {
				gooCounter++;
				if (faceType == Face.HUMAN)
					gooCounter++;
				if (arms.type == Arms.HUMAN)
					gooCounter++;
			}
			if (wings.type == Wings.NONE)
				gooCounter++;
			if (lowerBody == LowerBody.GOO)
				gooCounter += 2;
			if (vaginalCapacity() > 9000)
				gooCounter++;
			if (hasStatusEffect(StatusEffects.SlimeCraving))
				gooCounter++;
			if (hasPerk(PerkLib.SlimeCore))
				gooCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				gooCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && gooCounter >= 4)
				gooCounter += 1;
			End("Player","racialScore");
			return gooCounter;
		}

		//Naga score
		public function nagaScore():Number {
			Begin("Player","racialScore","naga");
			var nagaCounter:Number = 0;
			if (isNaga())
				nagaCounter += 2;
			if (tongue.type == Tongue.SNAKE)
				nagaCounter++;
			if (faceType == Face.SNAKE_FANGS)
				nagaCounter++;
			if (arms.type == Arms.HUMAN)
				nagaCounter++;
			if (hasPartialCoat(Skin.SCALES))
				nagaCounter++;
			if (eyes.type == Eyes.SNAKE)
				nagaCounter++;
			if (ears.type == Ears.SNAKE)
				nagaCounter++;
			if (gorgonScore() > 10 || vouivreScore() > 10 || couatlScore() > 10)
				nagaCounter -= 8;
			
			End("Player","racialScore");
			return nagaCounter;
		}
		//Gorgon score
		public function gorgonScore():Number {
			Begin("Player","racialScore","gorgon");
			var gorgonCounter:Number = 0;
			if (isNaga())
				gorgonCounter += 2;
			if (tongue.type == Tongue.SNAKE)
				gorgonCounter++;
			if (faceType == Face.SNAKE_FANGS)
				gorgonCounter++;
			if (arms.type == Arms.HUMAN)
				gorgonCounter++;
			if (hasCoatOfType(Skin.SCALES))
				gorgonCounter++;
			if (ears.type == Ears.SNAKE)
				gorgonCounter++;
			if (eyes.type == Eyes.SNAKE)
				gorgonCounter++;
			if (eyes.type == Eyes.GORGON)
				gorgonCounter += 2;
			if (hairType == Hair.GORGON)
				gorgonCounter += 2;
			if (hasPerk(PerkLib.GorgonsEyes))
				gorgonCounter++;
			if (antennae.type != Antennae.NONE)
				gorgonCounter -= 3;
			if (wings.type != Wings.NONE)
				gorgonCounter -= 3;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				gorgonCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && gorgonCounter >= 7)
				gorgonCounter += 1;
			if (hasPerk(PerkLib.GorgonsEyes) && hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				gorgonCounter++;
			
			End("Player","racialScore");
			return gorgonCounter;
		}
		//Vouivre score
		public function vouivreScore():Number {
			Begin("Player","racialScore","vouivre");
			var vouivreCounter:Number = 0;
			if (isNaga())
				vouivreCounter += 2;
			if (tongue.type == Tongue.SNAKE)
				vouivreCounter++;
			if (faceType == Face.SNAKE_FANGS)
				vouivreCounter++;
			if (arms.type == Arms.DRAGON)
				vouivreCounter++;
			if (hasCoatOfType(Skin.DRAGON_SCALES))
				vouivreCounter++;
			if (eyes.type == Eyes.SNAKE)
				vouivreCounter++;
			if (ears.type == Ears.DRAGON)
				vouivreCounter++;
			if (horns.type == Horns.DRACONIC_X4_12_INCH_LONG || horns.type == Horns.DRACONIC_X2)
				vouivreCounter++;
			if (wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE)
				vouivreCounter += 2;
			if (hasPerk(PerkLib.DragonFireBreath) && vouivreCounter >= 11)
				vouivreCounter++;
			if (hasPerk(PerkLib.DragonIceBreath) && vouivreCounter >= 11)
				vouivreCounter++;
			if (hasPerk(PerkLib.DragonLightningBreath) && vouivreCounter >= 11)
				vouivreCounter++;
			if (hasPerk(PerkLib.DragonDarknessBreath) && vouivreCounter >= 11)
				vouivreCounter++;
			if (hasPerk(PerkLib.DraconicLungs))
				vouivreCounter++;
			if (hasPerk(PerkLib.DraconicLungsEvolved))
				vouivreCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && vouivreCounter >= 7)
				vouivreCounter += 1;

			End("Player","racialScore");
			return vouivreCounter;
		}
		//Couatl score
		public function couatlScore():Number {
			Begin("Player","racialScore","couatl");
			var couatlCounter:Number = 0;
			if (isNaga())
				couatlCounter += 2;
			if (tongue.type == Tongue.SNAKE)
				couatlCounter++;
			if (faceType == Face.SNAKE_FANGS)
				couatlCounter++;
			if (arms.type == Arms.HARPY)
				couatlCounter++;
			if (hasCoatOfType(Skin.SCALES))
				couatlCounter++;
			if (ears.type == Ears.SNAKE)
				couatlCounter++;
			if (eyes.type == Eyes.SNAKE)
				couatlCounter++;
			if (hairType == Hair.FEATHER)
				couatlCounter++;
			if (wings.type == Wings.FEATHERED_LARGE)
				couatlCounter += 2;
			if (hasPerk(PerkLib.AscensionHybridTheory) && couatlCounter >= 7)
				couatlCounter += 1;

			End("Player","racialScore");
			return couatlCounter;
		}

		//Bunny score
		public function bunnyScore():Number {
			Begin("Player","racialScore","bunny");
			var bunnyCounter:Number = 0;
			if (faceType == Face.BUNNY)
				bunnyCounter++;
			if (tailType == Tail.RABBIT)
				bunnyCounter++;
			if (ears.type == Ears.BUNNY)
				bunnyCounter++;
			if (lowerBody == LowerBody.BUNNY)
				bunnyCounter++;
			//More than 2 balls reduces bunny score
			if (balls > 2 && bunnyCounter > 0)
				bunnyCounter--;
			//Human skin on bunmorph adds
			if (hasPlainSkin() && bunnyCounter > 1 && skinAdj != "slippery")
				bunnyCounter++;
			//No wings and antennae.type a plus
			if (bunnyCounter > 0 && antennae.type == 0)
				bunnyCounter++;
			if (bunnyCounter > 0 && wings.type == Wings.NONE)
				bunnyCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				bunnyCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && bunnyCounter >= 3)
				bunnyCounter += 1;
			
			End("Player","racialScore");
			return bunnyCounter;
		}

		//Harpy score
		public function harpyScore():Number {
			Begin("Player","racialScore","harpy");
			var harpy:Number = 0;
			if (arms.type == Arms.HARPY)
				harpy++;
			if (hairType == Hair.FEATHER)
				harpy++;
			if (wings.type == Wings.FEATHERED_LARGE)
				harpy += 2;
			if (tailType == Tail.HARPY)
				harpy++;
			if (tailType == Tail.SHARK || tailType == Tail.SALAMANDER)
				harpy -= 5;
			if (lowerBody == LowerBody.HARPY)
				harpy++;
			if (lowerBody == LowerBody.SALAMANDER)
				harpy--;
			if (harpy >= 2 && faceType == Face.HUMAN)
				harpy++;
			if (faceType == Face.SHARK_TEETH)
				harpy--;
			if (harpy >= 2 && (ears.type == Ears.HUMAN || ears.type == Ears.ELFIN))
				harpy++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				harpy += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && harpy >= 3)
				harpy += 1;
			
			End("Player","racialScore");
			return harpy;
		}

		//Kanga score
		public function kangaScore():Number {
			Begin("Player","racialScore","kanga");
			var kanga:Number = 0;
			if (kangaCocks() > 0)
				kanga++;
			if (ears.type == Ears.KANGAROO)
				kanga++;
			if (tailType == Tail.KANGAROO)
				kanga++;
			if (lowerBody == LowerBody.KANGAROO)
				kanga++;
			if (faceType == Face.KANGAROO)
				kanga++;
			if (kanga >= 2 && hasFur())
				kanga++;
			
			End("Player","racialScore");
			return kanga;
		}

		//shark score
		public function sharkScore():Number {
			Begin("Player","racialScore","shark");
			var sharkCounter:Number = 0;
			if (faceType == Face.SHARK_TEETH)
				sharkCounter++;
			if (gills.type == Gills.FISH)
				sharkCounter++;
			if (rearBody.type == RearBody.SHARK_FIN)
				sharkCounter++;
			if (wings.type == Wings.SHARK_FIN)
				sharkCounter -= 7;
			if (arms.type == Arms.SHARK)
				sharkCounter++;
			if (lowerBody == LowerBody.SHARK)
				sharkCounter++;
			if (tailType == Tail.SHARK)
				sharkCounter++;
			if (hairType == Hair.NORMAL && hairColor == "silver")
				sharkCounter++;
			if (hasScales() && InCollection(skin.coat.color, "rough gray","orange and black"))
				sharkCounter++;
			if (eyes.type == Eyes.HUMAN && hairType == Hair.NORMAL && hairColor == "silver" && hasScales() && InCollection(skin.coat.color, "rough gray","orange and black"))
				sharkCounter++;
			if (vaginas.length > 0 && cocks.length > 0)
				sharkCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				sharkCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && sharkCounter >= 3)
				sharkCounter += 1;
			
			End("Player","racialScore");
			return sharkCounter;
		}

		//Orca score
		public function orcaScore():Number {
			Begin("Player","racialScore","orca");
			var orcaCounter:Number = 0;
			if (ears.type == Ears.ORCA)
				orcaCounter++;
			if (tailType == Tail.ORCA)
				orcaCounter++;
			if (faceType == Face.ORCA)
				orcaCounter++;
			if (lowerBody == LowerBody.ORCA)
				orcaCounter++;
			if (arms.type == Arms.ORCA)
				orcaCounter++;
			if (rearBody.type == RearBody.ORCA_BLOWHOLE)
				orcaCounter++;
			if (hasPlainSkinOnly() && skinAdj == "glossy")
				orcaCounter++;
			if (skin.base.pattern == Skin.PATTERN_ORCA_UNDERBODY)
				orcaCounter++;
			if (wings.type == Wings.NONE)
				orcaCounter += 2;
			if (eyes.type == Eyes.HUMAN)
				orcaCounter++;
			if (tallness >= 84)
				orcaCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				orcaCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && orcaCounter >= 3)
				orcaCounter += 1;
			
			End("Player","racialScore");
			return orcaCounter;
		}

		//Oni score
		public function oniScore():Number {
			Begin("Player","racialScore","oni");
			var oniCounter:Number = 0;
			if (ears.type == Ears.ONI)
				oniCounter++;
			if (faceType == Face.ONI_TEETH)
				oniCounter++;
			if (horns.type == Horns.ONI)
				oniCounter++;
			if (arms.type == Arms.ONI)
				oniCounter++;
			if (lowerBody == LowerBody.ONI)
				oniCounter++;
			if (eyes.type == Eyes.ONI && InCollection(eyes.colour,Mutations.oniEyeColors))
				oniCounter++;
			if (skinTone == "red" || skinTone == "reddish orange" || skinTone == "purple" || skinTone == "blue")
				oniCounter++;
			if (skin.base.pattern == Skin.PATTERN_BATTLE_TATTOO)
				oniCounter++;
			if (tailType == Tail.NONE)
				oniCounter++;
			if (tone >= 75)
				oniCounter++;
			if ((hasVagina() && biggestTitSize() >= 19) || (cocks.length > 18))
				oniCounter++;
			if (tallness >= 120)
				oniCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				oniCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && oniCounter >= 3)
				oniCounter += 1;
			
			End("Player","racialScore");
			return oniCounter;
		}
		
		//Elf score
		public function elfScore():Number {
			Begin("Player","racialScore","elf");
			var elfCounter:Number = 0;
			if (ears.type == Ears.ELVEN)
				elfCounter++;
			if (eyes.type == Eyes.ELF)
				elfCounter++;
			if (tongue.type == Tongue.ELF)
				elfCounter++;
			if (arms.type == Arms.ELF)
				elfCounter++;
			if (lowerBody == LowerBody.ELF)
				elfCounter++;
			if (hairType == Hair.SILKEN)
				elfCounter++;
			if (hairColor == "black" || hairColor == "leaf green" || hairColor == "golden blonde" || hairColor == "silver")
				elfCounter++;
			if (skinTone == "dark" || skinTone == "light" || skinTone == "tan")
				elfCounter++;
			if (skinType == Skin.PLAIN && skinAdj == "flawless")
				elfCounter += 2;//elfCounter++;
			if (cocks.length < 6)
				elfCounter++;
			if (hasVagina() && biggestTitSize() >= 3)
				elfCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				elfCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && elfCounter >= 3)
				elfCounter += 1;
			
			End("Player","racialScore");
			return elfCounter;
		}

		//Elf score
		public function raijuScore():Number {
			Begin("Player","racialScore","raiju");
			var raijuCounter:Number = 0;
			if (ears.type == Ears.WEASEL)
				raijuCounter++;
			if (eyes.type == Eyes.RAIJU)
				raijuCounter++;
			if (faceType == Face.RAIJU_FANGS)
				raijuCounter++;
			if (arms.type == Arms.RAIJU)
				raijuCounter++;
			if (lowerBody == LowerBody.RAIJU)
				raijuCounter++;
			if (tailType == Tail.RAIJU)
				raijuCounter++;
			if (rearBody.type == RearBody.RAIJU_MANE)
				raijuCounter++;
			if (skin.base.pattern == Skin.PATTERN_LIGHTNING_SHAPED_TATTOO)
				raijuCounter++;
			if (hairType == Hair.STORM)
				raijuCounter++;
			if (hairColor == "purple" || hairColor == "light blue" || hairColor == "yellow" || hairColor == "white")
				raijuCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				raijuCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && raijuCounter >= 3)
				raijuCounter += 1;
			
			End("Player","racialScore");
			return raijuCounter;
		}

		//Determine Mutant Rating
		public function mutantScore():Number{
			Begin("Player","racialScore","mutant");
			var mutantCounter:Number = 0;
			if (faceType != Face.HUMAN)
				mutantCounter++;
			if (!hasPlainSkinOnly())
				mutantCounter++;
			if (tailType != Tail.NONE)
				mutantCounter++;
			if (cockTotal() > 1)
				mutantCounter++;
			if (hasCock() && hasVagina())
				mutantCounter++;
			if (hasFuckableNipples())
				mutantCounter++;
			if (breastRows.length > 1)
				mutantCounter++;
			if (faceType == Face.HORSE)
			{
				if (hasFur())
					mutantCounter--;
				if (tailType == Tail.HORSE)
					mutantCounter--;
			}
			if (faceType == Face.DOG)
			{
				if (hasFur())
					mutantCounter--;
				if (tailType == Tail.DOG)
					mutantCounter--;
			}
			End("Player","racialScore");
			return mutantCounter;
		}
		
		//scorpion score
		public function scorpionScore():Number {
			Begin("Player","racialScore","scorpion");
			var scorpionCounter:Number = 0;
			if (hasCoatOfType(Skin.CHITIN))
				scorpionCounter++;
			if (tailType == Tail.SCORPION)
				scorpionCounter++;
			if (scorpionCounter > 0 && hasPerk(PerkLib.TrachealSystem))
				scorpionCounter++;
			if (scorpionCounter > 4 && hasPerk(PerkLib.TrachealSystemEvolved))
				scorpionCounter++;
			if (scorpionCounter > 8 && hasPerk(PerkLib.TrachealSystemFinalForm))
				scorpionCounter++;
			
			End("Player","racialScore");
			return scorpionCounter;
		}
		
		//Mantis score
		public function mantisScore():Number {
			Begin("Player","racialScore","mantis");
			var mantisCounter:Number = 0;
			if (hasCoatOfType(Skin.CHITIN))
				mantisCounter++;
			if (antennae.type == Antennae.MANTIS)
			{
				mantisCounter++;
				if (faceType == Face.HUMAN)
					mantisCounter++;
			}
			if (arms.type == Arms.MANTIS)
				mantisCounter++;
			if (lowerBody == LowerBody.MANTIS)
				mantisCounter++;
			if (tailType == Tail.MANTIS_ABDOMEN)
				mantisCounter++;
			if (wings.type == Wings.MANTIS_LIKE_SMALL)
				mantisCounter++;
			if (wings.type == Wings.MANTIS_LIKE_LARGE)
				mantisCounter += 2;
			if (wings.type == Wings.MANTIS_LIKE_LARGE_2)
				mantisCounter += 4;
			if (mantisCounter > 0 && hasPerk(PerkLib.TrachealSystem))
				mantisCounter++;
			if (mantisCounter > 4 && hasPerk(PerkLib.TrachealSystemEvolved))
				mantisCounter++;
			if (mantisCounter > 8 && hasPerk(PerkLib.TrachealSystemFinalForm))
				mantisCounter++;
			if (hasPerk(PerkLib.MantislikeAgility))
				mantisCounter++;
			if (hasPerk(PerkLib.MantislikeAgilityEvolved))
				mantisCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				mantisCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && mantisCounter >= 3)
				mantisCounter += 1;
			if (hasPerk(PerkLib.MantislikeAgility) && hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				mantisCounter++;
			End("Player","racialScore");
			return mantisCounter;
		}
		
		//Thunder Mantis score
		//4 eyes - adj spider 4 eyes desc
		//var. of arms, legs, wings, tail, ears
		
		//Salamander score
		public function salamanderScore():Number {
			Begin("Player","racialScore","salamander");
			var salamanderCounter:Number = 0;
			if (hasPartialCoat(Skin.SCALES))
				salamanderCounter++;
			if (faceType == Face.SALAMANDER_FANGS)
				salamanderCounter++;
			if (ears.type == Ears.HUMAN && faceType == Face.SALAMANDER_FANGS)
				salamanderCounter++;
			if (eyes.type == Eyes.REPTILIAN)
				salamanderCounter++;
			if (arms.type == Arms.SALAMANDER)
				salamanderCounter++;
			if (lowerBody == LowerBody.SALAMANDER)
				salamanderCounter++;
			if (tailType == Tail.SALAMANDER)
				salamanderCounter++;
			if (lizardCocks() > 0)
				salamanderCounter++;
			if (hasPerk(PerkLib.Lustzerker))
				salamanderCounter++;
			if (hasPerk(PerkLib.SalamanderAdrenalGlands))
				salamanderCounter++;
			if (hasPerk(PerkLib.SalamanderAdrenalGlandsEvolved))
				salamanderCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				salamanderCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && salamanderCounter >= 4)
				salamanderCounter += 1;
			if (hasPerk(PerkLib.SalamanderAdrenalGlands) && hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				salamanderCounter++;
			
			End("Player","racialScore");
			return salamanderCounter;
		}
		
		//Yeti score
		public function yetiScore():Number {
			Begin("Player","racialScore","yeti");
			var yetiCounter:Number = 0;
			if (skinTone == "dark")
				yetiCounter++;
			if (eyes.type == Eyes.HUMAN)
				yetiCounter++;
			if (lowerBody == LowerBody.YETI)
				yetiCounter++;
			if (arms.type == Arms.YETI)
				yetiCounter++;
			if (ears.type == Ears.YETI)
				yetiCounter++;
			if (faceType == Face.YETI_FANGS)
				yetiCounter++;
			if (hairType == Hair.FLUFFY)
				yetiCounter++;
			if (hairColor == "white")
				yetiCounter++;
			if (hasPartialCoat(Skin.FUR))
				yetiCounter++;
			if (hasFur() && coatColor == "white")
				yetiCounter++;
			if (tallness >= 78)
				yetiCounter++;
			if (butt.type >= 10)
				yetiCounter++;
			
			End("Player","racialScore");
			return yetiCounter;
		}

		//Centaur score
		public function centaurScore():Number
		{
			if (horns.type == Horns.UNICORN)
				return 0;
			Begin("Player","racialScore","centaur");
			var centaurCounter:Number = 0;
			if (isTaur())
				centaurCounter += 2;
			if (lowerBody == LowerBody.HOOFED || lowerBody == LowerBody.CLOVEN_HOOFED)
				centaurCounter++;
			if (tailType == Tail.HORSE)
				centaurCounter++;
			if (hasPlainSkinOnly())
				centaurCounter++;
			if (arms.type == Arms.HUMAN)
				centaurCounter++;
			if (ears.type == Ears.HUMAN || ears.type == Ears.HUMAN)
				centaurCounter++;
			if (faceType == Face.HUMAN)
				centaurCounter++;
			if (horseCocks() > 0)
				centaurCounter++;
			if (hasVagina() && vaginaType() == VaginaClass.EQUINE)
				centaurCounter++;
			if (wings.type != Wings.NONE)
				centaurCounter -= 3;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				centaurCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && centaurCounter >= 3)
				centaurCounter += 1;
			End("Player","racialScore");
			return centaurCounter;
		}

		public function sphinxScore():Number
		{
			var sphinxCounter:Number = 0;
			if (isTaur()) {
				if (lowerBody == LowerBody.CAT)
					sphinxCounter += 2;
				if (tailType == Tail.CAT && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
				if (skinType == 0 && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
				if (arms.type == Arms.SPHINX && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
				if (ears.type == Ears.LION && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
				if (faceType == Face.CAT_CANINES && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
			}
			if (eyes.type == Eyes.CAT_SLITS)
				sphinxCounter++;
			if (ears.type == Ears.LION)
				sphinxCounter++;
			if (tongue.type == Tongue.CAT)
				sphinxCounter++;
			if (tailType == Tail.CAT)
				sphinxCounter++;
			if (tailType == Tail.LION)
				sphinxCounter++;
			if (lowerBody == LowerBody.CAT)
				sphinxCounter++;
			if (faceType == Face.CAT_CANINES)
				sphinxCounter++;
			if (wings.type == Wings.FEATHERED_SPHINX)
				sphinxCounter += 2;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				sphinxCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && sphinxCounter >= 3)
				sphinxCounter += 1;
			if (hasPerk(PerkLib.Flexibility))
				sphinxCounter++;
			if (hasPerk(PerkLib.CatlikeNimbleness))
				sphinxCounter += 1;
			return sphinxCounter;
		}

		//Determine Unicorn Rating
		public function unicornScore():Number {
			if (horns.type != Horns.UNICORN)
				return 0;
			if (wings.type == Wings.FEATHERED_ALICORN)
				return 0;
			Begin("Player","racialScore","unicorn");
			var unicornCounter:Number = 0;
			if (faceType == Face.HORSE)
				unicornCounter += 2;
			if (faceType == Face.HUMAN)
				unicornCounter++;
			if (ears.type == Ears.HORSE)
				unicornCounter++;
			if (tailType == Tail.HORSE)
				unicornCounter++;
			if (lowerBody == LowerBody.HOOFED)
				unicornCounter++;
			if (legCount == 4)
				unicornCounter++;
			if (eyes.colour == "red" || eyes.colour == "blue")
				unicornCounter++;
			if (horns.type == Horns.UNICORN && horns.count < 6)
				unicornCounter++;
			if (horns.type == Horns.UNICORN && horns.count >= 6)
				unicornCounter += 2;
			if (hasFur() || hasPlainSkinOnly())
				unicornCounter++;
			if (hairColor == "white")
				unicornCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				unicornCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && unicornCounter >= 3)
				unicornCounter += 1;
			End("Player","racialScore");
			return unicornCounter;
		}
		
		//Determine Alicorn Rating
		public function alicornScore():Number {
			if (horns.type != Horns.UNICORN)
				return 0;
			if (wings.type != Wings.FEATHERED_ALICORN)
				return 0;
			Begin("Player","racialScore","alicorn");
			var alicornCounter:Number = 0;
			if (faceType == Face.HORSE)
				alicornCounter += 2;
			if (faceType == Face.HUMAN)
				alicornCounter++;
			if (ears.type == Ears.HORSE)
				alicornCounter++;
			if (tailType == Tail.HORSE)
				alicornCounter++;
			if (lowerBody == LowerBody.HOOFED)
				alicornCounter++;
			if (legCount == 4)
				alicornCounter++;
			if (eyes.colour == "red" || eyes.colour == "blue")
				alicornCounter++;
			if (wings.type == Wings.FEATHERED_ALICORN)
				alicornCounter += 2;
			if (horns.type == Horns.UNICORN && horns.count < 6)
				alicornCounter++;
			if (horns.type == Horns.UNICORN && horns.count >= 6)
				alicornCounter += 2;
			if (hasFur() || hasPlainSkinOnly())
				alicornCounter++;
			if (hairColor == "white")
				alicornCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				alicornCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && alicornCounter >= 3)
				alicornCounter += 1;
			
			End("Player","racialScore");
			return alicornCounter;
		}
		
		//Determine Phoenix Rating
		public function phoenixScore():Number {
			Begin("Player","racialScore","phoenix");
			var phoenixCounter:Number = 0;
			if (hairType == Hair.FEATHER) {
				if (hairType == Hair.FEATHER)
					phoenixCounter++;
				if (faceType == Face.HUMAN && phoenixCounter > 2)
					phoenixCounter++;
				if (ears.type == Ears.HUMAN && phoenixCounter > 2)
					phoenixCounter++;
			}
			if (eyes.type == Eyes.REPTILIAN)
				phoenixCounter++;
			if (wings.type == Wings.FEATHERED_PHOENIX)
				phoenixCounter++;
			if (arms.type == Arms.PHOENIX)
				phoenixCounter++;
			if (lowerBody == LowerBody.SALAMANDER)
				phoenixCounter++;
			if (tailType == Tail.SALAMANDER)
				phoenixCounter++;
			if (hasPartialCoat(Skin.SCALES))
				phoenixCounter++;
			if (lizardCocks() > 0)
				phoenixCounter++;
			if (hasPerk(PerkLib.PhoenixFireBreath))
				phoenixCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				phoenixCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && phoenixCounter >= 3)
				phoenixCounter += 1;
			End("Player","racialScore");
			return phoenixCounter;
		}
		
		//Scylla score
		public function scyllaScore():Number {
			Begin("Player","racialScore","scylla");
			var scyllaCounter:Number = 0;
			if (faceType == Face.HUMAN)
				scyllaCounter++;
			if (faceType != 0)
				scyllaCounter--;
			if (ears.type == Ears.ELFIN)
				scyllaCounter++;
			if (hasPlainSkinOnly() && skinAdj == "slippery")
				scyllaCounter++;
		//	if (hasPlainSkinOnly() && skinAdj == "rubberlike slippery")
		//		scyllaCounter += 2;
			if (isScylla())
				scyllaCounter += 2;
			if (tallness > 96)
				scyllaCounter++;
			if (hasPerk(PerkLib.InkSpray))
				scyllaCounter++;
			if (hasPerk(PerkLib.ScyllaInkGlands))
				scyllaCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				scyllaCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && scyllaCounter >= 4)
				scyllaCounter += 1;
			if (hasPerk(PerkLib.ScyllaInkGlands) && hasPerk(PerkLib.ChimericalBodyAdvancedStage))
				scyllaCounter++;
			
			End("Player","racialScore");
			return scyllaCounter;
		}//potem tentacle dick lub scylla vag też bedą sie liczyć do wyniku)
		
		//Determine Kitshoo Rating
		public function kitshooScore():Number {
			Begin("Player","racialScore","kitshoo");
			var kitshooCounter:int = 0;
			//If the character has fox ears, +1
			if (ears.type == Ears.FOX)
				kitshooCounter++;
			//If the character has a fox tail, +1
		//	if (tailType == FOX)
		//		kitshooCounter++;
			//If the character has two to eight fox tails, +2
		//	if (tailType == FOX && tailCount >= 2 && tailCount < 9)
		//		kitshooCounter += 2;
			//If the character has nine fox tails, +3
		//	if (tailType == FOX && tailCount == 9)
		//		kitshooCounter += 3;
			//If the character has tattooed skin, +1
			//9999
			//If the character has a 'vag of holding', +1
		//	if (vaginalCapacity() >= 8000)
		//		kitshooCounter++;
			//If the character's kitshoo score is greater than 0 and:
			//If the character has a normal face, +1
			if (kitshooCounter > 0 && (faceType == Face.HUMAN || faceType == Face.FOX))
				kitshooCounter++;
			//If the character's kitshoo score is greater than 1 and:
			//If the character has "blonde","black","red","white", or "silver" hair, +1
			if (kitshooCounter > 0 && hasFur() && (InCollection(coatColor, KitsuneScene.basicKitsuneHair) || InCollection(coatColor, KitsuneScene.elderKitsuneColors)))
				kitshooCounter++;
			//If the character's femininity is 40 or higher, +1
		//	if (kitshooCounter > 0 && femininity >= 40)
		//		kitshooCounter++;
			//If the character has fur, chitin, or gooey skin, -1
		//	if (skinType == FUR && !InCollection(furColor, KitsuneScene.basicKitsuneFur) && !InCollection(furColor, KitsuneScene.elderKitsuneColors))
		//		kitshooCounter--;
		//	if (skinType == SCALES)
		//		kitshooCounter -= 2; - czy bedzie pozytywny do wyniku czy tez nie?
			if (hasCoatOfType(Skin.CHITIN))
				kitshooCounter -= 2;
			if (hasGooSkin())
				kitshooCounter -= 3;
			//If the character has abnormal legs, -1
		//	if (lowerBody != HUMAN && lowerBody != FOX)
		//		kitshooCounter--;
			//If the character has a nonhuman face, -1
		//	if (faceType != HUMAN && faceType != FOX)
		//		kitshooCounter--;
			//If the character has ears other than fox ears, -1
		//	if (earType != FOX)
		//		kitshooCounter--;
			//If the character has tail(s) other than fox tails, -1
		//	if (tailType != FOX)
		//		kitshooCounter--;
			//When character get one of 9-tail perk
		//	if (kitshooCounter >= 3 && (hasPerk(PerkLib.EnlightenedNinetails) || hasPerk(PerkLib.CorruptedNinetails)))
		//		kitshooCounter += 2;
			//When character get Hoshi no tama
		//	if (hasPerk(PerkLib.KitsuneThyroidGland))
		//		kitshooCounter++;
		//	if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
		//		kitshooCounter += 10;
			
			End("Player","racialScore");
			return kitshooCounter;
		}
		
		//plant score
		public function plantScore():Number {
			Begin("Player","racialScore","plant");
			var plantCounter:Number = 0;
			if (faceType == Face.HUMAN)
				plantCounter++;
			if (faceType == Face.PLANT_DRAGON)
				plantCounter--;
			if (horns.type == Horns.OAK || horns.type == Horns.ORCHID)
				plantCounter++;
			if (ears.type == Ears.ELFIN)
				plantCounter++;
			if (ears.type == Ears.LIZARD)
				plantCounter--;
			if ((hairType == Hair.LEAF || hairType == Hair.GRASS) && hairColor == "green")
				plantCounter++;
			if (hasPlainSkinOnly() && (skinTone == "leaf green" || skinTone == "lime green" || skinTone == "turquoise"))
				plantCounter++;
		//	if (skinType == 6)/zielona skóra +1, bark skin +2
		//		plantCounter += 2;
			if (arms.type == Arms.PLANT)
				plantCounter++;
			if (lowerBody == LowerBody.PLANT_HIGH_HEELS || lowerBody == LowerBody.PLANT_ROOT_CLAWS) {
				if (tentacleCocks() > 0) {
					plantCounter++;
				}
				plantCounter++;
			}
			if (wings.type == Wings.PLANT)
				plantCounter++;
		//	if (scorpionCounter > 0 && hasPerk(PerkLib.TrachealSystemEvolved))
		//		plantCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && plantCounter >= 3)
				plantCounter += 1;
			if (alrauneScore() >= 10)
				plantCounter -= 7;
			if (yggdrasilScore() >= 10)
				plantCounter -= 4;
			End("Player","racialScore");
			return plantCounter;
		}
		
		public function alrauneScore():Number {
			Begin("Player","racialScore","alraune");
			var alrauneCounter:Number = 0;
			if (faceType == Face.HUMAN)
				alrauneCounter++;
			if (eyes.type == Eyes.HUMAN)
				alrauneCounter++;
			if (ears.type == Ears.ELFIN)
				alrauneCounter++;
			if ((hairType == Hair.LEAF || hairType == Hair.GRASS) && hairColor == "green")
				alrauneCounter++;
			if (skinType == Skin.PLAIN && (skinTone == "leaf green" || skinTone == "lime green" || skinTone == "turquoise"))
				alrauneCounter++;
			if (arms.type == Arms.PLANT)
				alrauneCounter++;
			if (wings.type == Wings.NONE)
				alrauneCounter++;
			if (lowerBody == LowerBody.PLANT_FLOWER)
				alrauneCounter += 2;
			if (stamenCocks() > 0)
				alrauneCounter++;
			
			End("Player","racialScore");
			return alrauneCounter;
		}
		
		public function yggdrasilScore():Number {
			Begin("Player","racialScore","yggdrasil");
			var yggdrasilCounter:Number = 0;
			if (faceType == Face.PLANT_DRAGON)
				yggdrasilCounter += 2;
			if ((hairType == Hair.ANEMONE || hairType == Hair.LEAF || hairType == Hair.GRASS) && hairColor == "green")
				yggdrasilCounter++;
			if (ears.type == Ears.LIZARD)
				yggdrasilCounter++;
			if (ears.type == Ears.ELFIN)
				yggdrasilCounter -= 2;
			if (arms.type == Arms.PLANT || arms.type == Arms.PLANT2)
				yggdrasilCounter += 2;//++ - untill claws tf added arms tf will count for both arms and claws tf
			//claws?

			if (wings.type == Wings.PLANT)
				yggdrasilCounter++;
			//skin(fur(moss), scales(bark))
			if (skinType == Skin.SCALES)
				yggdrasilCounter++;
			if (tentacleCocks() > 0 || stamenCocks() > 0)
				yggdrasilCounter++;
			if (lowerBody == LowerBody.YGG_ROOT_CLAWS)
				yggdrasilCounter++;
			if (tailType == Tail.YGGDRASIL)
				yggdrasilCounter++;
			
			End("Player","racialScore");
			return yggdrasilCounter;
		}

		//Wolf/Fenrir score
		public function wolfScore():Number {
			Begin("Player","racialScore","wolf");
			var wolfCounter:Number = 0;
			if (faceType == Face.WOLF)
				wolfCounter++;
			if (eyes.type == Eyes.FENRIR)
				wolfCounter++;
			if (eyes.type == Eyes.FERAL)
				wolfCounter -= 11;
			if (ears.type == Ears.WOLF)
				wolfCounter++;
			if (arms.type == Arms.WOLF)
				wolfCounter++;
			if (lowerBody == LowerBody.WOLF)
				wolfCounter++;
			if (tailType == Tail.WOLF)
				wolfCounter++;
			if (hasFur())
				wolfCounter++;
			if (hairColor == "glacial white" && hasFur() && coatColor == "glacial white")
				wolfCounter++;
			if (rearBody.type == RearBody.FENRIR_ICE_SPIKES)
				wolfCounter++;
			if (wolfCocks() > 0 && wolfCounter > 0)
				wolfCounter++;
			if (hasPerk(PerkLib.FreezingBreath))
				wolfCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && eyes.type == 5)
				wolfCounter += 1;
			
			End("Player","racialScore");
			return wolfCounter;
		}

		//Werewolf score
		public function werewolfScore():Number {
			Begin("Player","racialScore","werewolf");
			var werewolfCounter:Number = 0;
			if (faceType == Face.WOLF_FANGS)
				werewolfCounter++;
			if (eyes.type == Eyes.FERAL)
				werewolfCounter++;
			if (eyes.type == Eyes.FENRIR)
				werewolfCounter -= 7;
			if (ears.type == Ears.WOLF)
				werewolfCounter++;
			if (tongue.type == Tongue.DOG)
				werewolfCounter++;
			if (arms.type == Arms.WOLF)
				werewolfCounter++;
			if (lowerBody == LowerBody.WOLF)
				werewolfCounter++;
			if (tailType == Tail.WOLF)
				werewolfCounter++;
			if (hasPartialCoat(Skin.FUR))
				werewolfCounter++;
			if (rearBody.type == RearBody.WOLF_COLLAR)
				werewolfCounter++;
			if (rearBody.type == RearBody.FENRIR_ICE_SPIKES)
				werewolfCounter -= 7;
			if (wolfCocks() > 0 && werewolfCounter > 0)
				werewolfCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && werewolfCounter >= 3)
				werewolfCounter++;
			if (cor >= 20)
				werewolfCounter += 2;
			if (hasPerk(PerkLib.Lycanthropy))
				werewolfCounter++;
			if (hasPerk(PerkLib.LycanthropyDormant))
				werewolfCounter -= 11;
			
			End("Player","racialScore");
			return werewolfCounter;
		}

		public function sirenScore():Number {
			Begin("Player","racialScore","siren");
			var sirenCounter:Number = 0;
			if (faceType == Face.SHARK_TEETH)
				sirenCounter++;
			if (hairType == Hair.FEATHER)
				sirenCounter++;
			if (hairColor == "silver")
				sirenCounter++;
			if (tailType == Tail.SHARK)
				sirenCounter++;
			if (wings.type == Wings.FEATHERED_LARGE)
				sirenCounter += 2;
			if (arms.type == Arms.HARPY)
				sirenCounter++;
			if (lowerBody == LowerBody.SHARK)
				sirenCounter++;
			if (skinType == Skin.SCALES && (skinTone == "rough gray" || skinTone == "orange and black"))
				sirenCounter++;
			if (gills.type == Gills.FISH)
				sirenCounter++;
			if (eyes.type == Eyes.HUMAN)
				sirenCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				sirenCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && sirenCounter >= 3)
				sirenCounter += 1;
			End("Player","racialScore");
			return sirenCounter;
		}
		
		public function pigScore():Number {
			Begin("Player","racialScore","pig");
			var pigCounter:Number = 0;
			if (ears.type == Ears.PIG)
				pigCounter++;
			if (tailType == Tail.PIG)
				pigCounter++;
			if (faceType == Face.PIG || Face.BOAR)
				pigCounter++;
			if (lowerBody == LowerBody.CLOVEN_HOOFED)
				pigCounter += 2;
			if (pigCocks() > 0)
				pigCounter++;
			
			End("Player","racialScore");
			return pigCounter;
		}
		
		public function satyrScore():Number {
			Begin("Player","racialScore","satyr");
			var satyrCounter:Number = 0;
			if (lowerBody == LowerBody.HOOFED)
				satyrCounter++;
			if (tailType == Tail.GOAT)
				satyrCounter++;
			if (satyrCounter >= 2) {
				if (ears.type == Ears.ELFIN)
					satyrCounter++;
				if (faceType == Face.HUMAN)
					satyrCounter++;
				if (countCocksOfType(CockTypesEnum.HUMAN) > 0)
					satyrCounter++;
				if (balls > 0 && ballSize >= 3)
					satyrCounter++;
			}
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				satyrCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && satyrCounter >= 3)
				satyrCounter += 1;
			End("Player","racialScore");
			return satyrCounter;
		}
		
		public function rhinoScore():Number {
			Begin("Player","racialScore","rhino");
			var rhinoCounter:Number = 0;
			if (ears.type == Ears.RHINO)
				rhinoCounter++;
			if (tailType == Tail.RHINO)
				rhinoCounter++;
			if (faceType == Face.RHINO)
				rhinoCounter++;
			if (horns.type == Horns.RHINO)
				rhinoCounter++;
			if (rhinoCounter >= 2 && skinTone == "gray")
				rhinoCounter++;
			if (rhinoCounter >= 2 && hasCock() && countCocksOfType(CockTypesEnum.RHINO) > 0)
				rhinoCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				rhinoCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && rhinoCounter >= 3)
				rhinoCounter += 1;
			
			End("Player","racialScore");
			return rhinoCounter;
		}
		
		public function echidnaScore():Number {
			Begin("Player","racialScore","echidna");
			var echidnaCounter:Number = 0;
			if (ears.type == Ears.ECHIDNA)
				echidnaCounter++;
			if (tailType == Tail.ECHIDNA)
				echidnaCounter++;
			if (faceType == Face.ECHIDNA)
				echidnaCounter++;
			if (tongue.type == Tongue.ECHIDNA)
				echidnaCounter++;
			if (lowerBody == LowerBody.ECHIDNA)
				echidnaCounter++;
			if (echidnaCounter >= 2 && skinType == Skin.FUR)
				echidnaCounter++;
			if (echidnaCounter >= 2 && countCocksOfType(CockTypesEnum.ECHIDNA) > 0)
				echidnaCounter++;
			
			End("Player","racialScore");
			return echidnaCounter;
		}
		
		public function deerScore():Number {
			Begin("Player","racialScore","deer");
			var deerCounter:Number = 0;
			if (ears.type == Ears.DEER)
				deerCounter++;
			if (tailType == Tail.DEER)
				deerCounter++;
			if (faceType == Face.DEER)
				deerCounter++;
			if (lowerBody == LowerBody.CLOVEN_HOOFED || lowerBody == LowerBody.DEERTAUR)
				deerCounter++;
			if (horns.type == Horns.ANTLERS && horns.count >= 4)
				deerCounter++;
			if (deerCounter >= 2 && skinType == Skin.FUR)
				deerCounter++;
			if (deerCounter >= 3 && countCocksOfType(CockTypesEnum.HORSE) > 0)
				deerCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && deerCounter >= 3)
				deerCounter += 1;
			
			End("Player","racialScore");
			return deerCounter;
		}
		
		//Dragonne
		public function dragonneScore():Number {
			Begin("Player","racialScore","dragonne");
			var dragonneCounter:Number = 0;
			if (faceType == Face.CAT)
				dragonneCounter++;
			if (ears.type == Ears.CAT)
				dragonneCounter++;
			if (tailType == Tail.CAT)
				dragonneCounter++;
			if (tongue.type == Tongue.DRACONIC)
				dragonneCounter++;
			if (wings.type == Wings.DRACONIC_LARGE)
				dragonneCounter += 2;
			if (wings.type == Wings.DRACONIC_SMALL)
				dragonneCounter++;
			if (lowerBody == LowerBody.CAT)
				dragonneCounter++;
			if (skinType == Skin.SCALES && dragonneCounter > 0)
				dragonneCounter++;
			
			End("Player","racialScore");
			return dragonneCounter;
		}
		
		//Manticore
		public function manticoreScore():Number {
			Begin("Player","racialScore","manticore");
			var manticoreCounter:Number = 0;
			if (faceType == Face.MANTICORE)
				manticoreCounter++;
			if (eyes.type == Eyes.MANTICORE)
				manticoreCounter++;
			if (ears.type == Ears.LION)
				manticoreCounter++;
			if (tailType == Tail.MANTICORE_PUSSYTAIL)
				manticoreCounter += 2;
			if (rearBody.type == RearBody.LION_MANE)
				manticoreCounter++;
			if (arms.type == Arms.LION)
				manticoreCounter++;
			if (lowerBody == LowerBody.LION)
				manticoreCounter++;
			if (tongue.type == Tongue.CAT)
				manticoreCounter++;
			if (wings.type == Wings.MANTICORE_LIKE_SMALL)
				manticoreCounter++;
			if (wings.type == Wings.MANTICORE_LIKE_LARGE)
				manticoreCounter += 2;
			if (!hasCock())
				manticoreCounter++;
			if (cocks.length > 0)
				manticoreCounter -= 3;
			if (hasPerk(PerkLib.ManticoreMetabolism))
				manticoreCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && manticoreCounter >= 3)
				manticoreCounter += 1;
			if (hasPerk(PerkLib.ChimericalBodyAdvancedStage) && hasPerk(PerkLib.ManticoreMetabolism))
				manticoreCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage) && hasPerk(PerkLib.ManticoreMetabolism) && manticoreCounter >= 6)
				manticoreCounter += 1;
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage) && hasPerk(PerkLib.ManticoreMetabolism) && manticoreCounter >= 7)
				manticoreCounter += 1;
			End("Player","racialScore");
			return manticoreCounter;
		}
		
		//Manticore
		public function redpandaScore():Number {
			Begin("Player","racialScore","redpanda");
			var redpandaCounter:Number = 0;
			if (faceType == Face.RED_PANDA)
				redpandaCounter += 2;
			if (ears.type == Ears.RED_PANDA)
				redpandaCounter++;
			if (tailType == Tail.RED_PANDA)
				redpandaCounter++;
			if (arms.type == Arms.RED_PANDA)
				redpandaCounter++;
			if (lowerBody == LowerBody.RED_PANDA)
				redpandaCounter++;
			if (hasPerk(PerkLib.AscensionHybridTheory) && redpandaCounter >= 3)
				redpandaCounter += 1;
			if (redpandaCounter >= 2 && skin.base.pattern == Skin.PATTERN_RED_PANDA_UNDERBODY)
				redpandaCounter++;
			if (redpandaCounter >= 2 && skinType == Skin.FUR)
				redpandaCounter++;
			End("Player","racialScore");
			return redpandaCounter;
		}
		
		//Determine Horse Rating
		public function avianScore():Number {
			Begin("Player","racialScore","avian");
			var avianCounter:Number = 0;
			if (hairType == Hair.FEATHER)
				avianCounter++;
			if (faceType == Face.AVIAN)
				avianCounter++;
			if (ears.type == Ears.AVIAN)
				avianCounter++;
			if (tailType == Tail.AVIAN)
				avianCounter++;
			if (arms.type == Arms.AVIAN)
				avianCounter++;
			if (lowerBody == LowerBody.AVIAN)
				avianCounter++;
			if (wings.type == Wings.FEATHERED_AVIAN)
				avianCounter += 2;
			if (hasCoatOfType(Skin.FEATHER))
				avianCounter++;
			if (avianCocks() > 0)
				avianCounter++;
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage))
				avianCounter += 10;
			if (hasPerk(PerkLib.AscensionHybridTheory) && avianCounter >= 3)
				avianCounter += 1;
			
			End("Player","racialScore");
			return avianCounter;
		}
		
		//Gargoyle
		public function gargoyleScore():Number {
			Begin("Player","racialScore","gargoyle");
			var gargoyleCounter:Number = 0;
			if (hairColor == "light grey" || hairColor == "quartz white")
				gargoyleCounter++;
			if (skinTone == "light grey" || skinTone == "quartz white")
				gargoyleCounter++;
			if (hairType == Hair.NORMAL)
				gargoyleCounter++;
			if (skinType == Skin.STONE)
				gargoyleCounter++;
			if (horns.type == Horns.GARGOYLE)
				gargoyleCounter++;
			if (eyes.type == Eyes.GEMSTONES)
				gargoyleCounter++;
			if (ears.type == Ears.ELFIN)
				gargoyleCounter++;
			if (faceType == Face.DEVIL_FANGS)
				gargoyleCounter++;
			if (tongue.type == Tongue.DEMONIC)
				gargoyleCounter++;
			if (arms.type == Arms.GARGOYLE || arms.type == Arms.GARGOYLE_2)
				gargoyleCounter++;
			if (tailType == Tail.GARGOYLE || tailType == Tail.GARGOYLE_2)
				gargoyleCounter++;
			if (lowerBody == LowerBody.GARGOYLE || lowerBody == LowerBody.GARGOYLE_2)
				gargoyleCounter++;
			if (hasPerk(PerkLib.GargoylePure) || hasPerk(PerkLib.GargoyleCorrupted))
				gargoyleCounter++;
			if (hasPerk(PerkLib.TransformationImmunity))
				gargoyleCounter += 4;
			if (wings.type == Wings.GARGOYLE_LIKE_LARGE)
				gargoyleCounter += 4;
			
			End("Player","racialScore");
			return gargoyleCounter;
		}
		//Bat
		public function batScore():int{
            Begin("Player","racialScore","bat");
			var counter:int = 0;
			if(ears.type == Ears.BAT){ counter++;}
			else if(ears.type == Ears.ELFIN){ counter -= 10;}
			if(wings.type == Wings.BAT_ARM) {counter += 5;}
			if(lowerBody == LowerBody.HUMAN) {counter++;}
			if(faceType == Face.VAMPIRE){counter +=2;}
			if(eyes.type == Eyes.VAMPIRE){counter++;}
			if(rearBody.type == RearBody.BAT_COLLAR){counter++;}
            End("Player","racialScore");
			return counter < 0? 0:counter;
		}
		//Vampire
		public function vampireScore():int{
            Begin("Player","racialScore","vampire");
            var counter:int = 0;
            if(ears.type == Ears.BAT){ counter-=10;}
            else if(ears.type == Ears.VAMPIRE){ counter++;}
			if(wings.type == Wings.VAMPIRE){counter += 4;}
            if(lowerBody == LowerBody.HUMAN) {counter++;}
			if(arms.type == Arms.HUMAN){counter++;}
            if(faceType == Face.VAMPIRE){counter +=2;}
			if(eyes.type == Eyes.VAMPIRE){counter++;}
            End("Player","racialScore");
			return counter < 0? 0:counter;
		}

		//TODO: (logosK) elderSlime, succubus pussy/demonic eyes, arachne, wasp, lactabovine/slut, sleipnir, hellhound, ryu, quetzalcoatl, eredar, anihilan, 

		
		public function maxPrestigeJobs():Number
		{
			var prestigeJobs:Number = 1;
			if (hasPerk(PerkLib.PrestigeJobArcaneArcher))
				prestigeJobs--;
			if (hasPerk(PerkLib.PrestigeJobBerserker))
				prestigeJobs--;
			if (hasPerk(PerkLib.PrestigeJobSeer))
				prestigeJobs--;
			if (hasPerk(PerkLib.PrestigeJobSentinel))
				prestigeJobs--;
			if (hasPerk(PerkLib.PrestigeJobSoulArcher))
				prestigeJobs--;
			if (hasPerk(PerkLib.PrestigeJobSoulArtMaster))
				prestigeJobs--;
			if (hasPerk(PerkLib.DeityJobMunchkin))
				prestigeJobs++;
		//	if (hasPerk(PerkLib.TrachealSystemEvolved))
		//		prestigeJobs++;
		//	if (hasPerk(PerkLib.TrachealSystemEvolved))
		//		prestigeJobs++;
			return prestigeJobs;
		}

		public function lactationQ():Number
		{
			if (biggestLactation() < 1)
				return 0;
			//(Milk production TOTAL= breastSize x 10 * lactationMultiplier * breast total * milking-endurance (1- default, maxes at 2.  Builds over time as milking as done)
			//(Small – 0.01 mLs – Size 1 + 1 Multi)
			//(Large – 0.8 - Size 10 + 4 Multi)
			//(HUGE – 2.4 - Size 12 + 5 Multi + 4 tits)
			var total:Number;
			if (!hasStatusEffect(StatusEffects.LactationEndurance))
				createStatusEffect(StatusEffects.LactationEndurance, 1, 0, 0, 0);
			total = biggestTitSize() * 10 * averageLactation() * statusEffectv1(StatusEffects.LactationEndurance) * totalBreasts();
			if (hasPerk(PerkLib.MilkMaid))
				total += 200 + (perkv1(PerkLib.MilkMaid) * 100);
			if (hasPerk(PerkLib.ProductivityDrugs))
				total += (perkv4(PerkLib.ProductivityDrugs));
			if (statusEffectv1(StatusEffects.LactationReduction) >= 48)
				total = total * 1.5;
			if (total > int.MAX_VALUE)
				total = int.MAX_VALUE;
			return total;
		}
		
		public function isLactating():Boolean
		{
			return lactationQ() > 0;

		}

		public function cuntChange(cArea:Number, display:Boolean, spacingsF:Boolean = false, spacingsB:Boolean = true):Boolean {
			if (vaginas.length==0) return false;
			var wasVirgin:Boolean = vaginas[0].virgin;
			var stretched:Boolean = cuntChangeNoDisplay(cArea);
			var devirgined:Boolean = wasVirgin && !vaginas[0].virgin;
			if (devirgined){
				if(spacingsF) outputText("  ");
				outputText("<b>Your hymen is torn, robbing you of your virginity.</b>");
				if(spacingsB) outputText("  ");
			}
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(display && stretched) {
				//Virgins get different formatting
				if(devirgined) {
					//If no spaces after virgin loss
					if(!spacingsB) outputText("  ");
				}
				//Non virgins as usual
				else if(spacingsF) outputText("  ");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR) outputText("<b>Your " + Appearance.vaginaDescript(this,0)+ " is stretched painfully wide, large enough to accommodate most beasts and demons.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched so wide that it gapes continually.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " painfully stretches, the lips now wide enough to gape slightly.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now very loose.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now a little loose.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched out to a more normal size.</b>");
				if(spacingsB) outputText("  ");
			}
			return stretched;
		}

		public function buttChange(cArea:Number, display:Boolean, spacingsF:Boolean = true, spacingsB:Boolean = true):Boolean
		{
			var stretched:Boolean = buttChangeNoDisplay(cArea);
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(stretched && display) {
				if (spacingsF) outputText("  ");
				buttChangeDisplay();
				if (spacingsB) outputText("  ");
			}
			return stretched;
		}

		/**
		 * Refills player's hunger. 'amnt' is how much to refill, 'nl' determines if new line should be added before the notification.
		 * @param	amnt
		 * @param	nl
		 */
		public function refillHunger(amnt:Number = 0, nl:Boolean = true):void {
			if ((flags[kFLAGS.HUNGER_ENABLED] > 0 || flags[kFLAGS.IN_PRISON] > 0) && !isGargoyle())
			{
				
				var oldHunger:Number = hunger;
				var weightChange:int = 0;
				
				hunger += amnt;
				if (hunger > maxHunger())
				{
					while (hunger > (maxHunger() + 10) && !SceneLib.prison.inPrison) {
						weightChange++;
						hunger -= 10;
					}
					modThickness(100, weightChange);
					hunger = maxHunger();
				}
				if (hunger > oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatUp('hunger');
				//game.dynStats("lus", 0, "scale", false);
				if (nl) outputText("\n");
				//Messages
				if (hunger < maxHunger() * 0.1) outputText("<b>You still need to eat more. </b>");
				else if (hunger >= maxHunger() * 0.1 && hunger < maxHunger() * 0.25) outputText("<b>You are no longer starving but you still need to eat more. </b>");
				else if (hunger >= maxHunger() * 0.25 && hunger < maxHunger() * 0.5) outputText("<b>The growling sound in your stomach seems to quiet down. </b>");
				else if (hunger >= maxHunger() * 0.5 && hunger < maxHunger() * 0.75) outputText("<b>Your stomach no longer growls. </b>");
				else if (hunger >= maxHunger() * 0.75 && hunger < maxHunger() * 0.9) outputText("<b>You feel so satisfied. </b>");
				else if (hunger >= maxHunger() * 0.9) outputText("<b>Your stomach feels so full. </b>");
				if (weightChange > 0) outputText("<b>You feel like you've put on some weight. </b>");
				EngineCore.awardAchievement("Tastes Like Chicken ", kACHIEVEMENTS.REALISTIC_TASTES_LIKE_CHICKEN);
				if (oldHunger < 1 && hunger >= 100) EngineCore.awardAchievement("Champion Needs Food Badly ", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD);
				if (oldHunger >= 90) EngineCore.awardAchievement("Glutton ", kACHIEVEMENTS.REALISTIC_GLUTTON);
				if (hunger > oldHunger) CoC.instance.mainView.statsView.showStatUp("hunger");
				dynStats("lus", 0, "scale", false);
				EngineCore.statScreenRefresh();
			}
		}
		public function refillGargoyleHunger(amnt:Number = 0, nl:Boolean = true):void {
			var oldHunger:Number = hunger;
			hunger += amnt;
			if (hunger > maxHunger()) hunger = maxHunger();
			if (hunger > oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatUp('hunger');
			//game.dynStats("lus", 0, "scale", false);
			if (nl) outputText("\n");
			if (hunger > oldHunger) CoC.instance.mainView.statsView.showStatUp("hunger");
			dynStats("lus", 0, "scale", false);
			EngineCore.statScreenRefresh();
		}
		
		/**
		 * Damages player's hunger. 'amnt' is how much to deduct.
		 * @param	amnt
		 */
		public function damageHunger(amnt:Number = 0):void {
			var oldHunger:Number = hunger;
			hunger -= amnt;
			if (hunger < 0) hunger = 0;
			if (hunger < oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatDown('hunger');
			dynStats("lus", 0, "scale", false);
		}
		
		public function corruptionTolerance():int {
			var temp:int = perkv1(PerkLib.AscensionTolerance) * 5;
			if (flags[kFLAGS.MEANINGLESS_CORRUPTION] > 0) temp += 100;
			return temp;
		}
		
		public function newGamePlusMod():int {
			var temp:int = flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			//Constrains value between 0 and 5.
			if (temp < 0) temp = 0;
			if (temp > 5) temp = 5;
			return temp;
		}
		
		public function buttChangeDisplay():void
		{	//Allows the test for stretching and the text output to be separated
			if (ass.analLooseness == 5) outputText("<b>Your " + Appearance.assholeDescript(this) + " is stretched even wider, capable of taking even the largest of demons and beasts.</b>");
			if (ass.analLooseness == 4) outputText("<b>Your " + Appearance.assholeDescript(this) + " becomes so stretched that it gapes continually.</b>");
			if (ass.analLooseness == 3) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now very loose.</b>");
			if (ass.analLooseness == 2) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now a little loose.</b>");
			if (ass.analLooseness == 1) outputText("<b>You have lost your anal virginity.</b>");
		}

		public function slimeFeed():void{
			if (hasStatusEffect(StatusEffects.SlimeCraving)) {
				//Reset craving value
				changeStatusValue(StatusEffects.SlimeCraving,1,0);
				//Flag to display feed update and restore stats in event parser
				if(!hasStatusEffect(StatusEffects.SlimeCravingFeed)) {
					createStatusEffect(StatusEffects.SlimeCravingFeed,0,0,0,0);
				}
			}
			if (hasPerk(PerkLib.Diapause)) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228] += 3 + rand(3);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] = 1;
			}
			if (isGargoyle() && hasPerk(PerkLib.GargoyleCorrupted)) refillGargoyleHunger(30);
		}

		public function minoCumAddiction(raw:Number = 10):void {
			//Increment minotaur cum intake count
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340]++;
			//Fix if variables go out of range.
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;

			//Turn off withdrawal
			//if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 1;
			//Reset counter
			flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] = 0;
			//If highly addicted, rises slower
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 60) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 80) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 90) raw /= 2;
			if(hasPerk(PerkLib.MinotaurCumResistance) || hasPerk(PerkLib.ManticoreCumAddict)) raw *= 0;
			//If in withdrawl, readdiction is potent!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) raw += 10;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) raw += 5;
			raw = Math.round(raw * 100)/100;
			//PUT SOME CAPS ON DAT' SHIT
			if(raw > 50) raw = 50;
			if(raw < -50) raw = -50;
			if(!hasPerk(PerkLib.ManticoreCumAddict)) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] += raw;
			//Recheck to make sure shit didn't break
			if(hasPerk(PerkLib.MinotaurCumResistance)) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0; //Never get addicted!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;

		}

		public function hasSpells():Boolean
		{
			return spellCount()>0;
		}

		public function spellCount():Number
		{
			return [StatusEffects.KnowsArouse,StatusEffects.KnowsHeal,StatusEffects.KnowsMight,StatusEffects.KnowsCharge,StatusEffects.KnowsBlind,StatusEffects.KnowsWhitefire,StatusEffects.KnowsChargeA,StatusEffects.KnowsBlink,StatusEffects.KnowsBlizzard,StatusEffects.KnowsIceSpike,StatusEffects.KnowsLightningBolt,StatusEffects.KnowsDarknessShard,StatusEffects.KnowsFireStorm,StatusEffects.KnowsIceRain]
					.filter(function(item:StatusEffectType, index:int, array:Array):Boolean{
						return this.hasStatusEffect(item);},this)
					.length;
		}

		public function armorDescript(nakedText:String = "gear"):String
		{
			var textArray:Array = [];
			var text:String = "";
			//if (armor != ArmorLib.NOTHING) text += armorName;
			//Join text.
			if (armor != ArmorLib.NOTHING) textArray.push(armor.name);
			if (upperGarment != UndergarmentLib.NOTHING) textArray.push(upperGarmentName);
			if (lowerGarment != UndergarmentLib.NOTHING) textArray.push(lowerGarmentName);
			if (textArray.length > 0) text = formatStringArray(textArray);
			//Naked?
			if (upperGarment == UndergarmentLib.NOTHING && lowerGarment == UndergarmentLib.NOTHING && armor == ArmorLib.NOTHING) text = nakedText;
			return text;
		}
		
		public function clothedOrNaked(clothedText:String, nakedText:String = ""):String
		{
			return (armorDescript() != "gear" ? clothedText : nakedText);
		}
		
		public function clothedOrNakedLower(clothedText:String, nakedText:String = ""):String
		{
			return (armorName != "gear" && (armorName != "lethicite armor" && lowerGarmentName == "nothing") && !isTaur() ? clothedText : nakedText);
		}
		
		public function addToWornClothesArray(armor:Armor):void {
			for (var i:int = 0; i < previouslyWornClothes.length; i++) {
				if (previouslyWornClothes[i] == armor.shortName) return; //Already have?
			}
			previouslyWornClothes.push(armor.shortName);
		}
		
		public function shrinkTits(ignore_hyper_happy:Boolean=false):void
		{
			if (flags[kFLAGS.HYPER_HAPPY] && !ignore_hyper_happy)
			{
				return;
			}
			if(breastRows.length == 1) {
				if(breastRows[0].breastRating > 0) {
					//Shrink if bigger than N/A cups
					var temp:Number;
					temp = 1;
					breastRows[0].breastRating--;
					//Shrink again 50% chance
					if(breastRows[0].breastRating >= 1 && rand(2) == 0 && !hasPerk(PerkLib.BigTits)) {
						temp++;
						breastRows[0].breastRating--;
					}
					if(breastRows[0].breastRating < 0) breastRows[0].breastRating = 0;
					//Talk about shrinkage
					if(temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your breasts have shrunk!  With a quick measure, you determine they're now " + breastCup(0) + "s.");
					if(temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are much smaller!  With a quick measure, you determine they're now " + breastCup(0) + "s.");
				}
			}
			else if(breastRows.length > 1) {
				//multiple
				outputText("\n");
				//temp2 = amount changed
				//temp3 = counter
				var temp2:Number = 0;
				var temp3:Number = breastRows.length;
				while(temp3 > 0) {
					temp3--;
					if(breastRows[temp3].breastRating > 0) {
						breastRows[temp3].breastRating--;
						if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
						temp2++;
						outputText("\n");
						if(temp3 < breastRows.length - 1) outputText("...and y");
						else outputText("Y");
						outputText("our " + breastDescript(temp3) + " shrink, dropping to " + breastCup(temp3) + "s.");
					}
					if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
				}
				if(temp2 == 2) outputText("\nYou feel so much lighter after the change.");
				if(temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.");
				if(temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
			}
		}

		public function growTits(amount:Number, rowsGrown:Number, display:Boolean, growthType:Number):void
		{
			if(breastRows.length == 0) return;
			//GrowthType 1 = smallest grows
			//GrowthType 2 = Top Row working downward
			//GrowthType 3 = Only top row
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Chance for "big tits" perked characters to grow larger!
			if(hasPerk(PerkLib.BigTits) && rand(3) == 0 && amount < 1) amount=1;

			// Needs to be a number, since uint will round down to 0 prevent growth beyond a certain point
			var temp:Number = breastRows.length;
			if(growthType == 1) {
				//Select smallest breast, grow it, move on
				while(rowsGrown > 0) {
					//Temp = counter
					temp = breastRows.length;
					//Temp2 = smallest tits index
					temp2 = 0;
					//Find smallest row
					while(temp > 0) {
						temp--;
						if(breastRows[temp].breastRating < breastRows[temp2].breastRating) temp2 = temp;
					}
					//Temp 3 tracks total amount grown
					temp3 += amount;
					trace("Breastrow chosen for growth: " + String(temp2) + ".");
					//Reuse temp to store growth amount for diminishing returns.
					temp = amount;
					if (!flags[kFLAGS.HYPER_HAPPY])
					{
						//Diminishing returns!
						if(breastRows[temp2].breastRating > 3)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=1.5;
							else
								temp /=1.3;
						}

						// WHy are there three options here. They all have the same result.
						if(breastRows[temp2].breastRating > 7)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 9)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 12)
						{
							if(!hasPerk(PerkLib.BigTits))
								temp /=2;
							else
								temp  /=1.5;
						}
					}

					//Grow!
					trace("Growing breasts by ", temp);
					breastRows[temp2].breastRating += temp;
					rowsGrown--;
				}
			}

			if (!flags[kFLAGS.HYPER_HAPPY])
			{
				//Diminishing returns!
				if(breastRows[0].breastRating > 3) {
					if(!hasPerk(PerkLib.BigTits)) amount/=1.5;
					else amount/=1.3;
				}
				if(breastRows[0].breastRating > 7) {
					if(!hasPerk(PerkLib.BigTits)) amount/=2;
					else amount /= 1.5;
				}
				if(breastRows[0].breastRating > 12) {
					if(!hasPerk(PerkLib.BigTits)) amount/=2;
					else amount /= 1.5;
				}
			}
			/*if(breastRows[0].breastRating > 12) {
				if(hasPerk("Big Tits") < 0) amount/=2;
				else amount /= 1.5;
			}*/
			if(growthType == 2) {
				temp = 0;
				//Start at top and keep growing down, back to top if hit bottom before done.
				while(rowsGrown > 0) {
					if(temp+1 > breastRows.length) temp = 0;
					breastRows[temp].breastRating += amount;
					trace("Breasts increased by " + amount + " on row " + temp);
					temp++;
					temp3 += amount;
					rowsGrown--;
				}
			}
			if(growthType == 3) {
				while(rowsGrown > 0) {
					rowsGrown--;
					breastRows[0].breastRating += amount;
					temp3 += amount;
				}
			}
			//Breast Growth Finished...talk about changes.
			trace("Growth amount = ", amount);
			if(display) {
				if(growthType < 3) {
					if(amount <= 2)
					{
						if(breastRows.length > 1) outputText("Your rows of " + breastDescript(0) + " jiggle with added weight, growing a bit larger.");
						if(breastRows.length == 1) outputText("Your " + breastDescript(0) + " jiggle with added weight as they expand, growing a bit larger.");
					}
					else if(amount <= 4)
					{
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of " + breastDescript(0) + " expand significantly.");
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.");
					}
					else
					{
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your " + breastDescript(0) + " tingle strongly, growing disturbingly large.");
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.");
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .5;
					}
				}
				else
				{
					if(amount <= 2) {
						if(breastRows.length > 1) outputText("Your top row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.");
						if(breastRows.length == 1) outputText("Your row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.");
					}
					if(amount > 2 && amount <= 4) {
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your top row of " + breastDescript(0) + " expand significantly.");
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.");
					}
					if(amount > 4) {
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your top row of " + breastDescript(0) + " tingle strongly, growing disturbingly large.");
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.");
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .5;
					}
				}
			}
		}

		public override function getAllMinStats():Object {
			var minStr:int = 1;
			var minTou:int = 1;
			var minSpe:int = 1;
			var minInt:int = 1;
			var minWis:int = 1;
			var minLib:int = 0;
			var minSen:int = 10;
			var minCor:int = 0;
			//Minimum Libido
			if (this.gender > 0) minLib = 15;
			else minLib = 10;
	
			if (this.armorName == "lusty maiden's armor") {
				if (minLib < 50) minLib = 50;
			}
			if (minLib < (minLust() * 2 / 3))
			{
				minLib = (minLust() * 2 / 3);
			}
			if (this.jewelryEffectId == JewelryLib.PURITY)
			{
				minLib -= this.jewelryEffectMagnitude;
			}
			if (this.hasPerk(PerkLib.PurityBlessing)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.HistoryReligious) || this.hasPerk(PerkLib.PastLifeReligious)) {
				minLib -= 2;
			}
			if (this.hasPerk(PerkLib.GargoylePure)) {
				minLib = 5;
				minSen = 5;
			}
			if (this.hasPerk(PerkLib.GargoyleCorrupted)) {
				minSen += 15;
			}
			//Factory Perks
			if(this.hasPerk(PerkLib.DemonicLethicite)) {minCor+=10;minLib+=10;}
			if(this.hasPerk(PerkLib.ProductivityDrugs)) {minLib+=this.perkv1(PerkLib.ProductivityDrugs);minCor+=this.perkv2(PerkLib.ProductivityDrugs);}

			//Minimum Sensitivity
			if(this.manticoreScore() >= 6) minSen += 30;
			if(this.manticoreScore() >= 12) minSen += 15;
			if(this.devilkinScore() >= 7) minSen += 10;
			if(this.devilkinScore() >= 10) minSen += 15;
			if(this.devilkinScore() >= 14) minSen += 30;
			if(this.elfScore() >= 5) minSen += 15;
			if(this.elfScore() >= 11) minSen += 15;
			if(this.raijuScore() >= 5) minSen += 25;
			if(this.raijuScore() >= 10) minSen += 25;

			return {
				str:minStr,
				tou:minTou,
				spe:minSpe,
				inte:minInt,
				wis:minWis,
				lib:minLib,
				sens:minSen,
				cor:minCor
			};
		}

		//Determine minimum lust
		public override function minLust():Number
		{
			var min:Number = 0;
			var minCap:Number = maxLust();
			//Bimbo body boosts minimum lust by 40
			if(hasStatusEffect(StatusEffects.BimboChampagne) || hasPerk(PerkLib.BimboBody) || hasPerk(PerkLib.BroBody) || hasPerk(PerkLib.FutaForm)) min += 40;
			//Omnibus' Gift
			if (hasPerk(PerkLib.OmnibusGift)) min += 35;
			//Fera Blessing
			if (hasStatusEffect(StatusEffects.BlessingOfDivineFera)) min += 15;
			//Nymph perk raises to 30
			if(hasPerk(PerkLib.Nymphomania)) min += 30;
			//Oh noes anemone!
			if(hasStatusEffect(StatusEffects.AnemoneArousal)) min += 30;
			//Hot blooded perk raises min lust!
			if(hasPerk(PerkLib.HotBlooded)) min += perkv1(PerkLib.HotBlooded);
			if(hasPerk(PerkLib.LuststickAdapted)) min += 10;
			if(hasStatusEffect(StatusEffects.Infested)) min += 50;
			//Add points for Crimstone
			min += perkv1(PerkLib.PiercedCrimstone);
			//Subtract points for Icestone!
			min -= perkv1(PerkLib.PiercedIcestone);
			min += perkv1(PerkLib.PentUp);
			//Cold blooded perk reduces min lust, to a minimum of 20! Takes effect after piercings. This effectively caps minimum lust at 80.
			if (hasPerk(PerkLib.ColdBlooded)) {
				if (min >= 20) min -= 20;
				else min = 0;
				minCap -= 20;
			}
			//Purity Blessing perk reduce min lust, to a minimum of 10! Takes effect after piercings. This effectively caps minimum lust at 90.
			if (hasPerk(PerkLib.PurityBlessing)) {
				if (min >= 10) min -= 10;
				else min = 0;
				minCap -= 10;
			}
			//Harpy Lipstick status forces minimum lust to be at least 50.
			if(hasStatusEffect(StatusEffects.Luststick)) min += 50;
			//SHOULDRA BOOSTS
			//+20
			if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -168 && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75) {
				min += 20;
				if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -216)
					min += 30;
			}
			//cumOmeter
			if (tailType == Tail.MANTICORE_PUSSYTAIL && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25) {
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 20) min += 10;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 20 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 15) min += 20;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 15 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 10) min += 30;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 10 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 5) min += 40;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 5) min += 50;
			}
			//SPOIDAH BOOSTS
			if(eggs() >= 20) {
				min += 10;
				if(eggs() >= 40) min += 10;
			}
			//Werebeast
			if (hasPerk(PerkLib.Lycanthropy)) min += perkv1(PerkLib.Lycanthropy);
			//Jewelry effects
			if (jewelryEffectId == JewelryLib.MODIFIER_MINIMUM_LUST)
			{
				min += jewelryEffectMagnitude;
				if (min > (minCap - jewelryEffectMagnitude) && jewelryEffectMagnitude < 0)
				{
					minCap += jewelryEffectMagnitude;
				}
			}
			if (armorName == "lusty maiden's armor") min += 30;
			if (armorName == "tentacled bark armor") min += 20;
			//Constrain values
			if (min < 0) min = 0;
			if (min > (maxLust() - 10)) min = (maxLust() - 10);
			if (min > minCap) min = minCap;
			return min;
		}
		
		public override function getAllMaxStats():Object {
			Begin("Player","getAllMaxStats");
			var maxStr:int = 100;
			var maxTou:int = 100;
			var maxSpe:int = 100;
			var maxInt:int = 100;
			var maxWis:int = 100;
			var maxLib:int = 100;
			var maxSen:int = 100;
			var maxCor:int = 100;
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var racialScores:* = Race.AllScoresFor(this);
			
			//Alter max speed if you have oversized parts. (Realistic mode)
			if (flags[kFLAGS.HUNGER_ENABLED] >= 1)
			{
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
				maxSpe -= tempSpeedPenalty;
				if (maxSpe < 50) maxSpe = 50;
			}
			//Perks ahoy
			Begin("Player","getAllMaxStats.perks");
			if (hasPerk(PerkLib.BasiliskResistance) && hasPerk(PerkLib.GorgonsEyes))
			{
				maxSpe -= (5 * newGamePlusMod);
			}
			//Uma's Needlework affects max stats. Takes effect BEFORE racial modifiers and AFTER modifiers from body size.
			//Caps strength from Uma's needlework. 
			if (hasPerk(PerkLib.ChiReflowSpeed))
			{
				if (maxStr > UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP)
				{
					maxStr = UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP;
				}
			}
			//Caps speed from Uma's needlework.
			if (hasPerk(PerkLib.ChiReflowDefense))
			{
				if (maxSpe > UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP)
				{
					maxSpe = UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP;
				}
			}
			End("Player","getAllMaxStats.perks");
			Begin("Player","getAllMaxStats.racial");
			//Alter max stats depending on race (+15 za pkt)
			if (minotaurScore() >= 4) {
				if (minotaurScore() >= 10) {
					maxStr += (120 * newGamePlusMod);
					maxTou += (45 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxInt -= (40 * newGamePlusMod);
					maxLib += (45 * newGamePlusMod);
				}
				else {
					maxStr += (60 * newGamePlusMod);
					maxTou += (10 * newGamePlusMod);
					maxSpe -= (10 * newGamePlusMod);
					maxInt -= (20 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
			}//+20/10-20
			if (cowScore() >= 4) {
				if (cowScore() >= 10) {
					maxStr += (120 * newGamePlusMod);
					maxTou += (45 * newGamePlusMod);
					maxSpe -= (40 * newGamePlusMod);
					maxInt -= (20 * newGamePlusMod);
					maxLib += (45 * newGamePlusMod);
				}
				else {
					maxStr += (60 * newGamePlusMod);
					maxTou += (10 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
			}//+20/10-20
			if (lizardScore() >= 4) {
				if (lizardScore() >= 8) {
					maxTou += (70 * newGamePlusMod);
					maxInt += (50 * newGamePlusMod);
				}
				else {
					maxTou += (40 * newGamePlusMod);
					maxInt += (20 * newGamePlusMod);
				}
			}//+10/10-20
			if (dragonScore() >= 4) {
				if (dragonScore() >= 28) {
				maxStr += (100 * newGamePlusMod);
				maxTou += (100 * newGamePlusMod);
				maxSpe += (40 * newGamePlusMod);
				maxInt += (50 * newGamePlusMod);
				maxWis += (50 * newGamePlusMod);
				maxLib += (20 * newGamePlusMod);
				}//+60
				else if (dragonScore() >= 20 && dragonScore() < 28) {
				maxStr += (95 * newGamePlusMod);
				maxTou += (95 * newGamePlusMod);
				maxSpe += (20 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
				maxWis += (40 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				}
				else if (dragonScore() >= 10 && dragonScore() < 20) {
				maxStr += (50 * newGamePlusMod);
				maxTou += (40 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (20 * newGamePlusMod);
				maxWis += (20 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				}
				else {
				maxStr += (15 * newGamePlusMod);
				maxTou += (15 * newGamePlusMod);
				maxInt += (15 * newGamePlusMod);
				maxWis += (15 * newGamePlusMod);
				}
			}//+60/50-60
			if (jabberwockyScore() >= 4) {
				if (jabberwockyScore() >= 20) {
				maxStr += (95 * newGamePlusMod);
				maxTou += (95 * newGamePlusMod);
				maxSpe += (100 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
				maxWis -= (50 * newGamePlusMod);
				maxLib += (20 * newGamePlusMod);
				}
				else if (jabberwockyScore() >= 10 && jabberwockyScore() < 20) {
				maxStr += (50 * newGamePlusMod);
				maxTou += (40 * newGamePlusMod);
				maxSpe += (50 * newGamePlusMod);
				maxInt += (20 * newGamePlusMod);
				maxWis -= (20 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				}
				else {
				maxStr += (15 * newGamePlusMod);
				maxTou += (15 * newGamePlusMod);
				maxSpe += (30 * newGamePlusMod);
				maxInt += (15 * newGamePlusMod);
				maxWis -= (15 * newGamePlusMod);
				}
			}
			if (dogScore() >= 4) {
				maxSpe += (15 * newGamePlusMod);
				maxInt -= (5 * newGamePlusMod);
			}//+10/10-20
			if (wolfScore() >= 4) {
				if (wolfScore() >= 10) {
					maxStr += (60 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxSpe += (60 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
				else if (wolfScore() >= 7 && hasFur() && coatColor == "glacial white") {
					maxStr += (30 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
				else if (wolfScore() >= 6) {
					maxStr += (30 * newGamePlusMod);
					maxTou += (10 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
				else {
					maxStr += (15 * newGamePlusMod);
					maxSpe += (10 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
			}//+15(60)((70))(((140))) / 10 - 20(50 - 60)((70 - 80))(((130 - 140)))
			if (werewolfScore() >= 6) {
				if (werewolfScore() >= 12) {
					maxStr += (100 * newGamePlusMod);
					maxTou += (40 * newGamePlusMod);
					maxSpe += (60 * newGamePlusMod);
					maxInt -= (20 * newGamePlusMod);
				}
				else {
					maxStr += (50 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
			}
			if (foxScore() >= 4) {
				if (foxScore() >= 7) {
					maxStr -= (30 * newGamePlusMod);
					maxSpe += (80 * newGamePlusMod);
					maxInt += (55 * newGamePlusMod);
				}
				else {
					maxStr -= (5 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
					maxInt += (25 * newGamePlusMod);
				}
			}//+10/10-20
			if (catScore() >= 4) {
				if (catScore() >= 8) {
					if (hasPerk(PerkLib.Flexibility)) maxSpe += (70 * newGamePlusMod);
					else maxSpe += (60 * newGamePlusMod);
					maxLib += (60 * newGamePlusMod);
				}
				else {
					if (hasPerk(PerkLib.Flexibility)) maxSpe += (50 * newGamePlusMod);
					else maxSpe += (40 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}

			}//+10 / 10 - 20


			if (sphinxScore() >= 5) {
				if (sphinxScore() >= 14) {
					if (hasPerk(PerkLib.Flexibility)) maxSpe += (50 * newGamePlusMod);
					else maxSpe += (40 * newGamePlusMod);
					maxStr += (50 * newGamePlusMod);
					maxTou -= (20 * newGamePlusMod);
					maxInt += (100 * newGamePlusMod);
					maxWis += (40 * newGamePlusMod);
				}
			}//+50/-20/+40/+100/+40



			if (nekomataScore() >= 11) {
				if (hasPerk(PerkLib.Flexibility)) maxSpe += (50 * newGamePlusMod);
				else maxSpe += (40 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
				maxWis += (85 * newGamePlusMod);
			}
			if (cheshireScore() >= 11) {
				if (hasPerk(PerkLib.Flexibility)) maxSpe += (70 * newGamePlusMod);
				else maxSpe += (60 * newGamePlusMod);
				maxInt += (80 * newGamePlusMod);
				maxSen += (25 * newGamePlusMod)
			}
			if (bunnyScore() >= 4) {
				maxSpe += (10 * newGamePlusMod);
			}//+10/10-20
			if (raccoonScore() >= 4) {
				maxSpe += (15 * newGamePlusMod);
			}//+15/10-20
			if (horseScore() >= 4) {
				if (horseScore() >= 7) {
					maxSpe += (70 * newGamePlusMod);
					maxTou += (35 * newGamePlusMod);
				}
				else {
					maxSpe += (40 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
				}
			}//+15/10-20
			if (goblinScore() >= 4) {
				maxInt += (20 * newGamePlusMod);
			}//+20/10-20
			if (gooScore() >= 4) {
				if (gooScore() >= 8) {
					maxTou += (80 * newGamePlusMod);
					maxSpe -= (40 * newGamePlusMod);
					maxLib += (80 * newGamePlusMod);
				}
				else {
					maxTou += (40 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxLib += (40 * newGamePlusMod);
				}
			}//+20/10-20
			if (kitsuneScore() >= 5) {
				if (kitsuneScore() >= 12 && tailType == 13 && tailCount == 9) {
					maxStr -= (50 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
					maxInt += (70 * newGamePlusMod);
					maxWis += (100 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
				else {
					maxStr -= (35 * newGamePlusMod);
					maxSpe += (20 * newGamePlusMod);
					maxInt += (30 * newGamePlusMod);
					maxWis += (40 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
			}//+50/50-60
		/*	if (kitshooScore() >= 6) {
				if (tailType == 26) {
					if (tailCount == 1) {
						maxStr -= (2 * newGamePlusMod);
						maxSpe += (2 * newGamePlusMod);
						maxInt += (4 * newGamePlusMod);
					}
					else if (tailCount >= 2 && tailCount < 9) {
						maxStr -= ((tailCount + 1) * newGamePlusMod);
						maxSpe += ((tailCount + 1) * newGamePlusMod);
						maxInt += (((tailCount/2) + 2) * newGamePlusMod);
					}
					else if (tailCount >= 9) {
						maxStr -= (10 * newGamePlusMod);;
						maxSpe += (10 * newGamePlusMod);;
						maxInt += (20 * newGamePlusMod);;
					}
				}
			}
		*/	if (beeScore() >= 5) {
				if (beeScore() >= 9) {
					maxTou += (50 * newGamePlusMod);
					maxSpe += (50 * newGamePlusMod);
					maxInt += (35 * newGamePlusMod);
				}
				else {
					maxTou += (30 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
					maxInt += (15 * newGamePlusMod);
				}
			}//+40/30-40
			if (spiderScore() >= 4) {
				if (spiderScore() >= 7) {
					maxStr -= (20 * newGamePlusMod);
					maxTou += (50 * newGamePlusMod);
					maxInt += (75 * newGamePlusMod);
				}
				else {
					maxStr -= (10 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxInt += (40 * newGamePlusMod);
				}
			}//+10/10-20
			if (kangaScore() >= 4) {
				maxTou += (5 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
			}//+20/10-20
			if (sharkScore() >= 4) {
				if (sharkScore() >= 9 && vaginas.length > 0 && cocks.length > 0) {
					maxStr += (60 * newGamePlusMod);
					maxSpe += (70 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
				else if (sharkScore() >= 8) {
					maxStr += (40 * newGamePlusMod);
					maxSpe += (70 * newGamePlusMod);
					maxLib += (10 * newGamePlusMod);
				}
				else {
					maxStr += (20 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
				}
			}//+10/10-20
			if (harpyScore() >= 4) {
				if (harpyScore() >= 8) {
					maxTou -= (20 * newGamePlusMod);
					maxSpe += (80 * newGamePlusMod);
					maxLib += (60 * newGamePlusMod);
				}
				else {
					maxTou -= (10 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
					maxLib += (30 * newGamePlusMod);
				}
			}//+10/10-20
			if (sirenScore() >= 10) {
				maxStr += (40 * newGamePlusMod);
				maxSpe += (70 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
			}//+20/10-20
			if (orcaScore() >= 6) {
				if (orcaScore() >= 12) {
					maxStr += (70 * newGamePlusMod);
					maxTou += (40 * newGamePlusMod);
					maxSpe += (70 * newGamePlusMod);
				}
				else {
					maxStr += (35 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
					maxSpe += (35 * newGamePlusMod);
				}
			}//+10/10-20
			if (oniScore() >= 6) {
				if (oniScore() >= 12) {
					maxStr += (100 * newGamePlusMod);
					maxTou += (60 * newGamePlusMod);
					maxInt -= (20 * newGamePlusMod);
					maxWis += (40 * newGamePlusMod);
				}
				else {
					maxStr += (50 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
					maxWis += (20 * newGamePlusMod);
				}
			}//+10/10-20
			if (elfScore() >= 5) {
				if (elfScore() >= 11) {
					maxStr -= (10 * newGamePlusMod);
					maxTou -= (15 * newGamePlusMod);
					maxSpe += (80 * newGamePlusMod);
					maxInt += (80 * newGamePlusMod);
					maxWis += (60 * newGamePlusMod);
					maxSen += (30 * newGamePlusMod);
				}
				else {
					maxStr -= (10 * newGamePlusMod);
					maxTou -= (10 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
					maxInt += (40 * newGamePlusMod);
					maxWis += (30 * newGamePlusMod);
					maxSen += (15 * newGamePlusMod);
				}
			}//+10/10-20
			if (raijuScore() >= 5) {
				if (raijuScore() >= 10) {
					maxSpe += (70 * newGamePlusMod);
					maxInt += (50 * newGamePlusMod);
					maxLib += (80 * newGamePlusMod);
					maxSen += (50 * newGamePlusMod);
				}
				else {
					maxSpe += (35 * newGamePlusMod);
					maxInt += (25 * newGamePlusMod);
					maxLib += (40 * newGamePlusMod);
					maxSen += (25 * newGamePlusMod);
				}
			}//+10/10-20
			if (demonScore() >= 5) {
				if (demonScore() >= 11) {
					maxSpe += (30 * newGamePlusMod);
					maxInt += (35 * newGamePlusMod);
					maxLib += (100 * newGamePlusMod);
				}
				else {
					maxSpe += (15 * newGamePlusMod);
					maxInt += (15 * newGamePlusMod);
					maxLib += (45 * newGamePlusMod);
				}
			}//+60/50-60
			if (devilkinScore() >= 7) {
				if (devilkinScore() >= 14) {
					maxSpe += (30 * newGamePlusMod);
					maxInt += (35 * newGamePlusMod);
					maxLib += (100 * newGamePlusMod);
				}
				else if (devilkinScore() >= 11 && devilkinScore() < 14) {
					maxStr += (50 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxInt += (60 * newGamePlusMod);
					maxLib += (75 * newGamePlusMod);
					maxSen += (15 * newGamePlusMod);
				}
				else {
					maxStr += (35 * newGamePlusMod);
					maxSpe -= (10 * newGamePlusMod);
					maxInt += (40 * newGamePlusMod);
					maxLib += (50 * newGamePlusMod);
					maxSen += (10 * newGamePlusMod);
				}
			}//+60/50-60
			if (rhinoScore() >= 4) {
				maxStr += (15 * newGamePlusMod);
				maxTou += (15 * newGamePlusMod);
				maxSpe -= (10 * newGamePlusMod);
				maxInt -= (10 * newGamePlusMod);
			}//+10/10-20
			if (satyrScore() >= 4) {
				maxStr += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
			}//+10/10-20
			if (manticoreScore() >= 6) {
				if (manticoreScore() >= 12) {
					maxSpe += (100 * newGamePlusMod);
					maxInt += (50 * newGamePlusMod);
					maxLib += (60 * newGamePlusMod);
				}
				else {
					maxSpe += (50 * newGamePlusMod);
					maxInt += (25 * newGamePlusMod);
					maxLib += (30 * newGamePlusMod);
				}
			}//+60/50-60
			if (redpandaScore() >= 4) {
				if (redpandaScore() >= 8) {
					maxStr += (15 * newGamePlusMod);
					maxSpe += (75 * newGamePlusMod);
					maxInt += (30 * newGamePlusMod);
				}
				else {
					maxSpe += (45 * newGamePlusMod);
					maxInt += (15 * newGamePlusMod);
				}
			}
			if (mantisScore() >= 6) {
				if (mantisScore() >= 12) {
					maxStr -= (40 * newGamePlusMod);
					maxTou += (60 * newGamePlusMod);
					maxSpe += (140 * newGamePlusMod);
					maxInt += (20 * newGamePlusMod);
				}
				else {
					maxStr -= (20 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxSpe += (70 * newGamePlusMod);
					maxInt += (10 * newGamePlusMod);
				}
			}//+35/30-40
			if (salamanderScore() >= 4) {
				if (salamanderScore() >= 7) {
					maxStr += (25 * newGamePlusMod);
					maxTou += (25 * newGamePlusMod);
					maxLib += (40 * newGamePlusMod);
				}
				else {
					maxStr += (15 * newGamePlusMod);
					maxTou += (15 * newGamePlusMod);
					maxLib += (30 * newGamePlusMod);
				}
			}//+15/10-20
			if (unicornScore() >= 9) {
				maxTou += (20 * newGamePlusMod);
				maxSpe += (40 * newGamePlusMod);
				maxInt += (75 * newGamePlusMod);
			}//+(15)30/(10-20)30-40
			if (alicornScore() >= 11) {
				maxTou += (25 * newGamePlusMod);
				maxSpe += (50 * newGamePlusMod);
				maxInt += (90 * newGamePlusMod);
			}//+(30)55/(30-40)50-60
			if (phoenixScore() >= 10) {
				maxStr += (20 * newGamePlusMod);
				maxTou += (20 * newGamePlusMod);
				maxSpe += (70 * newGamePlusMod);
				maxLib += (40 * newGamePlusMod);
			}//+30/30-40
			if (scyllaScore() >= 4) {
				if (scyllaScore() >= 12) {
					maxStr += (120 * newGamePlusMod);
					maxInt += (60 * newGamePlusMod);
				}
				else if (scyllaScore() >= 7 && scyllaScore() < 12) {
					maxStr += (65 * newGamePlusMod);
					maxInt += (40 * newGamePlusMod);
				}
				else {
					maxStr += (40 * newGamePlusMod);
					maxInt += (20 * newGamePlusMod);
				}
			}//+30/30-40
			if (plantScore() >= 4) {
				if (plantScore() >= 7) {
					maxStr += (25 * newGamePlusMod);
					maxTou += (100 * newGamePlusMod);
					maxSpe -= (50 * newGamePlusMod);
				}
				else if (plantScore() == 6) {
					maxStr += (20 * newGamePlusMod);
					maxTou += (80 * newGamePlusMod);
					maxSpe -= (40 * newGamePlusMod);
				}
				else if (plantScore() == 5) {
					maxStr += (10 * newGamePlusMod);
					maxTou += (50 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
				}
				else {
					maxTou += (30 * newGamePlusMod);
					maxSpe -= (10 * newGamePlusMod);
				}
			}//+20(40)(60)(75)/10-20(30-40)(50-60)(70-80)
			if (alrauneScore() >= 10) {
				maxTou += (100 * newGamePlusMod);
				maxSpe -= (50 * newGamePlusMod);
				maxLib += (100 * newGamePlusMod);
			}
			if (yggdrasilScore() >= 10) {
				maxStr += (50 * newGamePlusMod);
				maxTou += (70 * newGamePlusMod);
				maxSpe -= (50 * newGamePlusMod);
				maxInt += (50 * newGamePlusMod);
				maxWis += (80 * newGamePlusMod);
				maxLib -= (50 * newGamePlusMod);
			}//+150
			if (deerScore() >= 4) {
				maxSpe += (20 * newGamePlusMod);
			}//+20/10-20
			if (yetiScore() >= 6) {
				if (yetiScore() >= 12) {
					maxStr += (60 * newGamePlusMod);
					maxTou += (80 * newGamePlusMod);
					maxSpe += (50 * newGamePlusMod);
					maxInt -= (60 * newGamePlusMod);
					maxLib += (50 * newGamePlusMod);
				}
				else {
					maxStr += (30 * newGamePlusMod);
					maxTou += (40 * newGamePlusMod);
					maxSpe += (25 * newGamePlusMod);
					maxInt -= (30 * newGamePlusMod);
					maxLib += (25 * newGamePlusMod);
				}
			}
			if (couatlScore() >= 11) {
				maxStr += (40 * newGamePlusMod);
				maxTou += (25 * newGamePlusMod);
				maxSpe += (100 * newGamePlusMod);
			}//+30/30-40
			if (vouivreScore() >= 11) {
				maxStr += (10 * newGamePlusMod);
				maxTou -= (10 * newGamePlusMod);
				maxSpe += (35 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis -= (20 * newGamePlusMod);
			}//+30/30-40
			if (gorgonScore() >= 11) {
				maxStr += (50 * newGamePlusMod);
				maxTou += (45 * newGamePlusMod);
				maxSpe += (70 * newGamePlusMod);
			}//+30/30-40
			if (nagaScore() >= 4)
			{
				if (nagaScore() >= 8) {
					maxStr += (40 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
					maxSpe += (60 * newGamePlusMod);
				}
				else {
					maxStr += (20 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
				}
			}
			if (centaurScore() >= 8) {
				maxTou += (80 * newGamePlusMod);
				maxSpe += (40 * newGamePlusMod);
			}//+40/30-40
			if (avianScore() >= 4) {
				if (avianScore() >= 9) {
					maxStr += (30 * newGamePlusMod);
					maxSpe += (75 * newGamePlusMod);
					maxInt += (30 * newGamePlusMod);
				}
				else {
					maxStr += (15 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
					maxInt += (15 * newGamePlusMod);
				}
			}
			if (isNaga()) {
				maxStr += (15 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
			}
			if (isTaur()) {
				maxSpe += (20 * newGamePlusMod);
			}
			if (isDrider()) {
				maxTou += (15 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
			}
			if (isScylla()) {
				maxStr += (30 * newGamePlusMod);
			}
			if (gargoyleScore() >= 21) {
				if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) {
					maxStr += (90 * newGamePlusMod);
					maxTou += (100 * newGamePlusMod);
					maxInt += (70 * newGamePlusMod);
				}
				if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) {
					maxStr += (70 * newGamePlusMod);
					maxTou += (100 * newGamePlusMod);
					maxInt += (90 * newGamePlusMod);
				}
			}
			if (batScore() >= 6){
                var mod:int = batScore() >= 10 ? 35:20;
                maxStr += mod * newGamePlusMod;
                maxSpe += mod * newGamePlusMod;
                maxInt += mod * newGamePlusMod;
                maxLib += (10+mod) * newGamePlusMod;
			}
			if (vampireScore() >= 6){
                mod = vampireScore() >= 10 ? 35:20;
				maxStr += mod * newGamePlusMod;
				maxSpe += mod * newGamePlusMod;
				maxInt += mod * newGamePlusMod;
				maxLib += (10 + mod) * newGamePlusMod;
			}
			if (dragonScore() >= 4) {
				if (dragonScore() >= 20) {
				maxStr += (95 * newGamePlusMod);
				maxTou += (95 * newGamePlusMod);
				maxSpe += (100 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
				maxWis -= (50 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				}
				else if (dragonScore() >= 10 && dragonScore() < 20) {
				maxStr += (50 * newGamePlusMod);
				maxTou += (40 * newGamePlusMod);
				maxSpe += (50 * newGamePlusMod);
				maxInt += (20 * newGamePlusMod);
				maxWis -= (20 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				}
				else {
				maxStr += (15 * newGamePlusMod);
				maxTou += (15 * newGamePlusMod);
				maxSpe += (30 * newGamePlusMod);
				maxInt += (15 * newGamePlusMod);
				maxWis -= (15 * newGamePlusMod);
				}
			}
			if (racialScores[Race.HUMAN.name] == 30) {
				maxStr += (40 * newGamePlusMod);
				maxTou += (40 * newGamePlusMod);
				maxSpe += (40 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
				maxWis += (40 * newGamePlusMod);
				maxLib += (40 * newGamePlusMod);
				maxSen += (40 * newGamePlusMod);
			}
			if (racialScores[Race.HUMAN.name] == 29) {
				maxStr += (30 * newGamePlusMod);
				maxTou += (30 * newGamePlusMod);
				maxSpe += (30 * newGamePlusMod);
				maxInt += (30 * newGamePlusMod);
				maxWis += (30 * newGamePlusMod);
				maxLib += (30 * newGamePlusMod);
				maxSen += (30 * newGamePlusMod);
			}
			if (racialScores[Race.HUMAN.name] == 28) {
				maxStr += (20 * newGamePlusMod);
				maxTou += (20 * newGamePlusMod);
				maxSpe += (20 * newGamePlusMod);
				maxInt += (20 * newGamePlusMod);
				maxWis += (20 * newGamePlusMod);
				maxLib += (20 * newGamePlusMod);
				maxSen += (20 * newGamePlusMod);
			}
			if (racialScores[Race.HUMAN.name] == 27) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				maxSen += (10 * newGamePlusMod);
			}
			if (internalChimeraScore() >= 1) {
				maxStr += (5 * internalChimeraScore() * newGamePlusMod);
				maxTou += (5 * internalChimeraScore() * newGamePlusMod);
				maxSpe += (5 * internalChimeraScore() * newGamePlusMod);
				maxInt += (5 * internalChimeraScore() * newGamePlusMod);
				maxWis += (5 * internalChimeraScore() * newGamePlusMod);
				maxLib += (5 * internalChimeraScore() * newGamePlusMod);
				maxSen += (5 * internalChimeraScore() * newGamePlusMod);
			}
			if (maxStr < 25) maxStr = 25;
			if (maxTou < 25) maxTou = 25;
			if (maxSpe < 25) maxSpe = 25;
			if (maxInt < 25) maxInt = 25;
			if (maxWis < 25) maxWis = 25;
			if (maxLib < 25) maxLib = 25;
			if (maxSen < 25) maxSen = 25;
			End("Player","getAllMaxStats.racial");
			Begin("Player","getAllMaxStats.perks2");
			if (hasPerk(PerkLib.ChimericalBodyInitialStage)) {
				maxTou += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ChimericalBodyBasicStage)) {
				maxStr += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ChimericalBodyAdvancedStage)) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ChimericalBodyPerfectStage)) {
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ChimericalBodyUltimateStage)) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.SalamanderAdrenalGlands)) {
				maxTou += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.SalamanderAdrenalGlandsEvolved)) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ScyllaInkGlands)) {
				maxStr += (10 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.MantislikeAgility)) {
				if (hasCoatOfType(Skin.CHITIN) && hasPerk(PerkLib.ThickSkin)) maxSpe += (20 * newGamePlusMod);
				if ((skinType == Skin.SCALES && hasPerk(PerkLib.ThickSkin)) || hasCoatOfType(Skin.CHITIN)) maxSpe += (15 * newGamePlusMod);
				if (skinType == Skin.SCALES) maxSpe += (10 * newGamePlusMod);
				if (hasPerk(PerkLib.ThickSkin)) maxSpe += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.MantislikeAgilityEvolved)) {
				if (hasCoatOfType(Skin.CHITIN) && hasPerk(PerkLib.ThickSkin)) maxSpe += (20 * newGamePlusMod);
				if ((skinType == Skin.SCALES && hasPerk(PerkLib.ThickSkin)) || hasCoatOfType(Skin.CHITIN)) maxSpe += (15 * newGamePlusMod);
				if (skinType == Skin.SCALES) maxSpe += (10 * newGamePlusMod);
				if (hasPerk(PerkLib.ThickSkin)) maxSpe += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.DraconicLungs)) {
				maxSpe += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.DraconicLungsEvolved)) {
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.KitsuneThyroidGland)) {
				maxSpe += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.KitsuneThyroidGlandEvolved)) {
				maxSpe += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.CatlikeNimblenessEvolved)) {
				maxSpe += (10 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.GargoylePure)) {
				maxWis += (80 * newGamePlusMod);
				maxLib -= (10 * newGamePlusMod);
				maxSen -= (10 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.GargoyleCorrupted)) {
				maxWis -= (10 * newGamePlusMod);
				maxLib += (80 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.EzekielBlessing)) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
				maxSen += (5 * newGamePlusMod);
			}
			//Perks
			if (hasPerk(PerkLib.JobAllRounder)) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (6 * newGamePlusMod);
				maxSen += (6 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.JobSwordsman)) maxStr += (10 * newGamePlusMod);
			if (hasPerk(PerkLib.JobBeastWarrior)) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				if (hasPerk(PerkLib.ImprovingNaturesBlueprintsApexPredator)) {
					maxInt += (5 * newGamePlusMod);
					maxWis += (5 * newGamePlusMod);
				}
				else {
					maxInt -= (5 * newGamePlusMod);
					maxWis -= (5 * newGamePlusMod);
				}
			}
			if (hasPerk(PerkLib.JobCourtesan)) maxLib += (15 * newGamePlusMod);
			if (hasPerk(PerkLib.JobBrawler)) maxStr += (10 * newGamePlusMod);
			if (hasPerk(PerkLib.JobDervish)) maxSpe += (10 * newGamePlusMod);
			if (hasPerk(PerkLib.JobDefender)) maxTou += (15 * newGamePlusMod);
			if (hasPerk(PerkLib.JobElementalConjurer)) maxWis += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.JobEnchanter)) maxInt += (15 * newGamePlusMod);
			if (hasPerk(PerkLib.JobEromancer)) {
				maxInt += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.JobGuardian)) maxTou += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.JobHealer)) {
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.JobHunter)) {
				maxSpe += (10 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.JobKnight)) maxTou += (10 * newGamePlusMod);
			if (hasPerk(PerkLib.JobMonk)) maxWis += (15 * newGamePlusMod);
			if (hasPerk(PerkLib.JobRanger)) maxSpe += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.JobSeducer)) maxLib += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.JobSorcerer)) maxInt += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.JobSoulCultivator)) maxWis += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.JobWarlord)) maxTou += (20 * newGamePlusMod);
			if (hasPerk(PerkLib.JobWarrior)) maxStr += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.PrestigeJobArcaneArcher)) {
				maxSpe += (40 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.PrestigeJobBerserker)) {
				maxStr += (60 * newGamePlusMod);
				maxTou += (20 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.PrestigeJobSeer)) {
				maxInt += (60 * newGamePlusMod);
				maxWis += (20 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.PrestigeJobSentinel)) {
				maxStr += (20 * newGamePlusMod);
				maxTou += (60 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.PrestigeJobSoulArcher)) {
				maxSpe += (40 * newGamePlusMod);
				maxWis += (40 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.PrestigeJobSoulArtMaster)) {
				maxStr += (40 * newGamePlusMod);
				maxWis += (40 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.DeityJobMunchkin)) {
				maxStr += (25 * newGamePlusMod);
				maxTou += (25 * newGamePlusMod);
				maxSpe += (25 * newGamePlusMod);
				maxInt += (25 * newGamePlusMod);
				maxWis += (25 * newGamePlusMod);
				maxLib += (15 * newGamePlusMod);
				maxSen += (15 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.WeaponMastery)) maxStr += (5 * newGamePlusMod);
			if (hasPerk(PerkLib.WeaponGrandMastery)) maxStr += (10 * newGamePlusMod);
			if (hasPerk(PerkLib.ElementalConjurerResolve)) {
				if (!hasPerk(PerkLib.ElementalConjurerMindAndBodyResolve)) {
					maxStr -= (15 * newGamePlusMod);
					maxTou -= (15 * newGamePlusMod);
					maxSpe -= (15 * newGamePlusMod);
				}
				maxInt += (20 * newGamePlusMod);
				maxWis += (30 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ElementalConjurerDedication)) {
				if (!hasPerk(PerkLib.ElementalConjurerMindAndBodyDedication)) {
					maxStr -= (30 * newGamePlusMod);
					maxTou -= (30 * newGamePlusMod);
					maxSpe -= (30 * newGamePlusMod);
				}
				maxInt += (40 * newGamePlusMod);
				maxWis += (60 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ElementalConjurerSacrifice)) {
				if (!hasPerk(PerkLib.ElementalConjurerMindAndBodySacrifice)) {
					maxStr -= (45 * newGamePlusMod);
					maxTou -= (45 * newGamePlusMod);
					maxSpe -= (45 * newGamePlusMod);
				}
				maxInt += (60 * newGamePlusMod);
				maxWis += (90 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				maxSen += (10 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) {
				maxStr += (15 * newGamePlusMod);
				maxTou += (15 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
				maxInt += (15 * newGamePlusMod);
				maxWis += (15 * newGamePlusMod);
				maxLib += (15 * newGamePlusMod);
				maxSen += (15 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.SoulApprentice)) maxWis += 5;
			if (hasPerk(PerkLib.SoulPersonage)) maxWis += 5;
			if (hasPerk(PerkLib.SoulWarrior)) maxWis += 5;
			if (hasPerk(PerkLib.SoulSprite)) maxWis += 5;
			if (hasPerk(PerkLib.SoulScholar)) maxWis += 5;
			if (hasPerk(PerkLib.SoulElder)) maxWis += 5;
			if (hasPerk(PerkLib.SoulExalt)) maxWis += 5;
			if (hasPerk(PerkLib.SoulOverlord)) maxWis += 5;
			if (hasPerk(PerkLib.SoulTyrant)) maxWis += 5;
			if (hasPerk(PerkLib.SoulKing)) maxWis += 5;
			if (hasPerk(PerkLib.SoulEmperor)) maxWis += 5;
			if (hasPerk(PerkLib.SoulAncestor)) maxWis += 5;
			if (hasPerk(PerkLib.CarefulButRecklessAimAndShooting) && !hasPerk(PerkLib.ColdAim)) maxTou -= (15 * newGamePlusMod);
			if (hasPerk(PerkLib.Lycanthropy)) {
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) {
					maxStr += (10 * newGamePlusMod);
					maxTou += (10 * newGamePlusMod);
					maxSpe += (10 * newGamePlusMod);
				}
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) {
					maxStr += (20 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
					maxSpe += (20 * newGamePlusMod);
				}
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) {
					maxStr += (30 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
				}
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) {
					maxStr += (40 * newGamePlusMod);
					maxTou += (40 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
				}
			}
			End("Player","getAllMaxStats.perks2");
			Begin("Player","getAllMaxStats.effects");
			//Apply New Game+
			maxStr += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxTou += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxSpe += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxInt += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxWis += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxLib += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxSen += 5 * perkv1(PerkLib.AscensionTranshumanism);
			//Might
			if (hasStatusEffect(StatusEffects.Might)) {
				if (hasStatusEffect(StatusEffects.FortressOfIntellect)) maxInt += statusEffectv1(StatusEffects.Might);
				else maxStr += statusEffectv1(StatusEffects.Might);
				maxTou += statusEffectv2(StatusEffects.Might);
			}
			//Blink
			if (hasStatusEffect(StatusEffects.Blink)) {
				maxSpe += statusEffectv1(StatusEffects.Blink);
			}
			//Dwarf Rage
			if (hasStatusEffect(StatusEffects.DwarfRage)) {
				maxStr += statusEffectv1(StatusEffects.DwarfRage);
				maxTou += statusEffectv2(StatusEffects.DwarfRage);
				maxSpe += statusEffectv2(StatusEffects.DwarfRage);
			}
			//Trance Transformation
			if (hasStatusEffect(StatusEffects.TranceTransformation)) {
				maxStr += statusEffectv1(StatusEffects.TranceTransformation);
				maxTou += statusEffectv1(StatusEffects.TranceTransformation);
			}
			//Crinos Shape
			if (hasStatusEffect(StatusEffects.CrinosShape)) {
				maxStr += statusEffectv1(StatusEffects.CrinosShape);
				maxTou += statusEffectv2(StatusEffects.CrinosShape);
				maxSpe += statusEffectv3(StatusEffects.CrinosShape);
			}
			//
			if (hasStatusEffect(StatusEffects.ShiraOfTheEastFoodBuff2)) {
				if (statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff2) >= 1) maxStr += statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff2);
				maxTou += statusEffectv4(StatusEffects.ShiraOfTheEastFoodBuff2);
				if (statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff2) >= 1) maxSpe += statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff2);
				if (statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff2) >= 1) maxInt += statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff2);
			}
			//Beat of War
			if (hasStatusEffect(StatusEffects.BeatOfWar)) {
				maxStr += statusEffectv1(StatusEffects.BeatOfWar);
			}
			if (hasStatusEffect(StatusEffects.AndysSmoke)) {
				maxSpe -= statusEffectv2(StatusEffects.AndysSmoke);
				maxInt += statusEffectv3(StatusEffects.AndysSmoke);
			}
			if (hasStatusEffect(StatusEffects.FeedingEuphoria)) {
				maxSpe += statusEffectv2(StatusEffects.FeedingEuphoria);
			}
			if (hasStatusEffect(StatusEffects.BlessingOfDivineFenrir)) {
				maxStr += statusEffectv2(StatusEffects.BlessingOfDivineFenrir);
				maxTou += statusEffectv3(StatusEffects.BlessingOfDivineFenrir);
			}
			if (hasStatusEffect(StatusEffects.BlessingOfDivineTaoth)) {
				maxSpe += statusEffectv2(StatusEffects.BlessingOfDivineTaoth);
			}
			var vthirst:VampireThirstEffect = statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
			if (vthirst != null) {
				maxStr += vthirst.currentBoost;
				maxSpe += vthirst.currentBoost;
				maxInt += vthirst.currentBoost;
				maxLib += vthirst.currentBoost;
			}
			if (hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
				maxStr += statusEffectv1(StatusEffects.UnderwaterCombatBoost);
				maxSpe += statusEffectv2(StatusEffects.UnderwaterCombatBoost);
			}
			End("Player","getAllMaxStats.effects");
			End("Player","getAllMaxStats");
			maxStr = Math.max(maxStr,1);
			maxTou = Math.max(maxTou,1);
			maxSpe = Math.max(maxSpe,1);
			maxInt = Math.max(maxInt,1);
			maxWis = Math.max(maxWis,1);
			maxLib = Math.max(maxLib,1);
			maxSen = Math.max(maxSen,1);
			maxCor = Math.max(maxCor,1);
			return {
				str:maxStr,
				tou:maxTou,
				spe:maxSpe,
				inte:maxInt,
				wis:maxWis,
				lib:maxLib,
				sens:maxSen,
				cor:maxCor
			};
		}
		
		public function requiredXP():int {
			var temp:int = level * 100;
			if (temp > 15000) temp = 15000;
			return temp;
		}
		
		public function minotaurAddicted():Boolean {
			return !hasPerk(PerkLib.MinotaurCumResistance) && !hasPerk(PerkLib.ManticoreCumAddict) && (hasPerk(PerkLib.MinotaurCumAddict) || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1);
		}
		public function minotaurNeed():Boolean {
			return !hasPerk(PerkLib.MinotaurCumResistance) && !hasPerk(PerkLib.ManticoreCumAddict) && flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1;
		}

		public function clearStatuses(visibility:Boolean):void
		{
			if (hasStatusEffect(StatusEffects.DriderIncubusVenom))
			{
				str += statusEffectv2(StatusEffects.DriderIncubusVenom);
				removeStatusEffect(StatusEffects.DriderIncubusVenom);
				CoC.instance.mainView.statsView.showStatUp('str');
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.Sandstorm)) CoC.instance.monster.removeStatusEffect(StatusEffects.Sandstorm);
			if(hasStatusEffect(StatusEffects.DwarfRage)) {
				dynStats("str", -statusEffectv1(StatusEffects.DwarfRage),"tou", -statusEffectv2(StatusEffects.DwarfRage),"spe", -statusEffectv2(StatusEffects.DwarfRage), "scale", false);
				removeStatusEffect(StatusEffects.DwarfRage);
			}
			if(hasStatusEffect(StatusEffects.Berzerking)) {
				removeStatusEffect(StatusEffects.Berzerking);
			}
			if(hasStatusEffect(StatusEffects.Lustzerking)) {
				removeStatusEffect(StatusEffects.Lustzerking);
			}
			if(hasStatusEffect(StatusEffects.EverywhereAndNowhere)) {
				removeStatusEffect(StatusEffects.EverywhereAndNowhere);
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				CoC.instance.monster.removeStatusEffect(StatusEffects.TailWhip);
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.TwuWuv)) {
				inte += CoC.instance.monster.statusEffectv1(StatusEffects.TwuWuv);
				EngineCore.statScreenRefresh();
				CoC.instance.mainView.statsView.showStatUp( 'inte' );
			}
			if(hasStatusEffect(StatusEffects.NagaVenom)) {
				spe += statusEffectv1(StatusEffects.NagaVenom);
				CoC.instance.mainView.statsView.showStatUp( 'spe' );
				removeStatusEffect(StatusEffects.NagaVenom);
			}
			if(hasStatusEffect(StatusEffects.MedusaVenom)) {
				str += statusEffectv1(StatusEffects.MedusaVenom);
				tou += statusEffectv2(StatusEffects.MedusaVenom);
				spe += statusEffectv3(StatusEffects.MedusaVenom);
				inte += statusEffectv4(StatusEffects.MedusaVenom);
				CoC.instance.mainView.statsView.showStatUp( 'str' );
				CoC.instance.mainView.statsView.showStatUp( 'tou' );
				CoC.instance.mainView.statsView.showStatUp( 'spe' );
				CoC.instance.mainView.statsView.showStatUp( 'inte' );
				removeStatusEffect(StatusEffects.MedusaVenom);
			}
			if(hasStatusEffect(StatusEffects.Frostbite)) {
				str += statusEffectv1(StatusEffects.Frostbite);
				CoC.instance.mainView.statsView.showStatUp( 'str' );
				removeStatusEffect(StatusEffects.Frostbite);
			}
			if(hasStatusEffect(StatusEffects.Flying)) {
				removeStatusEffect(StatusEffects.Flying);
				if(hasStatusEffect(StatusEffects.FlyingNoStun)) {
					removeStatusEffect(StatusEffects.FlyingNoStun);
					removePerk(PerkLib.Resolute);
				}
			}
			if(hasStatusEffect(StatusEffects.Might)) {
				if (hasStatusEffect(StatusEffects.FortressOfIntellect)) dynStats("int", -statusEffectv1(StatusEffects.Might), "scale", false);
				else dynStats("str", -statusEffectv1(StatusEffects.Might), "scale", false);
				dynStats("tou", -statusEffectv2(StatusEffects.Might), "scale", false);
				removeStatusEffect(StatusEffects.Might);
			}
			if(hasStatusEffect(StatusEffects.Blink)) {
				dynStats("spe", -statusEffectv1(StatusEffects.Blink), "scale", false);
				removeStatusEffect(StatusEffects.Blink);
			}
			if(hasStatusEffect(StatusEffects.BeatOfWar)) {
				dynStats("str", -statusEffectv1(StatusEffects.BeatOfWar), "scale", false);
				removeStatusEffect(StatusEffects.BeatOfWar);
			}
			if(hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
				dynStats("str", -statusEffectv1(StatusEffects.UnderwaterCombatBoost),"spe", -statusEffectv2(StatusEffects.UnderwaterCombatBoost), "scale", false);
				removeStatusEffect(StatusEffects.UnderwaterCombatBoost);
			}
			if(hasStatusEffect(StatusEffects.TranceTransformation)) {
				dynStats("str", -statusEffectv1(StatusEffects.TranceTransformation), "scale", false);
				dynStats("tou", -statusEffectv1(StatusEffects.TranceTransformation), "scale", false);
				removeStatusEffect(StatusEffects.TranceTransformation);
			}
			if(hasStatusEffect(StatusEffects.CrinosShape)) {
				dynStats("str", -statusEffectv1(StatusEffects.CrinosShape), "scale", false);
				dynStats("tou", -statusEffectv2(StatusEffects.CrinosShape), "scale", false);
				dynStats("spe", -statusEffectv3(StatusEffects.CrinosShape), "scale", false);
				removeStatusEffect(StatusEffects.CrinosShape);
			}
			if(hasStatusEffect(StatusEffects.EzekielCurse)) {
				removeStatusEffect(StatusEffects.EzekielCurse);
			}
			if(hasStatusEffect(StatusEffects.DragonBreathCooldown) && hasPerk(PerkLib.DraconicLungsEvolved)) {
				removeStatusEffect(StatusEffects.DragonBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) && hasPerk(PerkLib.DraconicLungs)) {
				removeStatusEffect(StatusEffects.DragonDarknessBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonFireBreathCooldown) && hasPerk(PerkLib.DraconicLungs)) {
				removeStatusEffect(StatusEffects.DragonFireBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonIceBreathCooldown) && hasPerk(PerkLib.DraconicLungs)) {
				removeStatusEffect(StatusEffects.DragonIceBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonLightningBreathCooldown) && hasPerk(PerkLib.DraconicLungs)) {
				removeStatusEffect(StatusEffects.DragonLightningBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.HeroBane)) {
				removeStatusEffect(StatusEffects.HeroBane);
			}
			if(hasStatusEffect(StatusEffects.PlayerRegenerate)) {
				removeStatusEffect(StatusEffects.PlayerRegenerate);
			}
			if(hasStatusEffect(StatusEffects.Disarmed)) {
				removeStatusEffect(StatusEffects.Disarmed);
				if (weapon == WeaponLib.FISTS) {
//					weapon = ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon;
//					(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon).doEffect(this, false);
					setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
				}
				else {
					flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID];
				}
			}
			if (hasStatusEffect(StatusEffects.DriderIncubusVenom))
			{
				str += statusEffectv2(StatusEffects.DriderIncubusVenom);
				removeStatusEffect(StatusEffects.DriderIncubusVenom);
			}
			
			// All CombatStatusEffects are removed here
			for (var a:/*StatusEffectClass*/Array=statusEffects.slice(),n:int=a.length,i:int=0;i<n;i++) {
				// Using a copy of array in case effects are removed/added in handler
				if (statusEffects.indexOf(a[i])>=0) a[i].onCombatEnd();
			}
		}

		public function consumeItem(itype:ItemType, amount:int = 1):Boolean {
			if (!hasItem(itype, amount)) {
				CoC_Settings.error("ERROR: consumeItem attempting to find " + amount + " item" + (amount > 1 ? "s" : "") + " to remove when the player has " + itemCount(itype) + ".");
				return false;
			}
			//From here we can be sure the player has enough of the item in inventory
			var slot:ItemSlotClass;
			while (amount > 0) {
				slot = getLowestSlot(itype); //Always draw from the least filled slots first
				if (slot.quantity > amount) {
					slot.quantity -= amount;
					amount = 0;
				}
				else { //If the slot holds the amount needed then amount will be zero after this
					amount -= slot.quantity;
					slot.emptySlot();
				}
			}
			return true;
/*			
			var consumed:Boolean = false;
			var slot:ItemSlotClass;
			while (amount > 0)
			{
				if(!hasItem(itype,1))
				{
					CoC_Settings.error("ERROR: consumeItem in items.as attempting to find an item to remove when the has none.");
					break;
				}
				trace("FINDING A NEW SLOT! (ITEMS LEFT: " + amount + ")");
				slot = getLowestSlot(itype);
				while (slot != null && amount > 0 && slot.quantity > 0)
				{
					amount--;
					slot.quantity--;
					if(slot.quantity == 0) slot.emptySlot();
					trace("EATIN' AN ITEM");
				}
				//If on slot 5 and it doesn't have any more to take, break out!
				if(slot == undefined) amount = -1

			}
			if(amount == 0) consumed = true;
			return consumed;
*/
		}

		public function getLowestSlot(itype:ItemType):ItemSlotClass
		{
			var minslot:ItemSlotClass = null;
			for each (var slot:ItemSlotClass in itemSlots) {
				if (slot.itype == itype) {
					if (minslot == null || slot.quantity < minslot.quantity) {
						minslot = slot;
					}
				}
			}
			return minslot;
		}
		
		public function hasItem(itype:ItemType, minQuantity:int = 1):Boolean {
			return itemCount(itype) >= minQuantity;
		}
		
		public function itemCount(itype:ItemType):int {
			var count:int = 0;
			for each (var itemSlot:ItemSlotClass in itemSlots){
				if (itemSlot.itype == itype) count += itemSlot.quantity;
			}
			return count;
		}

		// 0..5 or -1 if no
		public function roomInExistingStack(itype:ItemType):Number {
			for (var i:int = 0; i<itemSlots.length; i++){
				if(itemSlot(i).itype == itype && itemSlot(i).quantity != 0 && itemSlot(i).quantity < 10)
					return i;
			}
			return -1;
		}

		public function itemSlot(idx:int):ItemSlotClass
		{
			return itemSlots[idx];
		}

		// 0..5 or -1 if no
		public function emptySlot():Number {
		    for (var i:int = 0; i<itemSlots.length;i++){
				if (itemSlot(i).isEmpty() && itemSlot(i).unlocked) return i;
			}
			return -1;
		}


		public function destroyItems(itype:ItemType, numOfItemToRemove:Number):Boolean
		{
			for (var slotNum:int = 0; slotNum < itemSlots.length; slotNum += 1)
			{
				if(itemSlot(slotNum).itype == itype)
				{
					while(itemSlot(slotNum).quantity > 0 && numOfItemToRemove > 0)
					{
						itemSlot(slotNum).removeOneItem();
						numOfItemToRemove--;
					}
				}
			}
			return numOfItemToRemove <= 0;
		}

		public function lengthChange(temp2:Number, ncocks:Number):void {

			if (temp2 < 0 && flags[kFLAGS.HYPER_HAPPY])  // Early return for hyper-happy cheat if the call was *supposed* to shrink a cock.
			{
				return;
			}
			//DIsplay the degree of length change.
			if(temp2 <= 1 && temp2 > 0) {
				if(cocks.length == 1) outputText("Your [cock] has grown slightly longer.");
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("One of your [cocks] grows slightly longer.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("Some of your [cocks] grow slightly longer.");
					if(ncocks == cocks.length) outputText("Your [cocks] seem to fill up... growing a little bit larger.");
				}
			}
			if(temp2 > 1 && temp2 < 3) {
				if(cocks.length == 1) outputText("A very pleasurable feeling spreads from your groin as your [cock] grows permanently longer - at least an inch - and leaks pre-cum from the pleasure of the change.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A very pleasurable feeling spreads from your groin as your [cocks] grow permanently longer - at least an inch - and leak plenty of pre-cum from the pleasure of the change.");
					if(ncocks == 1) outputText("A very pleasurable feeling spreads from your groin as one of your [cocks] grows permanently longer, by at least an inch, and leaks plenty of pre-cum from the pleasure of the change.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("A very pleasurable feeling spreads from your groin as " + num2Text(ncocks) + " of your [cocks] grow permanently longer, by at least an inch, and leak plenty of pre-cum from the pleasure of the change.");
				}
			}
			if(temp2 >=3){
				if(cocks.length == 1) outputText("Your [cock] feels incredibly tight as a few more inches of length seem to pour out from your crotch.");
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("Your [cocks] feel incredibly tight as one of their number begins to grow inch after inch of length.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("Your [cocks] feel incredibly number as " + num2Text(ncocks) + " of them begin to grow inch after inch of added length.");
					if(ncocks == cocks.length) outputText("Your [cocks] feel incredibly tight as inch after inch of length pour out from your groin.");
				}
			}
			//Display LengthChange
			if(temp2 > 0) {
				if(cocks[0].cockLength >= 8 && cocks[0].cockLength-temp2 < 8){
					if(cocks.length == 1) outputText("  <b>Most men would be overly proud to have a tool as long as yours.</b>");
					if(cocks.length > 1) outputText("  <b>Most men would be overly proud to have one cock as long as yours, let alone " + multiCockDescript() + ".</b>");
				}
				if(cocks[0].cockLength >= 12 && cocks[0].cockLength-temp2 < 12) {
					if(cocks.length == 1) outputText("  <b>Your [cock] is so long it nearly swings to your knee at its full length.</b>");
					if(cocks.length > 1) outputText("  <b>Your [cocks] are so long they nearly reach your knees when at full length.</b>");
				}
				if(cocks[0].cockLength >= 16 && cocks[0].cockLength-temp2 < 16) {
					if(cocks.length == 1) outputText("  <b>Your [cock] would look more at home on a large horse than you.</b>");
					if(cocks.length > 1) outputText("  <b>Your [cocks] would look more at home on a large horse than on your body.</b>");
					if (biggestTitSize() >= BreastCup.C) {
						if (cocks.length == 1) outputText("  You could easily stuff your [cock] between your breasts and give yourself the titty-fuck of a lifetime.");
						if (cocks.length > 1) outputText("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the titty-fuck of a lifetime.");
					}
					else {
						if(cocks.length == 1) outputText("  Your [cock] is so long it easily reaches your chest.  The possibility of autofellatio is now a foregone conclusion.");
						if(cocks.length > 1) outputText("  Your [cocks] are so long they easily reach your chest.  Autofellatio would be about as hard as looking down.");
					}
				}
				if(cocks[0].cockLength >= 20 && cocks[0].cockLength-temp2 < 20) {
					if(cocks.length == 1) outputText("  <b>As if the pulsing heat of your [cock] wasn't enough, the tip of your [cock] keeps poking its way into your view every time you get hard.</b>");
					if(cocks.length > 1) outputText("  <b>As if the pulsing heat of your [cocks] wasn't bad enough, every time you get hard, the tips of your [cocks] wave before you, obscuring the lower portions of your vision.</b>");
					if(cor > 40 && cor <= 60) {
						if(cocks.length > 1) outputText("  You wonder if there is a demon or beast out there that could take the full length of one of your [cocks]?");
						if(cocks.length ==1) outputText("  You wonder if there is a demon or beast out there that could handle your full length.");
					}
					if(cor > 60 && cor <= 80) {
						if(cocks.length > 1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [cocks] to their hilts, milking you dry.\n\nYou smile at the pleasant thought.");
						if(cocks.length ==1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [cock] to the hilt, milking it of all your cum.\n\nYou smile at the pleasant thought.");
					}
					if(cor > 80) {
						if(cocks.length > 1) outputText("  You find yourself fantasizing about impaling nubile young champions on your [cocks] in a year's time.");
					}
				}
			}
			//Display the degree of length loss.
			if(temp2 < 0 && temp2 >= -1) {
				if(cocks.length == 1) outputText("Your [cocks] has shrunk to a slightly shorter length.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your [cocks] have shrunk to a slightly shorter length.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your [cocks] have shrunk to a slightly shorter length.");
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your [cocks] has shrunk to a slightly shorter length.");
				}
			}
			if(temp2 < -1 && temp2 > -3) {
				if(cocks.length == 1) outputText("Your [cocks] shrinks smaller, flesh vanishing into your groin.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your [cocks] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your [cocks] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your [cocks] shrink smaller, the flesh vanishing into your groin.");
				}
			}
			if(temp2 <= -3) {
				if(cocks.length == 1) outputText("A large portion of your [cocks]'s length shrinks and vanishes.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A large portion of your [cocks] recedes towards your groin, receding rapidly in length.");
					if(ncocks == 1) outputText("A single member of your [cocks] vanishes into your groin, receding rapidly in length.");
					if(ncocks > 1 && cocks.length > ncocks) outputText("Your [cocks] tingles as " + num2Text(ncocks) + " of your members vanish into your groin, receding rapidly in length.");
				}
			}
		}

		public function killCocks(deadCock:Number):void
		{
			//Count removal for text bits
			var removed:Number = 0;
			var temp:Number;
			//Holds cock index
			var storedCock:Number = 0;
			//Less than 0 = PURGE ALL
			if (deadCock < 0) {
				deadCock = cocks.length;
			}
			//Double loop - outermost counts down cocks to remove, innermost counts down
			while (deadCock > 0) {
				//Find shortest cock and prune it
				temp = cocks.length;
				while (temp > 0) {
					temp--;
					//If anything is out of bounds set to 0.
					if (storedCock > cocks.length - 1) storedCock = 0;
					//If temp index is shorter than stored index, store temp to stored index.
					if (cocks[temp].cockLength <= cocks[storedCock].cockLength) storedCock = temp;
				}
				//Smallest cock should be selected, now remove it!
				removeCock(storedCock, 1);
				removed++;
				deadCock--;
				if (cocks.length == 0) deadCock = 0;
			}
			//Texts
			if (removed == 1) {
				if (cocks.length == 0) {
					outputText("<b>Your manhood shrinks into your body, disappearing completely.</b>");
					if (hasStatusEffect(StatusEffects.Infested)) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.");
				}
				if (cocks.length == 1) {
					outputText("<b>Your smallest penis disappears, shrinking into your body and leaving you with just one [cock].</b>");
				}
				if (cocks.length > 1) {
					outputText("<b>Your smallest penis disappears forever, leaving you with just your [cocks].</b>");
				}
			}
			if (removed > 1) {
				if (cocks.length == 0) {
					outputText("<b>All your male endowments shrink smaller and smaller, disappearing one at a time.</b>");
					if (hasStatusEffect(StatusEffects.Infested)) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.");
				}
				if (cocks.length == 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with just your [cock].");
				}
				if (cocks.length > 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with [cocks].");
				}
			}
			//remove infestation if cockless
			if (cocks.length == 0) removeStatusEffect(StatusEffects.Infested);
			if (cocks.length == 0 && balls > 0) {
				outputText("  <b>Your " + sackDescript() + " and [balls] shrink and disappear, vanishing into your groin.</b>");
				balls = 0;
				ballSize = 1;
			}
		}
		public function modCumMultiplier(delta:Number):Number
		{
			trace("modCumMultiplier called with: " + delta);
		
			if (delta == 0) {
				trace( "Whoops! modCumMuliplier called with 0... aborting..." );
				return delta;
			}
			else if (delta > 0) {
				trace("and increasing");
				if (hasPerk(PerkLib.MessyOrgasms)) {
					trace("and MessyOrgasms found");
					delta *= 1.5
				}
			}
			else if (delta < 0) {
				trace("and decreasing");
				if (hasPerk(PerkLib.MessyOrgasms)) {
					trace("and MessyOrgasms found");
					delta *= 0.5
				}
			}

			trace("and modifying by " + delta);
			cumMultiplier += delta;
			return delta;
		}

		public function increaseCock(cockNum:Number, lengthDelta:Number):Number
		{
			var bigCock:Boolean = false;
	
			if (hasPerk(PerkLib.BigCock))
				bigCock = true;

			return cocks[cockNum].growCock(lengthDelta, bigCock);
		}
		
		public function increaseEachCock(lengthDelta:Number):Number
		{
			var totalGrowth:Number = 0;
			
			for (var i:Number = 0; i < cocks.length; i++) {
				trace( "increaseEachCock at: " + i);
				totalGrowth += increaseCock(i as Number, lengthDelta);
			}
			
			return totalGrowth;
		}
		
		// Attempts to put the player in heat (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if she is already pregnant or is a he.
		// 
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the 
		// duration and intensity. Defaults to 1.
		public function goIntoHeat(output:Boolean, intensity:int = 1):Boolean {
			if(!hasVagina() || pregnancyIncubation != 0) {
				// No vagina or already pregnant, can't go into heat.
				return false;
			}
			
			//Already in heat, intensify further.
			if (inHeat) {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Despite already being in heat, the desire to copulate constantly grows even larger.");
				}
				var sac:StatusEffectClass = statusEffectByType(StatusEffects.Heat);
				sac.value1 += 5 * intensity;
				sac.value2 += 5 * intensity;
				sac.value3 += 48 * intensity;
				dynStats("lib", 5 * intensity, "scale", false);
			}
			//Go into heat.  Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
			else {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Your hands begin stroking your body from top to bottom, your sensitive skin burning with desire.  Fantasies about bending over and presenting your needy pussy to a male overwhelm you as <b>you realize you have gone into heat!</b>");
				}
				createStatusEffect(StatusEffects.Heat, 10 * intensity, 15 * intensity, 48 * intensity, 0);
				dynStats("lib", 15 * intensity, "scale", false);
			}
			return true;
		}
		
		// Attempts to put the player in rut (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if he is a she.
		// 
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the 
		// duration and intensity. Defaults to 1.
		public function goIntoRut(output:Boolean, intensity:int = 1):Boolean {
			if (!hasCock()) {
				// No cocks, can't go into rut.
				return false;
			}
			
			//Has rut, intensify it!
			if (inRut) {
				if(output) {
					outputText("\n\nYour [cock] throbs and dribbles as your desire to mate intensifies.  You know that <b>you've sunken deeper into rut</b>, but all that really matters is unloading into a cum-hungry cunt.");
				}
				
				addStatusValue(StatusEffects.Rut, 1, 100 * intensity);
				addStatusValue(StatusEffects.Rut, 2, 5 * intensity);
				addStatusValue(StatusEffects.Rut, 3, 48 * intensity);
				dynStats("lib", 5 * intensity, "scale", false);
			}
			else {
				if(output) {
					outputText("\n\nYou stand up a bit straighter and look around, sniffing the air and searching for a mate.  Wait, what!?  It's hard to shake the thought from your head - you really could use a nice fertile hole to impregnate.  You slap your forehead and realize <b>you've gone into rut</b>!");
				}
				
				//v1 - bonus cum production
				//v2 - bonus libido
				//v3 - time remaining!
				createStatusEffect(StatusEffects.Rut, 150 * intensity, 5 * intensity, 100 * intensity, 0);
				dynStats("lib", 5 * intensity, "scale", false);
			}
			
			return true;
		}
		public function orgasmReal():void
		{
			dynStats("lus=", 0, "sca", false);
			hoursSinceCum = 0;
			flags[kFLAGS.TIMES_ORGASMED]++;

			if (countCockSocks("gilded") > 0) {
				var randomCock:int = rand( cocks.length );
				var bonusGems:int = rand( cocks[randomCock].cockThickness ) + countCockSocks("gilded"); // int so AS rounds to whole numbers
				EngineCore.outputText("\n\nFeeling some minor discomfort in your " + cockDescript(randomCock) + " you slip it out of your [armor] and examine it. <b>With a little exploratory rubbing and massaging, you manage to squeeze out " + bonusGems + " gems from its cum slit.</b>\n\n");
				gems += bonusGems;
			}
		}
		public function orgasm(type:String = 'Default', real:Boolean = true):void
		{
			switch (type) {
					// Start with that, whats easy
				case 'Vaginal': //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_VAGINAL] < 10) flags[kFLAGS.TIMES_ORGASM_VAGINAL]++;
					break;
				case 'Anal':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_ANAL]    < 10) flags[kFLAGS.TIMES_ORGASM_ANAL]++;
					break;
				case 'Dick':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_DICK]    < 10) flags[kFLAGS.TIMES_ORGASM_DICK]++;
					break;
				case 'Lips':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_LIPS]    < 10) flags[kFLAGS.TIMES_ORGASM_LIPS]++;
					break;
				case 'Tits':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_TITS]    < 10) flags[kFLAGS.TIMES_ORGASM_TITS]++;
					break;
				case 'Nipples': //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_NIPPLES] < 10) flags[kFLAGS.TIMES_ORGASM_NIPPLES]++;
					break;
				case 'Ovi':     break;

					// Now to the more complex types
				case 'VaginalAnal':
					orgasm((hasVagina() ? 'Vaginal' : 'Anal'), real);
					return; // Prevent calling orgasmReal() twice

				case 'DickAnal':
					orgasm((rand(2) == 0 ? 'Dick' : 'Anal'), real);
					return;

				case 'Default':
				case 'Generic':
				default:
					if (!hasVagina() && !hasCock()) {
						orgasm('Anal'); // Failsafe for genderless PCs
						return;
					}

					if (hasVagina() && hasCock()) {
						orgasm((rand(2) == 0 ? 'Vaginal' : 'Dick'), real);
						return;
					}

					orgasm((hasVagina() ? 'Vaginal' : 'Dick'), real);
					return;
			}

			if (real) orgasmReal();
		}
		public function orgasmRaijuStyle():void
		{
			if (game.player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
				EngineCore.outputText("\n\nAs you finish masturbating you feel a jolt in your genitals, as if for a small moment the raiju discharge was brought back, increasing the intensity of the pleasure and your desire to touch yourself. Electricity starts coursing through your body again by intermittence as something in you begins to change.");
				game.player.addStatusValue(StatusEffects.RaijuLightningStatus,1,6);
				dynStats("lus", (60 + rand(20)), "sca", false);
				game.mutations.voltageTopaz(false,CoC.instance.player);
			}
			else {
				EngineCore.outputText("\n\nAfter this electrifying orgasm your lust only raise sky high above. You will need a partner to fuck with in order to discharge your ramping up desire and electricity.");
				dynStats("lus", (maxLust() * 0.1), "sca", false);
			}
			hoursSinceCum = 0;
			flags[kFLAGS.TIMES_ORGASMED]++;
		}
		public function penetrated(where:ISexyPart, tool:ISexyPart, options:Object = null):void {
			options = Utils.extend({
				display:true,
				orgasm:false
			},options||{});

			if (where.host != null && where.host != this) {
				trace("Penetration confusion! Host is "+where.host);
				return;
			}

			var size:Number = 8;
			if ('size' in options) size = options.size;
			else if (tool is Cock) size = (tool as Cock).cArea();

			var otype:String = 'Default';
			if (where is AssClass) {
				buttChange(size, options.display);
				otype = 'Anal';
			} else if (where is VaginaClass) {
				cuntChange(size, options.display);
				otype = 'Vaginal';
			}
			if (options.orgasm) {
				orgasm(otype);
			}
		}
		
		protected override function maxHP_base():Number {
			var max:Number = super.maxHP_base();
			if (alicornScore() >= 11) max += (150 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (centaurScore() >= 8) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 4) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 10) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 20) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 28) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (gorgonScore() >= 11) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (horseScore() >= 4) max += (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (horseScore() >= 7) max += (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (manticoreScore() >= 6) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (rhinoScore() >= 4) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (scyllaScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (scyllaScore() >= 7) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (scyllaScore() >= 12) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (unicornScore() >= 9) max += (120 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			
			return max;
		}
		protected override function maxLust_base():Number {
			var max:Number = super.maxLust_base();
			if (cowScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (cowScore() >= 9) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (demonScore() >= 5) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (demonScore() >= 11) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (devilkinScore() >= 7) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (devilkinScore() >= 10) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 20) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 28) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (minotaurScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (minotaurScore() >= 9) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (phoenixScore() >= 5) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (salamanderScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (sharkScore() >= 9 && vaginas.length > 0 && cocks.length > 0) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			
			return max;
		}
		
		override public function modStats(dstr:Number, dtou:Number, dspe:Number, dinte:Number, dwis:Number,dlib:Number, dsens:Number, dlust:Number, dcor:Number, scale:Boolean, max:Boolean):void {
			//Easy mode cuts lust gains!
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1 && dlust > 0 && scale) dlust /= 2;
			
			//Set original values to begin tracking for up/down values if
			//they aren't set yet.
			//These are reset when up/down arrows are hidden with
			//hideUpDown();
			//Just check str because they are either all 0 or real values
			if(game.oldStats.oldStr == 0) {
				game.oldStats.oldStr = str;
				game.oldStats.oldTou = tou;
				game.oldStats.oldSpe = spe;
				game.oldStats.oldInte = inte;
				game.oldStats.oldWis = wis;
				game.oldStats.oldLib = lib;
				game.oldStats.oldSens = sens;
				game.oldStats.oldCor = cor;
				game.oldStats.oldHP = HP;
				game.oldStats.oldLust = lust;
				game.oldStats.oldFatigue = fatigue;
				game.oldStats.oldSoulforce = soulforce;
				game.oldStats.oldHunger = hunger;
			}
			if (scale) {
				//MOD CHANGES FOR PERKS
				//Bimbos learn slower
				if (hasPerk(PerkLib.FutaFaculties) || hasPerk(PerkLib.BimboBrains) || hasPerk(PerkLib.BroBrains)) {
					if (dinte > 0) dinte /= 2;
					if (dinte < 0) dinte *= 2;
				}
				if (hasPerk(PerkLib.FutaForm) || hasPerk(PerkLib.BimboBody) || hasPerk(PerkLib.BroBody)) {
					if (dlib > 0) dlib *= 2;
					if (dlib < 0) dlib /= 2;
				}
				
				// Uma's Perkshit
				if (hasPerk(PerkLib.ChiReflowSpeed) && dspe < 0) dspe *= UmasShop.NEEDLEWORK_SPEED_SPEED_MULTI;
				if (hasPerk(PerkLib.ChiReflowLust) && dlib > 0) dlib *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
				if (hasPerk(PerkLib.ChiReflowLust) && dsens > 0) dsens *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
				
				//Apply lust changes in NG+.
				dlust *= 1 + (newGamePlusMod() * 0.2);
				
				//lust resistance
				if (dlust > 0 && scale) dlust *= EngineCore.lustPercent() / 100;
				if (dlib > 0 && hasPerk(PerkLib.PurityBlessing)) dlib *= 0.75;
				if (dcor > 0 && hasPerk(PerkLib.PurityBlessing)) dcor *= 0.5;
				if (dcor > 0 && hasPerk(PerkLib.PureAndLoving)) dcor *= 0.75;
				if (dcor > 0 && weapon == game.weapons.HNTCANE) dcor *= 0.5;
				if (hasPerk(PerkLib.AscensionMoralShifter)) dcor *= 1 + (perkv1(PerkLib.AscensionMoralShifter) * 0.2);
				if (hasPerk(PerkLib.Lycanthropy)) dcor *= 1.2;
				if (hasStatusEffect(StatusEffects.BlessingOfDivineFera)) dcor *= 2;
				
				if (sens > 50 && dsens > 0) dsens /= 2;
				if (sens > 75 && dsens > 0) dsens /= 2;
				if (sens > 90 && dsens > 0) dsens /= 2;
				if (sens > 50 && dsens < 0) dsens *= 2;
				if (sens > 75 && dsens < 0) dsens *= 2;
				if (sens > 90 && dsens < 0) dsens *= 2;
				
				
				//Bonus gain for perks!
				if (hasPerk(PerkLib.Strong)) dstr += dstr * perkv1(PerkLib.Strong);
				if (hasPerk(PerkLib.Tough)) dtou += dtou * perkv1(PerkLib.Tough);
				if (hasPerk(PerkLib.Fast)) dspe += dspe * perkv1(PerkLib.Fast);
				if (hasPerk(PerkLib.Smart)) dinte += dinte * perkv1(PerkLib.Smart);
				if (hasPerk(PerkLib.Lusty)) dlib += dlib * perkv1(PerkLib.Lusty);
				if (hasPerk(PerkLib.Sensitive)) dsens += dsens * perkv1(PerkLib.Sensitive);
				
				// Uma's Str Cap from Perks (Moved to max stats)
				/*if (hasPerk(PerkLib.ChiReflowSpeed))
				{
					if (str > UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP)
					{
						str = UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP;
					}
				}
				if (hasPerk(PerkLib.ChiReflowDefense))
				{
					if (spe > UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP)
					{
						spe = UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP;
					}
				}*/
			}
			//Change original stats
			super.modStats(dstr,dtou,dspe,dinte,dwis,dlib,dsens,dlust,dcor,false,max);
			//Refresh the stat pane with updated values
			//mainView.statsView.showUpDown();
			EngineCore.showUpDown();
			EngineCore.statScreenRefresh();
		}
	}
}
