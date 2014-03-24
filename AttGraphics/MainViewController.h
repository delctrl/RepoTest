//
//  MainViewController.h
//  AttGraphics
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 03/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonagensDataSource.h"
#import "ViewControllerSingleton.h"
#import "Personagem.h"

@interface MainViewController : UIViewController

//Button
@property (weak, nonatomic) IBOutlet UIButton *btnNovo;
@property (weak, nonatomic) IBOutlet UIButton *btnSalvar;

//TextFields
@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtRaca;
@property (weak, nonatomic) IBOutlet UITextField *txtNivel;
@property (weak, nonatomic) IBOutlet UITextField *txtClasse;
@property (weak, nonatomic) IBOutlet UITextField *txtAlinhamento;

//TextFields - Atributos
@property (weak, nonatomic) IBOutlet UITextField *txtFor;
@property (weak, nonatomic) IBOutlet UITextField *txtCon;
@property (weak, nonatomic) IBOutlet UITextField *txtDes;
@property (weak, nonatomic) IBOutlet UITextField *txtInt;
@property (weak, nonatomic) IBOutlet UITextField *txtSab;
@property (weak, nonatomic) IBOutlet UITextField *txtCar;


@end
