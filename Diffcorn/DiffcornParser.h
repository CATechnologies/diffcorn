//
//  DiffCornParser.h
//  Redbooth
//
//  Created by Sergi on 8/26/14.
//  Copyright (c) 2014 teambox. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DiffcornProtocol <NSObject>
+ (void)new:(NSArray *)objects entityName:(NSString *)entityName;
+ (void)deleted:(NSArray *)objects entityName:(NSString *)entityName;
+ (void)patch:(NSArray *)objects entityName:(NSString *)entityName;
@end

@interface DiffcornParser : NSObject

@end
