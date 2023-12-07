within ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.TransferUnit;
model TransferUnit
  parameter Boolean IsUsed "True if used. False if unused";
  parameter Modelica.Units.SI.ThermalConductance lambda;
  parameter Modelica.Units.SI.ThermodynamicTemperature T_target;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a primary annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a secondary annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation (Placement(transformation(extent={{60,-60},{40,-40}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=lambda,
    yMax=lambda,
    yMin=0)                             annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=if IsUsed then T_target else temperatureSensor.T)
                                                        annotation (Placement(transformation(extent={{-82,10},{-62,30}})));
  Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
equation
  connect(convection.fluid, secondary) annotation (Line(points={{60,0},{100,0}}, color={191,0,0}));
  connect(temperatureSensor.port, secondary) annotation (Line(points={{60,-50},{80,-50},{80,0},{100,0}}, color={191,0,0}));
  connect(primary, convection.solid) annotation (Line(points={{-100,0},{40,0}}, color={191,0,0}));
  connect(feedback.u2, temperatureSensor.T) annotation (Line(points={{-30,12},{-30,-50},{40,-50}}, color={0,0,127}));
  connect(realExpression.y, feedback.u1) annotation (Line(points={{-61,20},{-38,20}}, color={0,0,127}));
  connect(feedback.y, PID.u_m) annotation (Line(points={{-21,20},{0,20},{0,38}}, color={0,0,127}));
  connect(const.y, PID.u_s) annotation (Line(points={{-59,50},{-12,50}}, color={0,0,127}));
  connect(PID.y, convection.Gc) annotation (Line(points={{11,50},{50,50},{50,10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-30,60},{30,-60}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{30,60},{-30,-60}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-30,40},{-40,40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{60,40},{30,40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-30,-40},{-60,-40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{60,-40},{30,-40}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Ellipse(
          extent={{-80,60},{-40,20}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-72,56},{-40,40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-72,24},{-40,40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{50,80},{-60,80}},
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{50,40},{50,80}},
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{-60,60},{-60,80}},
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash,
          arrow={Arrow.Filled,Arrow.None})}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end TransferUnit;
