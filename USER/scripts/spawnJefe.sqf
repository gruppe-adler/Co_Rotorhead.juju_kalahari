params ["_position"];

private _spawnpos = ASLtoAGL _position;
private _unit = (createGroup civilian) createUnit ["UK3CB_ADC_C_FUNC", _spawnpos, [], 0, "NONE"];

[{
	_this setUnitLoadout [[],[],[],["UK3CB_TKA_I_U_Officer_OLI",[]],["UK3CB_V_Invisible_Plate",[]],[],"gm_gc_headgear_beret_orn","G_Spectacles",[],["","","","","ItemWatch","fsob_Beard01_Dark_nvg"]];
}, _unit, 3] call CBA_fnc_waitAndExecute;

[_unit, "ElJefe"] remoteExec ["setIdentity", 0, _unit];
[_unit] call ace_common_fnc_setName;
_unit setRank "MAJOR";