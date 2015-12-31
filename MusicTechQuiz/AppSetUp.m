//
//  AppSetUp.m
//  MusicTechQuiz
//
//  Created by Carl  on 31/12/2015.
//  Copyright © 2015 Carl Taylor. All rights reserved.
//

#import "AppSetUp.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation AppSetUp

+(void)setUpMagicalRecord
{
    NSString *bundleID = (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey];
    NSString *dbStore = [NSString stringWithFormat:@"%@.sqlite", bundleID];
    
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:dbStore];
}

@end
