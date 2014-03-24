//
//  Personagem.h
//  AttGraphics
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 03/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Atributo.h"

@interface Personagem : NSObject
{
     Atributo *atributos[6];
}

@property NSString *nome;
@property NSString *raca;
@property NSString *classe;
@property NSString *alinhamento;
@property int nivel;

-(int) atributoNoIndice:(int) indice;
-(int) atributoComNome:(NSString*) nome;
-(void) setAtributoNoIndice:(int) indice :(int) valor;
-(void) setAtributoComNome:(NSString*) nome :(int) valor;

@end
