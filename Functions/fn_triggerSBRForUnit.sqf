//Trigger an SBR for unit
params ["_waveNumber"];

private _fnc_respawnEH = {
	params ["_unit", "_corpse"];
	deleteVehicle _corpse;
	player setPlayerRespawnTime 99999;
	private _playersRespawnSection = player getVariable "SBR_unitRespawnSection";
	[player, _playersRespawnSection] remoteExecCall ["SBR_fnc_updateSectionUnitList", 2];
	player removeEventHandler ["Respawn",_thisEventHandler];
};

if (alive player) then {
	[player, _waveNumber] call SBR_fnc_addGear;
	["SBR_execUnitCode", [player, _waveNumber, player getVariable "SBR_unitRespawnSection"]] call CBA_fnc_serverEvent;
} else {
	player addEventHandler ["Respawn", _fnc_respawnEH];
	player setPlayerRespawnTime 1;
	[{alive player}, SBR_fnc_triggerSBRForUnit, [_waveNumber], 5] call CBA_fnc_waitUntilAndExecute;
};