﻿package classes 
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
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.*;
import classes.Scenes.Areas.Desert.SandWitchScene;
import classes.Scenes.Dungeons.DungeonAbstractContent;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.NPCs.XXCNPC;
import classes.Scenes.SceneLib;
import classes.Stats.PrimaryStat;
import classes.internals.EnumValue;
import classes.lists.BreastCup;
import classes.lists.Gender;

import coc.view.ButtonDataList;
import coc.view.MainView;

import mx.utils.StringUtil;

public class CharCreation extends BaseContent {
		
		public const MAX_TOLERANCE_LEVEL:int = 10;				//40 AP
		public const MAX_MORALSHIFTER_LEVEL:int = 10;			//40 AP
		public const MAX_DESIRES_LEVEL:int = 25;				//90 AP
		public const MAX_ENDURANCE_LEVEL:int = 25;				//90 AP
		public const MAX_HARDINESS_LEVEL:int = 25;				//90 AP
		public const MAX_SOULPURITY_LEVEL:int = 25;				//90 AP
		public const MAX_INNERPOWER_LEVEL:int = 25;				//90 AP
		public const MAX_FURY_LEVEL:int = 25;					//90 AP
		public const MAX_MYSTICALITY_LEVEL:int = 20;			//90 AP
		public const MAX_SPIRITUALENLIGHTENMENT_LEVEL:int = 20;	//90 AP
		public const MAX_WISDOM_LEVEL:int = 5;					//15 AP
		public const MAX_TRANSHUMANISM_LEVEL:int = 25;			//90 AP
		public const MAX_FORTUNE_LEVEL:int = -1;				//No maximum level.(845)
		public const MAX_VIRILITY_LEVEL:int = 10;				//40 AP
		public const MAX_FERTILITY_LEVEL:int = 10;				//40 AP
		
		private var specialCharacters:CharSpecial = new CharSpecial();
		private var _specialArr:Array;
		private var customPlayerProfile:Function;
		
//		private var boxNames:ComboBox;
		
		public function CharCreation() {}
		
		public function newGameFromScratch():void {
			flags[kFLAGS.NEW_GAME_PLUS_LEVEL] = 0;
			newGameGo();
		}

		private function showNameCombo():void {
			if(!_specialArr){
				_specialArr = [];
				for each(var ch:Array in specialCharacters.customs){
					_specialArr.push({label:ch[0], data:ch});
				}
			}
			CoC.instance.showComboBox(_specialArr,"Pre-defined characters",selectName);
			mainView.placeComboAfterTextInput();
		}

		public function newGameGo():void {
			clearOutput();
			CoC.instance.mainMenu.hideMainMenu();
			XXCNPC.unloadSavedNPCs();
			CoC.instance.resetMods();
			mainView.eventTestInput.x = -10207.5;
			mainView.eventTestInput.y = -1055.1;
			hideStats();
			hideUpDown();
			mainView.hideAllMenuButtons();
			mainView.setButtonText(0, "Newgame"); // b1Text.text = "Newgame";

			outputText("You grew up in the small village of Ingnam, a remote village with rich traditions, buried deep in the wilds.  Every year for as long as you can remember, your village has chosen a champion to send to the cursed Demon Realm.  Legend has it that in years Ingnam has failed to produce a champion, chaos has reigned over the countryside.  Children disappear, crops wilt, and disease spreads like wildfire.  This year, <b>you</b> have been selected to be the champion.\n\n");
			outputText("What is your name?");

			menu();
			addButton(0, "OK", chooseName);
			mainViewManager.showTextInput("",null,16);
			showNameCombo();
			//RESET DUNGEON
			DungeonAbstractContent.inDungeon = false;
			DungeonAbstractContent.dungeonLoc = 0;
			DungeonAbstractContent.inRoomedDungeon = false;
			DungeonAbstractContent.inRoomedDungeonResume = null;
			//Hold onto old data for NG+
			var oldPlayer:Player = player;
			//Reset all standard stats
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) player = new Player();

