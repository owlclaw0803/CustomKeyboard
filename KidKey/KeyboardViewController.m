//
//  KeyboardViewController.m
//  KidKey
//
//  Created by kangZhe on 10/30/14.
//  Copyright (c) 2014 com.spark.keyboarddesigner. All rights reserved.
//

#import "KeyboardViewController.h"
#import <AVFoundation/AVFoundation.h>

#define portraitHeight_phone 216
#define landscapeHeight_phone 162
#define portraitHeight_pad 264
#define landscapeHeight_pad 352

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define FONT_SFCartoonistHand(s) [UIFont fontWithName:@"SFCartoonistHand-Bold" size:s]

#define lowerkeyboards @[@"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_EXCLAMATION_COMMA.png", @"KEY_QUESTION_PERIOD.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_orange.png"]

#define upperkeyboards @[@"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_EXCLAMATION_COMMA.png", @"KEY_QUESTION_PERIOD.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_orange.png"]

#define lowerkeys @[@"q", @"w", @"e", @"r", @"t", @"y", @"u", @"i", @"o", @"p", @"", @"a", @"s", @"d", @"f", @"g", @"h", @"j", @"k", @"l", @"return", @"ABC", @"z", @"x", @"c", @"v", @"b", @"n", @"m", @",", @".", @"ABC", @"123", @"", @"", @"SPACE", @"", @""]

#define upperkeys @[@"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P", @"", @"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L", @"return", @"abc", @"Z", @"X", @"C", @"V", @"B", @"N", @"M", @"!", @"?", @"abc", @"123", @"", @"", @"SPACE", @"", @""]

#define alphasounds @[@"q_sound", @"w_sound", @"e_sound", @"r_sound", @"t_sound", @"y_sound", @"u_sound", @"i_sound", @"o_sound", @"p_sound", @"", @"a_sound", @"s_sound", @"d_sound", @"f_sound", @"g_sound", @"h_sound", @"j_sound", @"k_sound", @"l_sound", @"", @"", @"z_sound", @"x_sound", @"c_sound", @"v_sound", @"b_sound", @"n_sound", @"m_sound", @"comma_sound", @"period_sound"]

#define numberkeyboards @[@"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_orange.png"]

#define numberkeys @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"", @"-", @"/", @":", @";", @"(", @")", @"$", @"&", @"@", @"return", @"%+=", @"undo", @".", @",", @"?", @"!", @"\'", @"\"", @"%+=", @"abc", @"", @"", @"SPACE", @"abc", @""]

#define numbersounds @[@"1_sound", @"2_sound", @"3_sound", @"4_sound", @"5_sound", @"6_sound", @"7_sound", @"8_sound", @"9_sound", @"0_sound", @"", @"hyphen_sound", @"slash_sound", @"colon_sound", @"semicolon_sound", @"left_parenthesis_sound", @"right_parenthesis_sound", @"dollar_sound", @"ampersand_sound", @"at_sound", @"", @"", @"", @"period_sound", @"comma_sound", @"question_sound", @"exclamation_sound", @"apostrophe_sound", @"quotation_sound"]

#define symbolkeyboards @[@"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_orange.png", @"KEY_back.png", @"KEY_orange.png", @"KEY_orange.png"]

#define symbolkeys @[@"[", @"]", @"{", @"}", @"#", @"%", @"^", @"*", @"+", @"=", @"", @"_", @"\\", @"|", @"~", @"<", @">", @"￡", @"€", @"￥", @"return", @"123", @"redo", @".", @",", @"?", @"!", @"\'", @"\"", @"123", @"abc", @"", @"", @"SPACE", @"abc", @""]

#define symbolsounds @[@"left_square_bracket_sound", @"right_square_bracket_sound", @"left_curved_bracket_sound", @"right_curved_bracket_sound", @"hash_sound", @"percent_sound", @"caret_sound", @"asterisk_sound", @"plus_sound", @"equal_sound", @"", @"underscore__sound", @"backslash_sound", @"bar_sound", @"tilde_sound", @"less_than_sound", @"greater_than_sound", @"pound_sound", @"euro_sound", @"yen_sound", @"", @"", @"", @"period_sound", @"comma_sound", @"question_sound", @"exclamation_sound", @"apostrophe_sound", @"quotation_sound"]

@interface KeyboardViewController ()<AVAudioSessionDelegate>{
    UIButton *predictbtns[3];
    UIButton *alphalowerbtns[38];
    UIButton *alphaupperbtns[38];
    UIButton *symbolbtns[36];
    UIButton *numberbtns[36];
    UIView *alphakeyboard;
    UIView *symbolkeyboard;
    UIView *numberkeyboard;
    
    UIView *predictkeyboard;
    BOOL bCapsLock;
    BOOL bDoubleCapsClick;
    BOOL bSpeak;
    BOOL bSpeakSentence;
    
    int keyboardwidth;
    int keyboardheight;
    NSArray *worddictionary;
    
    NSTimer *aTimer;
    
    NSMutableArray *undoTexts;
    int curundo;
    NSString *undoText;
    NSString *redoText;
    BOOL bUndoclicked;
    int fontsize;
    
    UIImageView* imgbtnChangeKeyboard_alpha;
    UIImageView* imgbtnChangeKeyboard_symbol;
    UIImageView* imgbtnChangeKeyboard_number;
    
    UIImageView* imgbtnSpeak_alpha;
    UIImageView* imgbtnSpeakSentence_alpha;
    UIImageView* imgbtnSpeak_symbol;
    UIImageView* imgbtnSpeak_number;
    
    UIImageView* imgbtnDelete_alpha;
    UIImageView* imgbtnDelete_symbol;
    UIImageView* imgbtnDelete_number;
    
    UIImageView* imgbtnDrop_alpha;
    UIImageView* imgbtnDrop_symbol;
    UIImageView* imgbtnDrop_number;
    
    UIImageView* imgbtnDobuleCaps1;
    UIImageView* imgbtnDobuleCaps2;
}

- (void)removeAllKeys;
- (void)initAlphaKeyboard;
- (void)initSymbolKeyboard;
- (void)initNumberKeyboard;
- (void)initPredictiveKeyboard;
- (NSMutableArray*)getPredictiveWord:(NSString*) word;
- (void)invalidatePredictive;
- (void)clearPredictive;
- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer;
- (void)capslockkeypressed:(UILongPressGestureRecognizer *)gestureRecognizer;
- (void)doublespacepressed:(UILongPressGestureRecognizer *)gestureRecognizer;

- (void)backspacepressed;
- (void)SpeakWord:(NSString*)word;

@property (strong, nonatomic)  AVAudioPlayer * audioPlayer;
@property (strong, nonatomic)  UILexicon *mylexicon;

- (IBAction)alphakeypressed:(id)sender;
- (IBAction)symbolkeypressed:(id)sender;
- (IBAction)numberkeypressed:(id)sender;
- (IBAction)predictiveKeypressed:(id)sender;
- (BOOL) ToCapitalize;
- (NSString*) DoAutocorrection;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* tempview = [[UIView alloc] init];
    [self.view addSubview:tempview];
    undoTexts = [[NSMutableArray alloc] init];
    aTimer = nil;
    curundo = 0;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}

-(void)removeAllKeys
{
    for(int i = 0 ; i < 38 ; i++){
        [alphalowerbtns[i] removeFromSuperview];
        alphalowerbtns[i] = nil;
    }
    for(int i = 0 ; i < 36 ; i++){
        [symbolbtns[i] removeFromSuperview];
        symbolbtns[i] = nil;
    }
    for(int i = 0 ; i < 36 ; i++){
        [numberbtns[i] removeFromSuperview];
        numberbtns[i] = nil;
    }
    for(int i = 0 ; i < 3 ; i++){
        [predictbtns[i] removeFromSuperview];
        predictbtns[i] = nil;
    }
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGSize frame = [[UIScreen mainScreen] bounds].size;
    keyboardwidth = frame.width;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        if(frame.width > frame.height)
            keyboardheight = landscapeHeight_pad;
        else
            keyboardheight = portraitHeight_pad;
    }else{
        if(frame.width > frame.height)
            keyboardheight = landscapeHeight_phone;
        else
            keyboardheight = portraitHeight_phone;
    }
    
    [self removeAllKeys];
    [self initAlphaKeyboard];
    [self initNumberKeyboard];
    [self initSymbolKeyboard];
    [self initPredictiveKeyboard];
}

