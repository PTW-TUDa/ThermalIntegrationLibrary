within ThermalIntegrationLib.ProductionEquipment.MachineTools.MachineTool.CoolingSystem;
model CentralCoolWater
  parameter Modelica.SIunits.ThermodynamicTemperature T_flow "Flow temperature of cool water";
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor annotation (Placement(transformation(extent={{-40,10},{-20,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a consumption annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  Modelica.Blocks.Sources.Constant const(k=T_flow)
                                         annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Blocks.Interfaces.RealOutput P_th_cool annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=1e-5) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(prescribedTemperature.T, const.y) annotation (Line(points={{12,0},{39,0}}, color={0,0,127}));
  connect(heatFlowSensor.port_b, prescribedTemperature.port) annotation (Line(points={{-20,0},{-10,0}}, color={191,0,0}));
  connect(heatFlowSensor.Q_flow, P_th_cool) annotation (Line(points={{-30,10},{-30,20},{90,20},{90,0},{110,0}}, color={0,0,127}));
  connect(thermalResistor.port_b, heatFlowSensor.port_a) annotation (Line(points={{-60,0},{-40,0}}, color={191,0,0}));
  connect(thermalResistor.port_a, consumption) annotation (Line(points={{-80,0},{-100,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-98,100},{102,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-78,40},{82,40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-78,-40},{82,-40}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{-58,20},{-18,-20}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-50,12},{-26,-12}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-38,40},{-38,20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-38,-20},{-38,-40}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{22,20},{62,-20}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{30,12},{54,-12}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{42,40},{42,20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{42,-20},{42,-40}},
          color={0,0,0},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Line(
          points={{-44,42}},
          color={0,0,0},
          thickness=0.5)}));
end CentralCoolWater;
