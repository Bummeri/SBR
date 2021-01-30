params ["_show", "_wrongSlot"];
disableSerialization;
//Inline Functions
private _fnc_hideAnouncement = {
	disableSerialization;
	if (!isNull findDisplay 53) then {
		private _ctrl = ((findDisplay 53) displayCtrl 1110);
		_ctrl ctrlShow false;
	};
};

private _fnc_showAnouncement = {
	disableSerialization;
	if (!isNull findDisplay 53) then {
		params ["_anouncementText"];
		disableSerialization;
		private _ctrl = ((findDisplay 53) displayCtrl 1110);
		_ctrl ctrlSetStructuredText _anouncementText;
	};
};

private _fnc_listFreeSlots = {
	private _side = side player; 
	private _slots = "";
	{
		if (side _x isEqualTo _side) then {
			if ((_x getVariable["SBR_unitReservedForUID", ""]) isEqualTo "") then {
				_slots = _slots + format["%1\n", roleDescription _x];
			};
		};
	} forEach playableUnits;
	_slots
};

private _fnc_endMission = {
	if (!isNull findDisplay 46) then {
		params ["_anouncementText"];
		0 cutText [_anouncementText, "BLACK", 0, true, true];

		[] spawn {
			uiSleep 20;
			endMission "End_SBR_InvalidSlot";
		};
	};
};

if (_show) then {
	private _text = "";
	private _title = "";
	if(_wrongSlot) then {
		private _mySlot = [getPlayerUID player] call SBR_fnc_findReservedSlot;
		_title = "Switch to your own slot!";
		_text = format["You have reserved slot: %1 - %2, switch to it.", side _mySlot, roleDescription _mySlot];
	} else {
		private _freeSlots = [] call _fnc_listFreeSlots;
		_title = "You're in reserved slot!";
		_text = format["This slot is reserved to another player.\n%1 available slots:\n%2", side player, _freeSlots];
	};
	private _anouncementText = parseText format["<t size='1.5' color='#FF0000' align='center'>%1</t><t size='0.75'><br />%2</t>", ([_title, "\n", "<br />"] call CBA_fnc_replace), ([_text, "\n", "<br />"] call CBA_fnc_replace)];

	[{(!isNull findDisplay 53) || (getClientStateNumber isEqualTo 6)}, _fnc_showAnouncement, [_anouncementText]] CBA_fnc_waitUntilAndExecute;
	[{(!isNull findDisplay 46) || (getClientStateNumber isEqualTo 6)}, _fnc_endMission, [_anouncementText]] CBA_fnc_waitUntilAndExecute;
} else {
	[{(!isNull findDisplay 53) || (getClientStateNumber isEqualTo 6)}, _fnc_hideAnouncement] CBA_fnc_waitUntilAndExecute;
};