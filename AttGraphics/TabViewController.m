//
//  TabViewController.m
//  AttGraphics
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 04/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()

@end

@implementation TabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
//        UITabBarItem *item = [self tabBarItem];
//        [item setTitle:@"Lista"];
//        [item setImage:[UIImage imageNamed:@"iconLista.png"]];
        
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *btnCriar = [[UIBarButtonItem alloc] initWithTitle:@"Criar" style:UIBarButtonItemStyleDone target:self action:@selector(gotoCriar)];
        [btnCriar setTintColor:[UIColor redColor]];
        UIBarButtonItem *btnLista = [[UIBarButtonItem alloc] initWithTitle:@"Lista" style:UIBarButtonItemStyleDone target:self action:nil];
        [btnLista setTintColor:[UIColor redColor]];
        [btnLista setEnabled:NO];
        
        [self setToolbarItems:@[flexibleSpace, btnCriar, flexibleSpace,btnLista, flexibleSpace]];
        
        [self setLinhaSelecionada:-1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    SEL editar = @selector(editarTableView);
    
    [[self btnEditar] addTarget:self action:editar forControlEvents:UIControlEventTouchDown];
    
    [[self tableView] setDataSource:self];
    [[self tableView] setDelegate:self];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gotoCriar)];
    [[self view] addGestureRecognizer:swipeDown];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gotoCriar)];
    [[self view] addGestureRecognizer:swipeRight];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self atualizarTableView];
}

//Metodos Proprios
-(void) atualizarTableView
{
    [[self tableView] reloadData];
}

-(void)editarTableView
{
    if ([[self tableView] isEditing]) {
        [[self btnEditar] setTitle:@"Editar" forState:UIControlStateNormal];
        [[self tableView] setEditing:NO animated:YES];
    }
    else
    {
        [[self btnEditar] setTitle:@"Pronto" forState:UIControlStateNormal];
        [[self tableView] setEditing:YES animated:YES];
    }
}

-(void) selecionarPersonagem
{
    if ([self linhaSelecionada] < 0) {
        return;
    }
    
    PersonagensDataSource *dtSource = [PersonagensDataSource sharedSource];
    
    [dtSource setPersonagemAtual:[[dtSource todosPersonagens] objectAtIndex:[self linhaSelecionada]]];
}

-(void)gotoCriar
{
    UIViewController *mainVC = [[[ViewControllerSingleton sharedSource] viewControllers]objectAtIndex:0];
    [UIView animateWithDuration:0.75
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                         [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.navigationController.view cache:NO];
                     }];
    [[self navigationController] popToViewController:mainVC animated:NO];
}

//UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[PersonagensDataSource sharedSource] todosPersonagens] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    Personagem *p = [[[PersonagensDataSource sharedSource] todosPersonagens] objectAtIndex:[indexPath row]];
    NSString *text = [NSString stringWithFormat:@"%@ Nível: %d Raça: %@", [p nome], [p nivel], [p raca]];
    [[cell textLabel] setText:text];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

//UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setLinhaSelecionada:indexPath.row];
    [self selecionarPersonagem];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)
editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PersonagensDataSource *dtSource = [PersonagensDataSource sharedSource];
        NSArray *personagens = [dtSource todosPersonagens];
        Personagem *p = [personagens objectAtIndex:[indexPath row]];
        [dtSource delPersonagem:p];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[PersonagensDataSource sharedSource] movePersonagemNoIndice:[sourceIndexPath row] paraIndice:[destinationIndexPath row]];
}

@end
