//
//  NuevoViewController.m
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "NuevoViewController.h"
#import "CasasViewController.h"
#import "Personaje.h"

@interface NuevoViewController () <CasasViewControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *celdaCasa;
@property (weak, nonatomic) IBOutlet UITextField *nombre;
@property (weak, nonatomic) IBOutlet UITextView *bio;
@end

@implementation NuevoViewController

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
    
    self.title = @"Nuevo Personaje";
    self.celdaCasa.text = @"Seleccionar";
    
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelar)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem* okButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hecho)];
    self.navigationItem.rightBarButtonItem = okButton;
}

- (void) cancelar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) hecho
{
    if([self.nombre.text isEqualToString:@""] || [self.bio.text isEqualToString:@""] || [self.celdaCasa.text isEqualToString:@""]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Hay que introducir todos los datos" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    Personaje* personaje = [[Personaje alloc] init];
    personaje.nombre = self.nombre.text;
    personaje.descripcion = self.bio.text;
    
    [self.delegate personaje:personaje creadoEnCasa:self.celdaCasa.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"muestraCasas"]) {
        CasasViewController* vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

#pragma mark UITableView Delegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1)
        return indexPath;
    
    return nil;
}
#pragma mark CasasViewController Delegate
- (void) casaSeleccionada:(NSString *)nombreCasa
{
    self.celdaCasa.text = nombreCasa;
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
