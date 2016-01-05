//
//  ViewController.m
//  War Games
//
//  Created by Henry Moyerman on 10/21/15.
//  Copyright (c) 2015 Henry Moyerman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize onePlayer;
@synthesize playerTurn;
@synthesize endGame;
@synthesize SALVO;
@synthesize randomPlay;
@synthesize attackTile;
@synthesize originHit;
@synthesize currentHit;
@synthesize hitDirection;
@synthesize aiOffset;
@synthesize randomPlay2;
@synthesize attackTile2;
@synthesize originHit2;
@synthesize currentHit2;
@synthesize hitDirection2;
@synthesize aiOffset2;

@synthesize gameSpeed;
@synthesize rapidMode;
@synthesize p1turnCounter;
@synthesize p2turnCounter;
@synthesize rapidCounter;
@synthesize hundred;

@synthesize p1hitCounter;
@synthesize p2hitCounter;

@synthesize p1shipHitCounter;
@synthesize p2shipHitCounter;

@synthesize p1winCounter;
@synthesize p2winCounter;
@synthesize totalTurnCounter;

@synthesize topGrid;
@synthesize bottomGrid;
@synthesize p1guesses;
@synthesize p2guesses;
@synthesize p1board;
@synthesize p2board;
@synthesize names;

@synthesize p1ship1;
@synthesize p1ship2;
@synthesize p1ship3;
@synthesize p1ship4;
@synthesize p1ship5;
@synthesize p2ship1;
@synthesize p2ship2;
@synthesize p2ship3;
@synthesize p2ship4;
@synthesize p2ship5;

@synthesize p1ship1Counter;
@synthesize p1ship2Counter;
@synthesize p1ship3Counter;
@synthesize p1ship4Counter;
@synthesize p1ship5Counter;
@synthesize p2ship1Counter;
@synthesize p2ship2Counter;
@synthesize p2ship3Counter;
@synthesize p2ship4Counter;
@synthesize p2ship5Counter;

@synthesize notEmptyAlert;
@synthesize mainTitle;
@synthesize guessesTitle;
@synthesize boardTitle;
@synthesize hitTitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStart];
    UIAlertView *welcomeAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Welcome to War Games!"
                                 message:@"Build by Henry Moyerman"
                                 delegate:self
                                 cancelButtonTitle:@"Play"
                                 otherButtonTitles: nil];
    [welcomeAlert show];
}

