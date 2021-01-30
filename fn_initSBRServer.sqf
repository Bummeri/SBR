if !(SBR_initialized) exitWith {false};
if (!isserver) exitWith {false};

private _fnc_markerError = {
	if (cba_missiontime > 0) then {
		params ["_text"];
		_text remoteExecCall ["systemChat", -2];		
	};
};

private _missingRespawn = true;
private _missingWork = true;
{
	if ((toLower _x) isEqualTo "sbr_work") then {
		_missingWork = false;
	};
	if ("respawn" in (toLower _x)) then {
		_missingRespawn = false;
	};
} forEach allMapMarkers;

if (_missingWork) then {
	createMarker ["SBR_WORK", [0,0,0]];
	[{cba_missontime > 0 || getClientStateNumber == 4}, _fnc_markerError, ["This mission is lacking SBR_WORK marker, SBR might not work properly. Please Check the mission."]] call CBA_fnc_waitUntilAndExecute;
};

if (_missingRespawn) then {
	createMarker ["Respawn", [0,10,0]];
	[{cba_missontime > 0 || getClientStateNumber == 4}, _fnc_markerError, ["This mission is lacking Respawn markers, SBR might not work properly. Please Check the mission."]] call CBA_fnc_waitUntilAndExecute;
};

private _respawnSections = [SBR_data,"sectionList"] call CBA_fnc_hashGet;
{
	private _zeroWaveFnc = [SBR_data, [_x, 0,"waveFnc"]] call CBA_fnc_hashGet;
	[] call _zeroWaveFnc;
} forEach _respawnSections;
