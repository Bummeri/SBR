params [["_unit",objNull, [objNull]], ["_section","",[""]]];

if (isnull _unit) exitWith {false};
if (_section isEqualTo "") then {
	_section = _unit getVariable ["SBR_unitRespawnSection", ""];
	if (_section isEqualTo "") exitWith {false};
};

private _sectionUnitList = [SBR_data, [_section, "unitList"]] call CBA_fnc_hashGet;
if (isnil "_sectionUnitList") then {
	_sectionUnitList = [];
	[SBR_data, [_section, "unitList"], _sectionUnitList] call CBA_fnc_hashSet;
};
_sectionUnitList pushBackUnique _unit; //This gets updated to the hash by array reference