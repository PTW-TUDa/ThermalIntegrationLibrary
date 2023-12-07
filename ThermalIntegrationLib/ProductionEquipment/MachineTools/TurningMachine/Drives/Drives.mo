within ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.Drives;
model Drives
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-100,0}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput P_el(quantity="Power", unit="W") "Electric power demand of drives"
                                                                         annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(P_el, controlBus.P_el_drives) annotation (Line(points={{110,0},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.None),
        Ellipse(
          extent={{-58,30},{-44,-30}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-50,30},{28,-30}},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{20,30},{34,-30}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-50,30},{26,30}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-52,-30},{26,-30}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{24,20},{34,-20}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{30,20},{60,-20}},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{30,20},{60,20}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{56,20},{66,-20}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{30,-20},{60,-20}},
          color={0,0,0},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Drives;
