//
//  TCGettingStartedViewController.m
//  ThumbtackClone
//
//  Created by Vensi Developer on 7/9/14.
//  Copyright (c) 2014 EnterWithBoldness. All rights reserved.
//

#import "TCGettingStartedViewController.h"

@interface TCGettingStartedViewController ()
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *bottomView;

@end

@implementation TCGettingStartedViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Here");
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    //setup
    [self setUpEmail];
    //make sure it's not seen
    self.topView.alpha = 0;

    
}



-(void)viewDidAppear:(BOOL)animated{
    [self animateTopViewIn];
    [self animateBottomViewIn];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - setting up email textField
-(void)setUpEmail{
    self.email.textColor = [UIColor whiteColor];
    NSString *placeHolderText = @"Enter your e-mail address";
    UIColor *color = [UIColor colorWithRed:160.0f/255.0f green:158.0f/255.0f blue:158.0f/255.0f alpha:1.0];
    
    self.email.attributedPlaceholder =[[NSAttributedString alloc] initWithString:placeHolderText attributes:@{NSForegroundColorAttributeName: color}];
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

@end
