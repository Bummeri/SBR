_mode = param [0,"",[""]];
_input = param [1,[],[[]]];

switch _mode do {
	// Default object init
	case "init": {
		_logic = _input param [0,objNull,[objNull]]; // Module logic
		_isActivated = _input param [1,true,[true]]; // True when the module was activated, false when it's deactivated
		_isCuratorPlaced = _input param [2,false,[true]]; // True if the module was placed by Zeus
		if (is3den) then {
			private _error = false;
			private _multiplayerSettings = [
				["respawnDelay", 99999],
				["respawn", 3],
				["respawnTemplates", ["ace_spectator","Counter"]],
				["disabledAI", false]
			];

			{
				_x params ["_settingName","_value"];
				"Multiplayer" set3DENMissionAttribute [_settingName, _value];
			} forEach _multiplayerSettings;

			{
				_x params ["_settingName","_value"];
				if !([missionConfigFile,_settingName,0] call BIS_fnc_returnConfigEntry in [0,_value]) exitWith {
					_error = true;
				};
			} forEach _multiplayerSettings;

			if (_error) then {
				private _name = "Bum_SBR_missionConfigError";
				private _duration = 9;
				[_name,_duration] call BIS_fnc_3DENNotification;
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

			if (_missingRespawn || _missingWork) then {
				private _name = "Bum_SBR_missionMarkerError";
				private _duration = 9;
				[_name, _duration] spawn {
					uiSleep 9;
					params ["_name", "_duration"];
					[_name,_duration] call BIS_fnc_3DENNotification;
				};

			};
		} else {
			missionNamespace setVariable ["SBR_initialized", true, true];
		};
	};
};