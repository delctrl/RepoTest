//
//  PersonagensDataSource.h
//  AttGraphics
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 04/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Personagem.h"

@interface PersonagensDataSource : NSObject
{
    NSMutableArray *personagens;
}

@property Personagem *PersonagemAtual;

+(PersonagensDataSource*) sharedSource;

-(void) addPersonagem: (Personagem*) perso;
-(void) delPersonagem: (Personagem*) perso;
-(void) movePersonagemNoIndice: (int)de paraIndice:(int)para;

-(NSMutableArray*) todosPersonagens;
-(Personagem*) retornaPersonagemNoIndice: (int) indice;

@end
