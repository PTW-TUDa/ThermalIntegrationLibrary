within ThermalIntegrationLib.FactoryBuilding.BuildingElements;
model FactoryBuilding

  //parameter
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor hallInsideAtmosphere(C=500000, T(start=293.15, fixed=true))
                                                                                                                annotation (Placement(transformation(extent={{30,14},{50,34}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(extent={{-56,22},{-36,42}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature1 annotation (Placement(transformation(extent={{-54,-50},{-34,-30}})));

  Roof roof(redeclare Examples.Records.ETA_TechnicalConfiguration_Roof deviceData) annotation (Placement(transformation(extent={{-24,70},{-4,90}})));
  Wall wall(redeclare Examples.Records.ETA_TechnicalConfiguration_GlasFacade deviceData) annotation (Placement(transformation(extent={{-24,46},{-4,66}})));
  Wall wall1(redeclare Examples.Records.ETA_TechnicalConfiguration_Walls deviceData) annotation (Placement(transformation(extent={{-24,22},{-4,42}})));
  Wall wall2(redeclare Examples.Records.ETA_TechnicalConfiguration_Walls deviceData) annotation (Placement(transformation(extent={{-24,-2},{-4,18}})));
  Wall wall3(redeclare Examples.Records.ETA_TechnicalConfiguration_GlasFacade deviceData) annotation (Placement(transformation(extent={{-24,-26},{-4,-6}})));
  Floor floor(redeclare Examples.Records.ETA_TechnicalConfiguration_Floor deviceData) annotation (Placement(transformation(extent={{-24,-50},{-4,-30}})));


  Modelica.Blocks.Sources.Sine FloorTemperature(
    amplitude=10,
    f=1/(60*60*24*365*2),
    offset=288.15) annotation (Placement(transformation(extent={{-92,-50},{-72,-30}})));
  Modelica.Blocks.Sources.Sine OutsideTemperature(
    amplitude=10,
    f=1/(24*3600),
    offset=288.15) annotation (Placement(transformation(extent={{-92,22},{-72,42}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={38,56})));
  Modelica.Thermal.HeatTransfer.Celsius.TemperatureSensor Temperature annotation (Placement(transformation(extent={{52,2},{64,14}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={70,56})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=1) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={56,56})));
  Modelica.Blocks.Sources.RealExpression TargetTemperatureInside(y=20) annotation (Placement(transformation(
        extent={{-8,-10},{8,10}},
        rotation=180,
        origin={88,56})));

  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor annotation (Placement(transformation(extent={{12,62},{24,50}})));
  Modelica.Blocks.Interfaces.RealOutput insideRoomTemperature "Absolute temperature in degree Celsius as output signal" annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput outsideTemperature "Connector of Real output signal" annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow "Heat flow from port_a to port_b as output signal" annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin annotation (Placement(transformation(extent={{80,-26},{92,-14}})));
equation


  connect(prescribedTemperature.port, roof.Outside) annotation (Line(points={{-36,32},{-28,32},{-28,80},{-24,80}},
                                                                                                                 color={191,0,0}));
  connect(roof.Inside, hallInsideAtmosphere.port) annotation (Line(points={{-4,80},{6,80},{6,8},{40,8},{40,14}},
                                                                                                           color={191,0,0}));
  connect(wall.Inside, hallInsideAtmosphere.port) annotation (Line(points={{-4,56},{6,56},{6,8},{40,8},{40,14}},
                                                                                                           color={191,0,0}));
  connect(prescribedTemperature.port, wall.Outside) annotation (Line(points={{-36,32},{-28,32},{-28,56},{-24,56}},
                                                                                                                 color={191,0,0}));
  connect(prescribedTemperature.port, wall1.Outside) annotation (Line(points={{-36,32},{-24,32}},                 color={191,0,0}));
  connect(wall1.Inside, hallInsideAtmosphere.port) annotation (Line(points={{-4,32},{6,32},{6,8},{40,8},{40,14}},
                                                                                                            color={191,0,0}));
  connect(prescribedTemperature.port, wall2.Outside) annotation (Line(points={{-36,32},{-28,32},{-28,8},{-24,8}},
                                                                                                                color={191,0,0}));
  connect(wall2.Inside, hallInsideAtmosphere.port) annotation (Line(points={{-4,8},{40,8},{40,14}},       color={191,0,0}));
  connect(prescribedTemperature.port, wall3.Outside) annotation (Line(points={{-36,32},{-28,32},{-28,-16},{-24,-16}},
                                                                                                                    color={191,0,0}));
  connect(wall3.Inside, hallInsideAtmosphere.port) annotation (Line(points={{-4,-16},{40,-16},{40,14}},       color={191,0,0}));
  connect(prescribedTemperature1.port, floor.Outside) annotation (Line(points={{-34,-40},{-24,-40}}, color={191,0,0}));
  connect(floor.Inside, hallInsideAtmosphere.port) annotation (Line(points={{-4,-40},{40,-40},{40,14}}, color={191,0,0}));
  connect(FloorTemperature.y, prescribedTemperature1.T) annotation (Line(points={{-71,-40},{-56,-40}}, color={0,0,127}));
  connect(firstOrder.y, Heating.Q_flow) annotation (Line(points={{51.6,56},{48,56}}, color={0,0,127}));
  connect(feedback.y, firstOrder.u) annotation (Line(points={{64.6,56},{60.8,56}}, color={0,0,127}));
  connect(feedback.u1, TargetTemperatureInside.y) annotation (Line(points={{74.8,56},{79.2,56}},
                                                                                               color={0,0,127}));
  connect(Temperature.port, hallInsideAtmosphere.port) annotation (Line(points={{52,8},{40,8},{40,14}}, color={191,0,0}));
  connect(Temperature.T, feedback.u2) annotation (Line(points={{64,8},{70,8},{70,51.2}}, color={0,0,127}));
  connect(OutsideTemperature.y, prescribedTemperature.T) annotation (Line(points={{-71,32},{-58,32}},          color={0,0,127}));
  connect(Heating.port, heatFlowSensor.port_b) annotation (Line(points={{28,56},{24,56}}, color={191,0,0}));
  connect(heatFlowSensor.port_a, hallInsideAtmosphere.port) annotation (Line(points={{12,56},{6,56},{6,8},{40,8},{40,14}}, color={191,0,0}));
  connect(Temperature.T, insideRoomTemperature) annotation (Line(points={{64,8},{70,8},{70,20},{110,20}}, color={0,0,127}));
  connect(heatFlowSensor.Q_flow, Q_flow) annotation (Line(points={{18,62.6},{18,80},{110,80}}, color={0,0,127}));
  connect(OutsideTemperature.y, fromKelvin.Kelvin) annotation (Line(points={{-71,32},{-66,32},{-66,-20},{78.8,-20}}, color={0,0,127}));
  connect(fromKelvin.Celsius, outsideTemperature) annotation (Line(points={{92.6,-20},{110,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=18000, __Dymola_Algorithm="Dassl"));
end FactoryBuilding;
