params ["_helper"];


[
	_helper,
	"Destroy",
	"", "",
	"true", "true",
	{  },
	{  },
	{ 
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _candidates = nearestTerrainObjects [getPos _target, [], 5, true];
		private _greenhouse = objNull;
		{
			if (_x isKindOf "Land_Greenhouse_01_F") then {
				_greenhouse = _x;
			};
			if (_x isKindOf "CUP_clutter_mochomurka") then {
				_x setDamage 1;
			};
		} forEach _candidates;

		if (!isNull _greenhouse && alive _greenhouse) then {
			_greenhouse setDamage 1;
		};
	},
	{ "Aborted burning" call CBA_fnc_notify; },
	[], 10, nil, true, false
] call BIS_fnc_holdActionAdd;
