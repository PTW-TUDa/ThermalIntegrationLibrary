within ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.HydraulicSystem;
model HydraulicSystem
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-100,0}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput P_el(quantity="Power", unit="W") "Electric power demand of hydraulic system"
                                                                         annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(P_el, controlBus.P_el_hydraulicSystem) annotation (Line(points={{110,0},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.None),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-30,52},{60,0}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-30,-52},{60,0}},
          color={0,0,0},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end HydraulicSystem;
