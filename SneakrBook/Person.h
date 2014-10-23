//
//  Person.h
//  SneakrBook
//
//  Created by Vi on 10/22/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSSet *shoes;
@property NSArray *genders;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addShoesObject:(NSManagedObject *)value;
- (void)removeShoesObject:(NSManagedObject *)value;
- (void)addShoes:(NSSet *)values;
- (void)removeShoes:(NSSet *)values;

@end
