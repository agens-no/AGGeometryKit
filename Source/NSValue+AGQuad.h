//
//  NSValue+AGQuad.h
//  AGGeometryKit
//
//  Created by Håvard Fossli on 20.02.13.
//  Copyright (c) 2013 Håvard Fossli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGQuad.h"

@interface NSValue (AGQuad)

+ (NSValue *)valueWithAGQuad:(AGQuad)q;
- (AGQuad)AGQuadValue;

@end

