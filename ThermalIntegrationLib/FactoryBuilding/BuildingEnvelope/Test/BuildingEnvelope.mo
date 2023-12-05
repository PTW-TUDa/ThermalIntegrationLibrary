within ThermalIntegrationLib.FactoryBuilding.BuildingEnvelope.Test;
model BuildingEnvelope

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor hallInsideAtmosphere(C=C, T(start=293.15, fixed=true)) annotation (Placement(transformation(extent={{50,0},{70,20}})));
  parameter SI.HeatCapacity C=30*20*11*1.2*1.1 "Heat capacity of element (= cp*m)";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Roof roof(redeclare Examples.Records.ETA_TechnicalConfiguration_Roof deviceData) annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Wall wall(redeclare Examples.Records.ETA_TechnicalConfiguration_GlasFacade deviceData) annotation (Placement(transformation(extent={{-10,22},{10,42}})));
  Floor floor1(redeclare Examples.Records.ETA_TechnicalConfiguration_Floor deviceData) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature1
                                                                                    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=20,
    freqHz=1/(3600*24),
    offset=293.15) annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=5,
    freqHz=1/(3600*24),
    offset=293.15) annotation (Placement(transformation(extent={{-92,-50},{-72,-30}})));
  Wall wall1(redeclare Examples.Records.ETA_TechnicalConfiguration_Walls deviceData) annotation (Placement(transformation(extent={{-10,46},{10,66}})));
  Wall wall2(redeclare Examples.Records.ETA_TechnicalConfiguration_Walls deviceData) annotation (Placement(transformation(extent={{-10,-2},{10,18}})));
  Wall wall3(redeclare Examples.Records.ETA_TechnicalConfiguration_GlasFacade deviceData) annotation (Placement(transformation(extent={{-10,-26},{10,-6}})));
equation
  connect(prescribedTemperature.port, roof.Outside) annotation (Line(points={{-40,0},{-20,0},{-20,80},{-10,80}}, color={191,0,0}));
  connect(roof.Inside, hallInsideAtmosphere.port) annotation (Line(points={{10,80},{20,80},{20,0},{60,0}}, color={191,0,0}));
  connect(wall.Inside, hallInsideAtmosphere.port) annotation (Line(points={{10,32},{20,32},{20,0},{60,0}}, color={191,0,0}));
  connect(prescribedTemperature.port, wall.Outside) annotation (Line(points={{-40,0},{-20,0},{-20,32},{-10,32}}, color={191,0,0}));
  connect(sine.y, prescribedTemperature.T) annotation (Line(points={{-71,0},{-62,0}}, color={0,0,127}));
  connect(prescribedTemperature1.port, floor1.Outside) annotation (Line(points={{-40,-40},{-10,-40}}, color={191,0,0}));
  connect(floor1.Inside, hallInsideAtmosphere.port) annotation (Line(points={{10,-40},{20,-40},{20,0},{60,0}}, color={191,0,0}));
  connect(sine1.y, prescribedTemperature1.T) annotation (Line(points={{-71,-40},{-62,-40}}, color={0,0,127}));
  connect(prescribedTemperature.port, wall1.Outside) annotation (Line(points={{-40,0},{-20,0},{-20,56},{-10,56}}, color={191,0,0}));
  connect(wall1.Inside, hallInsideAtmosphere.port) annotation (Line(points={{10,56},{20,56},{20,0},{60,0}}, color={191,0,0}));
  connect(prescribedTemperature.port, wall2.Outside) annotation (Line(points={{-40,0},{-20,0},{-20,8},{-10,8}}, color={191,0,0}));
  connect(wall2.Inside, hallInsideAtmosphere.port) annotation (Line(points={{10,8},{20,8},{20,0},{60,0}}, color={191,0,0}));
  connect(prescribedTemperature.port, wall3.Outside) annotation (Line(points={{-40,0},{-20,0},{-20,-16},{-10,-16}}, color={191,0,0}));
  connect(wall3.Inside, hallInsideAtmosphere.port) annotation (Line(points={{10,-16},{20,-16},{20,0},{60,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{100,100},{-100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{50,-46},{78,-100}}, lineColor={28,108,200}),
        Rectangle(extent={{-80,80},{-40,40}}, lineColor={28,108,200}),
        Rectangle(extent={{-20,80},{20,40}}, lineColor={28,108,200}),
        Rectangle(extent={{40,80},{80,40}}, lineColor={28,108,200}),
        Rectangle(extent={{-80,20},{80,-20}}, lineColor={28,108,200}),
        Rectangle(extent={{-80,-40},{20,-60}}, lineColor={28,108,200})}),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=18000, __Dymola_Algorithm="Dassl"));
end BuildingEnvelope;
