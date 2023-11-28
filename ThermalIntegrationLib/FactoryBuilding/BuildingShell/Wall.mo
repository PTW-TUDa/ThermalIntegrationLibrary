within ThermalIntegrationLib.FactoryBuilding.BuildingShell;
model Wall
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor HalfWallResistanceInside annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor HalfWallResistanceOutside annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Outside annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Inside annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor WallMass annotation (Placement(transformation(extent={{-10,0},{10,20}})));
equation
  connect(HalfWallResistanceInside.port_b, Inside) annotation (Line(points={{80,0},{100,0}}, color={191,0,0}));
  connect(Outside, HalfWallResistanceOutside.port_a) annotation (Line(points={{-100,0},{-66,0}}, color={191,0,0}));
  connect(HalfWallResistanceInside.port_a, WallMass.port) annotation (Line(points={{60,0},{0,0}}, color={191,0,0}));
  connect(WallMass.port, HalfWallResistanceOutside.port_b) annotation (Line(points={{0,0},{-46,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Wall;
