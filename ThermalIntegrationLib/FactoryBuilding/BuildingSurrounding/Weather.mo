within ThermalIntegrationLib.FactoryBuilding.BuildingSurrounding;
model Weather

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a radiationSouth annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convection annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a conduction annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  Modelica.Blocks.Sources.CombiTimeTable weahterData(columns=3:size(table, 3)) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowRadiation annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowRadiation1 annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a radiationNorth annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowRadiation2 annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a radiationWest annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowRadiation3 annotation (Placement(transformation(extent={{40,90},{60,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a radiationEast annotation (Placement(transformation(extent={{90,90},{110,110}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature OutsideAirTemperature annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature OutsideGroundTemperature annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
equation
  connect(prescribedHeatFlowRadiation.port, radiationSouth) annotation (Line(points={{60,-20},{100,-20}}, color={191,0,0}));
  connect(prescribedHeatFlowRadiation1.port, radiationNorth) annotation (Line(points={{60,20},{100,20}}, color={191,0,0}));
  connect(prescribedHeatFlowRadiation2.port, radiationWest) annotation (Line(points={{60,60},{100,60}}, color={191,0,0}));
  connect(prescribedHeatFlowRadiation3.port, radiationEast) annotation (Line(points={{60,100},{100,100}}, color={191,0,0}));
  connect(weahterData.y[3], prescribedHeatFlowRadiation.Q_flow) annotation (Line(points={{-59,0},{0,0},{0,-20},{40,-20}}, color={0,0,127}));
  connect(weahterData.y[4], prescribedHeatFlowRadiation1.Q_flow) annotation (Line(points={{-59,0},{0,0},{0,20},{40,20}}, color={0,0,127}));
  connect(weahterData.y[5], prescribedHeatFlowRadiation2.Q_flow) annotation (Line(points={{-59,0},{0,0},{0,60},{40,60}}, color={0,0,127}));
  connect(weahterData.y[6], prescribedHeatFlowRadiation3.Q_flow) annotation (Line(points={{-59,0},{0,0},{0,100},{40,100}}, color={0,0,127}));
  connect(OutsideAirTemperature.port, convection) annotation (Line(points={{60,-60},{100,-60}}, color={191,0,0}));
  connect(OutsideAirTemperature.T, weahterData.y[2]) annotation (Line(points={{38,-60},{0,-60},{0,0},{-59,0}}, color={0,0,127}));
  connect(OutsideGroundTemperature.port, conduction) annotation (Line(points={{60,-100},{80,-100},{80,-100},{100,-100}}, color={191,0,0}));
  connect(OutsideGroundTemperature.T, weahterData.y[1]) annotation (Line(points={{38,-100},{0,-100},{0,0},{-59,0}}, color={0,0,127}));
end Weather;