- (void)initAlphaKeyboard
{
    CGSize frame = [[UIScreen mainScreen] bounds].size;
    
    CGRect rt = CGRectMake(0, 0, keyboardwidth, keyboardheight);

    alphakeyboard.frame = CGRectMake(0,rt.size.height/8,rt.size.width,7*rt.size.height/8);
    float gap = (float)rt.size.width/160;
    float gapy;
    if(frame.width > frame.height)
        gapy = gap;
    else
        gapy = gap*2;
    
    float posy = gapy;
    float btnwidth = (float)rt.size.width/11-gap*2;
    float btnheight = (float)(7*rt.size.height/8 - gapy*8)/4;
    for(int i = 0 ; i < 11 ; i++){
        alphalowerbtns[i] = [[UIButton alloc] initWithFrame:CGRectMake(gap+gap*i*2+btnwidth*i,posy,btnwidth,btnheight)];
    }
    
    [imgbtnDelete_alpha removeFromSuperview];
    if(btnwidth > btnheight)
        imgbtnDelete_alpha.frame = CGRectMake((btnwidth-109*2*btnheight/(3*81))/2, btnheight/6, 109*2*btnheight/(3*81), 2*btnheight/3);
    else
        imgbtnDelete_alpha.frame = CGRectMake(4/2, (btnheight-(btnwidth-4)*81/109)/2, btnwidth-4, (btnwidth-4)*81/109);
    [alphalowerbtns[10] addSubview:imgbtnDelete_alpha];
    
    posy = posy+gapy+gapy+btnheight;
    for(int i = 0 ; i < 9 ; i++){
        alphalowerbtns[i+11] = [[UIButton alloc] initWithFrame:CGRectMake(gap+btnwidth/2+gap*i*2+btnwidth*i,posy,btnwidth,btnheight)];
    }
    
    float btnwidewidth = btnwidth+btnwidth/2+gap*2;
    alphalowerbtns[20] = [[UIButton alloc] initWithFrame:CGRectMake(gap+btnwidth/2+gap*9*2+btnwidth*9, posy, btnwidewidth, btnheight)];
    
    posy = posy+gapy+gapy+btnheight;
    for(int i = 0 ; i < 11 ; i++){
        alphalowerbtns[i+21] = [[UIButton alloc] initWithFrame:CGRectMake(gap+gap*i*2+btnwidth*i,posy,btnwidth,btnheight)];
    }
    
    posy = posy+gapy+gapy+btnheight;
    float posx = gap;
    alphalowerbtns[32] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidewidth,btnheight)];
    
    posx = posx+gap+gap+btnwidewidth;
    
    alphalowerbtns[33] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidewidth,btnheight)];
    [imgbtnChangeKeyboard_alpha removeFromSuperview];
    if(btnwidewidth > btnheight * 2)
        imgbtnChangeKeyboard_alpha.frame = CGRectMake((btnwidewidth-btnheight)/2, 0, btnheight, btnheight);
    else
        imgbtnChangeKeyboard_alpha.frame = CGRectMake((btnwidewidth-btnheight+10)/2, 10/2, btnheight-10, btnheight-10);
    [alphalowerbtns[33] addSubview:imgbtnChangeKeyboard_alpha];
    
    posx = posx+gap+gap+btnwidewidth;
    
    alphalowerbtns[34] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidewidth,btnheight)];
    [imgbtnSpeak_alpha removeFromSuperview];
    if(btnwidewidth > btnheight * 2)
        imgbtnSpeak_alpha.frame = CGRectMake((btnwidewidth-64*btnheight/58)/2, 0, 64*btnheight/58, btnheight);
    else
        imgbtnSpeak_alpha.frame = CGRectMake((btnwidewidth-64*(btnheight-10)/58)/2, 10/2, 64*(btnheight-10)/58, btnheight-10);
    [alphalowerbtns[34] addSubview:imgbtnSpeak_alpha];
    
    float postemp = posx+gap+gap+btnwidewidth;
    
    posx = frame.width-btnwidth-gap;
    alphalowerbtns[37] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidth,btnheight)];
    
    [imgbtnDrop_alpha removeFromSuperview];
    if(btnwidth > btnheight)
        imgbtnDrop_alpha.frame = CGRectMake((btnwidth-120*2*btnheight/(3*75))/2, btnheight/6, 120*2*btnheight/(3*75), 2*btnheight/3);
    else
        imgbtnDrop_alpha.frame = CGRectMake(4/2, (btnheight-(btnwidth-4)*75/120)/2, btnwidth-4, (btnwidth-4)*75/120);
    [alphalowerbtns[37] addSubview:imgbtnDrop_alpha];
    
    posx = posx-gap-gap-btnwidewidth;
    
    alphalowerbtns[36] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidewidth,btnheight)];
    [imgbtnSpeakSentence_alpha removeFromSuperview];
    if(btnwidewidth > btnheight * 2)
        imgbtnSpeakSentence_alpha.frame = CGRectMake((btnwidewidth-64*btnheight/58)/2, 0, 64*btnheight/58, btnheight);
    else
        imgbtnSpeakSentence_alpha.frame = CGRectMake((btnwidewidth-64*(btnheight-10)/58)/2, 10/2, 64*(btnheight-10)/58, btnheight-10);
    [alphalowerbtns[36] addSubview:imgbtnSpeakSentence_alpha];

    alphalowerbtns[35] = [[UIButton alloc] initWithFrame:CGRectMake(postemp,posy,posx-postemp-gap-gap,btnheight)];
    
    for(int i = 0 ; i < 38 ; i++){
        alphalowerbtns[i].layer.cornerRadius = 3.0f;
        alphalowerbtns[i].layer.masksToBounds = YES;
        if(bCapsLock || bDoubleCapsClick){
            [alphalowerbtns[i] setBackgroundImage:[UIImage imageNamed:upperkeyboards[i]] forState:UIControlStateNormal];
            alphalowerbtns[i].font = FONT_SFCartoonistHand(fontsize);
            if(i != 29 && i != 30)
                [alphalowerbtns[i] setTitle:upperkeys[i] forState:UIControlStateNormal];
        }else{
            [alphalowerbtns[i] setBackgroundImage:[UIImage imageNamed:lowerkeyboards[i]] forState:UIControlStateNormal];
            alphalowerbtns[i].font = FONT_SFCartoonistHand(fontsize-3);
            if(i != 29 && i != 30)
                [alphalowerbtns[i] setTitle:lowerkeys[i] forState:UIControlStateNormal];
        }
        alphalowerbtns[i].contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [alphalowerbtns[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [alphalowerbtns[i] addTarget:self action:@selector(alphakeypressed:) forControlEvents:UIControlEventTouchUpInside];
        alphalowerbtns[i].tag = i;
        [alphakeyboard addSubview:alphalowerbtns[i]];
    }
    
    if(bCapsLock || bDoubleCapsClick){
        alphalowerbtns[21].font = FONT_SFCartoonistHand(fontsize-17);
        alphalowerbtns[31].font = FONT_SFCartoonistHand(fontsize-17);
    }else{
        alphalowerbtns[21].font = FONT_SFCartoonistHand(fontsize-20);
        alphalowerbtns[31].font = FONT_SFCartoonistHand(fontsize-20);
    }
    if(bDoubleCapsClick){
        [alphalowerbtns[21] setTitle:@"" forState:UIControlStateNormal];
        [alphalowerbtns[31] setTitle:@"" forState:UIControlStateNormal];
    }
    if(frame.width < frame.height){
        alphalowerbtns[20].font = FONT_SFCartoonistHand(fontsize-20);
    }else{
        alphalowerbtns[20].font = FONT_SFCartoonistHand(fontsize-8);
    }
    alphalowerbtns[32].font = FONT_SFCartoonistHand(fontsize-17);
    alphalowerbtns[35].font = FONT_SFCartoonistHand(fontsize-15);
    alphalowerbtns[36].font = FONT_SFCartoonistHand(fontsize-17);
    
    [imgbtnDobuleCaps1 removeFromSuperview];
    [imgbtnDobuleCaps2 removeFromSuperview];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        imgbtnDobuleCaps1.frame = CGRectMake((btnwidth-((btnheight-4)/2)*52/19)/2, (btnheight-(btnheight-4)/2)/2, ((btnheight-4)/2)*52/19, (btnheight-4)/2);
    }else{
        if(btnwidth > btnheight)
            imgbtnDobuleCaps1.frame = CGRectMake((btnwidth-43*btnheight/47)/2, 0, 43*btnheight/47, btnheight);
        else
            imgbtnDobuleCaps1.frame = CGRectMake(0, (btnheight-btnwidth*47/43)/2, btnwidth, btnwidth*47/43);
    }
    imgbtnDobuleCaps2.frame = imgbtnDobuleCaps1.frame;
    [alphalowerbtns[21] addSubview:imgbtnDobuleCaps1];
    [alphalowerbtns[31] addSubview:imgbtnDobuleCaps2];
    
    UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(capslockkeypressed:)];
    tapTwice.numberOfTapsRequired = 2;
    [alphalowerbtns[21] addGestureRecognizer:tapTwice];
    
    UITapGestureRecognizer *tapTwice1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(capslockkeypressed:)];
    tapTwice1.numberOfTapsRequired = 2;
    [alphalowerbtns[31] addGestureRecognizer:tapTwice1];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = .3; //seconds
    lpgr.delegate = self;
    [alphalowerbtns[10] addGestureRecognizer:lpgr];
    
    UITapGestureRecognizer *tapTwice2 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(doublespacepressed:)];
    tapTwice2.numberOfTapsRequired = 2;
    [alphalowerbtns[35] addGestureRecognizer:tapTwice2];
}

