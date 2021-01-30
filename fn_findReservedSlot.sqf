/*
	Description:
	This function finds if player has already a reserved slot.

	Parameter(s):
	_this select 0: number - UID to search in units

	Returns:
	unit - The unit player has reserved to himself.
*/

params ["_uid"];

private _reservedSlot = objNull;
{
	if ((_x getVariable["SBR_unitReservedForUID", ""]) isEqualTo _uid) exitWith
	{
		_reservedSlot = _x;
	};
} forEach playableUnits;
_reservedSlot