- (void)initStart {
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // creates top grid of app
    
    topGrid = [[NSMutableArray alloc] init];
    int initX = 30;
    int initY = 115;
    int x = initX;
    int y = initY;
    for( int i = 0; i < 100; i++ ) {
        if (i%10 == 0 && i != 0){
            x = initX;
            y += 20;
        }
        
        UIButton* aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aButton.frame = CGRectMake(x, y, 19, 19);
        [aButton setTag:i];
        [self.view addSubview:aButton];
        [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        aButton.backgroundColor = [UIColor blackColor];
        [topGrid addObject:aButton];
        x += 20;
    }
    
    
    // creates bottom grid of app
    
    bottomGrid = [[NSMutableArray alloc] init];
    int inity2 = 360;
    int y2 = inity2;
    x = initX;
    for( int i = 0; i < 100; i++ ) {
        if (i%10 == 0 && i != 0){
            x = initX;
            y2 += 20;
        }
        
        UIButton* aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aButton.frame = CGRectMake(x, y2, 19, 19);
        [aButton setTag:i];
        [self.view addSubview:aButton];
        [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        aButton.backgroundColor = [UIColor blackColor];
        [bottomGrid addObject:aButton];
        x += 20;
    }
    
    
    // creates arrays for boards and guesses for each player
    
    typedef enum{E, H, M, S} battleEnum;
    p1guesses = [[NSMutableArray alloc] init];
    p2guesses = [[NSMutableArray alloc] init];
    p1board = [[NSMutableArray alloc] init];
    p2board = [[NSMutableArray alloc] init];
    for( int i = 0; i < 100; i++ ) {
        [p1guesses addObject:@(E)];
        [p2guesses addObject:@(E)];
        [p1board addObject:@(E)];
        [p2board addObject:@(E)];
    }
    
    
    // creates an array with a refernce for the name of a tile that mtches the index
    
    names = [[NSMutableArray alloc] init];
    for( int i = 0; i < 10; i++ ) {
        for( int j = 0; j < 10; j++ ){
            if (j == 0) {NSString *s = [NSString stringWithFormat:@"A%i", i+1]; [names addObject: s];}
            if (j == 1) {NSString *s = [NSString stringWithFormat:@"B%i", i+1]; [names addObject: s];}
            if (j == 2) {NSString *s = [NSString stringWithFormat:@"C%i", i+1]; [names addObject: s];}
            if (j == 3) {NSString *s = [NSString stringWithFormat:@"D%i", i+1]; [names addObject: s];}
            if (j == 4) {NSString *s = [NSString stringWithFormat:@"E%i", i+1]; [names addObject: s];}
            if (j == 5) {NSString *s = [NSString stringWithFormat:@"F%i", i+1]; [names addObject: s];}
            if (j == 6) {NSString *s = [NSString stringWithFormat:@"G%i", i+1]; [names addObject: s];}
            if (j == 7) {NSString *s = [NSString stringWithFormat:@"H%i", i+1]; [names addObject: s];}
            if (j == 8) {NSString *s = [NSString stringWithFormat:@"I%i", i+1]; [names addObject: s];}
            if (j == 9) {NSString *s = [NSString stringWithFormat:@"J%i", i+1]; [names addObject: s];}
        }
    }
    
    [self makeLabels1];
    [self makeLabels2];
    
    
    // creates the arrays the represent all 10 ships
    
    p1ship1 = [[NSMutableArray alloc] initWithObjects:
               @2, @"Destroyer", @0, @0, nil];
    p1ship2 = [[NSMutableArray alloc] initWithObjects:
               @3, @"Submarine", @0, @0, @0, nil];
    p1ship3 = [[NSMutableArray alloc] initWithObjects:
               @3, @"Cruiser", @0, @0, @0, nil];
    p1ship4 = [[NSMutableArray alloc] initWithObjects:
               @4, @"Battleship", @0, @0, @0, @0, nil];
    p1ship5 = [[NSMutableArray alloc] initWithObjects:
               @5, @"Carrier", @0, @0, @0, @0, @0, nil];
    p2ship1 = [[NSMutableArray alloc] initWithObjects:
               @2, @"Destroyer", @0, @0, nil];
    p2ship2 = [[NSMutableArray alloc] initWithObjects:
               @3, @"Submarine", @0, @0, @0, nil];
    p2ship3 = [[NSMutableArray alloc] initWithObjects:
               @3, @"Cruiser", @0, @0, @0, nil];
    p2ship4 = [[NSMutableArray alloc] initWithObjects:
               @4, @"Battleship", @0, @0, @0, @0, nil];
    p2ship5 = [[NSMutableArray alloc] initWithObjects:
               @5, @"Carrier", @0, @0, @0, @0, @0, nil];
    
    
    // creates all labels and button for app
    
    mainTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, 200, 40)];
    [mainTitle setFont:[UIFont systemFontOfSize:30]];
    mainTitle.text = @"War Games";
    mainTitle.numberOfLines = 1;
    //mainTitle.baselineAdjustment = YES;
    //mainTitle.adjustsFontSizeToFitWidth = YES;
    //mainTitle.clipsToBounds = YES;
    mainTitle.backgroundColor = [UIColor clearColor];
    mainTitle.textColor = [UIColor blackColor];
    mainTitle.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:mainTitle];
    
    hitTitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 60, 200, 25)];
    [hitTitle setFont:[UIFont systemFontOfSize:17]];
    hitTitle.text = @"";
    hitTitle.numberOfLines = 1;
    hitTitle.backgroundColor = [UIColor clearColor];
    hitTitle.textColor = [UIColor redColor];
    hitTitle.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:hitTitle];
    
    guessesTitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 80, 200, 25)];
    [guessesTitle setFont:[UIFont systemFontOfSize:17]];
    guessesTitle.text = @"iPhone 1";
    guessesTitle.numberOfLines = 1;
    guessesTitle.backgroundColor = [UIColor clearColor];
    guessesTitle.textColor = [UIColor blackColor];
    guessesTitle.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:guessesTitle];
    
    boardTitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 325, 200, 25)];
    [boardTitle setFont:[UIFont systemFontOfSize:17]];
    boardTitle.text = @"iPhone 2";
    boardTitle.numberOfLines = 1;
    boardTitle.backgroundColor = [UIColor clearColor];
    boardTitle.textColor = [UIColor blackColor];
    boardTitle.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:boardTitle];
    
    UIButton* newGameOption = [UIButton buttonWithType:UIButtonTypeCustom];
    newGameOption.frame = CGRectMake(200, 25, 100, 20);
    [self.view addSubview:newGameOption];
    [newGameOption setTitle: @"New Game" forState: UIControlStateNormal];
    [newGameOption setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    newGameOption.backgroundColor = [UIColor clearColor];
    [newGameOption addTarget:self action:@selector(newGameButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)makeLabels1 {
    
    // makes the A-J labels for grids
    
    NSString *s = @"";
    int initX = 36;
    int x = initX;
    int y = 105;
    int y2 = 350;
    for (int i = 0; i<10; i++) {
        if (i == 0) {s = @"A";}
        if (i == 1) {s = @"B";}
        if (i == 2) {s = @"C";}
        if (i == 3) {s = @"D";}
        if (i == 4) {s = @"E";}
        if (i == 5) {s = @"F";}
        if (i == 6) {s = @"G";}
        if (i == 7) {s = @"H";}
        if (i == 8) {s = @"I";}
        if (i == 9) {s = @"J";}
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 10, 10)];
        [label1 setFont:[UIFont systemFontOfSize:10]];
        label1.text = s;
        label1.numberOfLines = 1;
        label1.backgroundColor = [UIColor clearColor];
        label1.textColor = [UIColor blackColor];
        label1.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:label1];
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(x, y2, 10, 10)];
        
        [label2 setFont:[UIFont systemFontOfSize:10]];
        label2.text = s;
        label2.numberOfLines = 1;
        label2.backgroundColor = [UIColor clearColor];
        label2.textColor = [UIColor blackColor];
        label2.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:label2];
        x += 20;
    }
}