- (void)initSymbolKeyboard
{
    CGSize frame = [[UIScreen mainScreen] bounds].size;
    
    CGRect rt = CGRectMake(0, 0, keyboardwidth, keyboardheight);
    
    symbolkeyboard.frame = CGRectMake(0,rt.size.height/8,rt.size.width,7*rt.size.height/8);
    float gap = (float)rt.size.width/160;
    float gapy;
    if(frame.width > frame.height)
        gapy = gap;
    else
        gapy = gap*2;
    
    float posy = gapy;
    float btnwidth = (float)rt.size.width/11-gap*2;
    float btnheight = (float)(7*rt.size.height/8 - gapy*8)/4;
    for(int i = 0 ; i < 11 ; i++){
        symbolbtns[i] = [[UIButton alloc] initWithFrame:CGRectMake(gap+gap*i*2+btnwidth*i,posy,btnwidth,btnheight)];
    }
    
    [imgbtnDelete_symbol removeFromSuperview];
    if(btnwidth > btnheight)
        imgbtnDelete_symbol.frame = CGRectMake((btnwidth-109*2*btnheight/(3*81))/2, btnheight/6, 109*2*btnheight/(3*81), 2*btnheight/3);
    else
        imgbtnDelete_symbol.frame = CGRectMake(4/2, (btnheight-(btnwidth-4)*81/109)/2, btnwidth-4, (btnwidth-4)*81/109);
    [symbolbtns[10] addSubview:imgbtnDelete_symbol];
    
    posy = posy+gapy+gapy+btnheight;
    for(int i = 0 ; i < 9 ; i++){
        symbolbtns[i+11] = [[UIButton alloc] initWithFrame:CGRectMake(gap+btnwidth/2+gap*i*2+btnwidth*i,posy,btnwidth,btnheight)];
    }
    
    float btnwidewidth = btnwidth+btnwidth/2+gap*2;
    symbolbtns[20] = [[UIButton alloc] initWithFrame:CGRectMake(gap+btnwidth/2+gap*9*2+btnwidth*9, posy, btnwidewidth, btnheight)];
    
    posy = posy+gapy+gapy+btnheight;

    symbolbtns[21] = [[UIButton alloc] initWithFrame:CGRectMake(gap, posy, btnwidewidth, btnheight)];
    
    float tempwidth = frame.width-btnwidth*6 - btnwidewidth*2 - gap*18;
    symbolbtns[22] = [[UIButton alloc] initWithFrame:CGRectMake(gap+btnwidewidth+gap*2, posy, tempwidth, btnheight)];
    
    for(int i = 0 ; i < 6 ; i++){
        symbolbtns[i+23] = [[UIButton alloc] initWithFrame:CGRectMake(gap+btnwidewidth+tempwidth+gap*4+gap*i*2+btnwidth*i,posy,btnwidth,btnheight)];
    }
    
    symbolbtns[29] = [[UIButton alloc] initWithFrame:CGRectMake(frame.width-gap-btnwidewidth, posy, btnwidewidth, btnheight)];
    
    posy = posy+gapy+gapy+btnheight;
    float posx = gap;
    symbolbtns[30] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidewidth,btnheight)];
    
    posx = posx+gap+gap+btnwidewidth;
    
    symbolbtns[31] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidewidth,btnheight)];
    [imgbtnChangeKeyboard_symbol removeFromSuperview];
    if(btnwidewidth > btnheight * 2)
        imgbtnChangeKeyboard_symbol.frame = CGRectMake((btnwidewidth-btnheight)/2, 0, btnheight, btnheight);
    else
        imgbtnChangeKeyboard_symbol.frame = CGRectMake((btnwidewidth-btnheight+10)/2, 10/2, btnheight-10, btnheight-10);
    [symbolbtns[31] addSubview:imgbtnChangeKeyboard_symbol];
    
    posx = posx+gap+gap+btnwidewidth;
    
    symbolbtns[32] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidewidth,btnheight)];
    [imgbtnSpeak_symbol removeFromSuperview];
    if(btnwidewidth > btnheight * 2)
        imgbtnSpeak_symbol.frame = CGRectMake((btnwidewidth-btnheight)/2, 0, btnheight, btnheight);
    else
        imgbtnSpeak_symbol.frame = CGRectMake((btnwidewidth-btnheight+10)/2, 10/2, btnheight-10, btnheight-10);
    [symbolbtns[32] addSubview:imgbtnSpeak_symbol];
    
    float postemp = posx+gap+gap+btnwidewidth;
    
    posx = frame.width-btnwidth-gap;
    symbolbtns[35] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidth,btnheight)];
    [imgbtnDrop_symbol removeFromSuperview];
    if(btnwidth > btnheight)
        imgbtnDrop_symbol.frame = CGRectMake((btnwidth-120*2*btnheight/(3*75))/2, btnheight/6, 120*2*btnheight/(3*75), 2*btnheight/3);
    else
        imgbtnDrop_symbol.frame = CGRectMake(4/2, (btnheight-(btnwidth-4)*75/120)/2, btnwidth-4, (btnwidth-4)*75/120);
    [symbolbtns[35] addSubview:imgbtnDrop_symbol];
    
    posx = posx-gap-gap-btnwidewidth;
    
    symbolbtns[34] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidewidth,btnheight)];
    
    symbolbtns[33] = [[UIButton alloc] initWithFrame:CGRectMake(postemp,posy,posx-postemp-gap-gap,btnheight)];
    
    for(int i = 0 ; i < 36 ; i++){
        symbolbtns[i].layer.cornerRadius = 3.0f;
        symbolbtns[i].layer.masksToBounds = YES;
        [symbolbtns[i] setBackgroundImage:[UIImage imageNamed:symbolkeyboards[i]] forState:UIControlStateNormal];
        [symbolbtns[i] setTitle:symbolkeys[i] forState:UIControlStateNormal];
        symbolbtns[i].font = FONT_SFCartoonistHand(fontsize-2);
        symbolbtns[i].contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [symbolbtns[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [symbolbtns[i] addTarget:self action:@selector(symbolkeypressed:) forControlEvents:UIControlEventTouchUpInside];
        symbolbtns[i].tag = i+100;
        [symbolkeyboard addSubview:symbolbtns[i]];
    }
    symbolbtns[17].font = FONT_SFCartoonistHand(fontsize-10);
    symbolbtns[19].font = FONT_SFCartoonistHand(fontsize-10);
    if(frame.width < frame.height){
        symbolbtns[20].font = FONT_SFCartoonistHand(fontsize-20);
    }else{
        symbolbtns[20].font = FONT_SFCartoonistHand(fontsize-8);
    }
    symbolbtns[21].font = FONT_SFCartoonistHand(fontsize-15);
    symbolbtns[22].font = FONT_SFCartoonistHand(fontsize-15);
    symbolbtns[29].font = FONT_SFCartoonistHand(fontsize-15);
    symbolbtns[30].font = FONT_SFCartoonistHand(fontsize-15);
    symbolbtns[33].font = FONT_SFCartoonistHand(fontsize-15);
    symbolbtns[34].font = FONT_SFCartoonistHand(fontsize-15);
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = .3; //seconds
    lpgr.delegate = self;
    [symbolbtns[10] addGestureRecognizer:lpgr];
    
    UITapGestureRecognizer *tapTwice2 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(doublespacepressed:)];
    tapTwice2.numberOfTapsRequired = 2;
    [symbolbtns[33] addGestureRecognizer:tapTwice2];
}

