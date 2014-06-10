//
//  TablaViewController.m
//  GOTTableView
//
//  Created by Ricardo Sánchez Sotres on 10/06/14.
//  Copyright (c) 2014 Ricardo Sanchez. All rights reserved.
//

#import "TablaViewController.h"
#import "GotModel.h"
#import "Casa.h"
#import "Personaje.h"
#import "PersonajeCell.h"
#import "DetailViewController.h"

@interface TablaViewController () <DetailViewControllerDelegate>
@property (nonatomic, strong) GotModel* modelo;
@end

@implementation TablaViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Game of Thrones";
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.modelo = [[GotModel alloc] init];
    [self.modelo cargaModelo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"pushSegue"]) {
        DetailViewController* vc = segue.destinationViewController;
        vc.delegate = self;
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
        Personaje* personaje = [casa.personajes objectAtIndex:indexPath.row];
        vc.personaje = personaje;        
    }
}

#pragma mark - DetailViewController Delegate
- (void)mataPersonaje:(Personaje *)personaje
{
    NSIndexPath* indexPath;
    int seccion = 0;
    for (Casa* casa in self.modelo.casas) {
        int fila = 0;
        for (Personaje* pers in casa.personajes) {
            if([pers.imagen isEqual:personaje.imagen]) {
                indexPath = [NSIndexPath indexPathForRow:fila inSection:seccion];
                break;
            }
            fila+=1;
        }
        seccion+=1;
    }
    
    Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
    NSMutableArray* auxPersonajes = casa.personajes.mutableCopy;
    [auxPersonajes removeObjectAtIndex:indexPath.row];
    casa.personajes = auxPersonajes.copy;
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelo.casas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Casa* casa = [self.modelo.casas objectAtIndex:section];
    return casa.personajes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PersonajeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaPersonaje" forIndexPath:indexPath];
    
    Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
    Personaje* personaje = [casa.personajes objectAtIndex:indexPath.row];
    
    cell.nombre.text = personaje.nombre;
    cell.descripcion.text = personaje.descripcion;
    cell.retrato.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", personaje.imagen]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    Casa* casa = [self.modelo.casas objectAtIndex:section];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:casa.imagen]];
    return imageView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"pushSegue" sender:self];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Matar";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete) {
        Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
        NSMutableArray* auxPersonajes = casa.personajes.mutableCopy;
        [auxPersonajes removeObjectAtIndex:indexPath.row];
        casa.personajes = auxPersonajes.copy;
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
@end
