params ["_unit", "_sound"];

_unit say3d [_sound, 50];

_unit setRandomLip true;

[{
	params ["_unit"];
	_unit setRandomLip false;
}, [_unit], 2] call CBA_fnc_waitAndExecute;