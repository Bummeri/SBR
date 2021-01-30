private _playersRespawnSection = player getVariable "SBR_unitRespawnSection";
player setVariable ["SBR_unitInitialGroup", group player, true];
player setVariable ["SBR_unitReservedForUID", getPlayerUID player, true];
player setVariable ["SBR_unitReservedForName", profileNameSteam, true];
[false] call SBR_fnc_handleAnouncement;

[player, _playersRespawnSection] remoteExecCall ["SBR_fnc_updateSectionUnitList", 2];
[player, true] remoteExecCall ["SBR_fnc_enablePlayableUnitState", 2];

if (didJip) then
 {
 	[] call SBR_fnc_jipIntegration;
 }
 else
 {
 	[0] call SBR_fnc_triggerSBRForUnit;
 };