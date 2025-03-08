/*
*   Wird zum Missionsstart auf Server und Clients ausgeführt.
*   Funktioniert wie die init.sqf.
*/

if (isServer) then {

	addMissionEventHandler ["BuildingChanged", {
		params ["_from", "_to", "_isRuin"];

		if (_isRuin && _from isKindOf "Land_Greenhouse_01_F") then {
			private _pos = getPos _from;
			private _fire = "test_EmptyObjectForFireBig" createVehicle _pos;
			_fire setPos _pos;

			private _mushrooms = nearestObjects [_pos, ["CUP_clutter_mochomurka"], 5];
			{ deleteVehicle _x; } forEach _mushrooms;
		};
	}];

};