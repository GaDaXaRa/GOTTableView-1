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

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    [self.tableView beginUpdates];

    if(editing) {
        
        for (int c = 0; c<self.modelo.casas.count; c++) {
            Casa* casa = [self.modelo.casas objectAtIndex:c];
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:casa.personajes.count inSection:c];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    } else {
        
        for (int c = 0; c<self.modelo.casas.count; c++) {
            Casa* casa = [self.modelo.casas objectAtIndex:c];
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:casa.personajes.count inSection:c];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
    
    [self.tableView endUpdates];

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
    
    if(self.editing)
        return casa.personajes.count + 1;
    
    return casa.personajes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
    if(indexPath.row>=casa.personajes.count && self.isEditing) {
        UITableViewCell* celda = [tableView dequeueReusableCellWithIdentifier:@"celdaAdd" forIndexPath:indexPath];
        celda.textLabel.text = @"Añadir Personaje";
        return celda;
    }

    PersonajeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaPersonaje" forIndexPath:indexPath];

    Personaje* personaje = [casa.personajes objectAtIndex:indexPath.row];
    
    cell.nombre.text = personaje.nombre;
    cell.descripcion.text = personaje.descripcion;
    cell.retrato.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", personaje.imagen]];
    return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    Casa* casaOrigen = [self.modelo.casas objectAtIndex:sourceIndexPath.section];
    Casa* casaDestino = [self.modelo.casas objectAtIndex:destinationIndexPath.section];

    NSMutableArray* pOrigen = casaOrigen.personajes.mutableCopy;
    NSMutableArray* pDestino = casaDestino.personajes.mutableCopy;
    
    if(casaDestino == casaOrigen) {
        Personaje* personaje = [casaOrigen.personajes objectAtIndex:sourceIndexPath.row];
        [pOrigen insertObject:personaje atIndex:destinationIndexPath.row];
        [pOrigen removeObjectAtIndex:sourceIndexPath.row];
        casaOrigen.personajes = pOrigen.copy;
    } else {
        Personaje* personaje = [casaOrigen.personajes objectAtIndex:sourceIndexPath.row];
        [pDestino insertObject:personaje atIndex:destinationIndexPath.row];
        [pOrigen removeObjectAtIndex:sourceIndexPath.row];
        casaOrigen.personajes = pOrigen.copy;
        casaDestino.personajes = pDestino.copy;
    }
}

#pragma mark UITableView Delegate
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
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete: {
            Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
            NSMutableArray* auxPersonajes = casa.personajes.mutableCopy;
            [auxPersonajes removeObjectAtIndex:indexPath.row];
            casa.personajes = auxPersonajes.copy;
            
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
            
        case UITableViewCellEditingStyleInsert: {
            Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
            Personaje* personaje = [[Personaje alloc] init];
            personaje.nombre = @"Nuevo personaje";
            [casa addPersonaje:personaje];
            
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
        default:
            break;
    }
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
    if(indexPath.row >= casa.personajes.count)
        return UITableViewCellEditingStyleInsert;
    else
        return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
    if(indexPath.row >= casa.personajes.count)
        return NO;
    else
        return YES;
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Casa* casa = [self.modelo.casas objectAtIndex:indexPath.section];
    if(self.isEditing && indexPath.row<casa.personajes.count)
        return nil;
    
    return indexPath;
}

@end
