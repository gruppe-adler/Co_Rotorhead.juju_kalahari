params ["_unit", ["_isCock", false], ["_sound", "none"]];

if (!isServer) exitWith {};

private _type = if (_isCock) then { "\A3\animals_f_beta\chicken\Cock_F.p3d" } else { "\A3\animals_f_beta\chicken\Hen_F.p3d" };
private _cock = createSimpleObject [_type, [0,0,0]];

_cock attachTo [_unit, [-0.01,0.15,0], "pelvis", true];

private _yaw = 180; 
private _pitch = 0; 
private _roll = 0;

_cock setdir 180;
/*
_cock setVectorDirAndUp [
	[sin _yaw * cos _pitch, cos _yaw * cos _pitch, sin _pitch],
	[[sin _roll, -sin _pitch, cos _roll * cos _pitch], -_yaw] call BIS_fnc_rotateVector2D
]; 
*/

[{
	params ["_unit"];

	private _face = selectRandom ["AfricanHead_01", "AfricanHead_02", "AfricanHead_03", "TanoanHead_A3_06", "TanoanHead_A3_09"];
	[_unit, _face] remoteExec ["setFace", 0, _unit];
	
}, [_unit], 5] call CBA_fnc_waitAndExecute;


if (_isCock) exitWith {

	_unit addAction
	[
		"Dance",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"]; // script

			if (alive _caller) then {
				[_target, "Acts_Dance_01"] remoteExec ["switchMove"];
			};
		},
		nil,		// arguments
		1.5,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"_target == _this",		// condition
		50,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
	];

	_unit addAction
	[
		"Stop Dance",	// title
		{
			params ["_target", "_caller", "_actionId", "_arguments"]; // script

			if (alive _caller) then {
				[_target, ""] remoteExec ["switchMove"];
			};
		},
		nil,		// arguments
		1.5,		// priority
		true,		// showWindow
		true,		// hideOnUse
		"",			// shortcut
		"_target == _this",		// condition
		50,			// radius
		false,		// unconscious
		"",			// selection
		""			// memoryPoint
	];

};

[{
	params ["_unit"];

	[_unit, "Acts_JetsMarshallingSlow_loop"] remoteExec ["switchMove", 0];
	_unit addEventHandler ["AnimDone", {
		params ["_unit", "_anim"];

		if (alive _unit && damage _unit == 0) then {
			[_unit, "Acts_JetsMarshallingSlow_loop"] remoteExec ["switchMove", 0];
		};
	}];

}, [_unit], random 1] call CBA_fnc_waitAndExecute;

private _sound = "fly_" + _sound;
_unit setVariable ["grad_sound", _sound, true];

[{
	params ["_args", "_handle"];
	_args params ["_unit"];

	private _sound = _unit getVariable ["grad_sound", ""];
	if (_sound == "fly_none") exitWith {};
	[_unit, _sound] remoteExec ["grad_autoinit_fnc_playSoundLocal"];

}, 2, [_unit]] call CBA_fnc_addPerFrameHandler;

// Acts_JetsMarshallingSlow_loop