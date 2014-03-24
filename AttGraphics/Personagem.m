//
//  Personagem.m
//  AttGraphics
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 03/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import "Personagem.h"

@implementation Personagem

- (id)init
{
    self = [super init];
    if (self) {
        
        for (int i=0; i<6; i++) {
            atributos[i] = [[Atributo alloc] init];
        }
        
        [atributos[0] setNome:@"For"];
        [atributos[1] setNome:@"Con"];
        [atributos[2] setNome:@"Des"];
        [atributos[3] setNome:@"Int"];
        [atributos[4] setNome:@"Sab"];
        [atributos[5] setNome:@"Car"];
    }
    return self;
}

-(int) atributoNoIndice:(int) indice
{
    if (indice>5 || indice <0) {
        return -1;
    }
    
    return [atributos[indice] valor];
}

-(int) atributoComNome:(NSString*) nome
{
    for (int i=0; i<6; i++) {
        if (nome == [atributos[i] nome]) {
            return [atributos[i] valor];
        }
    }
    
    return -1;
}

-(void) setAtributoNoIndice:(int) indice :(int) valor
{
    if (indice>5 || indice <0) {
        return;
    }
    
    [atributos[indice] setValor:valor];
}

-(void) setAtributoComNome:(NSString*) nome :(int) valor
{
    
    for (int i=0; i<6; i++) {
        if (nome == [atributos[i] nome]) {
            [atributos[i] setValor:valor];
        }
    }
}

@end
