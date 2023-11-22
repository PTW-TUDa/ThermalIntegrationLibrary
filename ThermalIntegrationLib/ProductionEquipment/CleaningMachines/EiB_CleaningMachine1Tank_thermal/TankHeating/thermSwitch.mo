within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal.TankHeating;
model thermSwitch
  Modelica.SIunits.HeatFlowRate Q_flow;
 Modelica.SIunits.TemperatureDifference dT;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_in_1 annotation (Placement(transformation(extent={{-110,70},{-90,90}}),
        iconTransformation(extent={{-110,70},{-90,90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_in_2 annotation (Placement(transformation(extent={{-112,-90},{-92,-70}}),
        iconTransformation(extent={{-112,-90},{-92,-70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_out annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.BooleanInput u
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
equation
  if u then
    dT = port_in_1.T - port_out.T;
    port_in_1.Q_flow = Q_flow;
    port_in_2.Q_flow = 0;
  else
    dT = port_in_2.T - port_out.T;
    port_in_2.Q_flow = Q_flow;
    port_in_1.Q_flow = 0;
  end if;
  port_out.Q_flow = -Q_flow;
  Q_flow = 999999999 * dT;

//   port_out = if u then port_in_1 else port_in_2;
//
//   if u then
//     port_in_2.Q_flow = 0;
//   else
//     port_in_1.Q_flow = 0;
//   end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                         Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
        Line(points={{12,0},{100,0}},
          color={238,46,47}),
        Line(points={{-100,0},{-40,0}},
          color={255,0,255}),
        Line(points={{-100,-80},{-40,-80},{-40,-80}},
          color={238,46,47}),
        Line(points={{-40,12},{-40,-12}},
          color={255,0,255}),
        Line(points={{-100,80},{-38,80}},
          color={238,46,47}),
        Line(points={{-38,80},{6,2}},
          color={238,46,47},
          thickness=1),
        Ellipse(lineColor={0,0,255},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{2,-8},{18,8}}),
        Text(
          extent={{-100,140},{100,100}},
          lineColor={0,0,0},
          textString="%name")}),                                 Diagram(coordinateSystem(preserveAspectRatio=false)));
end thermSwitch;
