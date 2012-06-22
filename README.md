ofxSettings
===========

Easy access to standardUserDefaults from C++.
Can also be used to set/get any value beyond those you can define in Settings bundle.

Examples
--------

// Get an integer and a string value
int score = Settings::getInt("score");
string name = Settings::getString("playerName");

// Set some values
Settings::setInt(score + 1, "score");
Settings::setString("Bill", "playerName");