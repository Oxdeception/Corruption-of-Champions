package classes.BodyParts {
import classes.Creature;

public class Ears extends BodyPart {
	public static const HUMAN:int     = 0;
	public static const HORSE:int     = 1;
	public static const DOG:int       = 2;
	public static const COW:int       = 3;
	public static const ELFIN:int     = 4;
	public static const CAT:int       = 5;
	public static const LIZARD:int    = 6;
	public static const BUNNY:int     = 7;
	public static const KANGAROO:int  = 8;
	public static const FOX:int       = 9;
	public static const DRAGON:int    = 10;
	public static const RACCOON:int   = 11;
	public static const MOUSE:int     = 12;
	public static const FERRET:int    = 13;
	public static const PIG:int       = 14;
	public static const RHINO:int     = 15;
	public static const ECHIDNA:int   = 16;
	public static const DEER:int      = 17;
	public static const WOLF:int      = 18;
	public static const LION:int      = 19;
	public static const YETI:int      = 20;
	public static const ORCA:int      = 21;
	public static const SNAKE:int     = 22;
	public static const GOAT:int      = 23;
	public static const ONI:int       = 24;
	public static const ELVEN:int     = 25;
	public static const WEASEL:int    = 26;
	public static const BAT:int       = 27;
	public static const VAMPIRE:int   = 28;
	public static const RED_PANDA:int = 29;
	
	public function Ears(creature:Creature, publicPrimitives:Array) {
		super(creature, publicPrimitives);
	}
}
}