            //Reset autosave
            if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
                player.slotName = "VOID";
                player.autoSave = false;
            }

			model.player = player;
			for each (var ps:PrimaryStat in player.primaryStats()) {
				ps.reset(15);
			}
			player.sens = 15;
			player.cor = 15;
			player.ki = 50;
			player.wrath = 0;
			player.mana = 100;
			player.hunger = 80;
			player.lust = 15;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.XP = flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP];
				player.level = 1;

				player.gems = flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS];
			}
			player.hairLength = 5;
			player.skin.restore();
			player.faceType = Face.HUMAN;
			player.tailType = Tail.NONE;
			player.tongue.type = Tongue.HUMAN;
			player.femininity = 50;
			player.beardLength = 0;
			player.beardStyle = 0;
			player.tone = 50;
			player.thickness = 50;
			player.skinDesc = "skin";
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.balls = 0;
				player.ballSize = 0;
				player.clitLength = 0;
			}
			player.hoursSinceCum = 0;
			player.cumMultiplier = 1;
			player.ass.analLooseness = 0;
			player.ass.analWetness = 0;
			player.ass.fullness = 0;
			player.fertility = 5;
			player.fatigue = 0;
			player.horns.count = 0;
			player.tallness = 60;
			player.tailCount = 0;
			player.tailVenom = 0;
			player.tailRecharge = 0;
			player.gills.type = Gills.NONE;
			player.rearBody.type = RearBody.NONE;
			player.wings.type = Wings.NONE;
			player.wings.desc = "non-existant";
			//Default
			player.skinTone = "light";
			player.hairColor = "brown";
			player.hairType = Hair.NORMAL;
			player.beardLength = 0;
			player.beardStyle = 0;
			//Exploration
			player.explored = 0;
			player.exploredForest = 0;
			player.exploredDesert = 0;
			player.exploredMountain = 0;
			player.exploredLake = 0;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				//Inventory clear
				player.itemSlot1.unlocked = true;
				player.itemSlot1.emptySlot();
				player.itemSlot2.unlocked = true;
				player.itemSlot2.emptySlot();
				player.itemSlot3.unlocked = true;
				player.itemSlot3.emptySlot();
				player.itemSlot4.unlocked = true;
				player.itemSlot4.emptySlot();
				player.itemSlot5.unlocked = true;
				player.itemSlot5.emptySlot();
			}
            //PIERCINGS
            player.nipplesPierced = 0;
            player.nipplesPShort = "";
            player.nipplesPLong = "";
            player.lipPierced = 0;
            player.lipPShort = "";
            player.lipPLong = "";
            player.tonguePierced = 0;
            player.tonguePShort = "";
            player.tonguePLong = "";
            player.eyebrowPierced = 0;
            player.eyebrowPShort = "";
            player.eyebrowPLong = "";
            player.earsPierced = 0;
            player.earsPShort = "";
            player.earsPLong = "";
            player.nosePierced = 0;
            player.nosePShort = "";
            player.nosePLong = "";
            for each(var cock:Cock in player.cocks){
				cock.pierced = 0;
				cock.pShortDesc = "";
				cock.pLongDesc = "";
			}
			for each(var vagina:VaginaClass in player.vaginas){
				vagina.labiaPierced = 0;
                vagina.labiaPShort = "";
				vagina.labiaPLong = "";
				vagina.clitPierced = 0;
                vagina.clitPShort = "";
				vagina.clitPLong = "";
			}


			//PLOTZ
			JojoScene.monk                               = 0;
			SandWitchScene.rapedBefore = false;
		//Replaced by flag	CoC.instance.beeProgress = 0;
			SceneLib.isabellaScene.isabellaOffspringData = []; //CLEAR!
			//Lets get this bitch started
			CoC.instance.inCombat = false;
			DungeonAbstractContent.inDungeon = false;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				//Clothes clear
				player.setArmor(armors.C_CLOTH);
				player.setWeapon(WeaponLib.FISTS);
				player.setWeaponRange(WeaponRangeLib.NOTHING);
				//Clear camp slots
				inventory.clearStorage();
				inventory.clearGearStorage();
				inventory.clearPearlStorage();
				//Initialize gearStorage
				inventory.initializeGearStorage();
				inventory.initializePearlStorage();
				//Clear cocks
				while(player.cocks.length > 0)
				{
					player.removeCock(0,1);
					trace("1 cock purged.");
				}
				//Clear vaginas
				while(player.vaginas.length > 0)
				{
					player.removeVagina(0,1);
					trace("1 vagina purged.");
				}
				//Clear breasts
				player.breastRows = [];
			}
			else {
				var hadOldCock:Boolean = player.hasCock();
				var hadOldVagina:Boolean = player.hasVagina();
				//Clear cocks
				while(player.cocks.length > 0)
				{
					player.removeCock(0,1);
					trace("1 cock purged.");
				}
				//Clear vaginas
				while(player.vaginas.length > 0)
				{
					player.removeVagina(0,1);
					trace("1 vagina purged.");
				}
				//Keep gender and normalize genitals.
				if (hadOldCock) player.createCock(5.5, 1, CockTypesEnum.HUMAN);
				if (hadOldVagina) player.createVagina(true);
				if (player.balls > 2) player.balls = 2;
				if (player.ballSize > 2) player.ballSize = 2;
				if (player.clitLength > 1.5) player.clitLength = 1.5;
				while (player.breastRows.length > 1)
				{
					player.removeBreastRow(1, 1);
				}
				if (player.nippleLength > 0.25) player.nippleLength = 0.25;
				while (player.biggestTitSize() > 14) player.shrinkTits(true);
				//Sorry but you can't come, Valeria!
			//	if (!(oldPlayer.armor is GooArmor))
			//	player.setArmor(armors.C_CLOTH);
			}
			
			//Clear Statuses
			var statusTemp:Array = [];
			for (var i:int = 0; i < player.statusEffects.length; i++) {
				if (isSpell(player.statusEffects[i].stype)) statusTemp.push(player.statusEffects[i]);
			}
			player.removeStatuses();
			if (statusTemp.length > 0) {
				for (i = 0; i < statusTemp.length; i++) {
					player.createStatusEffect(statusTemp[i].stype, statusTemp[i].value1, statusTemp[i].value2, statusTemp[i].value3, statusTemp[i].value4);
				}
			}
			//Clear perks
			player.removePerks();
			//Clear key items
			var keyItemTemp:Array = [];
			for (i = 0; i < player.keyItems.length; i++) {
				if (isSpecialKeyItem(player.keyItems[i].keyName)) keyItemTemp.push(player.keyItems[i]);
			}
			player.removeKeyItems();
			if (keyItemTemp.length > 0) {
				for (i = 0; i < keyItemTemp.length; i++) {
					player.createKeyItem(keyItemTemp[i].keyName, keyItemTemp[i].value1, keyItemTemp[i].value2, keyItemTemp[i].value3, keyItemTemp[i].value4);
				}
			}
			//player.perkPoints = player.level - 1;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0) {
				var newGamePlusLevel:int = flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				var gameMode:Number = flags[kFLAGS.HUNGER_ENABLED];
				var hardcoreMode:int = flags[kFLAGS.HARDCORE_MODE];
				var hardcoreSlot:String = flags[kFLAGS.HARDCORE_SLOT];
			}
			//Clear plot storage array!
			CoC.instance.flags = new DefaultDict();
			CoC.instance.saves.loadPermObject();
			//Carry over data if new game plus.
			if (newGamePlusLevel > 0) {
				flags[kFLAGS.NEW_GAME_PLUS_LEVEL] = newGamePlusLevel;
				flags[kFLAGS.HUNGER_ENABLED] = gameMode;
				flags[kFLAGS.HARDCORE_MODE] = hardcoreMode;
				flags[kFLAGS.HARDCORE_SLOT] = hardcoreSlot;
			}
			//Set that jojo debug doesn't need to run
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_02999] = 3;
			//Time reset
			model.time.days = 0;
			model.time.hours = 0;
			model.time.minutes = 0;

		}
		
		private function chooseName():void {
			var name:String = mainViewManager.getTextInput();
			if (StringUtil.trim(name) == "") {
				//If part of newgame+, don't fully wipe.
				if (player.XP > 0 && player.explored == 0) {
					flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = player.XP;
					if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] == 0) {
						flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = 1;
					}
					while (player.level > 1) {
						flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] += player.level * 100;
						player.level--;
					}
					flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS] = player.gems;
				}
				if (flags[kFLAGS.LETHICE_DEFEATED] > 0){
					renamePrompt();
				} else {
					newGameGo();
				}
				outputText("\n\n\n<b>You must select a name.</b>");
				return;
			}
			clearOutput();
			player.short = name;
			if (flags[kFLAGS.LETHICE_DEFEATED] > 0) { //Dirty checking as the NG+ flag is incremented after reincarnating.
				clearOutput();
				outputText("You shall be known as [name] now.");
				ascensionMenu();
				return;
			}
			customPlayerProfile = customName(name);
			menu();
			if (customPlayerProfile != null) {
				outputText("This name, like you, is special.  Do you live up to your name or continue on, assuming it to be coincidence?");
				addButton(0, "SpecialName", useCustomProfile);
				addButton(1, "Continue On", noCustomProfile);
			} else { //Proceed with normal character creation
				genericGenderChoice();
			}
		}
		
		private function genericGenderChoice():void {
			outputText("Are you a man or a woman?");
			menu();
			addButton(0, "Man", isAMan);
			addButton(1, "Woman", isAWoman);
			if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] > 0) {
				outputText("\n\nOr a hermaphrodite as you've unlocked hermaphrodite option!");
				addButton(2, "Herm", isAHerm);
			}
		}
		
		private function useCustomProfile():void {
			clearOutput();
			if (specialName(player.short) != null) {
				outputText("Your name defines everything about you, and as such, it is time to wake...\n\n");
				flags[kFLAGS.HISTORY_PERK_SELECTED] = 1;
				completeCharacterCreation(); //Skip character creation, customPlayerProfile will be called in completeCharacterCreation
			}
			else {
				//After character creation the fact that customPlayerProfile is not null will activate a custom player setup 
				outputText("There is something different about you, but first, what is your basic gender?  An individual such as you may later overcome this, of course...\n\n");
				genericGenderChoice();
			}
		}
		
		private function noCustomProfile():void {
			clearOutput();
			customPlayerProfile = null;
			outputText("Your name carries little significance beyond it being your name.  What is your gender?");
			menu();
			addButton(0, "Man", isAMan);
			addButton(1, "Woman", isAWoman);
			if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] > 0) {
				addButton(2, "Herm", isAHerm);
			}
		}
		
		private function selectName(selectedItem:*):void {
			if (selectedItem.data[0].length > 16) {
				return;
			}
			clearOutput();
			outputText("<b>" + selectedItem.data[0] + ":</b> " + selectedItem.data[3]);
			if(selectedItem.data[2]) {
				outputText("\n\nThis character has a pre-defined history.");
			} else {
				outputText("\n\nThis character has no pre-defined history.");
			}
				
			flushOutputTextToGUI();
			mainViewManager.showTextInput(selectedItem.data[0],null,16);
			showNameCombo();
		}
		
		//Determines if has character creation bonuses
		internal function customName(arg:String):Function {
			for (var i:int = 0; i < specialCharacters.customs.length; i++)
				if (specialCharacters.customs[i][0] == arg && !specialCharacters.customs[i][2])
					return specialCharacters.customs[i][1];
			return specialName(arg); //Must check against the special name list as well
		}
		
		//Does PC skip creation?
		private function specialName(arg:String):Function {
			for (var i:int = 0; i < specialCharacters.customs.length; i++)
				if (specialCharacters.customs[i][0] == arg && specialCharacters.customs[i][2])
					return specialCharacters.customs[i][1];
			return null;
		}
		
		private function isAMan():void {
			//Attributes
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.strStat.core.value += 3;
				player.touStat.core.value += 2;
			}
			//Body attributes
			player.fertility = 5;
			player.hairLength = 1;
			player.tallness = 71;
			player.tone = 60;
			
			//Genetalia
			player.balls = 2;
			player.ballSize = 1;
			player.clitLength = 0;
			player.createCock();
			player.cocks[0].cockLength = 5.5;
			player.cocks[0].cockThickness = 1;
			player.cocks[0].cockType = CockTypesEnum.HUMAN;
			player.cocks[0].knotMultiplier = 1;
			
			//Breasts
			player.createBreastRow();
			
			//Choices
			clearOutput();
			outputText("You are a man.  Your upbringing has provided you an advantage in strength and toughness.\n\nWhat type of build do you have?");
			simpleChoices("Lean", buildLeanMale, "Average", buildAverageMale, "Thick", buildThickMale, "Girly", buildGirlyMale, "", null);
		}

		private function isAWoman():void {
			//Attributes
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.speStat.core.value += 3;
				player.intStat.core.value += 2;
			}
			//Body attributes
			player.fertility = 10;
			player.hairLength = 10;
			player.tallness = 67;
			player.tone = 30;
			
			//Genetalia
			player.balls = 0;
			player.ballSize = 0;
			player.createVagina();
			player.clitLength = 0.5;
			
			//Breasts
			player.createBreastRow();
			
			//Choices
			clearOutput();
			outputText("You are a woman.  Your upbringing has provided you an advantage in speed and intellect.\n\nWhat type of build do you have?");
			simpleChoices("Slender", buildSlenderFemale, "Average", buildAverageFemale, "Curvy", buildCurvyFemale, "Tomboyish", buildTomboyishFemale, "", null);
		}

		private function isAHerm():void {
			//Attributes
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.strStat.core.value+=1;
				player.touStat.core.value +=1;
				player.speStat.core.value +=1;
				player.intStat.core.value += 1;
			}
			//Body attributes
			player.fertility = 10;
			player.hairLength = 10;
			player.tallness = 69;
			player.tone = 45;
			
			//Genetalia
			player.createVagina();
			player.clitLength = .5;
			player.createCock();
			player.cocks[0].cockLength = 5.5;
			player.cocks[0].cockThickness = 1;
			player.cocks[0].cockType = CockTypesEnum.HUMAN;
			player.cocks[0].knotMultiplier = 1;
			
			//Breasts
			player.createBreastRow();
			
			//Choices
			clearOutput();
			outputText("\n\nYou are a hermaphrodite.  Your upbringing has provided you an average in stats.\n\nWhat type of build do you have?");
			menu();
			addButton(0, "Fem. Slender", buildSlenderFemale).hint("Feminine build. \n\nWill make you a futanari.", "Feminine, Slender");
			addButton(1, "Fem. Average", buildAverageFemale).hint("Feminine build. \n\nWill make you a futanari.", "Feminine, Average");
			addButton(2, "Fem. Curvy", buildCurvyFemale).hint("Feminine build. \n\nWill make you a futanari.", "Feminine, Curvy");
			//addButton(4, "Androgynous", chooseBodyTypeAndrogynous);
			addButton(5, "Mas. Lean", buildLeanMale).hint("Masculine build. \n\nWill make you a maleherm.", "Masculine, Lean");
			addButton(6, "Mas. Average", buildAverageMale).hint("Masculine build. \n\nWill make you a maleherm.", "Masculine, Average");
			addButton(7, "Mas. Thick", buildThickMale).hint("Masculine build. \n\nWill make you a maleherm.", "Masculine, Thick");
		}
		
		
		private function buildLeanMale():void {
			player.strStat.core.value -= 1;
			player.speStat.core.value += 1;
			
			player.femininity = 34;
			player.thickness = 30;
			player.tone += 5;
			
			player.breastRows[0].breastRating = BreastCup.FLAT;
			player.butt.type = Butt.RATING_TIGHT;
			player.hips.type = Hips.RATING_SLENDER;
			chooseComplexion();
		}

		private function buildSlenderFemale():void {
			player.strStat.core.value -= 1;
			player.speStat.core.value += 1;
			
			player.femininity = 66;
			player.thickness = 30;
			player.tone += 5;
			
			player.breastRows[0].breastRating = BreastCup.B;
			player.butt.type = Butt.RATING_TIGHT;
			player.hips.type = Hips.RATING_AMPLE;
			chooseComplexion();
		}

		private function buildAverageMale():void {
			player.femininity = 30;
			player.thickness = 50;
			
			player.breastRows[0].breastRating = BreastCup.FLAT;
			player.butt.type = Butt.RATING_AVERAGE;
			player.hips.type = Hips.RATING_AVERAGE;
			chooseComplexion();
		}

		private function buildAverageFemale():void {
			player.femininity = 70;
			player.thickness = 50;
			
			player.breastRows[0].breastRating = BreastCup.C;
			player.butt.type = Butt.RATING_NOTICEABLE;
			player.hips.type = Hips.RATING_AMPLE;
			chooseComplexion();
		}

		private function buildThickMale():void {
			player.speStat.core.value -= 4;
			player.strStat.core.value += 2;
			player.touStat.core.value += 2;
			
			player.femininity = 29;
			player.thickness = 70;
			player.tone -= 5;
			
			player.breastRows[0].breastRating = BreastCup.FLAT;
			player.butt.type = Butt.RATING_NOTICEABLE;
			player.hips.type = Hips.RATING_AVERAGE;
			chooseComplexion();
		}

		private function buildCurvyFemale():void {
			player.speStat.core.value -= 2;
			player.strStat.core.value += 1;
			player.touStat.core.value += 1;
			
			player.femininity = 71;
			player.thickness = 70;
			
			player.breastRows[0].breastRating = BreastCup.D;
			player.butt.type = Butt.RATING_LARGE;
			player.hips.type = Hips.RATING_CURVY;
			chooseComplexion();
		}

		private function buildGirlyMale():void {
			player.strStat.core.value -= 2;
			player.speStat.core.value += 2;
			
			player.femininity = 50;
			player.thickness = 50;
			player.tone = 26;
			
			player.breastRows[0].breastRating = BreastCup.A;
			player.butt.type = Butt.RATING_NOTICEABLE;
			player.hips.type = Hips.RATING_SLENDER;
			chooseComplexion();
		}

		private function buildTomboyishFemale():void {
			player.strStat.core.value += 1;
			player.speStat.core.value -= 1;
			
			player.femininity = 56;
			player.thickness = 50;
			player.tone = 50;
			
			player.breastRows[0].breastRating = BreastCup.A;
			player.butt.type = Butt.RATING_TIGHT;
			player.hips.type = Hips.RATING_SLENDER;
			chooseComplexion();
		}

		private function chooseComplexion(first:Boolean = false):void {
			clearOutput();
			outputText("What is your complexion?");
			menu();
			addButton(0, "Light", setComplexion, "light");
			addButton(1, "Fair", setComplexion, "fair");
			addButton(2, "Olive", setComplexion, "olive");
			addButton(3, "Dark", setComplexion, "dark");
			addButton(4, "Ebony", setComplexion, "ebony");
			addButton(5, "Mahogany", setComplexion, "mahogany");
			addButton(6, "Russet", setComplexion, "russet");

			function setComplexion(choice:String):void {
				player.skinTone = choice;
				if(first){
					chooseHair(true);
				} else {
					genericStyleCustomizeMenu();
				}
			}
		}

		private function chooseHair(first:Boolean = false):void { //And choose hair
			clearOutput();
			outputText("What color is your hair?");
			menu();
			addButton(0, "Blonde", setHair, "blonde");
			addButton(1, "Brown", setHair, "brown");
			addButton(2, "Black", setHair, "black");
			addButton(3, "Red", setHair, "red");
			addButton(4, "Gray", setHair, "gray");
			addButton(5, "White", setHair, "white");
			addButton(6, "Auburn", setHair, "auburn");

			function setHair(choice:String):void {
				player.hairColor = choice;
				if(first){
					menuEyesColor(true);
				} else {
					genericStyleCustomizeMenu()
				}
			}
		}

		//-----------------
		//-- GENERAL STYLE
		//-----------------
		private function genericStyleCustomizeMenu():void {
			clearOutput();
			outputText("You can finalize your appearance customization before you proceed to perk selection. You will be able to alter your appearance through the usage of certain items.\n\n");
			outputText("Height: " + Math.floor(player.tallness / 12) + "'" + player.tallness % 12 + "\"\n");
			outputText("Skin tone: " + player.skinTone + "\n");
			outputText("Hair color: [haircolor]\n");
			outputText("Eyes color: [eyecolor]\n");
			if (player.hasCock()) {
				outputText("Cock size: " + player.cocks[0].cockLength + "\" long, " + player.cocks[0].cockThickness + "\" thick\n");
			}
			outputText("Breast size: " + player.breastCup(0) + "\n");
			menu();
			addButton(0, "Complexion", chooseComplexion);
			addButton(1, "Hair Color", chooseHair);
			if (player.mf("m", "f") == "m") {
				if (player.hasBeard()) {
					outputText("Beard: " + player.beardDescript() + "\n");
				}
				addButton(2, "Beard Style", menuBeardSettings);
			}
			addButton(3, "Eyes Color", menuEyesColor);
			addButton(4, "Set Height", setHeight);
			if (player.hasCock()) addButton(5, "Cock Size", menuCockLength);
			addButton(6, "Breast Size", menuBreastSize);
			addButton(7, "Race", detailedRaceSetup, genericStyleCustomizeMenu);
			addButton(9, "Done", chooseEndowment, true);
		}

		//-----------------
		//-- BEARD STYLE
		//-----------------
		private function menuBeardSettings():void {
			clearOutput();
			outputText("You can choose your beard length and style.\n\n");
			outputText("Beard: " + player.beardDescript());
			menu();
			addButton(0, "Style", menuBeardStyle);
			addButton(1, "Length", menuBeardLength);
			addButton(14, "Back", genericStyleCustomizeMenu);
		}
		private function menuBeardStyle():void {
			clearOutput();
			outputText("What beard style would you like?");
			menu();
			addButton(0, "Normal", chooseBeardStyle, Beard.NORMAL);
			addButton(1, "Goatee", chooseBeardStyle, Beard.GOATEE);
			addButton(2, "Clean-cut", chooseBeardStyle, Beard.CLEANCUT);
			addButton(3, "Mountainman", chooseBeardStyle, Beard.MOUNTAINMAN);
			addButton(14, "Back", menuBeardSettings);
		}
		private function chooseBeardStyle(choiceStyle:int = 0):void {
			player.beardStyle = choiceStyle;
			menuBeardSettings();
		}
		private function menuBeardLength():void {
			clearOutput();
			outputText("How long would you like your beard be? \n\nNote: Beard will slowly grow over time, just like in the real world. Unless you have no beard. You can change your beard style later in the game.");
			menu();
			addButton(0, "No Beard", chooseBeardLength, 0);
			addButton(1, "Trim", chooseBeardLength, 0.1);
			addButton(2, "Short", chooseBeardLength, 0.2);
			addButton(3, "Medium", chooseBeardLength, 0.5);
			addButton(4, "Mod. Long", chooseBeardLength, 1.5);
			addButton(5, "Long", chooseBeardLength, 3);
			addButton(6, "Very Long", chooseBeardLength, 6);
			addButton(14, "Back", chooseBeardLength);
		}
		private function chooseBeardLength(choiceLength:Number = 0):void {
			player.beardLength = choiceLength;
			menuBeardSettings();
		}
		
		//-----------------
		//-- EYES COLOURS
		//-----------------
		private function menuEyesColor(first:Boolean = false):void {
			clearOutput();
			outputText("What is your eyes color?");
			menu();
			addButton(0, "Black", pickEyesColor, "black");
			addButton(1, "Green", pickEyesColor, "green");
			addButton(2, "Blue", pickEyesColor, "blue");
			addButton(3, "Red", pickEyesColor, "red");
			addButton(4, "White", pickEyesColor, "white");
			addButton(5, "Brown", pickEyesColor, "brown");
			addButton(6, "Yellow", pickEyesColor, "yellow");
			addButton(7, "Grey", pickEyesColor, "grey");
			addButton(8, "Purple", pickEyesColor, "purple");
			addButton(10, "Golden", pickEyesColor, "golden");
			addButton(11, "Silver", pickEyesColor, "silver");
			if(!first){
				addButton(14, "Back", genericStyleCustomizeMenu);
			}

			function pickEyesColor(color:String = ""):void {
				player.eyes.colour = color;
				genericStyleCustomizeMenu();
			}
		}

		//-----------------
		//-- HEIGHT
		//-----------------
		private function setHeight():void {
			clearOutput();
			outputText("Set your height in inches.");
			outputText("\nYou can choose any height between 4 feet (48 inches) and 8 feet (96 inches).");
			var text:String;
			switch (player.gender) {
				case Gender.GENDER_MALE:
					text = "71";
					break;
				case Gender.GENDER_FEMALE:
					text = "67";
					break;
				case Gender.GENDER_NONE:
				case Gender.GENDER_HERM:
				default:
					text = "69";
					break;
			}
			menu();
			addButton(0, "OK", confirmHeight);
			addButton(4, "Back", genericStyleCustomizeMenu);
			mainViewManager.showTextInput(text, "0-9", 2);
		}
		private function confirmHeight():void {
			var text:String = mainViewManager.getTextInput();
			var asInt:int = int(text);
			clearOutput();
			if (asInt >= 48 && asInt <= 96) {
				player.tallness = asInt;
				outputText("You'll be " + Measurements.footInchOrMetres(player.tallness) + " tall. Is this okay with you?");
				doYesNo(genericStyleCustomizeMenu, setHeight);
				return;
			}
			if (asInt < 48) {
				outputText("That is below your minimum height choices!");
			}
			else if (asInt > 96) {
				outputText("That is above your maximum height choices!");
			}
			else {
				outputText("Please input your height. Off you go to the height selection!");
			}
			doNext(setHeight);
		}

		//-----------------
		//-- COCK LENGTH
		//-----------------
		private function menuCockLength():void {
			clearOutput();
			outputText("You can choose a cock length between 4 and 8 inches. Your starting cock length will also affect starting cock thickness. \n\nCock type and size can be altered later in the game through certain items.");
			menu();
			var buttons:ButtonDataList = new ButtonDataList();
			for(var i:Number = 4; i <= 8; i+= 0.5){
				buttons.add(i+"\"", curry(chooseCockLength, i));
			}
			buttons.submenu(genericStyleCustomizeMenu, 0, false);

			function chooseCockLength(length:Number):void {
				player.cocks[0].cockLength = length;
				player.cocks[0].cockThickness = Math.floor(((length / 5) - 0.1) * 10) / 10;
				genericStyleCustomizeMenu();
			}
		}

		//-----------------
		//-- BREAST SIZE
		//-----------------
		private function menuBreastSize():void {
			clearOutput();
			outputText("You can choose a breast size. Breast size may be altered later in the game.");
			menu();
			addButton( 0, "Flat",   chooseBreastSize, BreastCup.FLAT);
			addButton( 1, "A-cup",  chooseBreastSize, BreastCup.A);
			addButton( 2, "B-cup",  chooseBreastSize, BreastCup.B);
			addButton( 3, "C-cup",  chooseBreastSize, BreastCup.C);
			addButton( 4, "D-cup",  chooseBreastSize, BreastCup.D);
			addButton( 5, "DD-cup", chooseBreastSize, BreastCup.DD);
			addButton(14, "Back",   genericStyleCustomizeMenu);

			function chooseBreastSize(size:int):void {
				player.breastRows[0].breastRating = size;
				genericStyleCustomizeMenu();
			}
		}

		//-----------------
		//-- STARTER PERKS
		//-----------------
		private function chooseEndowment(clear:Boolean):void {
			const endowments:Array = [
				[true, "Strength", PerkLib.Strong, 0.25, "Are you stronger than normal? (+5 Strength)\n\nStrength increases your combat damage, and your ability to hold on to an enemy or pull yourself away."],
				[true, "Toughness", PerkLib.Tough, 0.25, "Are you unusually tough? (+5 Toughness)\n\nToughness gives you more HP and increases the chances an attack against you will fail to wound you."],
				[true, "Speed", PerkLib.Fast, 0.25, "Are you very quick?  (+5 Speed)\n\nSpeed makes it easier to escape combat and grapples.  It also boosts your chances of evading an enemy attack and successfully catching up to enemies who try to run."],
				[true, "Smarts", PerkLib.Smart, 0.25, "Are you a quick learner?  (+5 Intellect)\n\nIntellect can help you avoid dangerous monsters or work with machinery.  It will also boost the power of any spells you may learn in your travels."],
				[true, "Libido", PerkLib.Lusty, 0.25, "Do you have an unusually high sex-drive?  (+5 Libido)\n\nLibido affects how quickly your lust builds over time.  You may find a high libido to be more trouble than it's worth..."],
				[true, "Touch", PerkLib.Sensitive, 0.25, "Is your skin unusually sensitive?  (+5 Sensitivity)\n\nSensitivity affects how easily touches and certain magics will raise your lust.  Very low sensitivity will make it difficult to orgasm."],
				[true, "Perversion", PerkLib.Pervert, 0.25, "Are you unusually perverted?  (+5 Corruption)\n\nCorruption affects certain scenes and having a higher corruption makes you more prone to Bad Ends.\n"],
				[player.hasCock(), "Big Cock", PerkLib.BigCock, 1.25, "Do you have a big cock?  (+2\" Cock Length)\n\nA bigger cock will make it easier to get off any sexual partners, but only if they can take your size."],
				[player.hasCock(), "Lots of Jizz", PerkLib.MessyOrgasms, 1.25, "Are your orgasms particularly messy?  (+50% Cum Multiplier)\n\nA higher cum multiplier will cause your orgasms to be messier."],
				[player.hasVagina(), "Big Clit", PerkLib.BigClit, 1.25, "Do you have a big clit?  (1\" Long)\n\nA large enough clit may eventually become as large as a cock.  It also makes you gain lust much faster during oral or manual stimulation."],
				[player.hasVagina(), "Fertile", PerkLib.Fertile, 1.5, "Is your family particularly fertile?  (+15% Fertility)\n\nA high fertility will cause you to become pregnant much more easily.  Pregnancy may result in: Strange children, larger bust, larger hips, a bigger ass, and other weirdness."],
				[player.hasVagina(), "Wet Vagina", PerkLib.WetPussy, 2.0, "Does your pussy get particularly wet?  (+1 Vaginal Wetness)\n\nVaginal wetness will make it easier to take larger cocks, in turn helping you bring the well-endowed to orgasm quicker."],
				[player.hasBreasts(), "Big Breasts", PerkLib.BigTits, 1.5, "Are your breasts bigger than average? (DD cups)\n\nLarger breasts will allow you to lactate greater amounts, tit-fuck larger cocks, and generally be a sexy bitch."]
			];
			var buttons:ButtonDataList = new ButtonDataList();
			for each (var endowment:Array in endowments) {
				if(endowment[0]){
					buttons.add(endowment[1], curry(confirmEndowment, endowment[2], endowment[3], endowment[4]));
				}
			}
			if (clear) clearOutput();
			outputText("Every person is born with a gift.  What's yours?");
			buttons.submenu();

			function confirmEndowment(pk:PerkType, v1:Number, text:String):void {
				clearOutput();
				outputText(text);
				menu();
				addButton(0, "Yes", setEndowment, pk, v1);
				addButton(1, "No", chooseEndowment, true);
			}
			function setEndowment(pk:PerkType, v1:Number): void {
				switch (pk) {
					case PerkLib.Strong       : player.strStat.core.value += 5; break;
					case PerkLib.Tough        : player.touStat.core.value += 5; break;
					case PerkLib.Fast         : player.speStat.core.value += 5; break;
					case PerkLib.Smart        : player.intStat.core.value += 5; break;
					case PerkLib.Lusty        : player.libStat.core.value += 5; break;
					case PerkLib.Pervert      :
					case PerkLib.Sensitive    : player.sens += 5; break;
					case PerkLib.BigCock      : {
						player.cocks[0].cockLength = 8;
						player.cocks[0].cockThickness = 1.5;
						break;
					}
					case PerkLib.MessyOrgasms : player.cumMultiplier += 1.5; break;
					case PerkLib.BigTits      : player.breastRows[0].breastRating += 2; break;
					case PerkLib.BigClit      : player.clitLength += 1; break;
					case PerkLib.Fertile      : {
						player.fertility += 25;
						player.hips.type += 2;
						break;
					}
					case PerkLib.WetPussy     : player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_WET; break;
					default                   : {
						trace("Switch error");
						return chooseEndowment(true);
					}
				}
				if (!player.hasPerk(pk)) {
					player.createPerk(pk, v1, 0, 0, 0);
				}
				chooseHistory();
			}
		}

		
		//-----------------
		//-- HISTORY PERKS
		//-----------------
		public function chooseHistory():void {
			clearOutput();
			if (flags[kFLAGS.HISTORY_PERK_SELECTED] != 0) { //This flag can only be non-zero if chooseHistory is called from camp.as
				outputText("<b>New history perks are available during creation.  Since this character was created before they were available, you may choose one now!</b>\n\n");
			}
			outputText("Before you became a champion, you had other plans for your life.  What were you doing before?");
			menu();
			var historyPerks:Array = [
				["Alchemy", PerkLib.HistoryAlchemist, "You spent some time as an alchemist's assistant, and alchemical items always seem to be more reactive in your hands."],
				["Fighting", PerkLib.HistoryFighter, "You spent much of your time fighting other children, and you had plans to find work as a guard when you grew up.  You do 10% more damage with physical melee attacks.  You will also start out with 50 gems."],
				["Fortune", PerkLib.HistoryFortune, "You always feel lucky when it comes to fortune.  Because of that, you have always managed to save up gems until whatever's needed and how to make the most out it (+15% gems on victory).  You will also start out with 250 gems."],
				["Healing", PerkLib.HistoryHealer, "You often spent your free time with the village healer, learning how to tend to wounds.  Healing items and effects are 20% more effective."],
				["Religion", PerkLib.HistoryReligious, "You spent a lot of time at the village temple, and learned how to meditate.  The 'masturbation' option is replaced with 'meditate' when corruption is at or below 66."],
				["Schooling", PerkLib.HistoryScholar, "You spent much of your time in school, and even begged the richest man in town, Mr. " + (silly() ? "Savin" : "Sellet") + ", to let you read some of his books.  You are much better at focusing, and spellcasting uses 20% less fatigue."],
				["Scout", PerkLib.HistoryScout, "You spent much of your time learning use range weapons, and you had plans to find work as a hunter when you grew up.  You do 10% more damage with physical range attacks and +20% accuracy.  You will also start out with 50 gems."],
				["Slacking", PerkLib.HistorySlacker, "You spent a lot of time slacking, avoiding work, and otherwise making a nuisance of yourself.  Your efforts at slacking have made you quite adept at resting, and your fatigue comes back 20% faster."],
				["Slutting", PerkLib.HistorySlut, "You managed to spend most of your time having sex.  Quite simply, when it came to sex, you were the village bicycle - everyone got a ride.  Because of this, your body is a bit more resistant to penetrative stretching, and has a higher upper limit on what exactly can be inserted."],
				["Smithing", PerkLib.HistorySmith, "You managed to get an apprenticeship with the local blacksmith.  Because of your time spent at the blacksmith's side, you've learned how to fit armor for maximum protection."],
				["Whoring", PerkLib.HistoryWhore, "You managed to find work as a whore.  Because of your time spent trading seduction for profit, you're more effective at teasing (+15% tease damage)."]
			];
			var buttons:ButtonDataList = new ButtonDataList();

			for each (var hist:Array in historyPerks) {
				buttons.add(hist[0], curry(confirmHistory, hist[1], hist[2]));
			}
			buttons.submenu();

			function confirmHistory(choice:PerkType,desc:String):void {
				clearOutput();
				outputText(desc);
				menu();
				addButton(0, "Yes", setHistory, choice);
				addButton(1, "No", chooseHistory);
			}

			function setHistory(choice:PerkType):void {
				player.createPerk(choice, 0, 0, 0, 0);
				if (choice == PerkLib.HistorySlut || choice == PerkLib.HistoryWhore) {
					if (player.hasVagina()) {
						player.vaginas[0].virgin = false;
						player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_LOOSE;
					}
					player.ass.analLooseness = 1;
				}
				if (choice == PerkLib.HistoryFighter || choice == PerkLib.HistoryWhore || choice == PerkLib.HistoryScout) {
					player.gems += 50;
				}
				if (choice == PerkLib.HistoryFortune) {
					player.gems += 250;
				}
				flags[kFLAGS.HISTORY_PERK_SELECTED] = 1;
				completeCharacterCreation();
			}
		}

		private function completeCharacterCreation():void {
			clearOutput();
			if (customPlayerProfile != null) {
				customPlayerProfile();
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) doNext(setupGameMode);
				else doNext(startTheGame);
				return;
			}
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) setupGameMode();
			else startTheGame();
		}

		public function arrival():void {
			statScreenRefresh();
			model.time.hours = 11;
			clearOutput();
			outputText("You are prepared for what is to come.  Most of the last year has been spent honing your body and mind to prepare for the challenges ahead.  You are the Champion of Ingnam.  The one who will journey to the demon realm and guarantee the safety of your friends and family, even though you'll never see them again.  You wipe away a tear as you enter the courtyard and see Elder Nomur waiting for you.  You are ready.\n\n");
			outputText("The walk to the tainted cave is long and silent.  Elder Nomur does not speak.  There is nothing left to say.  The two of you journey in companionable silence.  Slowly the black rock of Mount Ilgast looms closer and closer, and the temperature of the air drops.   You shiver and glance at the Elder, noticing he doesn't betray any sign of the cold.  Despite his age of nearly 80, he maintains the vigor of a man half his age.  You're glad for his strength, as assisting him across this distance would be draining, and you must save your energy for the trials ahead.\n\n");
			outputText("The entrance of the cave gapes open, sharp stalactites hanging over the entrance, giving it the appearance of a monstrous mouth.  Elder Nomur stops and nods to you, gesturing for you to proceed alone.\n\n");
			outputText("The cave is unusually warm and damp, ");
			if (player.gender == Gender.GENDER_FEMALE)
				outputText("and your body seems to feel the same way, flushing as you feel a warmth and dampness between your thighs. ");
			else outputText("and your body reacts with a sense of growing warmth focusing in your groin, your manhood hardening for no apparent reason. ");
			outputText("You were warned of this and press forward, ignoring your body's growing needs.  A glowing purple-pink portal swirls and flares with demonic light along the back wall.  Cringing, you press forward, keenly aware that your body seems to be anticipating coming in contact with the tainted magical construct.  Closing your eyes, you gather your resolve and leap forwards.  Vertigo overwhelms you and you black out...");
			showStats();
			dynStats("lus", 15);
			doNext(arrivalPartTwo);
		}
		
		private function arrivalPartTwo():void {
			clearOutput();
			hideUpDown();
			dynStats("lus", 40, "cor", 2);
			model.time.hours = 18;
			outputText("You wake with a splitting headache and a body full of burning desire.  A shadow darkens your view momentarily and your training kicks in.  You roll to the side across the bare ground and leap to your feet.  A surprised looking imp stands a few feet away, holding an empty vial.  He's completely naked, an improbably sized pulsing red cock hanging between his spindly legs.  You flush with desire as a wave of lust washes over you, your mind reeling as you fight ");
			if (player.gender == Gender.GENDER_FEMALE)
				outputText("the urge to chase down his rod and impale yourself on it.\n\n");
			else
				outputText("the urge to ram your cock down his throat.  The strangeness of the thought surprises you.\n\n");
			outputText("The imp says, \"<i>I'm amazed you aren't already chasing down my cock, human.  The last Champion was an eager whore for me by the time she woke up.  This lust draft made sure of it.</i>\"");
			doNext(arrivalPartThree);
		}
		
		private function arrivalPartThree():void {
			clearOutput();
			hideUpDown();
			dynStats("lus", -30);
			outputText("The imp shakes the empty vial to emphasize his point.  You reel in shock at this revelation - you've just entered the demon realm and you've already been drugged!  You tremble with the aching need in your groin, but resist, righteous anger lending you strength.\n\nIn desperation you leap towards the imp, watching with glee as his cocky smile changes to an expression of sheer terror.  The smaller creature is no match for your brute strength as you pummel him mercilessly.  You pick up the diminutive demon and punt him into the air, frowning grimly as he spreads his wings and begins speeding into the distance.\n\n");
			outputText("The imp says, \"<i>FOOL!  You could have had pleasure unending... but should we ever cross paths again you will regret humiliating me!  Remember the name Zetaz, as you'll soon face the wrath of my master!</i>\"\n\n");
			outputText("Your pleasure at defeating the demon ebbs as you consider how you've already been defiled.  You swear to yourself you will find the demon responsible for doing this to you and the other Champions, and destroy him AND his pet imp.");
			doNext(arrivalPartFour);
		}
		
		private function arrivalPartFour():void {
			clearOutput();
			hideUpDown();
			outputText("You look around, surveying the hellish landscape as you plot your next move.  The portal is a few yards away, nestled between a formation of rocks.  It does not seem to exude the arousing influence it had on the other side.  The ground and sky are both tinted different shades of red, though the earth beneath your feet feels as normal as any other lifeless patch of dirt.   You settle on the idea of making a camp here and fortifying this side of the portal.  No demons will ravage your beloved hometown on your watch.\n\nIt does not take long to set up your tent and a few simple traps.  You'll need to explore and gather more supplies to fortify it any further.  Perhaps you will even manage to track down the demons who have been abducting the other champions!");
			awardAchievement("Newcomer", kACHIEVEMENTS.STORY_NEWCOMER, true, true);
			doNext(playerMenu);
		}
		
		//-----------------
		//-- GAME MODES
		//-----------------
		private function setupGameMode():void {
			clearOutput();
			var screen:String = "[u: Current difficulty settings:]\n";
			screen += "\n[b: Hardcore mode: ]" + (flags[kFLAGS.HARDCORE_MODE] > 0 ? "ON" : "OFF");
			screen += "\n\tIf enabled: The game autosaves, debug and easy modes are disabled, and there is no continuing from bad ends. Can not be turned off after starting.";
			screen += "\n\n[b: Hunger: ]";
			switch (flags[kFLAGS.HUNGER_ENABLED]){
				case 1: screen += "Realistic"; break;
				case 0.5: screen += "On"; break;
				default: screen += "Off";
			}
			screen += "\n\tIf enabled: You will need to eat food periodically. With this set to realistic your cum production is capped and having oversized parts will weigh you down. Can not be turned off after starting.";
			var difficulty:int = flags[kFLAGS.GAME_DIFFICULTY];
			var names:Array = ["Normal", "Hard", "Nightmare", "Brutal", "Extreme"];
			screen += "\n\n[b: Difficulty: ]";
			if (difficulty < names.length){
				screen += difficulty + " " + names[difficulty];
			} else {
				screen += "Endless + " + difficulty;
			}
			outputText(screen);
			menu();
			addButton(0, "Finish", finalizeGameMode);
			addButton(1, "Difficulty +", changeDifficulty, 1);
			addButton(6, "Difficulty -", changeDifficulty, -1);
			addButton(2, "Hunger", changeHunger);
			addButton(3, "Hardcore", changeHardcore);


			function finalizeGameMode():void {
				if (flags[kFLAGS.HUNGER_ENABLED]){
					player.hunger = 80;
				}
				if (flags[kFLAGS.HARDCORE_MODE] <= 0) {
					outputText("\n\n[b: Difficulty can be adjusted at any time.]");
					doNext(startTheGame);
				} else {
					outputText("\n\nDebug Mode and Easy Mode are disabled in this game mode. \n\nPlease choose a slot to save in. You may not make multiple copies of saves. \n\n[b: Difficulty is locked.]");
					menu();
					for (var i:int = 0; i < 14; i++) {
						addButton(i, "Slot " + (i + 1), chooseSlotHardcore, (i + 1));
					}
					addButton(14, "Back", setupGameMode);
				}
			}
			function changeHunger():void {
				flags[kFLAGS.HUNGER_ENABLED] += 0.5;
				flags[kFLAGS.HUNGER_ENABLED] = flags[kFLAGS.HUNGER_ENABLED] % 1.5;
				setupGameMode();
			}
			function changeHardcore():void {
				flags[kFLAGS.HARDCORE_MODE] = !flags[kFLAGS.HARDCORE_MODE];
				setupGameMode();
			}
			function changeDifficulty(by:int = 1):void {
				flags[kFLAGS.GAME_DIFFICULTY] = Math.max(flags[kFLAGS.GAME_DIFFICULTY] += by, 0);
				setupGameMode();
			}
			function chooseSlotHardcore(num:int):void {
				flags[kFLAGS.HARDCORE_SLOT] = "CoC_" + num;
				startTheGame();
			}
		}

		private function startTheGame():void {
			player.startingRace = player.race();
			if (flags[kFLAGS.HARDCORE_MODE] > 0) {
				trace("Hardcore save file " + flags[kFLAGS.HARDCORE_SLOT] + " created.");
                CoC.instance.saves.saveGame(flags[kFLAGS.HARDCORE_SLOT])
            }
			CoC.instance.saves.loadPermObject();
			flags[kFLAGS.MOD_SAVE_VERSION] = CoC.instance.modSaveVersion;
			statScreenRefresh();
			chooseToPlay();
		}

		public function chooseToPlay():void {
			if (player.femininity >= 55) player.setUndergarment(undergarments.C_PANTY);
			else player.setUndergarment(undergarments.C_LOIN);
			if (player.biggestTitSize() >= 2) player.setUndergarment(undergarments.C_BRA);
			else player.setUndergarment(undergarments.C_SHIRT);
			if (player.hasPerk(PerkLib.HistoryAlchemist) || player.hasPerk(PerkLib.HistoryFortune) || player.hasPerk(PerkLib.HistoryHealer) || player.hasPerk(PerkLib.HistoryReligious) || player.hasPerk(PerkLib.HistorySlacker) || player.hasPerk(PerkLib.HistorySlut)) player.perkPoints += 1;
			clearOutput();
			statScreenRefresh();
			outputText("Would you like to play through the " + (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) + "-day");
			outputText(" prologue in Ingnam or just skip?");
			player.HP = player.maxHP();
			doYesNo(goToIngnam, arrival);
		}

		public function goToIngnam():void {
			model.time.days = -(1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			model.time.hours = 8;
			flags[kFLAGS.IN_INGNAM] = 1;
			SceneLib.ingnam.menuIngnam();
		}

		//-----------------
		//-- ASCENSION
		//-----------------
		public function ascensionMenu():void {
			hideStats();
			clearOutput();
			hideMenus();
			EngineCore.displayHeader("Ascension");
			outputText("The world you have departed is irrelevant and you are in an endless black void dotted with tens of thousands of stars. You encompass everything and everything encompasses you.");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			outputText("\n\n(When you're done, select Reincarnate.)");
			menu();
			addButton(10, "Rename", renamePrompt).hint("Change your name at no charge?");
			addButton(11, "Reincarnate", reincarnatePrompt).hint("Reincarnate and start an entirely new adventure?");
		}
		
		private function renamePrompt():void {
			clearOutput();
			outputText("You may choose to change your name.");
			menu();
			addButton(0, "OK", chooseName);
			addButton(4, "Back", ascensionMenu);
			mainViewManager.showTextInput(player.short,null,16);
		}
		
		private function reincarnatePrompt():void {
			clearOutput();
			outputText("Would you like to reincarnate and start a new life as a Champion?");
			doYesNo(reincarnate, ascensionMenu);
		}
		private function reincarnate():void {
			flags[kFLAGS.NEW_GAME_PLUS_LEVEL]++;
			customPlayerProfile = null;
			newGameGo();
			clearOutput();
			outputText("Everything fades to white and finally... black. You can feel yourself being whisked back to reality as you slowly awaken in your room. You survey your surroundings and recognize almost immediately; you are in your room inside the inn in Ingnam! You get up and look around. ");
			if (player.hasKeyItem("Sky Poison Pearl") >= 0) {
				outputText("\n\nYou soon noticing a circular green imprint at the palm of your left hand. When you trying to figure out it meaning something clicks in your mind. It's a strange artifact that fused with your body that allow storing many things inside. Artifact that fused with your body? You are unable to recall when did yo... Wait a second there are few almost fully faded away memory fragments of you been somewhere underwater fearlessly facing some huge monster with tentacles as it legs... Doing you utermost efforts no other memories even slightest fragments apprear in your mind. Resigned you try to concentrate on remembering how to use this thing but those memories are still too blurred. Maybe with time you remember all about this... 'thing'.")
			}
			player.breastRows = [];
			player.cocks = [];
			player.vaginas = new <VaginaClass>[];
			player.horns.count = 0;
			player.horns.type = Horns.NONE;
			player.antennae.type = Antennae.NONE;
			player.ears.type = Ears.HUMAN;
			player.eyes.type = Eyes.HUMAN;
			player.tongue.type = Tongue.HUMAN;
			player.gills.type = Gills.NONE;
			player.arms.type = Arms.HUMAN;
			player.wings.type = Wings.NONE;
			player.wings.desc = "non-existant";
			player.rearBody.type = RearBody.NONE;
			player.lowerBody = LowerBody.HUMAN;
			player.legCount = 2;
			player.tailType = Tail.NONE;
			player.tailRecharge = 0;
			player.level = 1;
			player.teaseLevel = 0;
			player.teaseXP = 0;
			player.statPoints = 0;
			player.perkPoints = 0;
			player.XP = 0;
			player.setWeapon(WeaponLib.FISTS);
			player.setWeaponRange(WeaponRangeLib.NOTHING);
			player.setShield(ShieldLib.NOTHING);
			player.setJewelry(JewelryLib.NOTHING);
			inventory.clearStorage();
			inventory.clearGearStorage();
			inventory.initializeGearStorage();
			//Inventory clear
			for (var i:int = 0; i < player.itemSlots.length; i++) {
				var itemSlot:ItemSlotClass = player.itemSlots[i];
				itemSlot.emptySlot();
				itemSlot.unlocked = i <= 4; // 1 - 5 unlocked by default
			}
			doNext(removeLevelPerks);
		}
		
		private function removeLevelPerks():void {
			clearOutput();
			player.perkPoints = player.level - 1;
			player.removePerks();
			outputText("After looking around the room for a while, you look into the mirror and begin to recollect who you are...");
			doNext(routeToGenderChoiceReincarnation);
		}
		
		private function routeToGenderChoiceReincarnation():void {
			clearOutput();
			genericGenderChoice();
		}
		
		private function isSpecialKeyItem(keyName:* = null):Boolean {//tylko sky poinson pearl zostawić tutaj
			return (keyName == "Sky Poison Pearl" || keyName == "Nieve's Tear"); 
		}

		private function isSpell(statusEffect:* = null):Boolean {	
			return (statusEffect == StatusEffects.KnowsWereBeast);	//na razie jest tu tylko werebeast
		}	//ale potem zamienić to naspecialne kiPowers z każdego z klanów


		// [Button Name, Name of part on player, list of enum values]
		private const raceParts:Array = [
			["Antennae" , "antennae"     , Antennae.Types   ],
			["Arms"     , "arms"         , Arms.Types       ],
			["Beard"    , "beardStyle"   , Beard.Types      ],
			["Claws"    , "clawsPart"    , Claws.Types      ],
			["Ears"     , "ears"         , Ears.Types       ],
			["Eyes"     , "eyes"         , Eyes.Types       ],
			["Face"     , "faceType"     , Face.Types       ],
			["Gills"    , "gills"        , Gills.Types      ],
			["Hair"     , "hairType"     , Hair.Types       ],
			["Horns"    , "horns"        , Horns.Types      ],
			["LowerBody", "lowerBodyPart", LowerBody.Types  ],
			["RearBody" , "rearBody"     , RearBody.Types   ],
			//["Skin"     , Skin.Types],  TODO: Skin is special (skin.base/skin.coat)
			["Tail"     , "tail"         , Tail.Types       ],
			["Tongue"   , "tongue"       , Tongue.Types     ],
			["Wings"    , "wings"        , Wings.Types      ]
		];
		public function detailedRaceSetup(returnTo:Function):void {
			if(returnTo == null) {
				returnTo = genericStyleCustomizeMenu; // Allows debug menu access to prevent redoing character creation
			}
			CoC.instance.playerAppearance.appearance(); //TODO: Change this? Not sure if this is fine for this purpose
			var buttons:ButtonDataList = new ButtonDataList();
			for each (var part:Array in raceParts){
				buttons.add(part[0], curry(detailedRaceSubmenu, part[1], part[2], returnTo));
			}
			buttons.submenu(returnTo);
		}

		private function detailedRaceSubmenu(partLoc:String, enumVals:Array, returnTo:Function):void {
			var pattern:RegExp = /\b\w/g; //Matches first character of every word
			var buttons:ButtonDataList = new ButtonDataList();
			for each(var val:EnumValue in enumVals) {
				buttons.add(
					val.id.split("_").join(" ").toLowerCase().replace(pattern, caps), // Change "PART_ID_STRING" to "Part Id String"
					curry(applySelected, partLoc, val, returnTo)
				);
			}
			buttons.submenu(curry(detailedRaceSetup, returnTo));

			function caps(...args):String {
				return args[0].toUpperCase();
			}
			function applySelected(loc:String, selected:EnumValue, returnTo:Function):void {
				if(player[loc] is int){
					player[loc] = selected.value;
				} else {
					player[loc].type = selected.value;
				}
				detailedRaceSetup(returnTo)
			}
		}
	}
}
