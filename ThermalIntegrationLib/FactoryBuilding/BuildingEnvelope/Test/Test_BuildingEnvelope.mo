within ThermalIntegrationLib.FactoryBuilding.BuildingEnvelope.Test;
model Test_BuildingEnvelope
  extends Modelica.Icons.Example;
  Roof roof(redeclare Examples.Records.ETAResearchFactory_Roof deviceData) annotation (Placement(transformation(extent={{-10,32},{10,52}})));
  Wall wall(redeclare Examples.Records.ETAResearchFactory_Walls deviceData) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Floor floor(redeclare Examples.Records.ETAResearchFactory_Floor deviceData) annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=C, T(start=293.15, fixed=true)) annotation (Placement(transformation(extent={{30,0},{50,20}})));
  parameter SI.HeatCapacity C=30*20*11*1.2*1.1 "Heat capacity of element (= cp*m)";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=313.15) annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));
equation
  connect(prescribedTemperature.T, realExpression.y) annotation (Line(points={{-62,0},{-73,0}}, color={0,0,127}));
  connect(wall.Outside, prescribedTemperature.port) annotation (Line(points={{-10,0},{-40,0}}, color={191,0,0}));
  connect(roof.Outside, wall.Outside) annotation (Line(points={{-10,42},{-16,42},{-16,0},{-10,0}}, color={191,0,0}));
  connect(floor.Outside, wall.Outside) annotation (Line(points={{-10,-50},{-16,-50},{-16,0},{-10,0}}, color={191,0,0}));
  connect(wall.Inside, heatCapacitor.port) annotation (Line(points={{10,0},{40,0}}, color={191,0,0}));
  connect(roof.Inside, heatCapacitor.port) annotation (Line(points={{10,42},{20,42},{20,0},{40,0}}, color={191,0,0}));
  connect(floor.Inside, heatCapacitor.port) annotation (Line(points={{10,-50},{20,-50},{20,0},{40,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=18000, __Dymola_Algorithm="Dassl"));
end Test_BuildingEnvelope;
