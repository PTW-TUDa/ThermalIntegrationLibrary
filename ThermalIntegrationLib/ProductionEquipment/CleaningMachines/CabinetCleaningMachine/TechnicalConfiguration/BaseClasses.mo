within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.CabinetCleaningMachine.TechnicalConfiguration;
package BaseClasses
  record TechnicalConfiguration_base

    parameter Modelica.Units.SI.Mass m_batch "Mass of batch" annotation (Dialog(tab="Batch", group="Batch"));
    parameter Modelica.Units.SI.HeatCapacity c_batch "Heat capacity of batch" annotation (Dialog(tab="Batch", group="Batch"));

    parameter Modelica.Units.SI.Mass m_rack "Mass of batching rack" annotation (Dialog(tab="Batch", group="Batching rack"));
    parameter Modelica.Units.SI.HeatCapacity c_rack "Heat capacity of batching rack" annotation (Dialog(tab="Batch", group="Batching rack"));

    parameter Modelica.Units.SI.Power P_heat "Electrical power of tank heating" annotation (Dialog(tab="Tanks", group="Heating"));
    parameter Real eta_heat "Efficiency factor of electrical heating (0-1)" annotation(Dialog(tab = "Tanks", group = "Heating"));
    parameter Modelica.Units.SI.Temperature T_req "Working temperature of cleaning fluid" annotation (Dialog(tab="Tanks", group="Heating"));
    parameter Modelica.Units.SI.Temperature T_lim "Minimum temperature of cleaning fluid" annotation (Dialog(tab="Tanks", group="Heating"));

    parameter Modelica.Units.SI.Mass m_t1 "Mass of cleaning fluid" annotation (Dialog(tab="Tanks", group="Tank parameters"));
    parameter Modelica.Units.SI.Area A_t1 "Surface area of tank" annotation (Dialog(tab="Tanks", group="Tank parameters"));
    parameter Modelica.Units.SI.SpecificHeatCapacity c_fluid "Heat capacity of cleaning fluid" annotation (Dialog(tab="Tanks", group="Tank parameters"));

    parameter Modelica.Units.SI.Length d_ins "Thickness insulation" annotation (Dialog(tab="Insulation"));
    parameter Modelica.Units.SI.ThermalConductivity lambda_ins "Thermal conductivity insulation" annotation (Dialog(tab="Insulation"));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end TechnicalConfiguration_base;
end BaseClasses;
