within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal.TechnicalConfiguration;
package BaseClasses
  record TechnicalConfiguration_base

    parameter Modelica.SIunits.Mass m_batch "Mass of batch" annotation(Dialog(tab = "Batch", group = "Batch"));
    parameter Modelica.SIunits.HeatCapacity c_batch "Heat capacity of batch" annotation(Dialog(tab = "Batch", group = "Batch"));

    parameter Modelica.SIunits.Mass m_rack "Mass of batching rack" annotation(Dialog(tab = "Batch", group = "Batching rack"));
    parameter Modelica.SIunits.HeatCapacity c_rack "Heat capacity of batching rack" annotation(Dialog(tab = "Batch", group = "Batching rack"));

    parameter Modelica.SIunits.Power P_heat "Electrical power of tank heating" annotation(Dialog(tab = "Tanks", group = "Heating"));
    parameter Real eta_heat "Efficiency factor of electrical heating (0-1)" annotation(Dialog(tab = "Tanks", group = "Heating"));
    parameter Modelica.SIunits.Temperature T_req "Working temperature of cleaning fluid" annotation(Dialog(tab = "Tanks", group = "Heating"));
    parameter Modelica.SIunits.Temperature T_lim "Minimum temperature of cleaning fluid" annotation(Dialog(tab = "Tanks", group = "Heating"));

    parameter Modelica.SIunits.Mass m_t1 "Mass of cleaning fluid" annotation(Dialog(tab = "Tanks", group = "Tank parameters"));
    parameter Modelica.SIunits.Area A_t1 "Surface area of tank" annotation(Dialog(tab = "Tanks", group = "Tank parameters"));
    parameter Modelica.SIunits.SpecificHeatCapacity c_fluid "Heat capacity of cleaning fluid" annotation(Dialog(tab = "Tanks", group = "Tank parameters"));

    parameter Modelica.SIunits.Length d_ins "Thickness insulation" annotation(Dialog(tab = "Insulation"));
    parameter Modelica.SIunits.ThermalConductivity lambda_ins "Thermal conductivity insulation" annotation(Dialog(tab = "Insulation"));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end TechnicalConfiguration_base;
end BaseClasses;
