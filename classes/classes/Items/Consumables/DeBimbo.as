/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Consumables
{
	import classes.Creature;
	import classes.Items.Consumable;
	import classes.PerkLib;

	public final class DeBimbo extends Consumable {
		
		public function DeBimbo() {
			super("Debimbo", "Debimbo", "a bottle marked as 'Debimbo'", 250);
		}
		
		override public function get description():String
		{
			if (game.player.hasPerk(PerkLib.BimboBrains) || game.player.hasPerk(PerkLib.FutaFaculties))
				return "This should totally like, fix your brain and stuff.  You don't really think anything is wrong with your head - it feels all pink and giggly all the time.";
			else
				return "This draft is concocted from five scholar's teas and who knows what else.  Supposedly it will correct the stupifying effects of Bimbo Liqueur. \n\nType: Consumable";
		}
		
		override public function canUse(host:Creature):String {
			if (!(host.hasPerk(PerkLib.BimboBrains) || host.hasPerk(PerkLib.FutaFaculties) || host.hasPerk(PerkLib.BroBrains))) {
				return "You can't use this right now, and it's too expensive to waste!\n\n";
			}
			return super.canUse(host);
		}
		
		override public function useItem(host:Creature):Boolean {
			if (host.hasPerk(PerkLib.BimboBrains)) {
				outputText("\n\n(<b>Perk Removed:  Bimbo Brains - Your intelligence and speech patterns are no longer limited to that of a bimbo.</b>)");
				host.removePerk(PerkLib.BimboBrains);
			}
			else if (host.hasPerk(PerkLib.FutaFaculties)) {
				outputText("\n\n(<b>Perk Removed:  Futa Faculties - Your intelligence and speech patterns are no longer limited to that of a futanari bimbo.</b>)");
				host.removePerk(PerkLib.FutaFaculties);
			}
			else if (host.hasPerk(PerkLib.BroBrains)) {
				outputText("\n\n(<b>Perk Removed:  Bro Brains - Your intelligence and speech patterns are no longer limited to that of a male who constantly works out.</b>)");
				host.removePerk(PerkLib.BroBrains);
			}
			return(false);
		}

		override public function useText(host:Creature):String {
			if (host.hasPerk(PerkLib.BroBrains)) {
				return "You pinch your nose and swallow the foul-tasting mixture with a grimace.  Oh, that's just <i>nasty!</i>  You drop the vial, which shatters on the ground, clutching at your head as a wave of nausea rolls over you.  Stumbling back against a rock for support, you close your eyes.  A constant, pounding ache throbs just behind your temples, and for once, you find yourself speechless.  A pained groan slips through your lips as thoughts and memories come rushing back.  One after another, threads of cognizant thought plow through the simple matrices of your bro mind, shredding and replacing them."
						+ "\n\nYou... you were a brute who constantly thinks of working out and fucking!  You shudder as your faculties return, the pain diminishing with each passing moment.";
			}

			return "Well, time to see what this smelly, old rat was on about!  You pinch your nose and swallow the foul-tasting mixture with a grimace.  Oh, that's just <i>nasty!</i>  You drop the vial, which shatters on the ground, clutching at your head as a wave of nausea rolls over you.  Stumbling back against a rock for support, you close your eyes.  A constant, pounding ache throbs just behind your temples, and for once, you find yourself speechless.  A pained groan slips through your lips as thoughts and memories come rushing back.  One after another, threads of cognizant thought plow through the simple matrices of your bimbo mind, shredding and replacing them."
					+ "\n\nYou... you were an air-headed ditz!  A vacuous, idiot-girl with nothing between her ears but hunger for dick and pleasure!  You shudder as your faculties return, the pain diminishing with each passing moment.";
		}
	}
}
