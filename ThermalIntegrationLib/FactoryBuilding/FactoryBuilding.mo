within ThermalIntegrationLib.FactoryBuilding;
model FactoryBuilding
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b radiationSouth annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b convection annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b conduction annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b radiationNorth annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b radiationWest annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b radiationEast annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor airHall annotation (Placement(transformation(extent={{90,0},{110,20}})));
  BuildingShell.Wall wallNorth annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  BuildingShell.Wall wallSouth annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  BuildingShell.Wall wallEast annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  BuildingShell.Wall wallWest annotation (Placement(transformation(extent={{-40,90},{-20,110}})));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convectiveResistor2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={72,0})));
  BuildingShell.Floor floor annotation (Placement(transformation(extent={{-40,-110},{-20,-90}})));
  BuildingShell.Roof roof annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convectiveResistor1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-68,-60})));
  Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convectiveResistor3 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,40})));
  Modelica.Blocks.Sources.Constant const annotation (Placement(transformation(extent={{-134,70},{-114,90}})));
  Modelica.Blocks.Sources.Constant const1 annotation (Placement(transformation(extent={{-136,-50},{-116,-30}})));
  Modelica.Blocks.Sources.Constant const2 annotation (Placement(transformation(extent={{36,30},{56,50}})));
equation
  connect(convectiveResistor2.fluid, airHall.port) annotation (Line(points={{82,0},{92,0},{92,0},{100,0}}, color={191,0,0}));
  connect(wallSouth.Inside, convectiveResistor2.solid) annotation (Line(points={{-20,-20},{30,-20},{30,0},{62,0}}, color={191,0,0}));
  connect(wallNorth.Inside, convectiveResistor2.solid) annotation (Line(points={{-20,20},{30,20},{30,0},{62,0}}, color={191,0,0}));
  connect(wallEast.Inside, convectiveResistor2.solid) annotation (Line(points={{-20,60},{30,60},{30,0},{62,0}}, color={191,0,0}));
  connect(wallWest.Inside, convectiveResistor2.solid) annotation (Line(points={{-20,100},{30,100},{30,0},{62,0}}, color={191,0,0}));
  connect(conduction, floor.Outside) annotation (Line(points={{-100,-100},{-40,-100}}, color={191,0,0}));
  connect(floor.Inside, convectiveResistor2.solid) annotation (Line(points={{-20,-100},{30,-100},{30,0},{62,0}}, color={191,0,0}));
  connect(roof.Inside, convectiveResistor2.solid) annotation (Line(points={{-20,-60},{30,-60},{30,0},{62,0}}, color={191,0,0}));
  connect(convectiveResistor1.fluid, roof.Outside) annotation (Line(points={{-58,-60},{-40,-60}}, color={191,0,0}));
  connect(convectiveResistor1.solid, convection) annotation (Line(points={{-78,-60},{-100,-60}}, color={191,0,0}));
  connect(radiationEast, convectiveResistor3.solid) annotation (Line(points={{-100,100},{-80,100},{-80,40}}, color={191,0,0}));
  connect(radiationWest, convectiveResistor3.solid) annotation (Line(points={{-100,60},{-80,60},{-80,40}}, color={191,0,0}));
  connect(radiationNorth, convectiveResistor3.solid) annotation (Line(points={{-100,20},{-80,20},{-80,40}}, color={191,0,0}));
  connect(radiationSouth, convectiveResistor3.solid) annotation (Line(points={{-100,-20},{-80,-20},{-80,40}}, color={191,0,0}));
  connect(convectiveResistor3.fluid, wallWest.Outside) annotation (Line(points={{-60,40},{-52,40},{-52,100},{-40,100}}, color={191,0,0}));
  connect(convectiveResistor3.fluid, wallEast.Outside) annotation (Line(points={{-60,40},{-52,40},{-52,60},{-40,60}}, color={191,0,0}));
  connect(convectiveResistor3.fluid, wallNorth.Outside) annotation (Line(points={{-60,40},{-52,40},{-52,20},{-40,20}}, color={191,0,0}));
  connect(convectiveResistor3.fluid, wallSouth.Outside) annotation (Line(points={{-60,40},{-52,40},{-52,-20},{-40,-20}}, color={191,0,0}));
  connect(const1.y, convectiveResistor1.Rc) annotation (Line(points={{-115,-40},{-68,-40},{-68,-50}}, color={0,0,127}));
  connect(const.y, convectiveResistor3.Rc) annotation (Line(points={{-113,80},{-70,80},{-70,50}}, color={0,0,127}));
  connect(const2.y, convectiveResistor2.Rc) annotation (Line(points={{57,40},{72,40},{72,10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end FactoryBuilding;