- (void)makeLabels2 {
    
    // makes the 1-10 labels for grids
    
    NSString *s = @"";
    int y1 = 119;
    int y2 = 364;
    int x = 20;
    for (int i = 0; i<10; i++) {
        if (i == 9) {
            x = 17;
        }
        s = [NSString stringWithFormat:@"%i", i+1];
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(x, y1, 12, 10)];
        [label1 setFont:[UIFont systemFontOfSize:10]];
        label1.text = s;
        label1.numberOfLines = 1;
        label1.backgroundColor = [UIColor clearColor];
        label1.textColor = [UIColor blackColor];
        label1.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:label1];
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(x, y2, 12, 10)];
        
        [label2 setFont:[UIFont systemFontOfSize:10]];
        label2.text = s;
        label2.numberOfLines = 1;
        label2.backgroundColor = [UIColor clearColor];
        label2.textColor = [UIColor blackColor];
        label2.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:label2];
        y1 += 20;
        y2 += 20;
    }
}

- (void)newGame {
    
    // resests anyting needed to start a new game
    
    [self resetBoardsandGuesses];
    [self clearGridText];
    endGame = false;
    p1ship1Counter = 2;
    p1ship2Counter = 3;
    p1ship3Counter = 3;
    p1ship4Counter = 4;
    p1ship5Counter = 5;
    p2ship1Counter = 2;
    p2ship2Counter = 3;
    p2ship3Counter = 3;
    p2ship4Counter = 4;
    p2ship5Counter = 5;
    p1hitCounter = 0;
    p2hitCounter = 0;
    p1shipHitCounter = 0;
    p2shipHitCounter = 0;
    hitDirection = 0;
    hitDirection2 = 0;
    p1turnCounter = 0;
    p2turnCounter = 0;
    randomPlay = true;
    randomPlay2 = true;
    
    [self setShipLocationsRandomlyForP1];
    [self setShipLocationsRandomlyForP2];
    
    [self iPhonePlay];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // checks all items clicked in alerts, and does the corresponding action

    NSString *string = [alertView buttonTitleAtIndex:buttonIndex];
    if ([string isEqualToString:@"Play"]) { [self gameSpeedSet]; }
    if ([string isEqualToString:@"Yes"]) {
        [self gameSpeedSet]; }
    if ([string isEqualToString:@"Fast"]) {
        gameSpeed = true;
        hundred = false;
        [self rapidModeSet]; }
    if ([string isEqualToString:@"Rapid"]) {
        rapidMode = true;
        [self trials]; }
    if ([string isEqualToString:@"50"]) {
        hitTitle.text = @"";
        hundred = true;
        [self newGame]; }
    if ([string isEqualToString:@"10"]) {
        
        hitTitle.text = @"";
        [self newGame]; }
    if ([string isEqualToString:@"Normal"]) {
        hitTitle.text = @"";
        rapidMode = false;
        [self newGame]; }
    if ([string isEqualToString:@"Slow"]) {
        hitTitle.text = @"";
        gameSpeed = false;
        [self newGame]; }
}

- (void) rapidModeSet{
    
    // sets normal or rapid mode for gameplay
    
    UIAlertView *rapidModeSetAlert = [[UIAlertView alloc]
                                      initWithTitle:@"Set the Fast Mode"
                                      message:nil
                                      delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:@"Normal", @"Rapid", nil];
    [rapidModeSetAlert show];
}

- (void) trials{
    
    /// if rapid mode us set, select number of trials
    
    p1winCounter = 0;
    p2winCounter = 0;
    totalTurnCounter = 0;
    
    UIAlertView *trialsAlert = [[UIAlertView alloc]
                                initWithTitle:@"Set the Number of Trials"
                                message:nil
                                delegate:self
                                cancelButtonTitle:nil
                                otherButtonTitles:@"10", @"50", nil];
    [trialsAlert show];
}

- (void) gameSpeedSet{
    
    // if normal mode is set, set a single slow or fast game
    
    UIAlertView *gameSpeedSetAlert = [[UIAlertView alloc]
                                      initWithTitle:@"Set the Game Speed"
                                      message:nil
                                      delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:@"Slow", @"Fast", nil];
    [gameSpeedSetAlert show];
}

