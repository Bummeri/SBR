class Extended_PostInit_EventHandlers {
    class SBR_postInit {
        Playerinit = "[] call SBR_fnc_initPlayer";
        Serverinit = "[] call SBF_fnc_initSBRServer";
    };
};

class Extended_InitPost_EventHandlers {
    class CAManBase {
        class SBR_initPost {
            Serverinit = "[_this] call SBR_fnc_InitUnitServer";
        };
    };
};