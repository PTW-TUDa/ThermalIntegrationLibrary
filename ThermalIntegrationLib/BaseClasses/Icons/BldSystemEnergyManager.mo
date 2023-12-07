within ThermalIntegrationLib.BaseClasses.Icons;
partial model BldSystemEnergyManager
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-90,50},{90,-50}},
          lineColor={0,0,0},
          lineThickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{-60,92},{-60,52}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,52},{-50,66}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-70,66},{-60,52}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{30,-32},{30,-86}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{30,-86},{40,-72}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{20,-72},{30,-86}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{42,40},{42,80},{82,80}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{68,70},{82,80}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{68,90},{82,80}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-80,50},{80,-50}},
          lineColor={0,0,0},
          lineThickness=1,
          fontName="Candara",
          textStyle={TextStyle.Italic},
          textString="dE/dt = 0")}),                             Diagram(coordinateSystem(preserveAspectRatio=false)));
end BldSystemEnergyManager;
