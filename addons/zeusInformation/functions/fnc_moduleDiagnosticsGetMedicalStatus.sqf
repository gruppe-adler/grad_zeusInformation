#include "script_component.hpp"

params [["_unit",objNull]];


//dead
if (!alive _unit) exitWith {
    ["dead"]
};

private _status = [];


//unconscious
private _downSince = _unit getVariable [QGVAR(downSince),-1];
if (_downSince > 0) then {
    private  _downTime = CBA_missionTime - _downSince;
    private  _downTimeText = format ([["%1s", round _downTime], ["%1min", round (_downTime/60)]] select (_downTime > 60));
    _status pushBack (format ["%1 %2", localize LSTRING(downFor), _downTimeText]);
};


//injured
private _bodyPartNames = [
    localize LSTRING(head),
    localize LSTRING(body),
    localize LSTRING(leftArm),
    localize LSTRING(rightArm),
    localize LSTRING(leftLeg),
    localize LSTRING(rightLeg)
];
private _injuredBodyParts = [];
{
    if (_x > 0) then {
        _injuredBodyParts pushBack (_bodyPartNames select _forEachIndex);
    };
} forEach (_unit getVariable ["ace_medical_bodyPartStatus", [0,0,0,0,0,0]]);

if (count _injuredBodyParts > 0) then {
    _status pushBack (format ["%1 %2", (_injuredBodyParts joinString ", "), localize LSTRING(injuredBodyPart)]);
};


//blood
private _bloodVolume = _unit getVariable ["ace_medical_bloodVolume",6];
if (_bloodVolume < 6) then {
    _status pushBack (format ["%1%2 blood", round (_bloodVolume/6 * 100),"%"]);
};


_status
