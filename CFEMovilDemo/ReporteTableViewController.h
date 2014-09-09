//
//  ReporteTableViewController.h
//  CFEMovilDemo
//
//  Created by Jesús Ruiz on 08/09/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReporteTableViewController : UITableViewController<UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *failure;

@property (weak, nonatomic) IBOutlet UILabel *lblFailure;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceholder;
@property (weak, nonatomic) IBOutlet UITextView *txtObservations;
@property (weak, nonatomic) IBOutlet UITextField *txtServiceNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtTwitter;

@end