- (void)initNumberKeyboard
{
    CGSize frame = [[UIScreen mainScreen] bounds].size;
    
    CGRect rt = CGRectMake(0, 0, keyboardwidth, keyboardheight);
    
    numberkeyboard.frame = CGRectMake(0,rt.size.height/8,rt.size.width,7*rt.size.height/8);
    float gap = (float)rt.size.width/160;
    float gapy;
    if(frame.width > frame.height)
        gapy = gap;
    else
        gapy = gap*2;
    
    float posy = gapy;
    float btnwidth = (float)rt.size.width/11-gap*2;
    float btnheight = (float)(7*rt.size.height/8 - gapy*8)/4;
    for(int i = 0 ; i < 11 ; i++){
        numberbtns[i] = [[UIButton alloc] initWithFrame:CGRectMake(gap+gap*i*2+btnwidth*i,posy,btnwidth,btnheight)];
    }
    
    [imgbtnDelete_number removeFromSuperview];
    if(btnwidth > btnheight)
        imgbtnDelete_number.frame = CGRectMake((btnwidth-109*2*btnheight/(3*81))/2, btnheight/6, 109*2*btnheight/(3*81), 2*btnheight/3);
    else
        imgbtnDelete_number.frame = CGRectMake(4/2, (btnheight-(btnwidth-4)*81/109)/2, btnwidth-4, (btnwidth-4)*81/109);
    [numberbtns[10] addSubview:imgbtnDelete_number];
    
    posy = posy+gapy+gapy+btnheight;
    for(int i = 0 ; i < 9 ; i++){
        numberbtns[i+11] = [[UIButton alloc] initWithFrame:CGRectMake(gap+btnwidth/2+gap*i*2+btnwidth*i,posy,btnwidth,btnheight)];
    }
    
    float btnwidewidth = btnwidth+btnwidth/2+gap*2;
    numberbtns[20] = [[UIButton alloc] initWithFrame:CGRectMake(gap+btnwidth/2+gap*9*2+btnwidth*9, posy, btnwidewidth, btnheight)];
    
    posy = posy+gapy+gapy+btnheight;
    
    numberbtns[21] = [[UIButton alloc] initWithFrame:CGRectMake(gap, posy, btnwidewidth, btnheight)];
    
    float tempwidth = frame.width-btnwidth*6 - btnwidewidth*2 - gap*18;
    numberbtns[22] = [[UIButton alloc] initWithFrame:CGRectMake(gap+btnwidewidth+gap*2, posy, tempwidth, btnheight)];
    
    for(int i = 0 ; i < 6 ; i++){
        numberbtns[i+23] = [[UIButton alloc] initWithFrame:CGRectMake(gap+btnwidewidth+tempwidth+gap*4+gap*i*2+btnwidth*i,posy,btnwidth,btnheight)];
    }
    
    numberbtns[29] = [[UIButton alloc] initWithFrame:CGRectMake(frame.width-gap-btnwidewidth, posy, btnwidewidth, btnheight)];
    
    posy = posy+gapy+gapy+btnheight;
    float posx = gap;
    numberbtns[30] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidewidth,btnheight)];
    
    posx = posx+gap+gap+btnwidewidth;
    
    numberbtns[31] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidewidth,btnheight)];
    [imgbtnChangeKeyboard_number removeFromSuperview];
    if(btnwidewidth > btnheight * 2)
        imgbtnChangeKeyboard_number.frame = CGRectMake((btnwidewidth-btnheight)/2, 0, btnheight, btnheight);
    else
        imgbtnChangeKeyboard_number.frame = CGRectMake((btnwidewidth-btnheight+10)/2, 10/2, btnheight-10, btnheight-10);
    [numberbtns[31] addSubview:imgbtnChangeKeyboard_number];
    
    posx = posx+gap+gap+btnwidewidth;
    
    numberbtns[32] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidewidth,btnheight)];
    [imgbtnSpeak_number removeFromSuperview];
    if(btnwidewidth > btnheight * 2)
        imgbtnSpeak_number.frame = CGRectMake((btnwidewidth-btnheight)/2, 0, btnheight, btnheight);
    else
        imgbtnSpeak_number.frame = CGRectMake((btnwidewidth-btnheight+10)/2, 10/2, btnheight-10, btnheight-10);
    [numberbtns[32] addSubview:imgbtnSpeak_number];
    
    float postemp = posx+gap+gap+btnwidewidth;
    
    posx = frame.width-btnwidth-gap;
    numberbtns[35] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidth,btnheight)];
    [imgbtnDrop_number removeFromSuperview];
    if(btnwidth > btnheight)
        imgbtnDrop_number.frame = CGRectMake((btnwidth-120*2*btnheight/(3*75))/2, btnheight/6, 120*2*btnheight/(3*75), 2*btnheight/3);
    else
        imgbtnDrop_number.frame = CGRectMake(4/2, (btnheight-(btnwidth-4)*75/120)/2, btnwidth-4, (btnwidth-4)*75/120);
    [numberbtns[35] addSubview:imgbtnDrop_number];
    
    posx = posx-gap-gap-btnwidewidth;
    
    numberbtns[34] = [[UIButton alloc] initWithFrame:CGRectMake(posx,posy,btnwidewidth,btnheight)];
    
    numberbtns[33] = [[UIButton alloc] initWithFrame:CGRectMake(postemp,posy,posx-postemp-gap-gap,btnheight)];
    
    for(int i = 0 ; i < 36 ; i++){
        numberbtns[i].layer.cornerRadius = 3.0f;
        numberbtns[i].layer.masksToBounds = YES;
        [numberbtns[i] setBackgroundImage:[UIImage imageNamed:numberkeyboards[i]] forState:UIControlStateNormal];
        [numberbtns[i] setTitle:numberkeys[i] forState:UIControlStateNormal];
        numberbtns[i].font = FONT_SFCartoonistHand(fontsize-2);
        numberbtns[i].contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [numberbtns[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [numberbtns[i] addTarget:self action:@selector(numberkeypressed:) forControlEvents:UIControlEventTouchUpInside];
        numberbtns[i].tag = i+200;
        [numberkeyboard addSubview:numberbtns[i]];
    }
    if(frame.width < frame.height){
        numberbtns[20].font = FONT_SFCartoonistHand(fontsize-20);
    }else{
        numberbtns[20].font = FONT_SFCartoonistHand(fontsize-8);
    }
    numberbtns[21].font = FONT_SFCartoonistHand(fontsize-15);
    numberbtns[22].font = FONT_SFCartoonistHand(fontsize-15);
    numberbtns[29].font = FONT_SFCartoonistHand(fontsize-15);
    numberbtns[30].font = FONT_SFCartoonistHand(fontsize-15);
    numberbtns[33].font = FONT_SFCartoonistHand(fontsize-15);
    numberbtns[34].font = FONT_SFCartoonistHand(fontsize-15);
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = .3; //seconds
    lpgr.delegate = self;
    [numberbtns[10] addGestureRecognizer:lpgr];
    
    UITapGestureRecognizer *tapTwice2 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(doublespacepressed:)];
    tapTwice2.numberOfTapsRequired = 2;
    [numberbtns[33] addGestureRecognizer:tapTwice2];
}

