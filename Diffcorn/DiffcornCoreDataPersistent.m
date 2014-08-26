//
//  DiffcornCoreDataPersistent.m
//  Redbooth
//
//  Created by Pedro Piñera Buendía on 26/08/14.
//  Copyright (c) 2014 teambox. All rights reserved.
//

#import "DiffcornCoreDataPersistent.h"

@implementation DiffcornCoreDataPersistent

/**
 *  Create objects in database from a given array of dictionaries
 *
 *  @param objects    NSArray[NSDictionary] with items to be created
 *  @param entityName NSString with the entity name (related with the CoreData entity model)
 */
+ (void)new:(NSArray *)objects entityName:(NSString *)entityName
{
    // Getting the class
    Class entityClass = [self classFromEntityName:entityName];
    if (entityClass == Nil) return;
    
    // Creating the items
    NSArray *__block blockObjects = objects;
    [LFSaveInBackgroundOperation saveInBackgroundWithBlock:^(NSManagedObjectContext *backgroundContext) {
        [entityClass importFromArray:blockObjects inContext:backgroundContext];
    } completion:^(NSError *error) {
        DDLogInfo(@"%d entities of type <%@> created in the local store", blockObjects.count, entityName);
    }];
}

/**
 *  Deletes the objects in the databse
 *
 *  @param objects    NSArray[NSDictionary] with objects to be delted (their IDs)
 *  @param entityName NSString with the entity name (related with the CoreData entity model)
 */
+ (void)deleted:(NSArray *)objects entityName:(NSString *)entityName
{
    // Getting the class
    Class entityClass = [self classFromEntityName:entityName];
    if (entityClass == Nil) return;
    
    // Deleting the items
    NSArray *__block blockObjects = objects;
    [LFSaveInBackgroundOperation saveInBackgroundWithBlock:^(NSManagedObjectContext *backgroundContext) {
        NSMutableArray *objectIDs = [NSMutableArray new];
        [blockObjects enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            // Getting id
            NSNumber *identifier = obj[@"id"];
            if (!obj) return;
            
            // Storing the ID
            if ([obj isKindOfClass:[NSNumber class]]) {
                [objectIDs addObject:identifier];
            }
        }];
        [entityClass deleteObjectsWithIDs:objectIDs inContext:backgroundContext];
    } completion:^(NSError *error) {
        DDLogInfo(@"%d entities of type <%@> deleted in the local store", blockObjects.count, entityName);
    }];
}

/**
 *  Updates the passed entities in the database
 *
 *  @param objects    NSArray[NSDictionary] with the items are going to be updated
 *  @param entityName NSString with  the entity name (related with the CoreData entity model)
 */
+ (void)patch:(NSArray *)objects entityName:(NSString *)entityName
{
    // Getting the class
    Class entityClass = [self classFromEntityName:entityName];
    if (entityClass == Nil) return;
    
    // Updating the items
    NSArray *__block blockObjects = objects;
    [LFSaveInBackgroundOperation saveInBackgroundWithBlock:^(NSManagedObjectContext *backgroundContext) {
        [entityClass importFromArray:blockObjects inContext:backgroundContext];
    } completion:^(NSError *error) {
        DDLogInfo(@"%d entities of type <%@> updated in the local store", blockObjects.count, entityName);
    }];
}


#pragma mark - Helper methods
/**
 *  Returns the NSManagedObject class from the entity name
 *
 *  @param entityName NSString with the entity name (related with the CoreData entity model)
 *
 *  @return Class of the CoreData NSManagedObject model
 */
+ (Class)classFromEntityName:(NSString*)entityName
{
    const char *constName = [entityName UTF8String];
    Class entityClass = objc_getClass(constName);
    
    if (entityClass == Nil) {
        entityClass = objc_getClass([[entityName firstLetterCapitalized] UTF8String]);
    }
    
    if (entityClass == Nil) {
        DDLogError(@"Error, entity <%@> in the local store not found", entityName);
    }
    return entityClass;
}

@end