- (void)setShipLocationsRandomlyForP1 {
    typedef enum{E, H, M, S} battleEnum;
    NSArray *layouts1 = @[
                          @30, @31, @34, @35, @36, @71, @72, @73, @47, @57, @67, @77, @13, @14, @15, @16, @17,
                          @84, @85, @71, @72, @73, @11, @21, @31, @24, @34, @44, @54, @48, @58, @68, @78, @88,
                          @44, @45, @51, @61, @71, @18, @28, @38, @11, @12, @13, @14, @58, @68, @78, @88, @98,
                          @25, @26, @55, @56, @57, @85, @86, @87, @11, @21, @31, @41, @52, @62, @72, @82, @92,
                          @21, @31, @52, @62, @72, @85, @86, @87, @27, @37, @47, @57, @14, @24, @34, @44, @54,
                          @80, @81, @83, @84, @85, @14, @15, @16, @32, @42, @52, @62, @37, @47, @57, @67, @77,
                          @24, @34, @55, @65, @75, @11, @21, @31, @81, @82, @83, @84, @18, @28, @38, @48, @58,
                          @77, @78, @71, @72, @73, @11, @12, @13, @24, @34, @44, @54, @8, @18, @28, @38, @48,
                          @40, @41, @1, @11, @21, @80, @81, @82, @23, @24, @25, @26, @63, @64, @65, @66, @67,
                          @6, @16, @66, @76, @86, @27, @37, @47, @10, @11, @12, @13, @41, @51, @61, @71, @81,
                          @41, @42, @53, @54, @55, @48, @58, @68, @14, @15, @16, @17, @81, @82, @83, @84, @85,
                          @18, @19, @48, @58, @68, @91, @92, @93, @34, @44, @54, @64, @11, @21, @31, @41, @51,
                          @0, @1, @97, @98, @99, @81, @82, @83, @4, @14, @24, @34, @28, @38, @48, @58, @68,
                          @21, @22, @61, @71, @81, @28, @38, @48, @14, @24, @34, @44, @55, @65, @75, @85, @95,
                          @11, @12, @15, @16, @17, @28, @38, @48, @41, @51, @61, @71, @34, @44, @54, @64, @74,
                          @11, @12, @23, @24, @25, @52, @53, @54, @65, @66, @67, @68, @80, @81, @82, @83, @84,
                          @0, @10, @79, @89, @99, @81, @82, @83, @31, @32, @33, @34, @63, @64, @65, @66, @67,
                          @88, @89, @61, @71, @81, @11, @12, @13, @24, @34, @44, @54, @18, @28, @38, @48, @58,
                          @24, @25, @51, @52, @53, @85, @86, @87, @10, @11, @12, @13, @18, @28, @38, @48, @58,
                          @50, @51, @42, @43, @44, @55, @56, @57, @81, @82, @83, @84, @11, @12, @13, @14, @15
                          ];
    int random = arc4random_uniform(20);
    int offSet = random*17;
    p1ship1[2] = @([layouts1[offSet + 0] integerValue]);
    p1ship1[3] = @([layouts1[offSet + 1] integerValue]);
    p1ship2[2] = @([layouts1[offSet + 2] integerValue]);
    p1ship2[3] = @([layouts1[offSet + 3] integerValue]);
    p1ship2[4] = @([layouts1[offSet + 4] integerValue]);
    p1ship3[2] = @([layouts1[offSet + 5] integerValue]);
    p1ship3[3] = @([layouts1[offSet + 6] integerValue]);
    p1ship3[4] = @([layouts1[offSet + 7] integerValue]);
    p1ship4[2] = @([layouts1[offSet + 8] integerValue]);
    p1ship4[3] = @([layouts1[offSet + 9] integerValue]);
    p1ship4[4] = @([layouts1[offSet + 10] integerValue]);
    p1ship4[5] = @([layouts1[offSet + 11] integerValue]);
    p1ship5[2] = @([layouts1[offSet + 12] integerValue]);
    p1ship5[3] = @([layouts1[offSet + 13] integerValue]);
    p1ship5[4] = @([layouts1[offSet + 14] integerValue]);
    p1ship5[5] = @([layouts1[offSet + 15] integerValue]);
    p1ship5[6] = @([layouts1[offSet + 16] integerValue]);
    
    for (int i = 0; i<17; i++) {
        p1board[[layouts1[offSet + i] integerValue]] = @(S);
    }
}