-(void)backspacepressed
{
    [self.textDocumentProxy deleteBackward];
    [self invalidatePredictive];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [aTimer invalidate];
        aTimer = nil;
        return;
    }
    if(!aTimer){
        aTimer = [NSTimer scheduledTimerWithTimeInterval:.06 target:self selector:@selector(backspacepressed) userInfo:nil repeats:YES];
    }
}

-(void)capslockkeypressed:(UILongPressGestureRecognizer *)gestureRecognizer
{
    bDoubleCapsClick = YES;
    [self changetoupper];
    [alphalowerbtns[21] setTitle:@"" forState:UIControlStateNormal];
    [alphalowerbtns[31] setTitle:@"" forState:UIControlStateNormal];
    
    [imgbtnDobuleCaps1 setHidden:NO];
    [imgbtnDobuleCaps2 setHidden:NO];
    bCapsLock = NO;
}

-(void)invalidatePredictive
{
    for(int i = 0 ; i < 3 ; i++){
        [predictbtns[i] setTitle:@"" forState:UIControlStateNormal];
    }
    NSString *totalstr = [self.textDocumentProxy documentContextBeforeInput];
    NSArray *arr = [totalstr componentsSeparatedByString:@" "];
    totalstr = [arr objectAtIndex:arr.count-1];
    if(totalstr != nil && ![totalstr isEqual:@""]){
        NSMutableArray* arr = [self getPredictiveWord:totalstr];
        if(arr){
            for(int i = 0 ; i < arr.count ; i++){
                if(i == 0)
                    [predictbtns[1] setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
                else if(i == 1)
                    [predictbtns[0] setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
                else
                    [predictbtns[i] setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
            }
         }
    }
}

- (void)SpeakWord:(NSString*)word
{
    if(word.length > 0){
        AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:word];
        [utterance setRate:AVSpeechUtteranceMinimumSpeechRate];
        [av speakUtterance:utterance];
    }else{
        [self changetolower];
        bCapsLock = NO;
        bDoubleCapsClick = NO;
    }
}

-(NSString*)getLastSentence:(int)type
{
    NSString *cur = [self.textDocumentProxy documentContextBeforeInput];
    cur = [cur stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    int len = cur.length;
    NSString *sentence = @"";
    if(len == 1)
        return @"";
    for(int i = len-1 ; i >= 0 ; i--){
        if([cur characterAtIndex:i] == '.' || [cur characterAtIndex:i] == '?' || [cur characterAtIndex:i] == ','){
            if(i == len-1&&type==3)
                continue;
            sentence = [cur substringFromIndex:i+1];
            sentence = [sentence stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            return sentence;
        }
    }
    return cur;
}

- (void)SpeakSentence:(int)type
{
    NSString *filename = @"";
    float time = 0;
    switch(type){
        case 0:
            filename = @"period_sound";
            time = 0.6;
            break;
        case 1:
            filename = @"question_sound";
            time = 0.9;
            break;
        case 2:
            filename = @"exclamation_sound";
            time = 1.4;
            break;
        case 3:
            filename = @"period_sound";
            time = 0.6;
            break;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"mp3"];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
    [self.audioPlayer setVolume:1.0];
    [self.audioPlayer setNumberOfLoops:0];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    [NSThread sleepForTimeInterval:time];
    if(bSpeakSentence){
        NSString *sentence = [self getLastSentence:type];
        AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc] init];
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:sentence];
        [utterance setRate:AVSpeechUtteranceMinimumSpeechRate];
        [av speakUtterance:utterance];
    }
}

-(void)clearPredictive
{
    for(int i = 0 ; i < 3 ; i++){
        [predictbtns[i] setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)doublespacepressed:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if([self ToCapitalize]){
        [self.textDocumentProxy insertText:@". "];
        [self SpeakSentence:3];
    }else{
        [self.textDocumentProxy insertText:@" "];
    }
}

- (void)savePreviousStatus
{
    if(undoTexts == nil){
        undoTexts = [[NSMutableArray alloc] init];
    }
    NSString *cur = [self.textDocumentProxy documentContextBeforeInput];
    if(cur == nil)
        return;
    for(int i = curundo ; i < undoTexts.count ; i++){
        [undoTexts removeObjectAtIndex:i];
    }
    [undoTexts addObject:cur];
    curundo++;
}
    
- (IBAction)alphakeypressed:(id)sender
{
    NSString *filename = @"";
    //AudioServicesPlaySystemSound(1104);
    UIButton *btn = (UIButton*)sender;
    int tag = btn.tag;
    if((tag >= 0 && tag <= 9) || (tag >= 11 && tag <= 19) || (tag >= 22 && tag <= 30)){
        filename = alphasounds[tag];
        [self savePreviousStatus];
        if(tag == 29){
            if(bCapsLock){
                filename = @"";
                [self SpeakSentence:2];
            }
        }else if(tag == 30){
            //if(bCapsLock)
                //filename = @"question_sound";
                filename = @"";
            if(bCapsLock)
                [self SpeakSentence:1];
            else
                [self SpeakSentence:0];
            //else{
            [self ToCapitalize];
            //}
        }
        bUndoclicked = NO;
        if(bCapsLock || bDoubleCapsClick)
            [self.textDocumentProxy insertText:upperkeys[tag]];
        else
            [self.textDocumentProxy insertText:lowerkeys[tag]];
        [self invalidatePredictive];
    }else if(tag == 10){//backspace
        filename = @"delete_sound";
        [self savePreviousStatus];
        [self.textDocumentProxy deleteBackward];
        [self invalidatePredictive];
        bUndoclicked = NO;
    }else if(tag == 20){
        filename = @"return_sound";
        [self.textDocumentProxy insertText:@"\n"];
        [self clearPredictive];
        bUndoclicked = NO;
    }else if(tag == 21 || tag == 31){//capslock
        if(bCapsLock || bDoubleCapsClick){
            filename = @"lower_case_sound";
            [alphalowerbtns[21] setTitle:@"ABC" forState:UIControlStateNormal];
            [alphalowerbtns[31] setTitle:@"ABC" forState:UIControlStateNormal];
            [self changetolower];
            bCapsLock = NO;
            bDoubleCapsClick = NO;
            [imgbtnDobuleCaps1 setHidden:YES];
            [imgbtnDobuleCaps2 setHidden:YES];
        }else{
            filename = @"upper_case_sound";
            [alphalowerbtns[21] setTitle:@"abc" forState:UIControlStateNormal];
            [alphalowerbtns[31] setTitle:@"abc" forState:UIControlStateNormal];
            [self changetoupper];
            bCapsLock = YES;
            bDoubleCapsClick = NO;
        }
    }else if(tag == 36){//symbol, speak sentence
        //filename = @"symbols_sound";
        //[imgbtnDobuleCaps1 setHidden:YES];
        //[imgbtnDobuleCaps2 setHidden:YES];
        //[alphakeyboard setHidden:YES];
        //[numberkeyboard setHidden:NO];
        if(bSpeakSentence){
            filename = @"speak_sentence_off_sound";
            dispatch_async(kBgQueue, ^{
                NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"mp3"];
                self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
                [self.audioPlayer setVolume:1.0];
                [self.audioPlayer setNumberOfLoops:0];
                [self.audioPlayer prepareToPlay];
                [self.audioPlayer play];
            });
            [imgbtnSpeakSentence_alpha setImage:[UIImage imageNamed:@"KEY_SENTENCE_OFF.png"]];
            bSpeakSentence = NO;
            return;
        }else{
            filename = @"speak_sentence_on_sound";
            [imgbtnSpeakSentence_alpha setImage:[UIImage imageNamed:@"KEY_SENTENCE.png"]];
            bSpeakSentence = YES;
        }
    }else if(tag == 33){//next keyboard
        filename = @"change_keyboard_sound";
        [self advanceToNextInputMode];
    }else if(tag == 34){//speak
        if(bSpeak){
            filename = @"speak_off_sound";
            dispatch_async(kBgQueue, ^{
                NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"mp3"];
                self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
                [self.audioPlayer setVolume:1.0];
                [self.audioPlayer setNumberOfLoops:0];
                [self.audioPlayer prepareToPlay];
                [self.audioPlayer play];
            });
            [imgbtnSpeak_alpha setImage:[UIImage imageNamed:@"KEY_SPEAK_OFF.png"]];
            [imgbtnSpeak_symbol setImage:[UIImage imageNamed:@"KEY_SPEAK_OFF.png"]];
            [imgbtnSpeak_number setImage:[UIImage imageNamed:@"KEY_SPEAK_OFF.png"]];
            bSpeak = NO;
            return;
        }else{
            filename = @"speak_on_sound";
            [imgbtnSpeak_alpha setImage:[UIImage imageNamed:@"KEY_SPEAK.png"]];
            [imgbtnSpeak_symbol setImage:[UIImage imageNamed:@"KEY_SPEAK.png"]];
            [imgbtnSpeak_number setImage:[UIImage imageNamed:@"KEY_SPEAK.png"]];
            bSpeak = YES;
        }
    }else if(tag == 35){
        filename = @"space_sound";
        [self savePreviousStatus];
        NSString *retword = [self DoAutocorrection];
        [self.textDocumentProxy insertText:@" "];
        [self clearPredictive];
        bUndoclicked = NO;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"space_sound" ofType:@"mp3"];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
        [self.audioPlayer setVolume:1.0];
        [self.audioPlayer setNumberOfLoops:0];
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        if(bSpeak){
            [NSThread sleepForTimeInterval:0.5];
            [self SpeakWord:retword];
            return;
        }
    }else if(tag == 32){//number
        filename = @"numbers_sound";
        [imgbtnDobuleCaps1 setHidden:YES];
        [imgbtnDobuleCaps2 setHidden:YES];
        [alphakeyboard setHidden:YES];
        [numberkeyboard setHidden:NO];
    }else if(tag == 37){//hide keyboard
        filename = @"drop_keyboard_sound";
        [self dismissKeyboard];
    }else if(tag == 1000){
        [self SpeakSentence:-1];
    }
    if(filename && filename.length > 0){
        dispatch_async(kBgQueue, ^{
            NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"mp3"];
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
            [self.audioPlayer setVolume:1.0];
            [self.audioPlayer setNumberOfLoops:0];
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
        });
    }
    if(tag != 21 && tag != 31 && bCapsLock && !bDoubleCapsClick){
        [self changetolower];
        bCapsLock = NO;
        bDoubleCapsClick = NO;
    }
    
    if((tag == 32 || tag == 36) && bDoubleCapsClick){
        [self changetolower];
        bCapsLock = NO;
        bDoubleCapsClick = NO;
    }
}

