# Gamescope Session
1) The upstream installation instructions are simply "download this repo and install its file structure to the appropriate places", so this package is versioned as a -9999 and given no keywords to match. Unmasking will require "gui-libs/gamescope-session::hoodeddeath **" in package.accept_keywords
2) Upstream provides a Systemd user unit to be used by sessions. I am not experienced with writing similar units for OpenRC and do not currently have an OpenRC system to test with. If you would like to assist with with service and/or fixing sessions such as gamescope-session-steam to work with an OpenRC session, feel free to contribute.