//
//  LaunchAtLoginController.m
//
//  Copyright 2011 Tomáš Znamenáček
//  Copyright 2010 Ben Clark-Robinson
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the ‘Software’),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "LaunchAtLoginController.h"
#import <ServiceManagement/ServiceManagement.h>

// LSSharedFileList (kLSSharedFileListSessionLoginItems) is no longer supported and has no
// effect on current macOS, so login item state is managed through SMAppService instead.
@implementation LaunchAtLoginController

- (BOOL) launchAtLogin
{
    return [SMAppService mainAppService].status == SMAppServiceStatusEnabled;
}

- (void) setLaunchAtLogin: (BOOL) enabled
{
    SMAppService *service = [SMAppService mainAppService];
    NSError *error = nil;
    
    if (enabled) {
        // RequiresApproval means the user switched Shuttle off in System Settings > Login Items;
        // respect that instead of re-registering on every config reload.
        if (service.status == SMAppServiceStatusEnabled || service.status == SMAppServiceStatusRequiresApproval)
            return;
        if (![service registerAndReturnError:&error])
            NSLog(@"Shuttle: could not enable launch at login: %@", error);
    } else if (service.status == SMAppServiceStatusEnabled) {
        if (![service unregisterAndReturnError:&error])
            NSLog(@"Shuttle: could not disable launch at login: %@", error);
    }
}

@end
