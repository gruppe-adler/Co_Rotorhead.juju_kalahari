params ["_helper"];

//While you can add "HitPart" handler to a remote unit, the respective addEventHandler command must be executed on the shooter's PC and will only fire on shooter's PC as well. 
_helper addEventHandler ["HitPart", {
  (_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
  
  private _pos = getPos _target;
  deleteVehicle (_target getVariable ["soundSource", objNull]);
  _target setVariable ['grad_music_destroyed', true, true];

  [_target] remoteExecCall ["grad_ambient_fnc_brokenRadio", 0];

  _target removeEventHandler ["HitPart", _thisEventhandler]; // removes once per shooter, not critical to have them all deleted at once

}];

private _parentObject = _helper getVariable ["grad_music_parent", objNull];

_parentObject addAction
[
	"Turn On Radio",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; // script

    private _helper = _target getVariable ["grad_music_child", objNull];
    if (!isNull _helper) then {
      private _source = (_helper getVariable ["soundSource", objNull]);
      if (!isNull _source) then {
        // prevent double sound just in case, should never happen
        deleteVehicle _source;
      };
      private _music = _target getVariable ["grad_music", ""];
      private _source = createSoundSource [_music, getPos _target, [], 0];
      _target setVariable ["soundSource", _source, true];
      _target setVariable ["grad_music_active", true, true];
    };

	},
	nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"(_this == driver _target || !(_target isKindOf 'LandVehicle')) && !(_target getVariable ['grad_music_active', false]) && !(_target getVariable ['grad_music_destroyed', false])",		// condition
	3,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];

_parentObject addAction
[
	"Turn off Radio",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; // script

    private _helper = _target getVariable ["grad_music_child", objNull];
    if (!isNull _helper) then {
      private _source = (_helper getVariable ["soundSource", objNull]);
      if (!isNull _source) then {
        deleteVehicle _source;
        _target setVariable ["grad_music_active", false, true];
      };
    };

	},
	nil,		// arguments
	1.5,		// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"(_this == driver _target || !(_target isKindOf 'LandVehicle')) && _target getVariable ['grad_music_active', false] && !(_target getVariable ['grad_music_destroyed', false])",		// condition
	3,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];