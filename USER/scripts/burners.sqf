params ["_unit", ["_isBoss", false]];


if (!isServer && _isBoss) exitWith {
	_unit addAction
	[
		"Ambush Players",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"]; // script

			missionNameSpace setVariable ["grad_ambushplayers", true, true];
		},
		nil,		// arguments
		1.5,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"_caller == _this",		// condition
		50,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
	];
};

[{
	missionNameSpace getVariable ["grad_ambushplayers", false]
},{
	params ["_unit"];

	[{
		params ["_unit"];
		
		if (random 3 > 2) then {
			private _sound = selectRandom [
				"youwilldienow",
				"youwilldienow2",
				"youwillpayforthis",
				"fuckoff",
				"horny_1"
			];
			[_unit, _sound] remoteExec ["say3d"];
		};

		[{
			params ["_unit"];
			[_unit ,'gm_p1_blk',7] call BIS_fnc_addWeapon;

		}, [_unit], random 2 + 2] call CBA_fnc_WaitAndExecute;
		
		_unit setBehaviour "AWARE";

	}, [_unit], random 1 + 1] call CBA_fnc_WaitAndExecute;

},[_unit]] call CBA_fnc_waitUntilAndExecute;