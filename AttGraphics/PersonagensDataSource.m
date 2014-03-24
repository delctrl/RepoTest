//
//  PersonagensDataSource.m
//  AttGraphics
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 04/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import "PersonagensDataSource.h"

@implementation PersonagensDataSource

+(PersonagensDataSource*) sharedSource
{
    static PersonagensDataSource *sharedSource = nil;
    if (!sharedSource) {
        sharedSource = [[super allocWithZone:nil] init];
    }
    return sharedSource;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedSource];
}

-(id)init
{
    self = [super init];
    if (self) {
        personagens = [[NSMutableArray alloc] init];
        [self setPersonagemAtual:[[Personagem alloc] init]];
    }
    return self;
}

-(void) addPersonagem: (Personagem*) perso
{
    BOOL subs = FALSE;
    
    for (Personagem *p in personagens) {
        if (p == perso) {
            subs = TRUE;
        }
    }
    
    if (subs) {
        [personagens removeObject:perso];
    }
    
    [personagens addObject:perso];
}

-(void) delPersonagem: (Personagem*) perso
{
    [personagens removeObject:perso];
}

-(NSMutableArray*) todosPersonagens
{
    return personagens;
}

-(Personagem*) retornaPersonagemNoIndice: (int) indice
{
    return [personagens objectAtIndex:indice];
}

-(void) movePersonagemNoIndice: (int)de paraIndice:(int)para
{
    if (de == para) {
        return;
    }
    
    Personagem *p = [personagens objectAtIndex:de];
    [personagens removeObjectAtIndex:de];
    [personagens insertObject:p atIndex:para];
}

@end
