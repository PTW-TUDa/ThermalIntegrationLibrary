within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.TechnicalConfiguration;
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

    parameter Modelica.SIunits.Mass m_t1 "Mass of cleaning fluid tank 1" annotation(Dialog(tab = "Tanks", group = "Tanks"));
    parameter Modelica.SIunits.Area A_t1 "Surface area of tank 1" annotation(Dialog(tab = "Tanks", group = "Tanks"));
    parameter Modelica.SIunits.Mass m_t2 "Mass of cleaning fluid tank 2" annotation(Dialog(tab = "Tanks", group = "Tanks"));
    parameter Modelica.SIunits.Area A_t2 "Surface area of tank 2" annotation(Dialog(tab = "Tanks", group = "Tanks"));
    parameter Modelica.SIunits.SpecificHeatCapacity c_fluid "Heat capacity of cleaning fluid" annotation(Dialog(tab = "Tanks", group = "Tanks"));
    parameter Modelica.SIunits.Area A_tt "Surface area of wall between tanks" annotation(Dialog(tab = "Tanks", group = "Tanks"));

    parameter Modelica.SIunits.Length d_ins "Thickness insulation" annotation(Dialog(tab = "Insulation"));
    parameter Modelica.SIunits.ThermalConductivity lambda_ins "Thermal conductivity insulation" annotation(Dialog(tab = "Insulation"));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end TechnicalConfiguration_base;
end BaseClasses;
