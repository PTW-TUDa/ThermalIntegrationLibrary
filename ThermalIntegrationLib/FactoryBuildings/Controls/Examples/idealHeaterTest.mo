within ThermalIntegrationLib.FactoryBuildings.Controls.Examples;
model idealHeaterTest
  extends Modelica.Icons.Example;
    /*maxHeatingPower=Modelica.Constants.inf,
    maxCoolingPower=Modelica.Constants.inf,*/
  Modelica.Blocks.Sources.Sine sine(
    amplitude=2000,
    freqHz=1/(24*3600),
    offset=0)  annotation (Placement(transformation(extent={{-86,-28},{-66,-8}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 26)
                                                              annotation (Placement(transformation(extent={{-44,-74},{-24,-54}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=273.15 + 19)
                                                              annotation (Placement(transformation(extent={{-32,-92},{-12,-72}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation (Placement(transformation(extent={{70,68},{90,88}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=5,
    width=50,
    period(displayUnit="h") = 86400,
    offset=293.15,
    startTime(displayUnit="h") = 28800) annotation (Placement(transformation(extent={{-86,6},{-66,26}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=100000,
    duration(displayUnit="h") = 18000,
    offset=283.15,
    startTime(displayUnit="h") = 28800) annotation (Placement(transformation(extent={{-88,40},{-68,60}})));
  Modelica.Blocks.Sources.Trapezoid setTemperature_heating(
    amplitude=2,
    rising(displayUnit="h") = 0,
    width(displayUnit="h") = 28800,
    falling(displayUnit="h") = 0,
    period(displayUnit="h") = 86400,
    offset=291.15,
    startTime(displayUnit="h") = 28800) annotation (Placement(transformation(extent={{-46,0},{-26,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression annotation (Placement(transformation(extent={{32,34},{52,54}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1000*1e3*1.2, T(start=293.15))
                                                                                           annotation (Placement(transformation(extent={{74,34},{94,54}})));
  Modelica.Blocks.Sources.Constant const(k=293.15) annotation (Placement(transformation(extent={{-90,-62},{-70,-42}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Blocks.Sources.BooleanPulse coolingPeriod(
    width=50,
    period(displayUnit="d") = 31536000,
    startTime(displayUnit="d") = 10368000) annotation (Placement(transformation(extent={{-38,54},{-18,74}})));
  Modelica.Blocks.Sources.Trapezoid setTemperatureCooling(
    amplitude=2,
    rising(displayUnit="h") = 0,
    width(displayUnit="h") = 28800,
    falling(displayUnit="h") = 0,
    period(displayUnit="h") = 86400,
    offset=295.15,
    startTime(displayUnit="h") = 28800) annotation (Placement(transformation(extent={{-46,-42},{-26,-22}})));
  ThermalIntegrationLib.FactoryBuildings.Controls.semi_idealHeater idealHeater2_1(k=1000*1e3*1.2)
                                                                                  annotation (Placement(transformation(extent={{-2,-20},{18,0}})));
equation
  connect(heatCapacitor.port, temperatureSensor.port) annotation (Line(points={{84,34},{78,34},{78,30},{64,30},{64,78},{70,78}},           color={191,0,0}));
  connect(prescribedHeatFlow.port, heatCapacitor.port) annotation (Line(points={{10,80},{64,80},{64,30},{78,30},{78,34},{84,34}},           color={191,0,0}));
  connect(sine.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-65,-18},{-52,-18},{-52,80},{-10,80}}, color={0,0,127}));
  connect(temperatureSensor.T, idealHeater2_1.actTemperature) annotation (Line(points={{90,78},{98,78},{98,4},{-10,4},{-10,-4.6},{-4,-4.6}},
                                                                                                                                         color={0,0,127}));
  connect(idealHeater2_1.port_b, heatCapacitor.port) annotation (Line(points={{18.4,-10},{24,-10},{24,28},{64,28},{64,30},{78,30},{78,34},{84,34}},
                                                                                                                                                  color={191,0,0}));
  connect(idealHeater2_1.T_max, realExpression1.y) annotation (Line(points={{-4,-12.8},{-16,-12.8},{-16,-64},{-23,-64}}, color={0,0,127}));
  connect(idealHeater2_1.T_min, realExpression2.y) annotation (Line(points={{-4,-17.2},{-10,-17.2},{-10,-68},{-4,-68},{-4,-82},{-11,-82}}, color={0,0,127}));
  annotation (experiment(
      StopTime=604800,
      __Dymola_fixedstepsize=1800,
      __Dymola_Algorithm="Cvode"));
end idealHeaterTest;
