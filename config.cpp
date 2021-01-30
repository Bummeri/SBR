class CfgPatches
{
	class SBR
	{
		units[] = {"SBR_ModuleSBRInit"};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F","3DEN","cba_main","cba_xeh","cba_settings","ace_main"};
	};
};

class CfgFactionClasses
{
	class Respawn;
	class SBR : Respawn
	{
		displayName = "SBR";
		priority = 2;
        side = 7;
	};
};

class CfgFunctions
{
	class Bum
	{
		class SBR
		{
			file = "x\Bum\addons\SBR\functions";
			class addGear{};
			class enablePlayableUnitState{};
			class InitUnitServer{};
			class moduleSBRInit{};
			class initPlayer{};
			class initPlayerUnit{};
			class handleJipPlayer{};
			class handleJipToReservedSlot{};
			class handleJipToWrongSlot{};
			class findReservedSlot{};
			class jipIntegration{};
			class setUnconsciousness{};
			class updateSectionUnitList{};
			class triggerSBRForUnit{};
		};
	};
};

class Cfg3DEN
{
    // Configuration of all objects
    class Object
    {
        // Categories collapsible in "Edit Attributes" window
        class AttributeCategories
        {
            // Category class, can be anything
            class SBR_objectAttributes
            {
                displayName = "SBR object Attributes"; // Category name visible in Edit Attributes window
                collapsed = 1; // When 1, the category is collapsed by default
                class Attributes
                {
                    class SBR_respawnSection
                    {
                        displayName = "Respawn Section";
                        tooltip = "Define the SBR section this unit belongs to";
                        property = "SBR_unitRespawnSection";
                        control = "Edit";
                        expression = "_this setVariable ['%s',_value,true]";
                        defaultValue = "''";
                        unique = 0;
						typeName = "STRING";
                        condition = "objectControllable";
                    };
					class SBR_gearVariable
                    {
                        displayName = "Gear Variable";
                        tooltip = "Define the SBR gear variable for this unit";
                        property = "SBR_unitGearVariable";
                        control = "Edit";
                        expression = "_this setVariable ['%s',_value,true];";
                        defaultValue = "(configFile >> 'CfgVehicles' >> typeOf _this >> 'displayName') call BIS_fnc_getCfgData";
                        unique = 0;
						typeName = "STRING";
                        condition = "objectControllable";
                    };
                };
            };
        };
    };
	class Notifications
	{
		class Bum_SBR_missionConfigError
		{
			text = "Description.ext is overwriting 3den editor multiplayer settings required by SBR!";
			isWarning = 1; //1 - Will display RED warning, 0 - Will display GREEN notification
		};
		class Bum_SBR_missionMarkerError
		{
			text = "You need to add SBR_WORK and Respawn markers to the mission for SBR!";
			isWarning = 1; //1 - Will display RED warning, 0 - Will display GREEN notification
		};
	};
};

class RscDisplayMainMap;
class RscStructuredText;

class RscDisplayClientGetReady: RscDisplayMainMap
{
	class controls
	{
		class SBR_anouncementText : RscStructuredText
		{
			idc = 1110;
			text = "If this doesn't disappear something didn't work in SBR as intended, try rejoining...";
			x = 0.5 * GUI_GRID_W + GUI_GRID_X;
			y = 0.15 * GUI_GRID_H + GUI_GRID_Y;
			w = 39 * GUI_GRID_W;
			h = 30 * GUI_GRID_H;
			colorBackground[] = {0, 0, 0, 1};
			style = 16;
		};
	};
};

class CfgDebriefing
{  
	class End_SBR_InvalidSlot
	{
		title = "You're in a wrong slot!";
		description = "Please switch to a free slot, or the slot reserved for you.";
	};
};

class CfgVehicles
{
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit; // Default edit box (i.e., text input field)
			class Combo; // Default combo box (i.e., drop-down menu)
			class Checkbox; // Default checkbox (returned value is Bool)
			class CheckboxNumber; // Default checkbox (returned value is Number)
			class ModuleDescription; // Module description
			class Units; // Selection of units on which the module is applied
		};
		class ModuleDescription
		{
			class Anything;
			class AnyPlayer;
			class AnyObject;
			class EmptyDetector;
			class AnyBrain;
		};
	};
	class SBR_ModuleSBRInit: Module_F
	{
		scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
		scopeCurator = 1;
		displayName = "SBR Init"; // Name displayed in the menu
		icon = ""; // Map icon. Delete this entry to use the default icon
		category = "SBR";

		// Name of function triggered once conditions are met
		function = "SBR_fnc_moduleSBRInit";
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 10;
		// 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isGlobal = 0;
		// 1 for module waiting until all synced triggers are activated
		isTriggerActivated = 0;
		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isDisposable = 1;
		// // 1 to run init function in Eden Editor as well
		is3DEN = 1;

		class ModuleDescription: ModuleDescription
		{
			description = "This module will set 3den Multiplayer settings to values to those required by SBR. Will also check for conflicts in description.ext. Will also enable the SBR system when game starts. Do not sync."; // Short description, will be formatted as structured text
			sync[] = {}; // Array of synced entities (can contain base classes)
		};
	};
};
#include "XEH.cpp"