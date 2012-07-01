//
//  Settings.h
//
//  Created by Pierre Rossel on 22.06.12.
//  Copyright (c) 2012 HEAD-Genève. All rights reserved.
//

#pragma once

#include "string"

using namespace std;

// This class ease getting values from application settings
// Application settings can easily be defined by creating a Settings bundle (menu file, new file, iOS resources)
class Settings {
    
public:
    
    static bool getBool(string sKey, bool bDefault = false);
    static int getInt(string sKey, int iDefault = 0);
    static float getFloat(string sKey, float fDefault = 0.0);
    static string getString(string sKey, string sDefault="");
    
    static void setBool(bool value, string sKey);
    static void setInt(int value, string sKey);
    static void setFloat(float value, string sKey);
    static void setString(string value, string sKey);
    
    // Register defaults from settings bundle
    //
    // Settings bundle has default values. However, they are saved only 
    // the first time the user is changing something in the settings. 
    // This function loads the default values from the settings bundle if 
    // they have not been initialised yet.
    // There is no need to call this function yourself, it is automatically done
    // when the first get... function is called.
    static void registerDefaultsFromSettingsBundle();

    
protected:
    static bool s_bDefaultsRegistered;
};