- (void)setShipLocationsRandomlyForP2 {
    typedef enum{E, H, M, S} battleEnum;
    NSArray *layouts2 = @[
                          @11, @21, @24, @25, @26, @76, @77, @78, @33, @43, @53, @63, @81, @82, @83, @84, @85,
                          @13, @23, @54, @64, @74, @16, @17, @18, @51, @61, @71, @81, @48, @58, @68, @78, @88,
                          @45, @46, @62, @63, @64, @18, @28, @38, @11, @21, @31, @41, @84, @85, @86, @87, @88,
                          @18, @19, @93, @94, @95, @21, @22, @23, @42, @52, @62, @72, @26, @36, @46, @56, @66,
                          @57, @56, @65, @75, @85, @20, @21, @22, @25, @26, @27, @28, @43, @53, @63, @73, @83,
                          @34, @44, @28, @38, @48, @11, @12, @13, @71, @72, @73, @74, @85, @86, @87, @88, @89,
                          @40, @41, @77, @78, @79, @55, @56, @57, @81, @82, @83, @84, @13, @14, @15, @16, @17,
                          @21, @31, @52, @62, @72, @85, @86, @87, @15, @16, @17, @18, @24, @34, @44, @54, @64,
                          @45, @46, @76, @77, @78, @81, @82, @83, @11, @21, @31, @41, @14, @15, @16, @17, @18,
                          @18, @28, @63, @73, @83, @50, @51, @52, @11, @12, @13, @14, @85, @86, @87, @88, @89,
                          @44, @54, @72, @82, @92, @18, @28, @38, @68, @78, @88, @98, @11, @12, @13, @14, @15,
                          @21, @22, @51, @52, @53, @83, @84, @85, @18, @28, @38, @48, @26, @36, @46, @56, @66,
                          @70, @71, @83, @84, @85, @76, @77, @78, @2, @12, @22, @32, @44, @45, @46, @47, @48,
                          @26, @27, @43, @44, @45, @71, @81, @91, @74, @75, @76, @77, @01, @11, @21, @31, @41,
                          @55, @56, @64, @74, @84, @14, @24, @34, @21, @31, @41, @51, @28, @38, @48, @58, @68,
                          @91, @92, @16, @17, @18, @33, @34, @35, @61, @62, @63, @64, @57, @67, @77, @87, @97,
                          @11, @21, @82, @83, @84, @76, @77, @78, @14, @24, @34, @44, @8, @18, @28, @38, @48,
                          @72, @73, @84, @85, @86, @54, @55, @56, @2, @12, @22, @32, @42, @18, @28, @38, @48,
                          @60, @61, @74, @84, @94, @97, @98, @99, @16, @26, @36, @46, @2, @12, @22, @32, @42,
                          @0, @10, @51, @52, @53, @83, @84, @85, @22, @23, @24, @25, @48, @58, @68, @78, @88
                          ];
    int random = arc4random_uniform(20);
    int offSet = random*17;
    p2ship1[2] = @([layouts2[offSet + 0] integerValue]);
    p2ship1[3] = @([layouts2[offSet + 1] integerValue]);
    p2ship2[2] = @([layouts2[offSet + 2] integerValue]);
    p2ship2[3] = @([layouts2[offSet + 3] integerValue]);
    p2ship2[4] = @([layouts2[offSet + 4] integerValue]);
    p2ship3[2] = @([layouts2[offSet + 5] integerValue]);
    p2ship3[3] = @([layouts2[offSet + 6] integerValue]);
    p2ship3[4] = @([layouts2[offSet + 7] integerValue]);
    p2ship4[2] = @([layouts2[offSet + 8] integerValue]);
    p2ship4[3] = @([layouts2[offSet + 9] integerValue]);
    p2ship4[4] = @([layouts2[offSet + 10] integerValue]);
    p2ship4[5] = @([layouts2[offSet + 11] integerValue]);
    p2ship5[2] = @([layouts2[offSet + 12] integerValue]);
    p2ship5[3] = @([layouts2[offSet + 13] integerValue]);
    p2ship5[4] = @([layouts2[offSet + 14] integerValue]);
    p2ship5[5] = @([layouts2[offSet + 15] integerValue]);
    p2ship5[6] = @([layouts2[offSet + 16] integerValue]);
    for (int i = 0; i<17; i++) { p2board[[layouts2[offSet + i] integerValue]] = @(S); }
}

- (void)clearGridText {
    
    // blanks out top and bottom grids, makes them black, and blanks out labels
    
    for( int i = 0; i < 100; i++ ) {
        [[topGrid objectAtIndex: i] setTitle: @"" forState: UIControlStateNormal];
        [[topGrid objectAtIndex: i] setBackgroundColor:[UIColor blackColor]];
        [[bottomGrid objectAtIndex: i] setTitle: @"" forState: UIControlStateNormal];
        [[bottomGrid objectAtIndex: i] setBackgroundColor:[UIColor blackColor]];
    }
}

- (void)resetBoardsandGuesses {
    
    // resest boards and guesses for each player
    
    typedef enum{E, H, M, S} battleEnum;
    for( int i = 0; i < 100; i++ ) {
        p1guesses[i] = @(E);
        p2guesses[i] = @(E);
        p1board[i] = @(E);
        p2board[i] = @(E);
    }
}

- (void)populateGrids {
    
    // the grids populate with the guesses of each AI
    
    typedef enum{E, H, M, S} battleEnum;
    for( int i = 0; i < 100; i++ ) {
        if ([p2board[i] isEqual: @(E)]){
            [[bottomGrid objectAtIndex: i] setTitle: @"" forState: UIControlStateNormal];
            [[bottomGrid objectAtIndex: i] setBackgroundColor:[UIColor blueColor]];
        }
        else if ([p2board[i] isEqual: @(H)]){
            [[bottomGrid objectAtIndex: i] setTitle: @"X" forState: UIControlStateNormal];
            [[bottomGrid objectAtIndex: i] setBackgroundColor:[UIColor redColor]];
        }
        else if ([p2board[i] isEqual: @(M)]){
            [[bottomGrid objectAtIndex: i] setTitle: @"O" forState: UIControlStateNormal];
            [[bottomGrid objectAtIndex: i] setBackgroundColor:[UIColor whiteColor]];
        }
        else {
            [[bottomGrid objectAtIndex: i] setTitle: @"" forState: UIControlStateNormal];
            [[bottomGrid objectAtIndex: i] setBackgroundColor:[UIColor grayColor]];
        }
        if ([p1board[i] isEqual: @(E)]){
            [[topGrid objectAtIndex: i] setTitle: @"" forState: UIControlStateNormal];
            [[topGrid objectAtIndex: i] setBackgroundColor:[UIColor blueColor]];
        }
        else if ([p1board[i] isEqual: @(H)]){
            [[topGrid objectAtIndex: i] setTitle: @"X" forState: UIControlStateNormal];
            [[topGrid objectAtIndex: i] setBackgroundColor:[UIColor redColor]];
        }
        else if ([p1board[i] isEqual: @(M)]){
            [[topGrid objectAtIndex: i] setTitle: @"O" forState: UIControlStateNormal];
            [[topGrid objectAtIndex: i] setBackgroundColor:[UIColor whiteColor]];
        }
        else {
            [[topGrid objectAtIndex: i] setTitle: @"" forState: UIControlStateNormal];
            [[topGrid objectAtIndex: i] setBackgroundColor:[UIColor grayColor]];
        }
    }
}

