private _joiningPlayerUID = getPlayerUID player;
private _unitReserverUID = player getVariable ["SBR_unitReservedForUID",""];

if (_unitReserverUID isEqualTo "") then
{
	private _playersReservedSlot = [_joiningPlayerUID] call SBR_fnc_findReservedSlot;
	if (isnull _playersReservedSlot) then
	{
		[] call SBR_fnc_initPlayerUnit;
	}
	else
	{
		[_playersReservedSlot] call SBR_fnc_handleJipToWrongSlot;
	};
}
else
{
	if (_unitReserverUID == _joiningPlayerUID) then
	{
		[false] call SBR_fnc_handleAnouncement;
		if (alive player) then
		{
			[player,false] call SBR_fnc_setUnconsciousness;
		}
		else
		{
			[] call SBR_fnc_jipIntegration;
		};
	}
	else
	{
		[] call SBR_fnc_handleJipToReservedSlot;
	};
};