- (IBAction)symbolkeypressed:(id)sender
{
    NSString *filename = @"";
    //AudioServicesPlaySystemSound(1104);
    UIButton *btn = (UIButton*)sender;
    int tag = btn.tag - 100;
    if((tag >= 0 && tag <= 9) || (tag >= 11 && tag <= 19) || (tag >= 23 && tag <= 28)){
        filename = symbolsounds[tag];
        [self savePreviousStatus];
        if(tag == 23 || tag == 25){
            filename = @"";
            [self ToCapitalize];
            if(tag == 23)
                [self SpeakSentence:0];
            else
                [self SpeakSentence:1];
        }
        if(tag == 26){
            filename = @"";
            [self SpeakSentence:2];
        }
        [self.textDocumentProxy insertText:symbolkeys[tag]];
        [self invalidatePredictive];
        bUndoclicked = NO;
    }else if(tag == 10){//backspace
        filename = @"delete_sound";
        [self savePreviousStatus];
        [self.textDocumentProxy deleteBackward];
        [self invalidatePredictive];
        bUndoclicked = NO;
    }else if(tag == 20){
        filename = @"return_sound";
        [self.textDocumentProxy insertText:@"\n"];
        [self clearPredictive];
        bUndoclicked = NO;
    }else if(tag == 21 || tag == 29){//number
        filename = @"numbers_sound";
        [symbolkeyboard setHidden:YES];
        [numberkeyboard setHidden:NO];
    }else if(tag == 22){//redo
        filename = @"redo_sound";
        //if(bUndoclicked){
        //    NSString* str = [self.textDocumentProxy documentContextBeforeInput];
        //    for(int i = 0 ; i < str.length ; i++)
        //        [self.textDocumentProxy deleteBackward];
        //    [self.textDocumentProxy insertText:redoText];
        //    bUndoclicked = NO;
        //}
        if(curundo < undoTexts.count){
            NSString* str = [self.textDocumentProxy documentContextBeforeInput];
            for(int i = 0 ; i < str.length ; i++)
                [self.textDocumentProxy deleteBackward];
            NSString *temp = [undoTexts objectAtIndex:curundo];
            [self.textDocumentProxy insertText:temp];
            curundo++;
        }
    }else if(tag == 30 || tag == 34){//alpha_keyboard
        filename = @"letters_sound";
        [symbolkeyboard setHidden:YES];
        [alphakeyboard setHidden:NO];
    }else if(tag == 31){//next keyboard
        filename = @"change_keyboard_sound";
        [self advanceToNextInputMode];
    }else if(tag == 32){//speak
        if(bSpeak){
            filename = @"speak_off_sound";
            [imgbtnSpeak_alpha setImage:[UIImage imageNamed:@"KEY_SPEAK_OFF.png"]];
            [imgbtnSpeak_symbol setImage:[UIImage imageNamed:@"KEY_SPEAK_OFF.png"]];
            [imgbtnSpeak_number setImage:[UIImage imageNamed:@"KEY_SPEAK_OFF.png"]];
        }else{
            filename = @"speak_on_sound";
            [imgbtnSpeak_alpha setImage:[UIImage imageNamed:@"KEY_SPEAK.png"]];
            [imgbtnSpeak_symbol setImage:[UIImage imageNamed:@"KEY_SPEAK.png"]];
            [imgbtnSpeak_number setImage:[UIImage imageNamed:@"KEY_SPEAK.png"]];
        }
        bSpeak = !bSpeak;
        dispatch_async(kBgQueue, ^{
            NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"mp3"];
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
            [self.audioPlayer setVolume:1.0];
            [self.audioPlayer setNumberOfLoops:0];
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
        });
        return;
    }else if(tag == 33){//space
        filename = @"space_sound";
        [self savePreviousStatus];
        NSString *retword = [self DoAutocorrection];
        [self.textDocumentProxy insertText:@" "];
        [self clearPredictive];
        bUndoclicked = NO;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"space_sound" ofType:@"mp3"];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
        [self.audioPlayer setVolume:1.0];
        [self.audioPlayer setNumberOfLoops:0];
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        if(bSpeak){
            [NSThread sleepForTimeInterval:0.5];
            [self SpeakWord:retword];
            return;
        }
    }else if(tag == 35){//hide keyboard
        filename = @"drop_keyboard_sound";
        [self dismissKeyboard];
    }
    if(filename && filename.length > 0){
        dispatch_async(kBgQueue, ^{
            NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"mp3"];
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
            [self.audioPlayer setVolume:1.0];
            [self.audioPlayer setNumberOfLoops:0];
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
        });
    }
}

-(void)changetolower
{
    for(int i = 0 ; i < 38 ; i++){
        if(i != 29 && i != 30)
            [alphalowerbtns[i] setTitle:lowerkeys[i] forState:UIControlStateNormal];
    }
    alphalowerbtns[21].font = FONT_SFCartoonistHand(fontsize-20);
    alphalowerbtns[31].font = FONT_SFCartoonistHand(fontsize-20);
}

-(void)changetoupper
{
    for(int i = 0 ; i < 38 ; i++){
        if(i != 29 && i != 30)
            [alphalowerbtns[i] setTitle:upperkeys[i] forState:UIControlStateNormal];
    }
    alphalowerbtns[21].font = FONT_SFCartoonistHand(fontsize-17);
    alphalowerbtns[31].font = FONT_SFCartoonistHand(fontsize-17);
}

