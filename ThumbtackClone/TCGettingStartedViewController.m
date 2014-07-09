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

@end

@implementation TCGettingStartedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Here");
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    //setup
    [self setUpEmail];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - setting up textField
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
