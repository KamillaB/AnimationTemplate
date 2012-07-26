package properties
{
	import components.InfoFieldSkin;
	
	import fl.transitions.easing.Regular;
	
	import flash.text.TextFormat;
	
	import items.BackgroundObject;
	import items.InfoButtonObject;
	import items.InfoFieldObject;
	import items.TitleFieldObject;

	//[Embed(source='/AnimationTemplateMath.swf')]
	public class FrameProperties
	{
		public static const BOTTOM_RIGHT : String = "FrameProperties.BOTTOM_RIGHT";
		public static const BOTTOM_LEFT : String = "FrameProperties.BOTTOM_LEFT";
		public static const TOP_LEFT : String = "FrameProperties.TOP_LEFT";
		public static const TOP_RIGHT : String = "FrameProperties.TOP_RIGHT";
		
		public static var backgroundMcSkinName : String;
		public static var backgroundMcSkinClass : Class;
		
		public static var titleFieldSkinName : String;
		public static var titleFieldSkinClass : Class;
		
		public static var infoButtonSkinName : String;
		public static var infoButtonClassName : Class;
		
		public static var infoFieldSkinName : String;
		public static var infoFieldSkinClass : Class;
		
		public var backgroundMc : BackgroundObject;
		public var titleFieldMc : TitleFieldObject;
		public var infoButtonMc : InfoButtonObject; 
		public var infoFieldMc : InfoFieldObject;
		
		public function FrameProperties()
		{
			//ANIMACIO HATTERE
			//a timeline-on lévő background-nak az instance neve, 
			//ha kicserled a timeline-on a background-ot, akkor igy kell elnevezni, vagy ha maskepp nevezed el, akkor az uj nevet itt at kell irni
			backgroundMcSkinName = "backgroundMc";
			//ha nincsen a timeline-on background, de itt be van allitva, hogy kell, akkor ezt az osztalyt fogja berantani a Library-bol
			//ez tok jo, akkor, ha cserelni szeretned a mainbackground-t, 
			//csinalsz egy masik symbol-t es elnevezed, jobb gombbal klikkel a MainBackground-ra a library-ben es nezd meg a property-kt, ugy kell majd beallitani a masiknak is
			backgroundMcSkinClass = MainBackground;
			
			setMainBackgroundProperties();			
			
			//ANIMACIO LOGO+CIM
			titleFieldSkinName = "titleFieldMc";
			titleFieldSkinClass = TitlefieldSkin;
			
			setTitleProperties( );
			
			//ANIMACIO Info gomb			
			infoButtonSkinName = "infoButtonMc";
			infoButtonClassName = InfoButtonSkin;
						
			setInfoButton( );
			
			//ANIMACIO infofield
			infoFieldSkinName = "infoField";
			infoFieldSkinClass = InfoFieldSkin;
			
			setInfoField( );
			
			//keret szövegeinek beállítása
			setFrameTexts( );
		
			
			
		}
		
		/**
		 * Keret szövegeinek megadása
		 * Információ
		 * Cím + alcím(alcímek) 
		 * 
		 */		
		public function setFrameTexts( ) : void
		{
			titleFieldMc.titleTexts = new Array( );
			
			//itt lehet megadni a keret cimenek szoveget
			//ahany elem lesz a tombben, annyi sorba fog kerulni a szoveg
			titleFieldMc.titleTexts[0] = "Elemi számolási feladatok";
			titleFieldMc.titleTexts[1] = "Műveletek törtekkel";
			//titleFieldMc.titleTexts[2] = "Hello";
			
			trace("infoFieldMc.infoText",infoFieldMc);
			infoFieldMc.infoText = "Végezze el a megadott műveleteket!"+"\n"+"Kérjük, válassza ki az Ön által helyesnek vélt lépést az egyenlet megoldásához!";
		}
		
		/**
		 * Az animáció hátterének tulajdonságait lehet itt megadni. 
		 * Ha az fla-ban kint van a timeline-on a mainbackground, akkor azt fogja ervenyesnek venni
		 * Ha nincs kint, akkor automatikusan kirak egyet az itt megadott parametereknek megfeleloen
		 * posX = 5, ha itt nincs megadva, akkor paddingLeft lesz alapbol
		 * posY = 5, ha itt nincs megadva, akkor paddingTop lesz alapbol
		 * paddingBottom = 5, ha itt nincs megadva
		 * paddingLeft = 5, ha itt nincs megadva
		 * paddingRight = 5, ha itt nincs megadva
		 * paddingTop = 5, ha itt nincs megadva
		 * autoFitToAnimSize = false, ez akkor jo, ha az fla-ban manualisan allitod az animacio meretet, akkor nem kell a background meretet is kezzel megvaltoztatni,automatikusan kozepre kerul a paddingLeft-et es a paddingRight-ot figyelembe veve
		 * usePadding = false, az animacio a megadott x es y koordinatara kerul, ha true, akkor a stage szeleitol szamitva hasznalja a paddinget
		 * 
		 * HA NEM KELL background:
		 * ennek a doksinak az elejen, ki kell kommentezni a setMainBackgroundProperties()-t
		 * az fla-ban is le kell szedni a stafe-rol
		 * 
		 * Ha a stage-n levot akarod hasznalni:
		 * kommentezd setMainBackgroundProperties()-t 
		 * 
		 */		
		private function setMainBackgroundProperties( ) : void
		{
			backgroundMc = new BackgroundObject( );
			//x koordinata
			backgroundMc.posX = 5;
			//y koordinata
			backgroundMc.posY = 5;
			backgroundMc.paddingBottom = 5;
			backgroundMc.paddingLeft = 5;
			backgroundMc.autoFitToAnimSize = true;
			backgroundMc.usePadding = false;
			//backgroundMc.bgClass = MainBackground;
			//backgroundMc.paddingBottom = 5;
			//backgroundMc.paddingLeft = 15;
		}
		
		/**
		 * FONTOS!!! Ennek a designe-jat csak az fla-ban lehet allitani, a kovetkezoket lehet itt beallitani:
		 * ugy is van implementalva, ha azon modositasz, akkor feltetlenulj szolj, mert akkor valtoztatni kell a programban
		 * autoFitToTitles : true;
		 * resizeLogoWhenNeeded : true, ha false, akkor a tetejen fog maradni
		 * titlesPaddingLeft : 50 - az animacio utan ez lesz az x koordinatajuk
		 * titleTexts : ezt ebben a doksiban a setFrameTexts() - ben lehet beallitani
		 * paddingTop : 0, Mileyn tavolsagra helyezkedjen el a tetejetol, deafult-bol erre az y ertekre kerul
		 * autoFitToBackground, automatikusan a background BAL oldalahoz igazitja
		 * posY : paddingTop
		 * titleFieldTextFormats, annyit kell megadni, ahany szoveg lesz benne, ha kevesebb van megadva, akkor a 2. sortol automatikusan a subTitleTetFormat lesz alkalmazva
		 */		
		private function setTitleProperties( ) : void
		{
			titleFieldMc = new TitleFieldObject( );
			titleFieldMc.autoFitToTitles = true;
			titleFieldMc.resizeLogoWhenNeeded = false;
			//titleFieldMc.titlesPaddingLeft =
			titleFieldMc.autoFitToBackground = true;
			//titleFieldMc.autoFitToTitles = 
			//titleFieldMc.maxHeight =
			//titleFieldMc.posX =
			//titleFieldMc.posY = 
			
			var mainTitleTextFormat : TextFormat = new TextFormat();
			mainTitleTextFormat.font = "Tahoma";
			mainTitleTextFormat.align = "left";
			mainTitleTextFormat.color = 0xFFFFFF;
			mainTitleTextFormat.size = 14;
			
			var subTitleTextFormat : TextFormat = new TextFormat();
			subTitleTextFormat.font = "Tahoma";
			subTitleTextFormat.align = "left";
			subTitleTextFormat.color = 0xFFFFFF;
			subTitleTextFormat.size = 12;
			
			//HA TOBB fomratum lesz, akkor ebbe a tombbe mindenkeppen bele kell kerulnie
			titleFieldMc.titleFieldTextFormats = new Array( mainTitleTextFormat, subTitleTextFormat );
			
			var animProp : AnimationProperties = new AnimationProperties( );
			
			animProp.apDuration = 4;
			animProp.apFunc = Regular.easeOut;
			animProp.apProp = "x";
			animProp.apUseSeconds=true;
			
			titleFieldMc.titleAnimationProperties = animProp;	
		}
		
		private function setInfoButton( ) : void
		{
			infoButtonMc = new InfoButtonObject( );
			
			var animProp : AnimationProperties = new AnimationProperties( );
			
			animProp.apDuration = 1;
			animProp.apFunc = Regular.easeOut;
			animProp.apProp = "width";
			animProp.apUseSeconds=true;
			
			infoButtonMc.infoButtonAnimation = animProp;			
		}
		
		private function setInfoField( ) : void
		{
			infoFieldMc = new InfoFieldObject();
			
			
			var animPropFadeIn : AnimationProperties = new AnimationProperties( );
			
			animPropFadeIn.apDuration = 2;
			animPropFadeIn.apFunc = Regular.easeOut;
			animPropFadeIn.apProp = "alpha";
			animPropFadeIn.apUseSeconds=true;
			animPropFadeIn.apBegin = 0;
			animPropFadeIn.apFinish = 1;
			
			var animPropFadeOut : AnimationProperties = new AnimationProperties( );
			
			animPropFadeOut.apDuration = 2;
			animPropFadeOut.apFunc = Regular.easeOut;
			animPropFadeOut.apProp = "alpha";
			animPropFadeOut.apUseSeconds=true;
			animPropFadeOut.apBegin = 1;
			animPropFadeOut.apFinish = 0;
			
			infoFieldMc.fadeInProperties = animPropFadeIn;
			infoFieldMc.fadeOutProperties = animPropFadeOut;
			
			infoFieldMc.smallBackgroundAlignedToAnim = FrameProperties.BOTTOM_RIGHT;
			infoFieldMc.smallBAckgroundAutoFitToText = true;
			infoFieldMc.textAlignedToCenter = false;
			infoFieldMc.textPaddingLeft = 5;
			infoFieldMc.textPaddingTop = 20;
			
			var textFormat : TextFormat = new TextFormat( );
			textFormat.font = "Tahoma";
			textFormat.align = "center";
			textFormat.color = 0xFFFFFF;
			textFormat.size = 12;
			
			infoFieldMc.textFormat = textFormat;
		}
	}
}