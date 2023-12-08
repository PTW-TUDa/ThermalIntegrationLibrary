within ThermalIntegrationLibrary.BaseClasses.Icons;
partial model CleaningMachines
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,50},{-10,-50}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          lineThickness=0.5),
        Rectangle(
          extent={{-40,40},{-20,-40}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          lineThickness=0.5),
        Rectangle(
          extent={{20,40},{40,-40}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-10,46},{10,-46}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder,
          lineThickness=0.5),
        Rectangle(
          extent={{10,50},{20,-50}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.HorizontalCylinder,
          lineThickness=0.5),
        Polygon(
          points={{-30,-18},{-32,-56},{-24,-68},{-38,-78},{-48,-62},{-44,-46},{-30,-18}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={95,95,95},
          smooth=Smooth.Bezier),
        Polygon(
          points={{40,6},{46,-24},{46,-44},{32,-54},{22,-38},{38,-14},{40,6}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={95,95,95},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-10,78},{-12,62},{-4,28},{-18,18},{-28,34},{-22,50},{-10,78}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={95,95,95},
          smooth=Smooth.Bezier)}),                               Diagram(coordinateSystem(preserveAspectRatio=false)));
end CleaningMachines;
