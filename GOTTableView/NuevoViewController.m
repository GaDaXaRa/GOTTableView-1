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

@interface NuevoViewController () <CasasViewControllerDelegate>
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

#pragma mark CasasViewController Delegate
- (void) casaSeleccionada:(NSString *)nombreCasa
{
    self.celdaCasa.text = nombreCasa;
}


@end