- (void)newGameButtonClicked:(UIButton*)button {
    [self gameSpeedSet];
}

- (void)playTile:(int) tile {
    
    // first method called when a tile is played
    // if it is a miss, set the board and guesses
    // if it is a hit, set the board and guesses, check for a win
    // if it is not a win, call the hit method

    typedef enum{E, H, M, S} battleEnum;
    if (playerTurn == true) {
        if ([p2board[tile]  isEqual: @(E)]) {
            p2board[tile] = @(M);
            p1guesses[tile] = @(M);
        }
        else {
            p2board[tile] = @(H);
            p1guesses[tile] = @(H);
            p1hitCounter++;
            if (p1hitCounter == 17) {
                p1shipHitCounter++;
                [self win];
            }
            else { [self hit:(tile)]; }
        }
    }
    else {
        if ([p1board[tile]  isEqual: @(E)]) {
            p1board[tile] = @(M);
            p2guesses[tile] = @(M);
        }
        else {
            p1board[tile] = @(H);
            p2guesses[tile] = @(H);
            p2hitCounter++;
            if (p2hitCounter == 17) {
                p2shipHitCounter++;
                [self win];
            }
            else { [self hit:(tile)]; }
        }
    }
}

- (void)hit:(int) tile {
    
    // checks for which ship was hit
    // if the AI sinks a ship, swtiches to random play
    // else, it switches to attack mode
    
    if (playerTurn == true) {
        for (int i=0; i<2; i++){
            if ([p2ship1[i+2] isEqual: @(tile)]) {
                p2ship1Counter--;
                if (p2ship1Counter == 0) { randomPlay2 = true; }
                else {[self iphoneAttackMode2:(tile)];}
            }   }
        for (int i=0; i<3; i++){
            if ([p2ship2[i+2] isEqual: @(tile)]) {
                p2ship2Counter--;
                if (p2ship2Counter == 0) { randomPlay2 = true; }
                else {[self iphoneAttackMode2:(tile)];}
            }   }
        for (int i=0; i<3; i++){
            if ([p2ship3[i+2] isEqual: @(tile)]) {
                p2ship3Counter--;
                if (p2ship3Counter == 0) { randomPlay2 = true; }
                else {[self iphoneAttackMode2:(tile)];}
            }   }
        for (int i=0; i<4; i++){
            if ([p2ship4[i+2] isEqual: @(tile)]) {
                p2ship4Counter--;
                if (p2ship4Counter == 0) { randomPlay2 = true; }
                else {[self iphoneAttackMode2:(tile)];}
            }   }
        for (int i=0; i<5; i++){
            if ([p2ship5[i+2] isEqual: @(tile)]) {
                p2ship5Counter--;
                if (p2ship5Counter == 0) { randomPlay2 = true; }
                else {[self iphoneAttackMode2:(tile)];}
            }   }
    }
    else {
        for (int i=0; i<2; i++){
            if ([p1ship1[i+2] isEqual: @(tile)]) {
                p1ship1Counter--;
                if (p1ship1Counter == 0) { randomPlay = true; }
                else {[self iphoneAttackMode:(tile)];}
            }   }
        for (int i=0; i<3; i++){
            if ([p1ship2[i+2] isEqual: @(tile)]) {
                p1ship2Counter--;
                if (p1ship2Counter == 0) { randomPlay = true; }
                else {[self iphoneAttackMode:(tile)];}
            }   }
        for (int i=0; i<3; i++){
            if ([p1ship3[i+2] isEqual: @(tile)]) {
                p1ship3Counter--;
                if (p1ship3Counter == 0) { randomPlay = true; }
                else {[self iphoneAttackMode:(tile)];}
            }   }
        for (int i=0; i<4; i++){
            if ([p1ship4[i+2] isEqual: @(tile)]) {
                p1ship4Counter--;
                if (p1ship4Counter == 0) { randomPlay = true; }
                else {[self iphoneAttackMode:(tile)];}
            }   }
        for (int i=0; i<5; i++){
            if ([p1ship5[i+2] isEqual: @(tile)]) {
                p1ship5Counter--;
                if (p1ship5Counter == 0) { randomPlay = true; }
                else {[self iphoneAttackMode:(tile)];}
            }   }
    }
}

