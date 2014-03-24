//
//  CDAtributos.h
//  AttGraphics 2
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 06/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDPersonagem;

@interface CDAtributos : NSManagedObject

@property (nonatomic, retain) NSNumber * forca;
@property (nonatomic, retain) NSNumber * constituicao;
@property (nonatomic, retain) NSNumber * destreza;
@property (nonatomic, retain) NSNumber * inteligencia;
@property (nonatomic, retain) NSNumber * sabedoria;
@property (nonatomic, retain) NSNumber * carisma;
@property (nonatomic, retain) CDPersonagem *relationship;

@end
