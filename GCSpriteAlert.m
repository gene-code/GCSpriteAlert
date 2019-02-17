//
//  GCSpriteAlert.m
//  Just a simple Node that emulates UIAlertController appearance
//
//  Created by Emir on 16/02/2019.
//  Copyright © 2019 emirBytes. All rights reserved.
//

#import "GCSpriteAlert.h"

@implementation GCSpriteAlert

// helper SKLabelNode maker that autowraps

-(NSArray*)createMultiLineLabelWithText:(NSString*)tmp withWidth:(int)width {
    // parse through the string and put each words into an array.
    NSCharacterSet *separators = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *words = [tmp componentsSeparatedByCharactersInSet:separators];
    
    long len = [tmp length];
    
    // get the number of labelnode we need.
    long totLines = len/width + 1;
    int cnt = 0; // used to parse through the words array
    
    // here is the for loop that create all the SKLabelNode that we need to
    // display the string.
    NSMutableArray *labelArray = [NSMutableArray new];
    
    for (int i=0; i<totLines; i++) {
        long lenPerLine = 0;
        NSString *lineStr = @"";
        
        while (lenPerLine<width) {
            if (cnt>[words count]-1) break; // failsafe - avoid overflow error
            lineStr = [NSString stringWithFormat:@"%@ %@", lineStr, words[cnt]];
            lenPerLine = [lineStr length];
            cnt ++;
            // NSLog(@"%@", lineStr);
        }
        // creation of the SKLabelNode itself
        SKLabelNode *_multiLineLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue"];
        _multiLineLabel.text = lineStr;
        // name each label node so you can animate it if u wish
        // the rest of the code should be self-explanatory
        _multiLineLabel.name = [NSString stringWithFormat:@"line%d",i];
        _multiLineLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        _multiLineLabel.fontSize = 12;
        _multiLineLabel.zPosition = PARENT_ZPOS+2;
        _multiLineLabel.fontColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        [labelArray addObject:_multiLineLabel];
    }
    return [NSArray arrayWithArray:labelArray];
}


-(id)initWithSize:(CGSize)size andParams:(NSDictionary*)params {
    
    if (self = [super init]) {
        
        // read params
        NSString *alertTitle = [params objectForKey:GCSA_KEY_TITLE];
        NSString *alertMsg = [params objectForKey:GCSA_KEY_MESSAGE];
        NSArray *btnTitles = [params objectForKey:GCSA_KEY_BUTTONTITLES];
        
        // ADD SEMI TRANSPARENT BLACK BG
        SKShapeNode *rectBg = [SKShapeNode shapeNodeWithRectOfSize:size];
        rectBg.zPosition = PARENT_ZPOS;
        rectBg.alpha = 0.0;
        rectBg.position = CGPointMake(size.width/2.0, size.height/2.0);
        rectBg.fillColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        

        
        [self addChild:rectBg];
        SKAction *fadeIn = [SKAction fadeAlphaTo:0.5 duration:0.35];
        [rectBg runAction:fadeIn completion:^(void) {
            
            SKAction* bounce = [SKAction sequence:@[[SKAction scaleTo:1.1 duration:0.1f],
                                                    [SKAction scaleTo:1.0 duration:0.12f],
                                                    [SKAction scaleTo:1.05 duration:0.14f],
                                                    [SKAction scaleTo:1 duration:0.16f],
                                                    ]];
            
            NSArray *msgLabelArr = [self createMultiLineLabelWithText:alertMsg withWidth:35];
            CGSize boxSize = CGSizeMake(GCSA_FIXED_WIDTH, 20*msgLabelArr.count+GCSA_TITLE_HEIGHT+GCSA_BUTTON_HEIGHT);
            SKShapeNode *rectBox = [SKShapeNode shapeNodeWithRectOfSize:boxSize];
            rectBox.zPosition = PARENT_ZPOS+1;
            rectBox.position = CGPointMake(size.width/2.0, size.height/2.0);
            rectBox.fillColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            //rectBox.strokeColor = [SKColor grayColor];
            [self addChild:rectBox];
            [rectBox runAction:bounce];
            
            // ADD TITLE
            SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-Bold"];
            titleLabel.text = alertTitle;
            titleLabel.name = @"titleLabel";
            titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
            titleLabel.fontSize = 16;
            titleLabel.zPosition = PARENT_ZPOS+2;
            titleLabel.fontColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
            titleLabel.position = CGPointMake(size.width/2.0, rectBox.position.y+rectBox.frame.size.height/2.0-2*titleLabel.frame.size.height);
            [self addChild:titleLabel];
            [titleLabel runAction:bounce];
            
            // ADD MESG
            float lastLabelY = 0;
            float yy = rectBox.position.y+(10*msgLabelArr.count/2.0);
            for (int i=0; i<msgLabelArr.count; i++) {
                SKLabelNode *lblNode = [msgLabelArr objectAtIndex:i];
                lblNode.position = CGPointMake(size.width/2.0, yy-20*i);
                [self addChild:lblNode];
                [lblNode runAction:bounce];
                if (i==msgLabelArr.count-1) lastLabelY = lblNode.position.y;
            }
            
            // ADD BUTTONS
            float btnWidth = rectBox.frame.size.width-2.0;
            for (int i=0; i<btnTitles.count; i++) {
                SKLabelNode *btnTitleNode = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-Bold"];
                btnTitleNode.text = [btnTitles objectAtIndex:i];
                btnTitleNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
                btnTitleNode.fontSize = 14;
                btnTitleNode.fontColor = [SKColor colorWithRed:0 green:0.8 blue:1.0 alpha:1.0];
                btnTitleNode.zPosition = PARENT_ZPOS+2;
                SKShapeNode *buttonNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(btnWidth, GCSA_BUTTON_HEIGHT)];
                buttonNode.fillColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
                buttonNode.position = CGPointMake(rectBox.position.x, lastLabelY-i*GCSA_BUTTON_HEIGHT-GCSA_BUTTON_HEIGHT);
                buttonNode.strokeColor = [SKColor grayColor];
                btnTitleNode.position = CGPointMake(0,-5);
                buttonNode.zPosition = PARENT_ZPOS+2;
                buttonNode.name = GCSA_BUTTON_INDEX;
                btnTitleNode.name = GCSA_BUTTON_INDEX;
                buttonNode.userData = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:i] forKey:GCSA_BUTTON_INDEX];
                btnTitleNode.userData = buttonNode.userData;
                [buttonNode addChild:btnTitleNode];
                [self addChild:buttonNode];
                [buttonNode runAction:bounce];
            }
            
        }];
        

        
    }
    return self;
}

-(void)dismissAlert {
    SKAction *delayBeforeRemove = [SKAction sequence:@[
                                                       [SKAction waitForDuration:0.35],
                                                       [SKAction removeFromParent]
                                                       ]];
    [self runAction:delayBeforeRemove];
    
}




@end
