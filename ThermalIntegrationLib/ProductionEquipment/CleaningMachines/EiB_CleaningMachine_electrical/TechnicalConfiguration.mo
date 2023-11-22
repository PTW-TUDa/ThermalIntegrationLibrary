within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_electrical;
package TechnicalConfiguration
  package BaseClasses
    record TechnicalConfiguration_base

      parameter Modelica.SIunits.Mass m_batch "Mass of batch in kg" annotation(Dialog(tab = "Batch"));
      parameter Modelica.SIunits.HeatCapacity c_batch "Heat capacity of batch in J/K" annotation(Dialog(tab = "Batch"));

      parameter Modelica.SIunits.Power P_heat "Power of tank heating in kW" annotation(Dialog(tab = "Tanks", group = "Heating"));
      parameter Modelica.SIunits.Temperature T_req "Working temperature in °C" annotation(Dialog(tab = "Tanks", group = "Heating"));
      parameter Modelica.SIunits.Temperature T_lim "Limit temperature in °C" annotation(Dialog(tab = "Tanks", group = "Heating"));
      parameter Modelica.SIunits.Mass m_t1 "Mass of fluid tank 1 in kg" annotation(Dialog(tab = "Tanks", group = "Tanks"));
      parameter Modelica.SIunits.Area A_t1 "Surface area of tank 1 in m^2" annotation(Dialog(tab = "Tanks", group = "Tanks"));
      parameter Modelica.SIunits.Mass m_t2 "Mass of fluid tank 2 in kg" annotation(Dialog(tab = "Tanks", group = "Tanks"));
      parameter Modelica.SIunits.Area A_t2 "Surface area of tank 2 in m^2" annotation(Dialog(tab = "Tanks", group = "Tanks"));
      parameter Modelica.SIunits.HeatCapacity c_fluid "Heat capacity of fluid " annotation(Dialog(tab = "Tanks", group = "Tanks"));
      parameter Modelica.SIunits.Area A_tt "Surface area of wall between tanks in m^2" annotation(Dialog(tab = "Tanks", group = "Tanks"));

      parameter Modelica.SIunits.Length d_ins "Thickness insulation in m" annotation(Dialog(tab = "Insulation"));
      parameter Modelica.SIunits.ThermalConductivity lambda_ins "Thermal conductivity insulation in W/mK" annotation(Dialog(tab = "Insulation"));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end TechnicalConfiguration_base;
  end BaseClasses;

  record TechnicalConfiguration_a
    extends BaseClasses.TechnicalConfiguration_base(
    m_batch = 50,
    c_batch = 0.477,
    P_heat = 10,
    T_req = 343.15,
    T_lim = 341.15,
    m_t1 = 540,
    A_t1 = 2.49138,
    m_t2 = 280,
    A_t2 = 1.7444,
    c_fluid = 4.19,
    A_tt = 0.551,
    d_ins = 0.21,
    lambda_ins = 0.04);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end TechnicalConfiguration_a;
end TechnicalConfiguration;
