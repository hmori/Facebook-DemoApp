//
//  Facebook+Add.m
//  DemoApp
//
//  Created by Mori Hidetoshi on 11/08/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Facebook+Add.h"


@implementation Facebook (Add)

static NSString* kDialogBaseURL = @"https://m.facebook.com/dialog/";

static NSString* kRedirectURL = @"fbconnect://success";

static NSString* kLogin = @"oauth";
static NSString* kSDKVersion = @"2";

/**
 * A public function for authorization without dialog.
 */
- (void)authorizeWithoutDialog {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   _appId, @"client_id",
                                   @"user_agent", @"type",
                                   kRedirectURL, @"redirect_uri",
                                   @"touch", @"display",
                                   kSDKVersion, @"sdk",
                                   nil];
    
    NSString *loginDialogURL = [kDialogBaseURL stringByAppendingString:kLogin];
    
    if (_permissions != nil) {
        NSString* scope = [_permissions componentsJoinedByString:@","];
        [params setValue:scope forKey:@"scope"];
    }
    
    if (_localAppId) {
        [params setValue:_localAppId forKey:@"local_client_id"];
    }
    
    // If single sign-on failed, open an inline login dialog. This will require the user to
    // enter his or her credentials.
    [_loginDialog release];
    _loginDialog = [[FBLoginDialog alloc] initWithURL:loginDialogURL
                                          loginParams:params
                                             delegate:self];
    [_loginDialog load];
}

@end
