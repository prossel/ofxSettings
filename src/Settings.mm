//
//  Settings.mm
//
//  Created by Pierre Rossel on 22.06.12.
//  Copyright (c) 2012 HEAD-Genève. All rights reserved.
//

#include "Settings.h"

bool Settings::s_bDefaultsRegistered = false;

bool Settings::getBool(string sKey, bool bDefault) {
    
    // Load defaults on the first get... call
    if (!s_bDefaultsRegistered) registerDefaultsFromSettingsBundle();
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // return default value if key does not exist
    id obj = [defaults objectForKey:[NSString stringWithUTF8String:sKey.c_str()]];
    if (!obj)
        return bDefault;
    
    return [defaults boolForKey:[NSString stringWithUTF8String:sKey.c_str()]];
}

int Settings::getInt(string sKey, int iDefault) {
    
    // Load defaults on the first get... call
    if (!s_bDefaultsRegistered) registerDefaultsFromSettingsBundle();
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // return default value if key does not exist
    id obj = [defaults objectForKey:[NSString stringWithUTF8String:sKey.c_str()]];
    if (!obj)
        return iDefault;

    return [defaults integerForKey:[NSString stringWithUTF8String:sKey.c_str()]];
}


float Settings::getFloat(string sKey, float fDefault) {
    
    // Load defaults on the first get... call
    if (!s_bDefaultsRegistered) registerDefaultsFromSettingsBundle();
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // return default value if key does not exist
    id obj = [defaults objectForKey:[NSString stringWithUTF8String:sKey.c_str()]];
    if (!obj)
        return fDefault;
    
    return [defaults floatForKey:[NSString stringWithUTF8String:sKey.c_str()]];
}


string Settings::getString(string sKey, string sDefault) {
    
    // Load defaults on the first get... call
    if (!s_bDefaultsRegistered) registerDefaultsFromSettingsBundle();
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* value = [defaults stringForKey:[NSString stringWithUTF8String:sKey.c_str()]];
    if (!value)
        return sDefault;
    
    return [value cStringUsingEncoding:[NSString defaultCStringEncoding]];
}


void Settings::setBool(bool value, string sKey) {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:[NSString stringWithUTF8String:sKey.c_str()]];
}


void Settings::setInt(int value, string sKey) {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:[NSString stringWithUTF8String:sKey.c_str()]];
}


void Settings::setFloat(float value, string sKey) {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:value forKey:[NSString stringWithUTF8String:sKey.c_str()]];
}


void Settings::setString(string value, string sKey) {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* id = [NSString stringWithUTF8String:value.c_str()];
    [defaults setObject:id forKey:[NSString stringWithUTF8String:sKey.c_str()]];
}


void Settings::registerDefaultsFromSettingsBundle()
{
	NSLog(@"Registering default values from Settings.bundle");
	NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
	[defs synchronize];
	
	NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
	
	if(!settingsBundle)
	{
		NSLog(@"Could not find Settings.bundle");
		return;
	}
	
	NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
	NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
	NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
	
	for (NSDictionary *prefSpecification in preferences)
	{
		NSString *key = [prefSpecification objectForKey:@"Key"];
		if (key)
		{
			// check if value readable in userDefaults
			id currentObject = [defs objectForKey:key];
			if (currentObject == nil)
			{
				// not readable: set value from Settings.bundle
				id objectToSet = [prefSpecification objectForKey:@"DefaultValue"];
				[defaultsToRegister setObject:objectToSet forKey:key];
				NSLog(@"Setting object %@ for key %@", objectToSet, key);
            }
			else
            {
				// already readable: don't touch
				NSLog(@"Key %@ is readable (value: %@), nothing written to defaults.", key, currentObject);
            }
        }
    }
	
	[defs registerDefaults:defaultsToRegister];
	[defaultsToRegister release];
	[defs synchronize];
    
    s_bDefaultsRegistered = true;
}

