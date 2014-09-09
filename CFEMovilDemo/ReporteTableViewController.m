//
//  ReporteTableViewController.m
//  CFEMovilDemo
//
//  Created by Jesús Ruiz on 08/09/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "ReporteTableViewController.h"
#import "RequestsCenter.h"

@interface ReporteTableViewController ()

@end

@implementation ReporteTableViewController {
    UITapGestureRecognizer *tap;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.txtObservations.delegate = self;
    self.txtServiceNumber.delegate = self;
    self.txtEmail.delegate = self;
    self.txtTwitter.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.lblFailure.text = [self.failure objectForKey:@"description"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0 || section == 1)
        return 1;
    return 3;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cerrarTeclado)];
    [self.view addGestureRecognizer:tap];
    self.lblPlaceholder.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self.view removeGestureRecognizer:tap];
    tap = nil;
    
    if ([self.txtObservations.text length] > 0)
        self.lblPlaceholder.hidden = YES;
    else
        self.lblPlaceholder.hidden = NO;

}

#pragma mark - UITextFieldDelegate

// Optimización gesture, se crea cuando empieza la edición del textfield, se destruye cuando se acaba la edición, para evitar conflictos con otros comportamientos (click a una celda, etc.)

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cerrarTeclado)];
    [self.view addGestureRecognizer:tap];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.view removeGestureRecognizer:tap];
    tap = nil;
}

- (void)cerrarTeclado {
    [self.view endEditing:YES];
}

#pragma mark - IBAction's

- (IBAction)sendReport:(id)sender {
    
    NSDictionary *report = @{
                             @"type": [self.failure objectForKey:@"_id"],
                             @"observations": self.txtObservations.text,
                             @"serviceNumber": self.txtServiceNumber.text,
                             @"email": self.txtEmail.text,
                             @"twitter": self.txtTwitter.text
                            };
    
    dispatch_queue_t queue = dispatch_queue_create("reportQueue", nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enviando Reporte..." message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alert show];
    
    dispatch_async(queue, ^{

        NSDictionary *response = [RequestsCenter sendReport:report];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [alert dismissWithClickedButtonIndex:0 animated:YES];
            
            if ([[response objectForKey:@"success"] boolValue]) {
                self.txtObservations.text = @"";
                self.lblPlaceholder.hidden = NO;
                self.txtServiceNumber.text = @"";
                self.txtEmail.text = @"";
                self.txtTwitter.text = @"";
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reporte Enviado" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        });
    });
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
