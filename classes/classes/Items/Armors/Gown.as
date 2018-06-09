//forest gown that has a slow progression to a dryad

package classes.Items.Armors
{
	import classes.BodyParts.*;
	import classes.CoC;
	import classes.Creature;
	import classes.EventParser;
	import classes.Items.Armor;
	import classes.Player;
	import classes.Scenes.SceneLib;
	import classes.TimeAwareInterface;
	import classes.internals.Utils;
	import classes.lists.BreastCup;
	import classes.lists.Gender;

	public class Gown extends Armor implements TimeAwareInterface {
 
		
		public function Gown():void {
			super("FrsGown","FrsGown","Forest Gown","A Forest Gown.",1,10,"This the very earthy gown commonly worn by dryads.   It is made from a mixture of plants.   The predominate fabric looks like a weave of fresh grass.   It is decorated by simple flowers that are attached to it.   Strangely, everything seems alive like it was still planted.   There must be some peculiar magic at work here.","Light");
		
			EventParser.timeAwareClassAdd(this);
		}
		private function get player():Player{ //need the instance of player
			return CoC.instance.player;
		}
		override public function useText(host:Creature):String { //Produces any text seen when equipping the armor normally
			var text:String;
			switch (player.gender) {
				case Gender.GENDER_FEMALE:
					text = "You comfortably slide into the forest gown.   You spin around several times and giggle happily."
							+ " Where did that come from?\n";
					break;

				case  Gender.GENDER_MALE:
					text = "You slide forest gown over your head and down to your toes. It obviously would fit someone more female."
							+ " You feel sad and wish you had the svelte body that would look amazing in this gown."
							+ " Wait, did you always think that way?\n";
					break;
				default :  //non-binary
					text = "You slide the gown over your head and slip it into place.\n";
			}
			return text + "[if(hascock)You notice the bulge from [cock] in the folds of the dress and wish it wasn't there.\n]";
		}
		public function timeChangeLarge():Boolean {	return false;	}
		
		public function timeChange():Boolean {
			if (player.armor is Gown && CoC.instance.model.time.hours == 5) { //only call function once per day as time change is called every hour
				dryadProgression(); 
				return true;
			}
			return false; //stop if not wearing
		}

		public function dryadProgression():void {
			var verb:String; 
			var text:String;
			var x :int;
			var tfChoice :Array = []; 
			var dryadDreams:Array = [
				"In your dream you find yourself in a lush forest standing next to a tree. The tree seems like your best friend and You give it a hug before sitting down next to it. Looking around, there is grass and flowers all about. You can’t help but hum a cheery tune enjoying nature as a bright butterfly flutters nearby, holding out your hand the butterfly lands softly on your finger and smile sweetly to it.",
				"You walk through a meadow and down towards a swift running brook, It looks like some clean water.   You sit down, pull up your gown and admire your feet. They are brown, the color of bark.   You place your feet in the cool water of the brook and soak up the water through your feet,  a cool refreshing feeling fills your body. Ah, being a Dryad is so nice.",
				"Your imagination runs a bit wild and you picture yourself dressed in your nice forest gown eyeing a satyr you stumble across in a grove.   You can't help but smirk as you consider all the fun you could have with him.",
				"You imagine running into a waterfall. You dance around playfully while torrents of water splash against your body.  Your soaked gown scandalously clings to your frame.",
				"You dream about tending to plants in a meadow. Some fairies are following you.  One of them buzzes around your head playfully and kisses you on the cheek.",
				"In your dream you are laying out in a lush glade soaking up the sun. You inspect your leafy hair and find that here are some buds forming. You can't help but wonder what the flowers will look like. ",
				"You dream of a starlight dance in the meadow. Several satyrs, nymphs and dryads are gathered together to celebrate the full moon. You take your gown off and gather around the fairy circle. The half dozen naked revelers dance the night away in the pale moonlight.",
				"You dream of skipping joyfully through a flowered meadow. After a while you kneel down and pick several budding flowers, placing them in your hair  you find that they merge with the leafy vines. They will bloom in a day or so.  It will be so lovely.",
				"In your dream, you and another dryad dance for a reed playing satyr. The dance is very intimate and you can't help wonder how excited the satyr will become from watching. ",
				"You dream of being in a lush grove watching a satyr sleeping. He is leaning up against a tree that you are very fond of! Some mischief is in order. You politely ask the tree for help and it lowers several vines that lift you up and move you above him. The vine lowers you mere inches away from his body. You can practically hear him breathing and his chest rising and falling slowly.  Leaning forward, you nibble on his ear, jolting him awake with a surprised look in his eyes just in time to see the vines recede back into the tree.   Chuckling to yourself, you watch the satry try to figure out what just happened from a branch above him. ",
				"You dream of being in a field surrounded by butterflies. There are blue ones, yellow ones, and pink ones, buthich ones are your favorite?   You spin around in your gown and laugh as you decide they are all your favorite!",
				"You dream about wandering around in the mountains. There is snow everywhere, and you notice something off in the distance digging its way out from under the snow. It’s a big bear and two smaller ones pawing their way out! You gleefully saunter up and say, 'Hello Mrs.bear, did you and your children enjoy your nap?'   You awake shortly after the strange dream, feeling confused. Was that really you?",
				"You dream about sitting on a tree branch in your lovely gown. You freely hang off the large oak, dangling over the side while your legs hold you up.   Your gown falls down to your arms and hangs over your head. You get excited, pondering if someone might be watching and just got flashed.   You sit back up and straighten out your gown,  coy smile playing across your face.",
			];
			//display a random dream
			clearOutput();
			outputText("\n\n"+Utils.randomChoice(dryadDreams)+"\n\n");
			//build a list of non ideal parts 
			if (player.hips.type != Hips.RATING_FERTILE)
				 tfChoice.push("hips");
			if (player.butt.type != Butt.RATING_NOTICEABLE)
				tfChoice.push("butt");
			if (player.hasCock() != false )
				tfChoice.push("cock");
			if (player.breastRows[0].breastRating != BreastCup.D)
				tfChoice.push("breasts");
			if (player.femininity < 70)
				tfChoice.push("girlyness");

			//progress slowly to the ideal dryad build	
			switch (Utils.randomChoice(tfChoice)) {
				case "hips":
						outputText("You wiggle around in your gown, pleasant feeling of flower petals rubbing against your skin washes over you.  The feeling settles on your [hips].\n");

						if (player.hips.type < Hips.RATING_FERTILE) {
							verb = "enlarge";
							player.hips.type++;
						}
						if (player.hips.type > Hips.RATING_FERTILE) {
							verb = "shrink";
							player.hips.type--;
						} 
						if (player.hips.type== Hips.RATING_FERTILE)
							break;
						outputText("You feel them slowly " + verb + ".<b>  You now have [hips].</b>\n"); 

					break;

				case "butt":
					outputText("You wiggle around in your gown, the pleasant feeling of flower petals rubbing against your skin washes over you.  The feeling settles on your [butt].\n");
				
					if (player.butt.type < Butt.RATING_NOTICEABLE) {
						verb = "enlarge";
						player.butt.type++;
					
					}
					if (player.butt.type > Butt.RATING_NOTICEABLE) {
						verb = "shrink";	
						player.butt.type--;
						
					} 
					if (player.butt.type == Butt.RATING_NOTICEABLE)
						break;

					outputText("You feel them slowly " + verb + ". <b>You now have a [butt].</b>"); 
	
					break;

				case "cock":
					outputText("You wake up to find a nice <b>pink egg</b> on your gown. \n\n What a nice treat. \n\n  You gobble it down not giving through as to how it got there.\n");
					SceneLib.mutationsTable.pinkEgg(false, player, false);
					break;

				case "breasts":
					outputText("You feel like a beautful flower in your gown.  Dawn approaches and you place your hands on your [breasts] as if expecting your nipples to bloom to greet the rising sun.\n");
		
				if (player.bRows() > 1) {
					x = 1;
					outputText("<b>Some of your breasts shrink back into your body leaving you with just two.</b>");
					while (x < player.bRows()) {
						if (player.breastRows[x].breastRating < 1) {
							player.breastRows[x].breastRating = 1;
							outputText("Your extra breasts shrink back into your body.");
						}
					
						x++;
					}
				}
				if (player.breastRows[0].breastRating > BreastCup.D )
					{
						player.breastRows[0].breastRating = BreastCup.D;
						outputText("A chill runs against your chest and your boobs become smaller.\n<b> You now have [breasts]</b>\n\n");

					}
					
				if ( player.smallestTitSize() < BreastCup.D )
					{
						player.breastRows[0].breastRating = BreastCup.D;
						outputText("Heat builds in chest and your boobs become bigger.\n\n<b>You now have [breasts]</b>");

					}
				
				break;

				case "girlyness":
					text = player.modFem(70, 2);
					if (text == "") break;
					outputText("You run your hands across the fabric of your Gown, then against your face as it feels like there is something you need to wipe off.\n");
					outputText(text);
					break;
					
				default:
					outputText("\nERROR: this forest gown TF choice shouldn't ever get called.");
			}
			outputText("\n\n"); //spacing issues
			if (tfChoice.length == 0) DryadProg();   //if no small changes, start big changes
		}

		public function DryadProg():void {

		//types of changes
			var tfChoice:String = Utils.randomChoice("skin", "ears", "face", "lowerbody", "arms", "hair");
			outputText("\n\n");
			switch (tfChoice) {
			case "ears":
				if (player.ears.type!== Ears.ELFIN) {
					outputText("There is a tingling on the sides of your head as your ears change to pointed elfin ears.");
					player.ears.type = Ears.ELFIN;
				}
				break;

			case "skin":
				if (player.skinType!== Skin.PLAIN) {
					outputText("A tingling runs up along your [skin] as it changes back to normal");
				} else if (player.skinType !== Skin.BARK && player.skin.type == Skin.PLAIN) {
					outputText("Your skin hardens and becomes the consistency of tree’s bark."); 
					player.skinTone = "woodly brown";
					player.skinType= Skin.BARK;
				}
				break;

			case "lowerbody":
				if (player.lowerBody !== LowerBody.HUMAN) {
					outputText("There is a rumbling in your lower body as it returns to a human shape.");
					player.lowerBody = LowerBody.HUMAN;
				}
				break;

			case "arms":
				if (player.arms.type !== Arms.HUMAN) {
					outputText("Your hands shake and shudder as they slowly transform back into normal human hands.");
					player.arms.type = Arms.HUMAN;
					//kGAMECLASS.mutations.updateClaws();
					//needs mutations updated from revamp, or some workaround, or wood claws added?
				}
				break;

			case "face":
				if (player.faceType !== Face.HUMAN) {
					outputText("Your face twitches a few times and slowly morphs itself back to a normal human face.");
					player.faceType = Face.HUMAN;
				}
				break;

			case "hair":
				if (player.hairType !== Hair.GRASS) {
					outputText("Much to your shock, your [haircolor] hair begins falling out in tuffs onto the ground. "
					          +" Moments later, your scalp sprouts vines all about that extend down and bloom into leafy hair.");
					player.hairType = Hair.GRASS;
					player.hairColor = "green";
					outputText("\n<b> You now have [haircolor] leaf hair.</b>");
				}

				break;
			default:
				outputText("\nERROR: this forest gown TF choice shouldn't ever get called.");
			}
		}
	}
}
