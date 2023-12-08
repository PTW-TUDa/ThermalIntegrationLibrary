within ThermalIntegrationLibrary.ProductionEquipment.MachineTools.TurningMachine.CoolingSystem;
model CentralColdWater
  parameter Modelica.Units.SI.ThermodynamicTemperature T_flow "Flow temperature of cold water";
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor annotation (Placement(transformation(extent={{-40,10},{-20,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a consumption annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  Modelica.Blocks.Sources.Constant const(k=T_flow)
                                         annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Blocks.Interfaces.RealOutput P_th_cold annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=1e-5) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(heatFlowSensor.port_b, prescribedTemperature.port) annotation (Line(points={{-20,0},{-10,0}}, color={191,0,0}));
  connect(P_th_cold, heatFlowSensor.Q_flow) annotation (Line(points={{110,0},{94,0},{94,46},{-30,46},{-30,10}}, color={0,0,127}));
  connect(thermalResistor.port_b, heatFlowSensor.port_a) annotation (Line(points={{-60,0},{-40,0}}, color={191,0,0}));
  connect(thermalResistor.port_a, consumption) annotation (Line(points={{-80,0},{-100,0}}, color={191,0,0}));
  connect(prescribedTemperature.T, const.y) annotation (Line(points={{12,0},{39,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-80,40},{80,40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-80,-40},{80,-40}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{-60,20},{-20,-20}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-52,12},{-28,-12}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,40},{-40,20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-40,-20},{-40,-40}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{20,20},{60,-20}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{28,12},{52,-12}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{40,40},{40,20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{40,-20},{40,-40}},
          color={0,0,0},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Line(
          points={{-44,42}},
          color={0,0,0},
          thickness=0.5)}));
end CentralColdWater;
