//
//  TabViewController.h
//  AttGraphics
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 04/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Personagem.h"
#import "PersonagensDataSource.h"
#import "ViewControllerSingleton.h"

@interface TabViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnEditar;

@property int linhaSelecionada;

@end
