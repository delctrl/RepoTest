//
//  CDPersonagem.h
//  AttGraphics 2
//
//  Created by RODRIGO PEREIRA ASSUNCAO on 06/12/13.
//  Copyright (c) 2013 RODRIGO PEREIRA ASSUNCAO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDAtributos;

@interface CDPersonagem : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * raca;
@property (nonatomic, retain) NSNumber * nivel;
@property (nonatomic, retain) NSString * classe;
@property (nonatomic, retain) NSString * alinhamento;
@property (nonatomic, retain) CDAtributos *relationship;

@end
