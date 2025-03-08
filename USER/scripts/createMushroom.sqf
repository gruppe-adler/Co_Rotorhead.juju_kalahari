params ["_smallmush", "_scale"];

private _pos = getPosASL _smallmush;
private _type = typeOf _smallmush;
deleteVehicle _smallmush;

_pos set [2, _pos#2+_scale*0.05];
private _globalSimpleObject = createSimpleObject [_type, _pos, false]; 
_globalSimpleObject setObjectScale _scale;
