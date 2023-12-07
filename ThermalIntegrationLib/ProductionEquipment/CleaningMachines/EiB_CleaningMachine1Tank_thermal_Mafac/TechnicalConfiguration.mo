within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal_Mafac;
package TechnicalConfiguration

  package BaseClasses
    record TechnicalConfiguration_base

      parameter Modelica.Units.SI.Mass m_batch "Mass of batch" annotation (Dialog(tab="Batch", group="Batch"));
      parameter Modelica.Units.SI.HeatCapacity c_batch "Heat capacity of batch" annotation (Dialog(tab="Batch", group="Batch"));

      parameter Modelica.Units.SI.Mass m_rack "Mass of batching rack" annotation (Dialog(tab="Batch", group="Batching rack"));
      parameter Modelica.Units.SI.HeatCapacity c_rack "Heat capacity of batching rack" annotation (Dialog(tab="Batch", group="Batching rack"));

      parameter Modelica.Units.SI.Temperature T_req "Working temperature of cleaning fluid" annotation (Dialog(tab="Tanks", group="Heating control"));
      parameter Modelica.Units.SI.Temperature T_lim "Minimum temperature of cleaning fluid" annotation (Dialog(tab="Tanks", group="Heating control"));

      parameter Modelica.Units.SI.Mass m_t1 "Mass of cleaning fluid tank 1" annotation (Dialog(tab="Tanks", group="Tank parameters"));
      parameter Modelica.Units.SI.Area A_t1 "Surface area of tank 1" annotation (Dialog(tab="Tanks", group="Tank parameters"));
      parameter Modelica.Units.SI.SpecificHeatCapacity c_fluid "Heat capacity of cleaning fluid" annotation (Dialog(tab="Tanks", group="Tank parameters"));

      parameter Real pct_oil_sep "Percentage of the process time for activating the oil separator (0-1)" annotation(Dialog(tab = "Units"));
      parameter Real Q_waste_heat "Estimated waste heat of all units except tank heating in W (engines, control cabinet, aggregates, etc.)" annotation(Dialog(tab = "Units"));

      parameter Modelica.Units.SI.Length d_ins "Thickness insulation" annotation (Dialog(tab="Insulation"));
      parameter Modelica.Units.SI.ThermalConductivity lambda_ins "Thermal conductivity insulation" annotation (Dialog(tab="Insulation"));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end TechnicalConfiguration_base;
  end BaseClasses;

  record TechnicalConfiguration_a

    extends BaseClasses.TechnicalConfiguration_base(
    m_batch = 50,
    c_batch = 0.477,
    m_rack = 132,
    c_rack = 0.477,
    T_req = 343.15,
    T_lim = 341.15,
    m_t1 = 540,
    A_t1 = 2.49138,
    c_fluid = 4186,
    pct_oil_sep = 0.5,
    Q_waste_heat = 100,
    d_ins = 0.021,
    lambda_ins = 0.04);

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end TechnicalConfiguration_a;
end TechnicalConfiguration;
