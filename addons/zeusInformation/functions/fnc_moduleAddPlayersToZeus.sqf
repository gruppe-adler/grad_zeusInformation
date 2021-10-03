#include "script_component.hpp"

params ["_logic", "", "_activated"];

if !(_activated && {local _logic}) exitWith {};

deleteVehicle _logic;

[getAssignedCuratorLogic player] remoteExec [QFUNC(moduleAddPlayersToZeusServer), 2, false];
