if (!hasInterface) exitWith {};

if (isNull player) exitWith
{
	[{!isnull player}, SBR_fnc_initPlayer] call CBA_fnc_waitUntilAndExecute;
};

private _unitAssignedToSBR = player getVariable ["SBR_unitRespawnSection",""];
if (_unitAssignedToSBR == "") exitWith {};

if (didJip) then
{
	[] call SBR_fnc_handleJipPlayer;
}
else
{
	[] call SBR_fnc_initPlayerUnit;
};