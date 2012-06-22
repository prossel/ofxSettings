ofxSettings
===========

This addon offers iOS apps an easy access to standardUserDefaults from C++ without bothering with Objective-C.

You can mainly use it for:

1. Save and read any value which has to persist when the app is closed
2. Get values set by users under the Settings icon for you application.

Note: For you app to appear in Settings, you have to provide a Settings bundle. You can create one with menu File | New File | Resources | Settings bundle. Look here if Xcode doesn't allow you to edit the bundle: http://stackoverflow.com/questions/7162846/empty-settings-bundle-in-xcode-4-2


Example
-------

    #include "Settings.h"
    
    // Get an integer and a string value
    int score = Settings::getInt("score");
    string name = Settings::getString("playerName");

    // Set some values
    Settings::setInt(score + 1, "score");
    Settings::setString("Bill", "playerName");