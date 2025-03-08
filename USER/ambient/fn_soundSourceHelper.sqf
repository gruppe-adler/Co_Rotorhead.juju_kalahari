params ["_source", "_sound", "_positionOrObject", ["_createDummy", true]];

private _posFinal = _positionOrObject;

if (!_createDummy) then {
    _posFinal = getPos _positionOrObject;
    // systemChat "isObject";
};

private _helper = _positionOrObject;

if (_createDummy) then {
    _helper = "Sign_Sphere25cm_Geometry_F" createVehicle [0,0,0];
    _helper setPos _posFinal;
    _helper setObjectTextureGlobal [0,"#(argb,8,8,3)color(0,0,0,0,ca)"];
    _helper setVariable ["soundSource", _source, true];
} else {
    _helper setVariable ["soundSource", _source, true];
};

_positionOrObject setVariable ["grad_music_child", _helper, true];
_helper setVariable ["grad_music_parent", _positionOrObject, true];
_positionOrObject setVariable ["grad_music", _sound, true];
_positionOrObject setVariable ["grad_music_active", true, true];


{
    _x addCuratorEditableObjects [[_helper], false];
} forEach allCurators;

_helper addEventHandler ["Deleted", {
  params ["_entity"];
  deleteVehicle (_entity getVariable ["soundSource", objNull]);
}];

[_helper] remoteExec ["grad_ambient_fnc_hitPart", 0, true];

if (!_createDummy) then {
    _helper addMPEventHandler ["MPKilled", {
        params ["_entity"];
        deleteVehicle (_entity getVariable ["soundSource", objNull]);
    }];

    [{
        params ["_args", "_handle"];
        _args params ["_helper", "_positionOrObject", "_source"];

        if (isNull _helper || !alive _helper) exitWith {
            [_handle] call CBA_fnc_removePerFrameHandler;
        };

        // we cant be sure the source is not toggled off atm
        private _source = _helper getVariable ["soundSource", objNull];
        if (!isNull _source) then {
            _source setPos getPos _positionOrObject;
        };

    },0.5,[_helper, _positionOrObject, _source]] call CBA_fnc_addPerFrameHandler;
};

_helper