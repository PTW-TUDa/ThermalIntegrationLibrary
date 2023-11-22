within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TechnicalConfiguration;
package BaseClasses
  record TechnicalConfiguration_base

    parameter Modelica.SIunits.Mass m_batch "Mass of batch in kg" annotation(Dialog(tab = "Batch"));
    parameter Modelica.SIunits.HeatCapacity c_batch "Heat capacity of batch in J/K" annotation(Dialog(tab = "Batch"));

    parameter Modelica.SIunits.Temperature T_heat "Temperature level of heat network in °C" annotation(Dialog(tab = "Tanks", group = "Heating"));
    parameter Modelica.SIunits.Temperature T_req "Working temperature in °C" annotation(Dialog(tab = "Tanks", group = "Heating"));
    parameter Modelica.SIunits.Temperature T_lim "Limit temperature in °C" annotation(Dialog(tab = "Tanks", group = "Heating"));
    parameter Modelica.SIunits.Mass m_t1 "Mass of fluid tank 1 in kg" annotation(Dialog(tab = "Tanks", group = "Tank parameters"));
    parameter Modelica.SIunits.Area A_t1 "Surface area of tank 1 in m^2" annotation(Dialog(tab = "Tanks", group = "Tank parameters"));
    parameter Modelica.SIunits.Mass m_t2 "Mass of fluid tank 2 in kg" annotation(Dialog(tab = "Tanks", group = "Tank parameters"));
    parameter Modelica.SIunits.Area A_t2 "Surface area of tank 2 in m^2" annotation(Dialog(tab = "Tanks", group = "Tank parameters"));
    parameter Modelica.SIunits.HeatCapacity c_fluid "Heat capacity of fluid " annotation(Dialog(tab = "Tanks", group = "Tank parameters"));
    parameter Modelica.SIunits.Area A_tt "Surface area of wall between tanks in m^2" annotation(Dialog(tab = "Tanks", group = "Tank parameters"));

    parameter Modelica.SIunits.Length d_ins "Thickness insulation in m" annotation(Dialog(tab = "Insulation"));
    parameter Modelica.SIunits.ThermalConductivity lambda_ins "Thermal conductivity insulation in W/mK" annotation(Dialog(tab = "Insulation"));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end TechnicalConfiguration_base;
end BaseClasses;
