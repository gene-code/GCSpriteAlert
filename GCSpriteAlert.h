//
//  GCSpriteAlert.h
//  Just a simple Node that emulates UIAlertController appearance
//
//  Created by Emir on 16/02/2019.
//  Copyright © 2019 emirBytes. All rights reserved.
//
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GCSpriteAlert;

#define GCSA_KEY_TITLE @"GCSA_KEY_TITLE"
#define GCSA_KEY_MESSAGE @"GCSA_KEY_MESSAGE"
#define GCSA_KEY_BUTTONTITLES @"GCSA_KEY_BUTTONTITLES"
#define GCSA_BUTTON_INDEX @"GCSA_BUTTON_INDEX"

#define PARENT_ZPOS  10000
#define GCSA_FIXED_WIDTH 250
#define GCSA_TITLE_HEIGHT 40
#define GCSA_BUTTON_HEIGHT 40


@interface GCSpriteAlert : SKNode



-(id)initWithSize:(CGSize)size andParams:(NSDictionary*)params;
-(void)dismissAlert;

@end

NS_ASSUME_NONNULL_END
