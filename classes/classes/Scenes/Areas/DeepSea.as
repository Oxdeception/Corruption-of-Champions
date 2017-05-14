/**
 * @author Stadler (mostly) and Ormael (choice of enemies encounters and other events)
 * Area with lvl 50-70 enemies.
 * Currently a Work in Progress.
 */

package classes.Scenes.Areas 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.DeepSea.*;
	
	use namespace kGAMECLASS;
	
	public class DeepSea extends BaseContent
	{
		
		public function DeepSea() 
		{
		}
		
		public function exploreDeepSea():void {
			flags[kFLAGS.DISCOVERED_DEEP_SEA]++
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0;	//Scylla
			choice[choice.length] = 1;	//Kraken
			if (rand(4) == 0) choice[choice.length] = 2;	 //Find nothing! The rand will be removed from this once the Deep Sea is populated with more encounters.
			
			select = choice[rand(choice.length)];
			switch(select) {
			/*	case 0:
					kGAMECLASS.exploration.genericImpEncounters2();
					break;
				case 1:
					kGAMECLASS.exploration.genericDemonsEncounters1();
					break;
			*/	default:
					outputText("You swim through the depths of the sea barely seeing anything for over an hour, finding nothing before you decied to give up and return to the shore.\n\n", true);
					if (rand(2) == 0) {
						//1/3 chance for strength
						if (rand(3) == 0 && player.str < 200) {
							outputText("The effort of struggling in the ocean depths has made you stronger.", false);
							dynStats("str", .5);
						}
						//1/3 chance for toughness
						else if (rand(3) == 1 && player.tou < 200) {
							outputText("The effort of struggling in the ocean depths has made you tougher.", false);
							dynStats("tou", .5);
						}
						//1/3 chance for speed
						else if (rand(3) == 2 && player.spe < 200) {
							outputText("The effort of struggling in the ocean depths has made you faster.", false);
							dynStats("tou", .5);
						}
					}
					doNext(camp.returnToCampUseTwoHours);
			}
			
		}
		
	}

}