- (void)win {
    
    // sets endGame to true, alerts user and give stats if in rapid mode
    
    [self populateGrids];
    endGame = true;
    NSString *s = @"";
    
    if (playerTurn == false) {
        p1winCounter++;
        totalTurnCounter += p1turnCounter;
        s = @"iPhone 1 Wins!!!";
        hitTitle.text = [NSString stringWithFormat:@"iPhone 1 Wins in %i Turns", p1turnCounter];
        [self populateGrids];
    }
    else {
        p2winCounter++;
        totalTurnCounter += p2turnCounter;
        s = @"iPhone 2 Wins!!!";
        hitTitle.text = [NSString stringWithFormat:@"iPhone 2 Wins in %i Turns", p2turnCounter];
        [self populateGrids];
    }
    if (rapidMode == false) {
        UIAlertView *winAlert = [[UIAlertView alloc]
                                 initWithTitle:s
                                 message:@"Play Again?"
                                 delegate:self
                                 cancelButtonTitle:@"No"
                                 otherButtonTitles:@"Yes", nil];
        
        [winAlert show];
    }
    else {
        rapidCounter++;
        if (hundred == false) {
            if (rapidCounter == 10) {
                rapidCounter = 0;
                rapidMode = false;
                int avg = totalTurnCounter/10;
                s = [NSString stringWithFormat:
                     @"iPhone 1 Won %i Times.\niPhone 2 Won %i Times.\nThe Average Game\nLasted %i Turns.",
                     p1winCounter, p2winCounter, avg];
                UIAlertView *winAlert = [[UIAlertView alloc]
                                         initWithTitle:s
                                         message:@"Play Again?"
                                         delegate:self
                                         cancelButtonTitle:@"No"
                                         otherButtonTitles:@"Yes", nil];
                
                [winAlert show];
            }
            else { [self performSelector:@selector(newGame) withObject:self afterDelay:1 ]; }
        }
        else {
            if (rapidCounter == 50) {
                rapidCounter = 0;
                rapidMode = false;
                int avg = totalTurnCounter/50;
                s = [NSString stringWithFormat:
                     @"iPhone 1 Won %i Times.\niPhone 2 Won %i Times.\nThe Average Game\nLasted %i Turns.",
                     p1winCounter, p2winCounter, avg];
                UIAlertView *winAlert = [[UIAlertView alloc]
                                         initWithTitle:s
                                         message:@"Play Again?"
                                         delegate:self
                                         cancelButtonTitle:@"No"
                                         otherButtonTitles:@"Yes", nil];
                
                [winAlert show];
            }
            else { [self performSelector:@selector(newGame) withObject:self afterDelay:.2 ]; }
        }
    }
}

- (void)iphoneAttackMode:(int) tile {
    
    // sets attack mode and sets the origin of this original hit
    
    if (randomPlay == true) { originHit = tile; }
    randomPlay = false;
}

- (void)iphoneAttackMode2:(int) tile {
    
    // sets attack mode and sets the origin of this original hit
    
    if (randomPlay2 == true) { originHit2 = tile; }
    randomPlay2 = false;
}

- (void)iPhonePlay {
    
    // AI for iphone
    // if the play is random, sort of randomly pick a tile
    // it is a bit more complicated
    //  1/6 of the time the tile selected is truly random
    // the other 5/6 of the time, it picks from a multiple of 3 plus an offset
    // offset is between 0 and 2 that is pick at the start of the game
    // this I found is  good way to find ships stragicially and avoids clumps
    // if play is not random, then stragically try to sink the hit ship
    // this is done by randomly picking an avilible next move
    // if this is a hit, move in that direction until a tile no longer exist or is a miss
    // if that occus and reverse direction
    
    typedef enum{E, H, M, S} battleEnum;
    p1turnCounter++;
    playerTurn = false;
    [self populateGrids];
    if (randomPlay == true) {
        hitDirection = 0;
        int randomTile = ((arc4random_uniform(33) * 3) + aiOffset);
        while ([p1board[randomTile] isEqual: @(M)] || [p1board[randomTile] isEqual: @(H)] ) {
            int howRandom = arc4random_uniform(7);
            if (howRandom == 0) {randomTile = arc4random_uniform(100); }
            else { randomTile = ((arc4random_uniform(33) * 3) + aiOffset); }
        }
        [self playTile:randomTile];
    }
    else {
        if (hitDirection == 0) {
            int tempDirection = [self randomDirection];
            while ( [self tileExists:originHit direction:tempDirection] == false ) {
                tempDirection = [self randomDirection];
            }
            int pickedTile = originHit+tempDirection;
            if ( [p1board[ pickedTile ] isEqual: @(S)] ) {
                currentHit = pickedTile;
                hitDirection = tempDirection;
            }
            [self playTile: pickedTile ];
        }
        else {
            if ( [self tileExists:currentHit direction:hitDirection ] == true ) {
                int pickedTile = currentHit + hitDirection;
                
                if ( [p1board[ pickedTile ] isEqual: @(S)] ) { currentHit = pickedTile; }
                else {
                    currentHit = originHit;
                    hitDirection = hitDirection * -1;
                }
                [self playTile: pickedTile];
            }
            else {
                currentHit = originHit;
                hitDirection = hitDirection * -1;
                int pickedTile = currentHit + hitDirection;
                [self playTile: pickedTile];
                currentHit = pickedTile;
            }
        }
    }
    if (endGame == false) {
        if (gameSpeed == true) {
            if (hundred == true ) { [self performSelector:@selector(iPhonePlay2) withObject:self afterDelay:.005 ]; }
            else { [self performSelector:@selector(iPhonePlay2) withObject:self afterDelay:.05 ]; }
        }
        else { [self performSelector:@selector(iPhonePlay2) withObject:self afterDelay:.5 ]; }
    }
}

