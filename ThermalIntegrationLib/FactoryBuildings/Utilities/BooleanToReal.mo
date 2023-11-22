within ThermalIntegrationLib.FactoryBuildings.Utilities;
block BooleanToReal "Convert Boolean to Real signal"
  extends Modelica.Blocks.Interfaces.partialBooleanSI;

  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal" annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput realTrue annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput realFalse annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
equation
  y = if u then realTrue else realFalse;
  annotation (Documentation(info="<html>
<p>
This block computes the output <strong>y</strong>
as <em>Real equivalent</em> of the Boolean input <strong>u</strong>:
</p>
<pre>    y = <strong>if</strong> u <strong>then</strong> realTrue <strong>else</strong> realFalse;
</pre>
<p>where <strong>u</strong> is of Boolean and <strong>y</strong> of Real type,
and <strong>realTrue</strong> and <strong>realFalse</strong> are parameters.
</p>
</html>"),
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-86,92},{-6,10}},
          lineColor={255,0,255},
          textString="B"),
        Polygon(
          points={{-12,-46},{-32,-26},{-32,-36},{-64,-36},{-64,-56},{-32,-56},
              {-32,-66},{-12,-46}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127}),
        Text(
          extent={{8,-4},{92,-94}},
          textString="R",
          lineColor={0,0,127})}));
end BooleanToReal;