- (IBAction)numberkeypressed:(id)sender
{
    NSString *filename = @"";
    //AudioServicesPlaySystemSound(1104);
    UIButton *btn = (UIButton*)sender;
    int tag = btn.tag - 200;
    if((tag >= 0 && tag <= 9) || (tag >= 11 && tag <= 19) || (tag >= 23 && tag <= 28)){
        filename = numbersounds[tag];
        [self savePreviousStatus];
        if(tag == 23 || tag == 25){
            filename = @"";
            [self ToCapitalize];
            if(tag == 23)
                [self SpeakSentence:0];
            else
                [self SpeakSentence:1];
        }
        if(tag == 26){
            filename = @"";
            [self SpeakSentence:2];
        }
        [self.textDocumentProxy insertText:numberkeys[tag]];
        [self invalidatePredictive];
        bUndoclicked = NO;
    }else if(tag == 10){//backspace
        filename = @"delete_sound";
        [self savePreviousStatus];
        [self.textDocumentProxy deleteBackward];
        [self invalidatePredictive];
        bUndoclicked = NO;
    }else if(tag == 20){
        filename = @"return_sound";
        [self.textDocumentProxy insertText:@"\n"];
        [self clearPredictive];
        bUndoclicked = NO;
    }else if(tag == 21 || tag == 29){//symbol
        filename = @"more_symbols_sound";
        [numberkeyboard setHidden:YES];
        [symbolkeyboard setHidden:NO];
    }else if(tag == 22){//undo
        filename = @"undo";
        if(undoTexts.count > 0){
            redoText = [self.textDocumentProxy documentContextBeforeInput];
            for(int i = 0 ; i < redoText.length ; i++)
                [self.textDocumentProxy deleteBackward];
            if(curundo > 0){
                NSString *tempprev = [undoTexts objectAtIndex:curundo-1];
                curundo--;
                [self.textDocumentProxy insertText:tempprev];
            }
            //[self.textDocumentProxy insertText:undoText];
            bUndoclicked = YES;
        }
    }else if(tag == 30 || tag == 34){//alpha_keyboard
        filename = @"letters_sound";
        [numberkeyboard setHidden:YES];
        [alphakeyboard setHidden:NO];
    }else if(tag == 31){//next keyboard
        filename = @"change_keyboard_sound";
        [self advanceToNextInputMode];
    }else if(tag == 32){//speak
        if(bSpeak){
            filename = @"speak_off_sound";
            [imgbtnSpeak_alpha setImage:[UIImage imageNamed:@"KEY_SPEAK_OFF.png"]];
            [imgbtnSpeak_symbol setImage:[UIImage imageNamed:@"KEY_SPEAK_OFF.png"]];
            [imgbtnSpeak_number setImage:[UIImage imageNamed:@"KEY_SPEAK_OFF.png"]];
        }else{
            filename = @"speak_on_sound";
            [imgbtnSpeak_alpha setImage:[UIImage imageNamed:@"KEY_SPEAK.png"]];
            [imgbtnSpeak_symbol setImage:[UIImage imageNamed:@"KEY_SPEAK.png"]];
            [imgbtnSpeak_number setImage:[UIImage imageNamed:@"KEY_SPEAK.png"]];
        }
        dispatch_async(kBgQueue, ^{
            NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"mp3"];
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
            [self.audioPlayer setVolume:1.0];
            [self.audioPlayer setNumberOfLoops:0];
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
        });
        bSpeak = !bSpeak;
        return;
    }else if(tag == 33){//space
        filename = @"space_sound";
        [self savePreviousStatus];
        NSString *retword = [self DoAutocorrection];
        [self.textDocumentProxy insertText:@" "];
        [self clearPredictive];
        bUndoclicked = NO;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"space_sound" ofType:@"mp3"];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
        [self.audioPlayer setVolume:1.0];
        [self.audioPlayer setNumberOfLoops:0];
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        if(bSpeak){
            [NSThread sleepForTimeInterval:0.5];
            [self SpeakWord:retword];
            return;
        }
    }else if(tag == 35){//hide keyboard
        filename = @"drop_keyboard_sound";
        [self dismissKeyboard];
    }
    if(filename && filename.length > 0){
        dispatch_async(kBgQueue, ^{
            NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"mp3"];
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
            [self.audioPlayer setVolume:1.0];
            [self.audioPlayer setNumberOfLoops:0];
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
        });
    }
}

