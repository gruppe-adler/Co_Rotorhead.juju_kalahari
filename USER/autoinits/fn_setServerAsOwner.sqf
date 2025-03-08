if (!isServer) exitWith {};

["GRAD_missionControl_setServerAsOwner", {

	params ["_group"];

	_group setGroupOwner 2;

}] call CBA_fnc_addEventhandler;




["GRAD_missionControl_drugVictim", {

	params ["_position", "_isBoss"];

	private _unit = createAgent ["UK3CB_ADC_O_CIV_CHR", ASLtoAGL _position, [], 0,  "NONE" ];
	[_unit, _isBoss] execvm "user\scripts\addCockhat.sqf";

}] call CBA_fnc_addEventhandler;
