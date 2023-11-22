within ThermalIntegrationLib.BaseClasses.Icons;
partial model AnnealingOven
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,60},{10,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={245,245,245}),
        Ellipse(
          extent={{0,60},{20,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={95,95,95}),
        Ellipse(
          extent={{20,60},{74,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={72,72,72}),
    Line(
    origin={2.5,51.6667},
    points={{1.5,-41.6667},{13.5,-35.6667},{-2.5,-15.6667},{7.5,-1.6667},{-2.5,6.3333},{3.5,18.3333},{-2.5,28.3333},{-4.5,36.3333}},
      smooth=Smooth.Bezier,
          color={0,0,0},
          thickness=0.5),
    Line(
    origin={10.5,63.6667},
    points={{1.5,-41.6667},{13.5,-35.6667},{-2.5,-15.6667},{7.5,-1.6667},{-2.5,6.3333},{3.5,18.3333},{-2.5,28.3333},{-4.5,36.3333}},
      smooth=Smooth.Bezier,
          color={0,0,0},
          thickness=0.5),
    Line(
    origin={2.5,73.6667},
    points={{1.5,-41.6667},{9.5,-25.6667},{1.5,-13.6667},{7.5,-1.6667},{-2.5,6.3333},{3.5,10.3333},{-2.5,14.3333},{-4.5,24.3333}},
      smooth=Smooth.Bezier,
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{-100,-34},{-12,-42}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-80},{-12,-36}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,-4},{22,4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.None)}),                       Diagram(coordinateSystem(preserveAspectRatio=false)));
end AnnealingOven;