- (void)initPredictiveKeyboard
{
    CGSize frame = [[UIScreen mainScreen] bounds].size;
    
    float gapx = 2;
    CGRect rt = CGRectMake(0, 0, keyboardwidth, keyboardheight);
    float height = rt.size.height/8;
    predictkeyboard.frame = CGRectMake(0,0,rt.size.width,height);
    
    if(frame.width > frame.height){
        float btnwidth = (rt.size.width - gapx*2) / 4;
        float startx = (rt.size.width - btnwidth*3 - gapx*2)/2;
        for(int i = 0 ; i < 3 ; i++)
            predictbtns[i] = [[UIButton alloc] initWithFrame:CGRectMake(startx+i*btnwidth+gapx*i, 0, btnwidth, height)];
    }else{
        float btnwidth = (rt.size.width - gapx*3) / 3;
        for(int i = 0 ; i < 3 ; i++)
            predictbtns[i] = [[UIButton alloc] initWithFrame:CGRectMake(gapx/2+i*btnwidth+gapx*i, 0, btnwidth, height)];
    }
    for(int i = 0 ; i < 3 ; i++){
        predictbtns[i].backgroundColor = [UIColor colorWithRed:116.0f/256.0f green:94.0f/256.0f blue:141.0f/256.0f alpha:1.0f];
        predictbtns[i].font = FONT_SFCartoonistHand(fontsize-15);
        [predictbtns[i] addTarget:self action:@selector(predictiveKeypressed:) forControlEvents:UIControlEventTouchUpInside];
        [predictkeyboard addSubview:predictbtns[i]];
    }
    predictbtns[1].backgroundColor = [UIColor colorWithRed:128.0f/255.0f green:0.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
}

- (IBAction)predictiveKeypressed:(id)sender
{
    UIButton *button = (UIButton*)sender;
    NSString *title = button.currentTitle;
    if([title isEqualToString:@""])
        return;
    
    /*NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *recents = [defaults objectForKey:@"recentwords"];
    NSMutableArray *temparr = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < recents.count ; i++){
        if(![[recents objectAtIndex:i] isEqualToString:title]){
            [temparr addObject:[recents objectAtIndex:i]];
        }
    }
    
    [temparr insertObject:title atIndex:0];
    
    while(temparr.count > 50){
        [temparr removeObjectAtIndex:50];
    }
    
    [defaults setObject:temparr forKey:@"recentwords"];
    [[NSUserDefaults standardUserDefaults] synchronize];*/
    
    NSString *totalstr = [self.textDocumentProxy documentContextBeforeInput];
    NSArray *arr = [totalstr componentsSeparatedByString:@" "];
    if(arr.count >= 1){
        totalstr = [arr objectAtIndex:arr.count-1];
        for(int i = 0 ; i < totalstr.length ; i++)
            [self.textDocumentProxy deleteBackward];
    }
    [self.textDocumentProxy insertText:title];
    [self.textDocumentProxy insertText:@" "];
    if(bSpeak){
        [self SpeakWord:title];
    }
    [predictbtns[0] setTitle:@"" forState:UIControlStateNormal];
    [predictbtns[1] setTitle:@"" forState:UIControlStateNormal];
    [predictbtns[2] setTitle:@"" forState:UIControlStateNormal];
}

-(NSMutableArray*)getPredictiveWord:(NSString*) word
{
    //word = [word lowercaseString];
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    int count = 0;
    /*NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *recents = [defaults objectForKey:@"recentwords"];
    if(recents != nil){
    for(int i = 0; i < recents.count ; i++){
        NSString *str = [recents objectAtIndex:i];
        if(str.length >= word.length){
            if([word isEqualToString:[str substringToIndex:word.length]]){
                [arr addObject:str];
                count++;
                if(count == 3)
                    break;
            }
        }
    }
    if(count == 3)
        return arr;
    }*/
    for(int i = 0 ; i < worddictionary.count ; i++){
        NSString *str = [worddictionary objectAtIndex:i];
        if(str.length >= word.length){
            if([word isEqualToString:[str substringToIndex:word.length]]){
                /*BOOL bExist = NO;
                for(int j = 0 ; j < count ; j++){
                    if([str isEqualToString:[arr objectAtIndex:j]]){
                        bExist = YES;
                        break;
                    }
                }
                if(!bExist){*/
                    if(arr.count < 3){
                        [arr addObject:str];
                    }else{
                        for(int j = 0 ; j < arr.count ; j++){
                            NSString *temp = [arr objectAtIndex:j];
                            if(temp.length > str.length){
                                [arr insertObject:str atIndex:j];
                                [arr removeObjectAtIndex:3];
                                break;
                            }
                        }
                    }
                //}
            }else if([[[str substringToIndex:1] lowercaseString] compare:[[word substringToIndex:1] lowercaseString]] == NSOrderedDescending){
                break;
            }
        }
    }
    if(arr.count == 0)
    {
        UITextChecker *checker = [[UITextChecker alloc] init];
        
        NSRange checkRange = NSMakeRange(0, word.length);
        
        NSRange misspelledRange = [checker rangeOfMisspelledWordInString:word
                                                                   range:checkRange
                                                              startingAt:checkRange.location
                                                                    wrap:NO
                                                                language:@"en_US"];
        
        NSArray *arrGuessed = [checker guessesForWordRange:misspelledRange inString:word language:@"en_US"];
        
        if(arrGuessed.count > 0){
            [arr addObject:[arrGuessed objectAtIndex:0]];
        }
        [arr addObject:word];
    }else{
        BOOL bExistOriginal = NO;
        for(int i = 0 ; i < arr.count ; i++){
            if([word isEqualToString:[arr objectAtIndex:i]]){
                bExistOriginal = YES;
                break;
            }
        }
        if(bExistOriginal == NO){
            [arr insertObject:word atIndex:1];
        }
        if(arr.count > 3)
            [arr removeObjectAtIndex:3];
    }
    return arr;
}

-(void)viewDidAppear:(BOOL)animated
{
    CGSize realframe = self.view.bounds.size;
    CGSize frame = [[UIScreen mainScreen] bounds].size;
    keyboardwidth = realframe.width;
    undoText = [self.textDocumentProxy documentContextBeforeInput];
    NSString* temp = [self.textDocumentProxy documentContextAfterInput];
    if(undoText == nil)
        undoText = @"";
    bUndoclicked = NO;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        fontsize = 50;
        if(frame.width > frame.height)
            keyboardheight = landscapeHeight_pad;
        else
            keyboardheight = portraitHeight_pad;
    }else{
        fontsize = 35;
        if(frame.width > frame.height)
            keyboardheight = landscapeHeight_phone;
        else
            keyboardheight = portraitHeight_phone;
    }
     
    //Change Keyboard Button
    imgbtnChangeKeyboard_alpha = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_CHANGE_KEYBOARD.png"]];
    imgbtnChangeKeyboard_symbol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_CHANGE_KEYBOARD.png"]];
    imgbtnChangeKeyboard_number = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_CHANGE_KEYBOARD.png"]];
    
    //Speak Button
    imgbtnSpeak_alpha = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_SPEAK.png"]];
    imgbtnSpeakSentence_alpha = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_SENTENCE.png"]];
    imgbtnSpeak_symbol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_SPEAK.png"]];
    imgbtnSpeak_number = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_SPEAK.png"]];
    
    //Delete Button
    imgbtnDelete_alpha = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_DELETE.png"]];
    imgbtnDelete_symbol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_DELETE.png"]];
    imgbtnDelete_number = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_DELETE.png"]];
    
    //Drop Keyboard Button
    imgbtnDrop_alpha = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_DROP_KEYBOARD.png"]];
    imgbtnDrop_symbol = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_DROP_KEYBOARD.png"]];
    imgbtnDrop_number = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_DROP_KEYBOARD.png"]];
    
    //Double Caps Button
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        imgbtnDobuleCaps1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_DOUBLE_CAPS_IPAD.png"]];
        imgbtnDobuleCaps2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_DOUBLE_CAPS_IPAD.png"]];
    }else{
        imgbtnDobuleCaps1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_DOUBLE_CAPS_IPHONE.png"]];
        imgbtnDobuleCaps2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"KEY_DOUBLE_CAPS_IPHONE.png"]];
    }
    [imgbtnDobuleCaps1 setHidden:YES];
    [imgbtnDobuleCaps2 setHidden:YES];
    
    self.view.backgroundColor = [UIColor colorWithRed:214.0f/256.0f green:205.0f/256.0f blue:225.0f/256.0f alpha:1.0f];
    alphakeyboard = [[UIView alloc] init];
    symbolkeyboard = [[UIView alloc] init];
    numberkeyboard = [[UIView alloc] init];
    predictkeyboard = [[UIView alloc] init];
    
    alphakeyboard.backgroundColor = [UIColor colorWithRed:192.0f/256.0f green:178.0f/256.0f blue:209.0f/256.0f alpha:1.0f];
    symbolkeyboard.backgroundColor = [UIColor colorWithRed:192.0f/256.0f green:178.0f/256.0f blue:209.0f/256.0f alpha:1.0f];
    numberkeyboard.backgroundColor = [UIColor colorWithRed:192.0f/256.0f green:178.0f/256.0f blue:209.0f/256.0f alpha:1.0f];
    [alphakeyboard setHidden:NO];
    [symbolkeyboard setHidden:YES];
    [numberkeyboard setHidden:YES];
    bCapsLock = NO;
    bDoubleCapsClick = NO;
    bSpeak = YES;
    bSpeakSentence = YES;
    
    [self initPredictiveKeyboard];
    [self initAlphaKeyboard];
    [self initSymbolKeyboard];
    [self initNumberKeyboard];
    
    //[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
    //[[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    [self.view addSubview:alphakeyboard];
    [self.view addSubview:numberkeyboard];
    [self.view addSubview:symbolkeyboard];
    [self.view addSubview:predictkeyboard];
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"wordlist" ofType:@"plist"];
    NSDictionary *Array = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    worddictionary = [Array objectForKey:@"allwords"];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[AVAudioSession sharedInstance] setActive:false error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
}

- (BOOL) ToCapitalize
{
    NSString *totalstr = [self.textDocumentProxy documentContextBeforeInput];
    NSArray *arr = [totalstr componentsSeparatedByString:@"."];
    totalstr = [arr objectAtIndex:arr.count-1];
    for(int i = 0 ; i < totalstr.length ; i++){
        NSRange range;
        range.location = i;
        range.length = 1;
        NSString *temp = [totalstr substringWithRange:range];
        if(![temp isEqualToString:@" "]){
            totalstr = [totalstr substringFromIndex:i];
            unichar x = [totalstr characterAtIndex:0];
            if(x >= 'a' && x <= 'z'){
                x = x + 'A' - 'a';
                for(int j = 0 ; j < totalstr.length ; j++)
                    [self.textDocumentProxy deleteBackward];
                [self.textDocumentProxy insertText:[NSString stringWithFormat:@"%c",x]];
                totalstr = [totalstr substringFromIndex:1];
                [self.textDocumentProxy insertText:totalstr];
            }
            return YES;
        }
    }
    return NO;
}

- (NSString*) DoAutocorrection
{
    NSString *totalstr = [self.textDocumentProxy documentContextBeforeInput];
    NSArray *arr = [totalstr componentsSeparatedByString:@" "];
    totalstr = [arr objectAtIndex:arr.count-1];
    
    NSCharacterSet *alphaSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    BOOL valid = [[totalstr stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
    
    if(!valid)
        return @"";
    
    if(![predictbtns[1].currentTitle isEqualToString:@""]){
        for(int i = 0 ; i < totalstr.length ; i++)
            [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy insertText:predictbtns[1].currentTitle];
        return predictbtns[1].currentTitle;
    }
    
    /*UITextChecker *checker = [[UITextChecker alloc] init];
    
    NSRange checkRange = NSMakeRange(0, totalstr.length);
    
    NSRange misspelledRange = [checker rangeOfMisspelledWordInString:totalstr
                                                               range:checkRange
                                                          startingAt:checkRange.location
                                                                wrap:NO
                                                            language:@"en_US"];
    
    NSArray *arrGuessed = [checker guessesForWordRange:misspelledRange inString:totalstr language:@"en_US"];
    
    if(arrGuessed.count > 0){
        for(int i = 0 ; i < totalstr.length ; i++)
            [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy insertText:[arrGuessed objectAtIndex:0]];
        return [arrGuessed objectAtIndex:0];
    }*/
    return totalstr;
}
@end