- (void)iPhonePlay2 {
    
    // AI for iphone
    // if the play is random, sort of randomly pick a tile
    // it is a bit more complicated
    //  1/6 of the time the tile selected is truly random
    // the other 5/6 of the time, it picks from a multiple of 3 plus an offset
    // offset is between 0 and 2 that is pick at the start of the game
    // this I found is  good way to find ships stragicially and avoids clumps
    // if play is not random, then stragically try to sink the hit ship
    // this is done by randomly picking an avilible next move
    // if this is a hit, move in that direction until a tile no longer exist or is a miss
    // if that occus and reverse direction
    
    typedef enum{E, H, M, S} battleEnum;
    p2turnCounter++;
    playerTurn = true;
    [self populateGrids];
    if (randomPlay2 == true) {
        hitDirection2 = 0;
        int randomTile = ((arc4random_uniform(33) * 3) + aiOffset2);
        while ([p2board[randomTile] isEqual: @(M)] || [p2board[randomTile] isEqual: @(H)] ) {
            int howRandom = arc4random_uniform(7);
            if (howRandom == 0) {randomTile = arc4random_uniform(100); }
            else { randomTile = ((arc4random_uniform(33) * 3) + aiOffset2); }
        }
        [self playTile:randomTile];
    }
    else {
        if (hitDirection2 == 0) {
            int tempDirection = [self randomDirection];
            while ( [self tileExists2:originHit2 direction:tempDirection] == false ) {
                tempDirection = [self randomDirection];
            }
            int pickedTile = originHit2+tempDirection;
            
            if ( [p2board[ pickedTile ] isEqual: @(S)] ) {
                currentHit2 = pickedTile;
                hitDirection2 = tempDirection;
            }
            [self playTile: pickedTile ];
        }
        else {
            if ( [self tileExists2:currentHit2 direction:hitDirection2 ] == true ) {
                int pickedTile = currentHit2 + hitDirection2;
                if ( [p2board[ pickedTile ] isEqual: @(S)] ) { currentHit2 = pickedTile; }
                else {
                    currentHit2 = originHit2;
                    hitDirection2 = hitDirection2 * -1;
                }
                [self playTile: pickedTile ];
            }
            else {
                currentHit2 = originHit2;
                hitDirection2 = hitDirection2 * -1;
                int pickedTile = currentHit2 + hitDirection2;
                [self playTile: pickedTile];
                currentHit2 = pickedTile;
            }
        }
    }
    if (endGame == false) {
        if (gameSpeed == true) {
            if (hundred == true ) { [self performSelector:@selector(iPhonePlay) withObject:self afterDelay:.005 ]; }
            else { [self performSelector:@selector(iPhonePlay) withObject:self afterDelay:.05 ]; }
        }
        else { [self performSelector:@selector(iPhonePlay) withObject:self afterDelay:.5 ]; }
    }
}

- (int)randomDirection {
    int randomVal = arc4random_uniform(4);
    int tempDirection = 0;
    if (randomVal == 0) { tempDirection = -10; }
    else if (randomVal == 1) { tempDirection = 10; }
    else if (randomVal == 2) { tempDirection = 1; }
    else { tempDirection = -1; }
    return tempDirection;
}

- (BOOL)tileExists:(int) currentPos
         direction: (int) currentDirection {
    
    // checks if a tile is off the board and if not, that it is empty or contains a ship for iPhone 1
    
    typedef enum{E, H, M, S} battleEnum;
    BOOL eval = false;
    int x = currentPos + currentDirection;
    int y = currentPos;
    if ( (x > -1) && (x < 100) && ( ([p1board[x] isEqual: @(E)]) || ([p1board[x] isEqual: @(S)]) ) ) {
        if ( (currentDirection == 10) || (currentDirection == -10) ) { eval = true; }
        else {
            if ( (x > (y - (y % 10)) - 1) && (x < (y - (y % 10)) + 10) ) { eval = true; }
            else { eval = false; }
        }
    }
    else { eval = false; }
    return eval;
}

- (BOOL)tileExists2:(int) currentPos
          direction: (int) currentDirection {
    
    // checks if a tile is off the board and if not, that it is empty or contains a ship for iPhone 2

    typedef enum{E, H, M, S} battleEnum;
    BOOL eval = false;
    int x = currentPos + currentDirection;
    int y = currentPos;
    if ( (x > -1) && (x < 100) && ( ([p2board[x] isEqual: @(E)]) || ([p2board[x] isEqual: @(S)]) ) ) {
        if ( (currentDirection == 10) || (currentDirection == -10) ) { eval = true; }
        else {
            if ( (x > (y - (y % 10)) - 1) && (x < (y - (y % 10)) + 10) ) { eval = true; }
            else { eval = false; }
        }
    }
    else { eval = false; }
    return eval;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
