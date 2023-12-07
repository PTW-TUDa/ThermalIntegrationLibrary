within ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.CoolingSystem.CompressionChillers;
package BaseClasses

  model ConditionCheck
    //## PARAMETERS ##
    parameter Modelica.Units.SI.Temperature T_in_cool_min=273.15 + 10 "Minimal cool instream temperature";
    parameter Modelica.Units.SI.Temperature T_in_cool_max=273.15 + 80 "Maximal cool instream temperature";
    parameter Modelica.Units.SI.Temperature T_in_heat_min=273.15 + 10 "Minimal heat instream temperature";
    parameter Modelica.Units.SI.Temperature T_in_heat_max=273.15 + 80 "Maximal heat instream temperature";

    //## COMPONENTS ##
    Modelica.Blocks.Interfaces.RealInput u "operating point reference" annotation(Placement(transformation(extent={{-120,
              -10},{-100,10}},                                                                                                                                           rotation = 0)));

    Modelica.Blocks.Interfaces.RealOutput s_u "resulting operating point"
      annotation (Placement(transformation(extent={{100,30},{120,50}})));
    Modelica.Blocks.Interfaces.RealInput T_in_cool(final unit="K") "instream temperature" annotation (Placement(transformation(extent={{-120,
              -70},{-100,-50}},                                                                                                      rotation=0)));
    Modelica.Blocks.Interfaces.RealInput T_in_heat(final unit="K") "instream temperature" annotation (Placement(transformation(extent={{-120,50},
              {-100,70}},                                                                                                            rotation=0)));
    Modelica.Blocks.Interfaces.BooleanOutput s_dis
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  equation
  if T_in_cool < T_in_cool_min or T_in_cool > T_in_cool_max or T_in_heat < T_in_heat_min or T_in_heat > T_in_heat_max then
    s_u = 0;
    s_dis = true;
  else
    s_u=u;
    s_dis = false;
  end if;
  end ConditionCheck;
end BaseClasses;
