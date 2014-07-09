//
//  TCGettingStartedViewController.m
//  ThumbtackClone
//
//  Created by Vensi Developer on 7/9/14.
//  Copyright (c) 2014 EnterWithBoldness. All rights reserved.
//

#import "TCGettingStartedViewController.h"

@interface TCGettingStartedViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;

@property (nonatomic) NSArray *cards;
@end

@implementation TCGettingStartedViewController


static NSInteger currentSlide ;
- (IBAction)signIn:(id)sender {
    [self.email setEnabled:YES];
    self.email.alpha = 0.0f;
    self.email.hidden = NO;
    [UIView  animateWithDuration:.4
                      animations:^{
        self.email.alpha = 1.0f;

    }];
    
    [self.email becomeFirstResponder];
    self.goBack.customView.hidden = NO;
    
    
    
}



- (IBAction)previous:(id)sender {
    [self.email setEnabled:NO];
    
    self.email.alpha = 1.0f;

    [UIView animateWithDuration:.4
                     animations:^{
                         self.email.alpha = 0.0f;
                         
                     }
                     completion:^(BOOL done) {
                         self.email.hidden = YES;
                         [self.email resignFirstResponder];
                     }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Here");
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    //setup
    [self setUpEmail];
    //make sure it's not seen
    [self setupTopBottomViews];
    
    
    self.topView.alpha = 0;
    //hide the back button
    self.goBack.customView.hidden = YES;
    //
    NSTimeInterval timeInterval = 4.0f;

    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:self
                                    selector:@selector(moveOut)
                                   userInfo:nil
                                    repeats:YES];

    
    //move in the first slide "manually", aka without the use of the timer

    currentSlide = 1 ;
    
}





-(void)viewDidAppear:(BOOL)animated{
    [self animateTopViewIn];
    [self moveIn];
}


#pragma mark - getting the views into the screen
-(void)animateTopViewIn{


    CGRect newFrame = self.topView.frame;
    newFrame.origin.y -= 50;
    
    [UIView animateWithDuration:.6 animations:^{
        
        self.topView.frame = newFrame;
        self.topView.alpha = 1.0f;

    }];
    
}



-(void)animateBottomViewIn{
    
}

static BOOL clicked = NO;
- (IBAction)checker:(id)sender {
    if (!clicked){
        [self moveIn];
        clicked  = YES;
    }else{
        [self moveOut];
        clicked = NO;
    }
//    [self move];
    
}

#pragma mark - set the views up so they are off the screen 
-(void)setupTopBottomViews{
    
}

#pragma mark - setting up email textField
-(void)setUpEmail{
    self.email.textColor = [UIColor whiteColor];
    NSString *placeHolderText = @"Enter your e-mail address";
    UIColor *color = [UIColor colorWithRed:160.0f/255.0f green:158.0f/255.0f blue:158.0f/255.0f alpha:1.0];
    
    self.email.attributedPlaceholder =[[NSAttributedString alloc] initWithString:placeHolderText
                                                                      attributes:@{NSForegroundColorAttributeName: color}];
    
    //disable and hide it
    [self.email setEnabled:NO];
    self.email.hidden = YES;
    
}

#pragma mark - helper method for moving the buttomView "in and out"

-(void)moveOut{
    //first move it out with animation and then move it to the right side of the screen
    CGRect bottomFrame = self.bottomView.frame;
    bottomFrame.origin.x = -300;
    
    [UIView animateWithDuration:.6
                     animations:^{
                         self.bottomView.frame = bottomFrame;
                     }
                     completion:^(BOOL done){
                         //figure out the right card(slide) and set it to the appropriate labels
                         NSInteger currentSlideIndex = currentSlide % 3;
                         UILabel *label = (UILabel *) [self.bottomView viewWithTag:0];
                         UILabel *info = (UILabel *)[self.bottomView viewWithTag:1];
                         
                         NSDictionary *card = [self.cards objectAtIndex:currentSlideIndex];
                         
                         NSString *labelText = card[@"label"];
                         NSString *infoText = card[@"info"];
                         
                         label.text = labelText;
                         info.text = infoText;
                         
                         //    [self moveOut];
                         
                         currentSlide += 1;

                         CGRect resetFrame = self.bottomView.frame;
                         resetFrame.origin.x = 400;
                         self.bottomView.frame = resetFrame;
                         [self moveIn];
    }];
    
    
}

-(void)moveIn{
    CGRect bottomFrame = self.bottomView.frame;
    bottomFrame.origin.x = 47;
    
    [UIView animateWithDuration:.6
                     animations:^{
                         self.bottomView.frame = bottomFrame;
                         
                     }];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - intalize what we set the info in the cards to show
-(NSArray *) cards{
    
    if(!_cards){
        NSDictionary *card1 = @{@"label":@"   We introduce you to pros",
                                @"info":@"  Within hours, we'll introduce you to serveral professionals who can            complete your project"};
        NSDictionary *card2 = @{@"label":@"   Tell us what you need",
                                @"info":@"   Let us know how we can help by answering questions about the projects you want to accomplish"};
        NSDictionary *card3 = @{@"label":@" Hire the right Professional",
                                @"info":@"Compare and hire an exprienced professional at a price that's right for you"};
        
        _cards = @[card1,card2,card3];
        
    }
    return _cards;

}



@end
