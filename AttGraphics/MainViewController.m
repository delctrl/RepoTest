//
//  MainViewController.m
//  AttGraphics
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 03/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
//        UITabBarItem *item = [self tabBarItem];
//        [item setTitle:@"Criar"];
//        [item setImage:[UIImage imageNamed:@"iconCriar.png"]];
        
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *btnCriar = [[UIBarButtonItem alloc] initWithTitle:@"Criar" style:UIBarButtonItemStyleDone target:self action:nil];
        [btnCriar setTintColor:[UIColor redColor]];
        [btnCriar setEnabled:NO];
        UIBarButtonItem *btnLista = [[UIBarButtonItem alloc] initWithTitle:@"Lista" style:UIBarButtonItemStyleDone target:self action:@selector(gotoLista)];
        [btnLista setTintColor:[UIColor redColor]];
        
        [self setToolbarItems:@[flexibleSpace, btnCriar, flexibleSpace, btnLista, flexibleSpace]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    SEL salvar = @selector(salvarPersonagem);
    SEL novo = @selector(limparDados);
    
    [[self btnSalvar] addTarget:self action:salvar forControlEvents:UIControlEventTouchDown];
    [[self btnNovo] addTarget:self action:novo forControlEvents:UIControlEventTouchDown];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gotoLista)];
    [[self view] addGestureRecognizer:swipeUp];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gotoLista)];
    [[self view] addGestureRecognizer:swipeLeft];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self carregarDados];
}

- (void) salvarPersonagem
{
    Personagem *perso = [[PersonagensDataSource sharedSource] PersonagemAtual];
    
    //Guardar identificadores do personagem
    [perso setNome:[self txtNome].text];
    [perso setRaca:[self txtRaca].text];
    [perso setNivel:[self txtNivel].text.intValue];
    [perso setClasse:[self txtClasse].text];
    [perso setAlinhamento:[self txtAlinhamento].text];
    
    //guardar atributos do personagem
    [perso setAtributoNoIndice:0 :[self txtFor].text.intValue];
    [perso setAtributoNoIndice:1 :[self txtCon].text.intValue];
    [perso setAtributoNoIndice:2 :[self txtDes].text.intValue];
    [perso setAtributoNoIndice:3 :[self txtInt].text.intValue];
    [perso setAtributoNoIndice:4 :[self txtSab].text.intValue];
    [perso setAtributoNoIndice:5 :[self txtCar].text.intValue];
    
    [[PersonagensDataSource sharedSource] addPersonagem:perso];
    [self limparDados];
}

-(void) limparDados
{
    [[PersonagensDataSource sharedSource] setPersonagemAtual:[[Personagem alloc] init]];
    
    [[self txtNome] setText:@""];
    [[self txtRaca] setText:@""];
    [[self txtNivel] setText:@""];
    [[self txtClasse] setText:@""];
    [[self txtAlinhamento] setText:@""];
    
    [[self txtFor] setText:@""];
    [[self txtCon] setText:@""];
    [[self txtDes] setText:@""];
    [[self txtInt] setText:@""];
    [[self txtSab] setText:@""];
    [[self txtCar] setText:@""];
}

-(void) carregarDados
{
    Personagem *perso = [[PersonagensDataSource sharedSource] PersonagemAtual];
    NSString *text;
    
    [[self txtNome] setText:[perso nome]];
    [[self txtRaca] setText:[perso raca]];
    text = [NSString stringWithFormat:@"%d", [perso nivel]];
    [[self txtNivel] setText:text];
    [[self txtClasse] setText:[perso classe]];
    [[self txtAlinhamento] setText:[perso alinhamento]];
    
    text = [NSString stringWithFormat:@"%d", [perso atributoNoIndice:0]];
    [[self txtFor] setText:text];
    text = [NSString stringWithFormat:@"%d", [perso atributoNoIndice:1]];
    [[self txtCon] setText:text];
    text = [NSString stringWithFormat:@"%d", [perso atributoNoIndice:2]];
    [[self txtDes] setText:text];
    text = [NSString stringWithFormat:@"%d", [perso atributoNoIndice:3]];
    [[self txtInt] setText:text];
    text = [NSString stringWithFormat:@"%d", [perso atributoNoIndice:4]];
    [[self txtSab] setText:text];
    text = [NSString stringWithFormat:@"%d", [perso atributoNoIndice:5]];
    [[self txtCar] setText:text];
}

-(void)gotoLista
{
    UIViewController *tabVC = [[[ViewControllerSingleton sharedSource] viewControllers]objectAtIndex:1];
    [UIView animateWithDuration:0.75
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                         [[self navigationController] pushViewController:tabVC animated:NO];
                         [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
                     }];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end
