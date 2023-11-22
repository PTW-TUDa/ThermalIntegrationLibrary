within ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ThermalSystem;
model decentralThermalSystem
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a hall "Thermal port for losses to surrounding of machine tool" annotation (Placement(transformation(extent={{190,-110},{210,-90}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=549819.89) annotation (Placement(transformation(extent={{-30,0},{30,60}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=553.99) annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=127.12) annotation (Placement(transformation(extent={{90,90},{110,110}})));
  Modelica.Blocks.Interfaces.RealInput P_el "Electric power demand of machine tool" annotation (Placement(transformation(extent={{-240,-20},{-200,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,130})));
  Modelica.Blocks.Interfaces.RealOutput T_machine annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,210})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ColdWater annotation (Placement(transformation(extent={{192,90},{212,110}})));
equation
  connect(thermalConductor1.port_b, hall) annotation (Line(points={{110,-100},{200,-100}}, color={191,0,0}));
  connect(prescribedHeatFlow.port, heatCapacitor.port) annotation (Line(points={{-90,0},{0,0}}, color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, P_el) annotation (Line(points={{-110,0},{-220,0}}, color={0,0,127}));
  connect(temperatureSensor.T, T_machine) annotation (Line(points={{4.44089e-16,140},{0,140},{0,210}}, color={0,0,127}));
  connect(temperatureSensor.port, heatCapacitor.port) annotation (Line(points={{-6.66134e-16,120},{0,120},{0,0}}, color={191,0,0}));
  connect(thermalConductor.port_b, ColdWater) annotation (Line(points={{110,100},{202,100}}, color={191,0,0}));
  connect(thermalConductor1.port_a, heatCapacitor.port) annotation (Line(points={{90,-100},{0,-100},{0,0}}, color={191,0,0}));
  connect(thermalConductor.port_a, heatCapacitor.port) annotation (Line(points={{90,100},{0,100},{0,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}}), graphics={
        Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None),
        Polygon(
          points={{-106,116},{54,136},{54,-144},{-106,-124},{-106,116}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Polygon(
          points={{54,-144},{114,-84},{114,116},{54,136},{54,-144}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Polygon(
          points={{-64,86},{-4,92},{-4,-34},{-64,-32},{-64,86}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Polygon(
          points={{-84,-34},{-118,-38},{-152,-34},{-152,-20},{-118,-24},{-84,-20},{-84,-34}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(points={{-162,2}}, color={28,108,200}),
        Line(
          points={{-150,-20},{-106,-14}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-106,-22},{-106,-36}},
          color={255,255,255},
          thickness=0.5),
        Line(
          points={{-106,-16},{-106,-22}},
          color={255,255,255},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}})));
end decentralThermalSystem;
