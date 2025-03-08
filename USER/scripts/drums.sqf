params ["_unit"];

if (!isServer) exitWith {};

private _sound = playSound3D [getMissionPath "user\sounds\drumLoop.ogg", _unit, false, getPosASL _unit, 1, 1, 1500];

[{
	params ["_unit", "_sound"];
	 soundParams _sound isEqualTo [] || !alive _unit
}, {
	params ["_unit", "_sound"];
	[_unit] execVM "user\scripts\drums.sqf";
},
[_unit, _sound]] call CBA_fnc_waitUntilAndExecute;


[_unit, "ApanPercMstpSnonWnonDnon_G01"] remoteExec ["switchMove"];

_unit addEventHandler ["AnimDone", {
	params ["_unit", "_anim"];
	if (!alive _unit) exitWith {};

	if (_anim != "ApanPercMstpSnonWnonDnon_G01") then {
		[_unit, "ApanPercMstpSnonWnonDnon_G01"] remoteExec ["switchMove"];
	};
}];