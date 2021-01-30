/*
	Author: Bummeri <@armafinland.fi>

	Description:
	This function preps unit for SBR.

	Parameter(s):
	_this select 0: Object - Unit to prep
*/

params [["_unit", objNull,[objNull]]];
if !(SBR_initialized) exitWith {false};
if (!isserver) exitWith {false};
if (isNull _unit) exitWith {false};
if (_unit getVariable ["SBR_unitRespawnSection", ""] isEqualTo "") exitWith {false};
if (_unit getVariable ["SBR_unitGearVariable", ""] isEqualTo "") then {_unit setVariable ["SBR_unitGearVariable", (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName") call BIS_fnc_getCfgData, true]};

if (!isMultiplayer) exitWith {
	if (isnil "SBR_editorFirstWaveExec") then {
		SBR_editorFirstWaveExec = true;
		//TODO EXEC FIRST WAVE CODE!
		//TODO: ALso do this in MP?
	};
	[_unit, 0] call SBR_fnc_addGear;
	["SBR_execUnitCode", [_unit, 0, _unit getVariable ["SBR_unitRespawnSection", ""]]] call CBA_fnc_serverEvent;
};
[_unit, false] call SBR_fnc_enablePlayableUnitState;
true