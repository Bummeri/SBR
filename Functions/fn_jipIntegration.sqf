//Inline Functions
private _fn_integrateAsSpectator = {
	if (alive player) then
	{
		removeAllWeapons player;
		player setPos getMarkerPos "SBR_WORK";
		forceRespawn player;
	};
};
private _fn_integrateToGame = {
	params ["_waveToTrigger"];
	[_waveToTrigger] call SBR_fnc_triggerSBRForUnit;
};

//Function Start
private _rSDataArray = missionNamespace getVariable ["SBR_rSData", [0,0,0]];
_rSDataArray params ["_lastRespawnTime", "_currentWaveNumber", "_gracePeriod"];

if (cba_missiontime > (_lastRespawnTime + _gracePeriod)) then
{
	[] call _fn_integrateAsSpectator;
}
else
{
	[_currentWaveNumber] call _fn_integrateToGame;
};
