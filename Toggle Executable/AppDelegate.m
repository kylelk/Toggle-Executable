//
//  AppDelegate.m
//  Toggle Executable
//
//  Created by Kyle on 11/28/13.
//  Copyright (c) 2013 Kyle kersey. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [NSApp setServicesProvider:self];
    NSUpdateDynamicServices();
}
    void runSystemCommand(NSString *cmd)
    {
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:@"/bin/chmod"];
        if ([[NSFileManager defaultManager] isExecutableFileAtPath:cmd]) {
            //NSLog(@"is executable \n");
            [task setArguments:@[ @"-x", cmd]];
            [task launch];
            
        } else {
            //NSLog(@"is not executable \n");
            [task setArguments:@[ @"+x", cmd]];
            [task launch];
            
        }
    }
- (void)handleServices:(NSPasteboard *)pboard
              userData:(NSString *)userData
                 error:(NSString **)error {
    if([[pboard types] containsObject:NSFilenamesPboardType]){
        NSArray* fileArray=[pboard propertyListForType:NSFilenamesPboardType];
        int i;
        int count;
        count = [fileArray count];
        for (i = 0; i < count; i++){
            //NSLog (@"%@", [fileArray objectAtIndex: i]);
            runSystemCommand([fileArray objectAtIndex: i]);
        }
    }
}

@end
