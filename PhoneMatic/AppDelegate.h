//
//  AppDelegate.h
//  PhoneMatic
//
//  Created by Ashank Singh on 9/21/17.
//  Copyright © 2017 Ashank Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

