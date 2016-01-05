//
//  ViewController.h
//  War Games
//
//  Created by Henry Moyerman on 10/21/15.
//  Copyright (c) 2015 Henry Moyerman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property BOOL onePlayer;
@property BOOL playerTurn;
@property BOOL endGame;
@property BOOL SALVO;
@property BOOL attackReady;

@property BOOL randomPlay;
@property int attackTile;
@property int originHit;
@property int currentHit;
@property int hitDirection;
@property int aiOffset;
@property BOOL randomPlay2;
@property int attackTile2;
@property int originHit2;
@property int currentHit2;
@property int hitDirection2;
@property int aiOffset2;

@property BOOL gameSpeed;
@property BOOL rapidMode;
@property int p1turnCounter;
@property int p2turnCounter;
@property int rapidCounter;
@property BOOL hundred;

@property int p1hitCounter;
@property int p2hitCounter;

@property int p1shipHitCounter;
@property int p2shipHitCounter;

@property int p1winCounter;
@property int p2winCounter;
@property int totalTurnCounter;

@property (nonatomic, retain) NSMutableArray *topGrid;
@property (nonatomic, retain) NSMutableArray *bottomGrid;
@property (nonatomic, retain) NSMutableArray *p1guesses;
@property (nonatomic, retain) NSMutableArray *p2guesses;
@property (nonatomic, retain) NSMutableArray *p1board;
@property (nonatomic, retain) NSMutableArray *p2board;
@property (nonatomic, retain) NSMutableArray *names;

@property (nonatomic, retain) NSMutableArray *p1ship1;
@property (nonatomic, retain) NSMutableArray *p1ship2;
@property (nonatomic, retain) NSMutableArray *p1ship3;
@property (nonatomic, retain) NSMutableArray *p1ship4;
@property (nonatomic, retain) NSMutableArray *p1ship5;
@property (nonatomic, retain) NSMutableArray *p2ship1;
@property (nonatomic, retain) NSMutableArray *p2ship2;
@property (nonatomic, retain) NSMutableArray *p2ship3;
@property (nonatomic, retain) NSMutableArray *p2ship4;
@property (nonatomic, retain) NSMutableArray *p2ship5;

@property int p1ship1Counter;
@property int p1ship2Counter;
@property int p1ship3Counter;
@property int p1ship4Counter;
@property int p1ship5Counter;
@property int p2ship1Counter;
@property int p2ship2Counter;
@property int p2ship3Counter;
@property int p2ship4Counter;
@property int p2ship5Counter;

@property UIAlertView *notEmptyAlert;

@property UILabel *mainTitle;
@property UILabel *guessesTitle;
@property UILabel *boardTitle;
@property UILabel *hitTitle;

@end





