# GCSpriteAlert

Easy to way to make Message or Alert boxes in Spritekit.

<img src="sample.gif" height=400>

# Introduction
This class is just an SKNode. You add it as you would any other SKNode. There are predefined constants so you can detect which button has been pressed. I made the buttons aligned vertically so that you can put longer button titles if necessary.

# How to Use
Copy GCSpriteAlert.h and GCSpriteAlert.m to your project. Then in your header:

```obj-c
#import "GCSpriteAlert.h";

```

Then in your m file, to call the SpriteAlert, define an ARRAY with NSStrings of the button titles. Buttons will be created from the strings. Currently there is no limit to how many
buttons you can put it, except by the screen size.

Then define an DICTIONARY with 3 OBJECTS/KEYS pair: MessageBox Title, MessageBox Message, and MessageBox ButtonTitles. MessageBox ButtonTitles object is the ARRAY that we defined earlier.
Then initialize it with initWithSize:andParams: as code sample below:

```obj-c
NSArray *btnArrayTitles = @[@"Cancel",@"Unlock"];
NSDictionary *dict= [NSDictionary dictionaryWithObjectsAndKeys:
                    @"Locked!",GCSA_KEY_TITLE,
                    @"Unlock all characters by tapping Unlock button below. Your account will be deducted by $10 once. ",GCSA_KEY_MESSAGE,
                    btnArrayTitles, GCSA_KEY_BUTTONTITLES,
                    nil];

GCSpriteAlert *alert = [[GCSpriteAlert alloc] initWithSize:self.size andParams:dict];
alert.name = @"Alert1";
[self addChild:alert];
```

You can name the alert anything you like, then you can detect the button by touchedBegan:

```obj-c

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInNode:self];
    SKNode *touchedNode = (SKNode *)[self nodeAtPoint:location];

    if ([touchedNode.name isEqualToString:GCSA_BUTTON_INDEX]) {
        NSNumber *btnIndex = [touchedNode.userData objectForKey:GCSA_BUTTON_INDEX];
        NSLog(@"BTN: %ld",[btnIndex integerValue]);
        GCSpriteAlert *alert = (GCSpriteAlert*)[self childNodeWithName:@"Alert1"];
        [alert dismissAlert];
    }
}

```
If you have multiple alerts, you can handle them this way:

```obj-c
...
GCSpriteAlert *alert = [[GCSpriteAlert alloc] initWithSize:self.size andParams:dict];
alert.name = @"Alert1";
[self addChild:alert];

...
GCSpriteAlert *alert = [[GCSpriteAlert alloc] initWithSize:self.size andParams:dict];
alert.name = @"Alert2";
[self addChild:alert];

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInNode:self];
    SKNode *touchedNode = (SKNode *)[self nodeAtPoint:location];

    // handling all alerts here:
    if ([touchedNode.name isEqualToString:GCSA_BUTTON_INDEX]) {

                SKNode *alertNode = [touchedNode parent];
                if ([alertNode.name isEqualToString:@"Alert1"]) {
                    NSNumber *btnIndex = [touchedNode.userData objectForKey:GCSA_BUTTON_INDEX];
                    if ([btnIndex integerValue]==1) {
                        // code when button1 is clicked
                    }
                    if ([btnIndex integerValue]==0) {
                      // code when button1 is clicked
                    }
                    GCSpriteAlert *alert = (GCSpriteAlert*)[self childNodeWithName:@"Alert1"];
                    [alert dismissAlert];
                }


                if ([alertNode.name isEqualToString:@"Alert2"]) {
                    NSNumber *btnIndex = [touchedNode.userData objectForKey:GCSA_BUTTON_INDEX];
                    if ([btnIndex integerValue]==1) {
                        // code when button1 is clicked
                    }
                    if ([btnIndex integerValue]==0) {
                      // code when button1 is clicked
                    }
                    GCSpriteAlert *alert = (GCSpriteAlert*)[self childNodeWithName:@"Alert2"];
                    [alert dismissAlert];

                }

            }
}

```

That's all there is to it. I would like to improve it more in future in terms of dismiss animation etc.

# Feedback

If you have questions, give a shout in the Discussion section. If you use this class,
do send me a link to your app I'd love to see what you created with it.

-GeneCode-

Check out my [XCode Tutorial Blog!](https://xcodenoobies.blogspot.com "XCode Tutorial Blog")
