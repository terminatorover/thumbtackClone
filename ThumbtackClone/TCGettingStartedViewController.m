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

@property (weak, nonatomic) IBOutlet UIView *gettingStarted;
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
    

    //setup gettingStarted View
    [self setUpGettinStarted];
    
    currentSlide = 1 ;
    
}





-(void)viewDidAppear:(BOOL)animated{
    [self animateTopViewIn];
    
    //move in the first slide "manually", aka without the use of the timer
    [self moveIn];
}





#pragma mark - seting up getting Started View when the view Loads 
-(void)setUpGettinStarted{
    //make the gettingStarted view no existant as far as the user is concerned
    self.gettingStarted.alpha = 0.0f;
    self.gettingStarted.userInteractionEnabled = NO;
    //some setup for the textfields in getting started
    UITextField *serviceNeeded = (UITextField *)[self.gettingStarted viewWithTag:1];
    UITextField *zipCode = (UITextField *)[self.gettingStarted viewWithTag:11];
    
    
    
    NSString *placeHolderTextForServiceNeeded = @"What service do you need?";
    NSString *placeHolderTextZipCode = @"Near Which ZipCode";
    UIColor *color = [UIColor colorWithRed:216.0f/255.0f green:198.0f/255.0f blue:198.0f/255.0f alpha:1.0];
    
    serviceNeeded.attributedPlaceholder =[[NSAttributedString alloc] initWithString:placeHolderTextForServiceNeeded
                                                                         attributes:@{NSForegroundColorAttributeName: color}];
    
    
    zipCode.attributedPlaceholder =[[NSAttributedString alloc] initWithString:placeHolderTextZipCode
                                                                         attributes:@{NSForegroundColorAttributeName: color}];
    

}



#pragma mark - getting the views into the screen
-(void)animateTopViewIn{


    CGRect newFrame = self.topView.frame;
    newFrame.origin.y -= 50;
    
    [UIView animateWithDuration:.6
                     animations:^{
        
                        self.topView.frame = newFrame;
                        self.topView.alpha = 1.0f;

    }];
    
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

#pragma mark - handling what happens when the user wants to get started
- (IBAction)gettingStarted:(id)sender {
    //first fade out the top view Controller
    [UIView animateWithDuration:.5
                     animations:^{
                         self.topView.alpha = 0.0f;
                     }
                     completion:^(BOOL done){
                         self.topView.userInteractionEnabled = NO;
                         CGRect gettingStartedPostion = self.gettingStarted.frame;
                         gettingStartedPostion.origin.y -= 100;
                         //now animate in the gettingStartedView
                         [UIView animateWithDuration:.3
                                          animations:^{
                                              self.gettingStarted.alpha = 1.0;
                                              self.gettingStarted.frame = gettingStartedPostion;

                                          }
                                          completion:^(BOOL done){
                                              NSLog(@"ALL DONE");
                                          
                                          }];
                         
                         
                         
                         
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
        NSDictionary *card3 = @{@"label":@"  Hire the right Professional",
                                @"info":@"Compare and hire an exprienced professional at a price that's right for you"};
        
        _cards = @[card1,card2,card3];
        
    }
    return _cards;

}


#pragma  mark - TextView Delegate method 
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.email resignFirstResponder];
    return YES;
}






@end
