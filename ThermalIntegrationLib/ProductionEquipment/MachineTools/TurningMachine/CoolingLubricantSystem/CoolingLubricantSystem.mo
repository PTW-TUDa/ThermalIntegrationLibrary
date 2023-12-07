within ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.CoolingLubricantSystem;
model CoolingLubricantSystem
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-100,0}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput P_el(quantity="Power", unit="W") "Electric power demand of cooling lubricant system"
                                                                         annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(P_el, controlBus.P_el_coolingLubricantSystem) annotation (Line(points={{110,0},{-100,0}}, color={0,0,127}), Text(
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
        Line(
          points={{-6,88},{-2,76},{-12,62},{-24,48},{-26,32},{-12,16},{12,14},{24,28},{26,46},{16,64},{6,76},{-6,88}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{-42,10},{-38,-2},{-48,-16},{-60,-30},{-62,-46},{-48,-62},{-24,-64},{-12,-50},{-10,-32},{-20,-14},{-30,-2},{-42,10}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{44,36},{48,24},{38,10},{26,-4},{24,-20},{38,-36},{62,-38},{74,-24},{76,-6},{66,12},{56,24},{44,36}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end CoolingLubricantSystem;
