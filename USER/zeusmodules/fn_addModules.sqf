[] spawn {
  waitUntil {!isNull player};
  waitUntil {  time > 3 };

  {
    private _curator = _x;
    
      _curator addEventHandler ["CuratorGroupPlaced", {
          params ["", "_group"];

          { 
              _x setSkill ["aimingAccuracy", 0.3];
              _x setSkill ["aimingShake", 0.2]; 
              _x setSkill ["aimingSpeed", 0.9]; 
              _x setSkill ["endurance", 0.6]; 
              _x setSkill ["spotDistance", 1]; 
              _x setSkill ["spotTime", 0.9]; 
              _x setSkill ["courage", 1]; 
              _x setSkill ["reloadSpeed", 1]; 
              _x setSkill ["commanding", 1];
              _x setSkill ["general", 1];

          } forEach units _group;

          ["GRAD_missionControl_setServerAsOwner", [_group]] call CBA_fnc_serverEvent;
      }];

      _curator addEventHandler ["CuratorObjectPlaced", {
          params ["", "_object"];
          
          _object setSkill ["aimingAccuracy", 0.3];
          _object setSkill ["aimingShake", 0.2]; 
          _object setSkill ["aimingSpeed", 0.9]; 
          _object setSkill ["endurance", 0.6]; 
          _object setSkill ["spotDistance", 1]; 
          _object setSkill ["spotTime", 0.9]; 
          _object setSkill ["courage", 1]; 
          _object setSkill ["reloadSpeed", 1]; 
          _object setSkill ["commanding", 1];
          _object setSkill ["general", 1];

          if (_object isKindOf "CAManBase") then {
             if (count units _object == 1) then {
                 ["GRAD_missionControl_setServerAsOwner", [group _object]] call CBA_fnc_serverEvent;
             };
          } else {
             if (count crew _object > 1) then {
                 ["GRAD_missionControl_setServerAsOwner", [group (crew _object select 0)]] call CBA_fnc_serverEvent;
             };
         };

      }];

      _curator addEventHandler ["CuratorWaypointPlaced", {
            params ["_curator", "_group", "_waypointID"];

            if (!((vehicle leader _group) getVariable ["GRAD_WP_originPos", [0,0,0]] isEqualTo [0,0,0])) then {
                
                private _position = waypointPosition [_group, _waypointID];
                vehicle leader _group setVariable ["GRAD_WP_targetPos", _position, true];

                "changing target wp to " + str _position call CBA_fnc_notify;
            };
     }];

     _curator addEventHandler ["CuratorWaypointEdited", {
            params ["_curator", "_group", "_waypointID"];

            if (!((vehicle leader _group) getVariable ["GRAD_WP_originPos", [0,0,0]] isEqualTo [0,0,0])) then {
                
                private _position = waypointPosition [_group, _waypointID];
                vehicle leader _group setVariable ["GRAD_WP_targetPos", _position, true];

                "changing target wp to " + str _position call CBA_fnc_notify;
            };
     }];

  } forEach allCurators;
};


["CO Rotorhead - Drug People", "Spawn Drug Victim", {
    params ["_position", "_object"];
    
    ["GRAD_missionControl_drugVictim", [_position, false]] call CBA_fnc_serverEvent;
     
}] call zen_custom_modules_fnc_register;

["CO Rotorhead - Drug People", "Spawn Drug Victim Boss", {
    params ["_position", "_object"];
    
    ["GRAD_missionControl_drugVictim", [_position, true]] call CBA_fnc_serverEvent;
     
}] call zen_custom_modules_fnc_register;


["CO Rotorhead - Convoy", "IDAP Convoy Start", {
    params ["_position", "_object"];
    
    missionNamespace setVariable ["idap_convoy_1", true, true];
     
}] call zen_custom_modules_fnc_register;

["CO Rotorhead - El Jefe", "Spawn El Jefe", {
    params ["_position", "_object"];
    
    [[_position], "user\scripts\spawnJefe.sqf"] remoteExec ["BIS_fnc_execVM", 2];
     
}] call zen_custom_modules_fnc_register;

["CO Rotorhead - Drug People", "Fanatics ambush players", {
    params ["_position", "_object"];
    
    missionNameSpace setVariable ["grad_ambushplayers", true, true];
     
}] call zen_custom_modules_fnc_register;



["Dushmaan Taal - GRAD Leavenotes", "Spawn Note", {
          params ["_modulePosition"]; 
          private _position = ASLtoAGL _modulePosition;

          ["Example Dialog", [["EDIT", "Your text?", "string ping"]], {
			   params ["_message", "_position"]; 
                  // systemchat str _position; 
                  // systemchat (_message select 0);
			   [_position, random 360, _message select 0, ["somewhat",["cramped","EtelkaNarrowMediumPro"]]] remoteExec ["GRAD_leaveNotes_fnc_spawnNote", 2, false];
		  }, { systemchat "cancelled"; }, _position] call zen_dialog_fnc_create;        
     }
] call zen_custom_modules_fnc_register;




    

["Dushmaan Taal - End", "Create Chair Circle",
{
  params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

  _position = ASLToAGL _position;
  ["Land_CampingChair_V1_F", _position, count (PlayableUnits + switchableUnits)] call grad_zeusmodules_fnc_createChairCircle;

}] call zen_custom_modules_fnc_register;



