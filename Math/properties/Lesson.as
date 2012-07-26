package properties
{
	import flash.display.DisplayObject;
	
	import gui.EndAnimation;
	import gui.ExerciseChooseCorrectAnswerMath;
	
	import items.EndAnimationObject;
	import items.Exercise;
	
	import util.Column;
	import util.Row;
	
	public class Lesson
	{
		public static const CHOOSE_CORRECT_ANSWER : String = "Lesson.CHOOSE_CORRECT_ANSWER";
		
		public static var showAnimationOnGoodAnswer : Boolean;
		public static var showAnimationOnBadAnswer : Boolean;
		
		public static var showExplainAnim : Boolean;
		
		public static var answerContainerClass : Class;		
		public static var questionContainerClass : Class;
		
		public static var goodAnswerAnimationClass : Class;
		public static var badAnswerAnimationClass : Class;
		
		public static var explainAnimationClass : Class;
		
		public static var backButtonClass : Class;
		
		public var numberOfExercise : int;
		public var type : String;
		
		public static var maxWidth : Number;
		public static var maxHeight : Number;
		
		public static var shuffleExercises : Boolean;
		public static var shuffleAnswers : Boolean;
		
		public static var showCongratsAnim : Boolean;
		public static var congratsAnimClass : Class;
		
		public static var needAnimationFrameAnimation : Boolean;
		
		public var exercises : Array;
		
		public static var endAnimation : EndAnimation;
		
		public function Lesson( )
		{
			exercises = new Array( );
			
			//a feladat tipusat itt lehet beallitani
			type = CHOOSE_CORRECT_ANSWER;
			
			//itt lehet megadni, hogy a library-ből melyik objectbe rántsa be a kérdést, 
			//ez jelenleg null-on van, ami azt jelenti, hogy nem lesz neki háttere, automatikusan kozepre lesz rendezve, soronkent
			//ha ezen változtatsz, akkor szólj és segítek
			questionContainerClass = null;
			
			answerContainerClass = ExerciseButtonSkin;
			
			backButtonClass = ExerciseButtonSkin;
			
			explainAnimationClass = null;
			
			//!!!!MINDENKEPPEN MEG KELL ADNI
			//
			shuffleExercises = false;
			
			//KEVERJE-E A VALASZOKAT
			shuffleAnswers = true;
			
			//setLesson( );
		}
		
		public function setLesson( ) : void
		{		
			//meg nem hasznalt
			//feladatok száma
			//numberOfExercise = 5;
			
			//Mutassa-e az animaciot rossz valasz eseten
			showAnimationOnBadAnswer = false;
			//jo valasz eseten mutassa-e az animaciot
			showAnimationOnGoodAnswer = false;
			//mutassa-e a magyarazo animaciot rossz valasznal
			showExplainAnim = false;	
			//ha ez true-ra van allitva, akkor, akkor a set exercises()-ban be kell allitani a skin tartalmat, ami az fla-ban van ( EndAnimSkin neven ); 
			showCongratsAnim = true;
			
			
		}
		
		/**
		 * ITT LEHET BEALLITANI A FELADATOKAT 
		 * ExerciseChooseCorrectAnswerMath.questions : Array - tomb ELEMEIKENT tudod megadni a feladat kerdesenek szoveget
		 * - a tomb elemei vizszintesen egymas alatt fognak megjelenni
		 * - tartalmazhat:
		 *  - szoveg : ha a tomb minden elemebe string kerul, akkor a stringek kulon sorban fognak megjelenni
		 *  - keplet : ha a tomb eleme egy Class (ha a kepletre jobb gombbal kattintasz az fla-ban, akkor nevezd a properties panelen es pipald be az Export for actionscript-et, 
		 *               fontos, hogy ugyanaz a Class szerepeljen mindket mezoben, a Base Class legyen MovieClip, vagy Sprite (az utobbit csak kezzel tudod beirni), 
		 *               ha ez van megadva, akkor automatikusan az a keplet fog bekerulni, kozepre rendezve
		 *  - sor Row() : ebben is van egy tomb (LineChooseCorrectAnswerMath.items )
		 *              a tomb elemei vizszintesen lesznek egymas melle helyezve
		 *  - sor Column() : ebben is van egy tomb (LineChooseCorrectAnswerMath.items )
		 *              a tomb elemei vizszintesen lesznek egymas melle helyezve
		 * 	- tombot : a fentiek kozul barmelyiket tartalmazhat
		 *  
		 * - ha a tombnek egy eleme van, automatikusan kozepre fogja rendezni, a valaszok szelessegehz kepest
		 * - ha a szoveg tartalmaz kepletet, akkor line-kent kell a tombbe helyezni es string helyett az osztaly nevet kell beirni a tomb elemenek
		 * - ha csak egy kepletet tartalmaz a sor, akkor az egy sort jelent, ha a tombben elotte es utana van szoveg, 
		 * - ha szoveg es keplet van benne, akkor automatikusan egymas mellett fognak megjelenni, a szoveg a keplet magassagahoz képest középre lesz igazítva
		 * 
		 * MINDEN FELADATOT, be kell irni az exercises.push(feladat1, feladat2, feladat3... )
		 * ez meghivodik a fuggveny aljan
		 */		
		public function setExercises( ) : Array
		{
			needAnimationFrameAnimation = false;
			
			//Exercise 1
			
			//minden feladatot letre kell hozni, ezt akar copy paste-elheted is csak a az exercise1 - et at kell nevezni
			var exercise1 : ExerciseChooseCorrectAnswerMath = new ExerciseChooseCorrectAnswerMath( );
			exercise1.question[0] = "Egy szabályos érmét háromszor feldobva mennyi a valószínűsége,"+"\n"+"hogy a dobott számok között lesz fej?"
									+"\n"+"Válassza ki az alábbi lehetőségek közül az Ön szerint helyeset!"
									/*+"\n"+"A fej vagy az első, vagy a második, vagy a harmadik, és más lehetőség nincs."
									+"\n"+"Nem érdemes esetszétválasztással gondolkodni.";*/
			//exercise1.question[1] = 
			//exercise1.question[1] =
			
			//VALASZOK
			//ExerciseChooseCorrectAnswerMath.answers tombben lehet megadni oket, ugyanazokat az elemeket tartalmazhatja, mint a kerdesek
			exercise1.answers[0] = "A fej vagy az első, vagy a második, vagy a harmadik, és más lehetőség nincs.";	
			exercise1.answers[1] = "Nem érdemes esetszétválasztással gondolkodni.";
			
			//MAGYARAZAT
			//magyarázó szöveg, rossz válasz esetén
			//amelyik válaszhoz tartozik a szöveg, a tömbnek abba az indexébe kell belerakni
			exercise1.explanationTexts[0]="Sajnos nem!";
			
			//JO VALASZ
			exercise1.goodAnswer = 1;		
			
			var exercise2 : ExerciseChooseCorrectAnswerMath = new ExerciseChooseCorrectAnswerMath( );
			exercise2.question[0] = "Valóban, először a szorzást kell elvégezni."+"\n"+"Válassza ki az Ön által helyesnek ítélt lépést!";
			//	exercise2.question[1] = "Valóban, először a szorzást kell elvégezni."+"\n"+"Válassza ki az Ön által helyesnek ítélt lépést!";
			/*exercise2.question[2] = "Valóban, először a szorzást kell elvégezni."+"\n"+"Válassza ki az Ön által helyesnek ítélt lépést!";
			exercise2.question[3] = "Valóban, először a szorzást kell elvégezni."+"\n"+"Válassza ki az Ön által helyesnek ítélt lépést!";
			exercise2.question[4] = "Valóban, először a szorzást kell elvégezni."+"\n"+"Válassza ki az Ön által helyesnek ítélt lépést!";
			exercise2.question[5] = "Valóban, először a szorzást kell elvégezni."+"\n"+"Válassza ki az Ön által helyesnek ítélt lépést!";*/
			
			//ELSO VALASZ
			var answerLine2 : Row = new Row();
			answerLine2.items[0] = Exercise2_1;
			
			//MASODIK VALASZ
			var answerLine3 : Row = new Row();
			answerLine3.items[0] = Exercise2_2;		
			
			//ES ITT adjuk meg a valaszokat
			exercise2.answers[0] = answerLine2;
			exercise2.answers[1] = answerLine3;
			
			var explColumn : Column = new Column( );
			explColumn.items[0] = "Sajnos nem, hiszen törtet egész számmal úgy szorzunk, hogy a tört számlálóját"
				+ "\n"+" megszorozzuk az egész számmal,a nevezőt pedig változatlanul hagyjuk."
				+"\n" +""
				+"\n"
				+"Helyesen:";
			
			
			explColumn.items[1] = Exercise2_1;
			
			exercise2.explanationTexts[1] = explColumn;
			
			//jó válasz száma
			exercise2.goodAnswer = 0;
			
			
			//Exerxise3
			var exercise3 : ExerciseChooseCorrectAnswerMath = new ExerciseChooseCorrectAnswerMath( );
			
			var questionColumn3 : Column = new Column();
			
			questionColumn3.items[0] = "Helyes!";
			questionColumn3.items[1] = Exercise3_1;
			
			exercise3.question[0] = questionColumn3;
			
			
			var answRow3 : Row = new Row( );
			answRow3.items[0] = Exercise3_2;
			answRow3.items[1] = " és kész is";
			
			exercise3.answers[0] = "Közös nevezőre kell hozni.";
			exercise3.answers[1] = answRow3;
			
			exercise3.explanationTexts[1] = "Sajnos nem!"+"\n"+"Két tört különbségének meghatározásához először közös nevezőre kell hozni.";
			
			//jó válasz száma
			exercise3.goodAnswer = 0;
			
			//Exercise4
			var exercise4 : ExerciseChooseCorrectAnswerMath = new ExerciseChooseCorrectAnswerMath( );
			
			var questionRow4 : Row = new Row();
			questionRow4.items[0] = "Valóban közös nevezőre kell hozni az";
			questionRow4.items[1] = Exercise4_1;
			questionRow4.items[2] = "és a"
			questionRow4.items[3] = Exercise4_2;
			questionRow4.items[4] = "törteket";
			
			exercise4.question[0] = questionRow4;			
			
			var answRow4 : Row = new Row( );
			answRow4.items[0] = "A közös nevező megválasztható 2 * 5 = 10 - nek";
			answRow4.items[1] = Exercise4_3;
			answRow4.items[2] = "-nek";
			
			exercise4.answers[0] = "Közös nevező 2.";
			exercise4.answers[1] = "A közös nevező megválasztható 2 * 5 = 10 - nek";
			
			exercise4.explanationTexts[0] = "Sajnos nem!"+"\n"+"A közös nevezőt célszerű a nevezők legkisebb közös többszörösének választani.";
			
			//jó válasz száma
			exercise4.goodAnswer = 1;
			
			
			//Exercise5
			var exercise5 : ExerciseChooseCorrectAnswerMath = new ExerciseChooseCorrectAnswerMath( );
			
			//var questionRow5 : Row = new Row();
			//questionRow5.items[0] = "Valóban közös nevezőre kell hozni az";
			//questionRow5.items[1] = Exercise5_1;
			//questionRow5.items[2] = Exercise5_2;
			
			exercise5.question[0] = "Valóban, a közös nevező 10.";			
			
			var answRow5 : Row = new Row( );
			answRow5.items[0] = Exercise5_1;
			answRow5.items[1] = "és kész.";
			//answRow5.items[2] = "-nek";
			
			var answRow6 : Row = new Row( );
			answRow6.items[0] = Exercise5_2;
			answRow6.items[1] = ",ennek viszont nincs ertelme";
			
			exercise5.answers[0] = answRow5
			exercise5.answers[1] = answRow6;
			
			var answRow7 : Row = new Row( );
			answRow7.items[0] = "Sajnos nem!"+"\n"+"Két tört különbségének meghatározásához a kisebbítendő számlálójából kivonjuk"+"\n"+" a kivonandó számlálóját, a nevezőt pedig változatlanul hagyjuk."
			exercise5.explanationTexts[1] = answRow7;
			
			//jó válasz száma
			exercise5.goodAnswer = 0;
			
			
			exercises.push( exercise1, exercise2, exercise3, exercise4, exercise5 );
			
			endAnimation = new EndAnimation( );
			
			
			var endAnimRow : Row = new Row( );
			endAnimRow.items[0] = ExerciseEnd;
			
			endAnimation.items[0] = endAnimRow;
			
			return exercises;
			
			
		}
		
	}
}