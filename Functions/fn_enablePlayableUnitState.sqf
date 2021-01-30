params ["_unit", "_enable"];

_unit hideObjectGlobal !_enable;
_unit enableSimulationGlobal _enable;
_unit allowDamage _enable;
[_unit,_enable] remoteExecCall ["allowDamage", _unit];