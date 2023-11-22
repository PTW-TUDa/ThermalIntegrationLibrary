within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TankHeating;
model thermOnOff
  Modelica.SIunits.HeatFlowRate Q_flow;
  Modelica.SIunits.TemperatureDifference dT;
  Real k;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_in annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_out annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
equation
  if u then
    k = 999999999;
  else
    k = 0.0000001;
  end if;
  dT = port_in.T - port_out.T;
  port_in.Q_flow = Q_flow;
  port_out.Q_flow = -Q_flow;
  Q_flow = k*dT;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                         Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
        Line(points={{-90,0},{-40,0}}, color={238,46,47}),
        Line(points={{40,0},{90,0}}, color={238,46,47}),
        Ellipse(
          extent={{24,8},{40,-8}},
          lineColor={238,46,47},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{24,-42},{-28,-4}}, color={238,46,47}),
        Line(points={{0,-100},{0,-24}}, color={217,67,180}),
        Ellipse(
          extent={{-40,8},{-24,-8}},
          lineColor={238,46,47},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,100},{80,40}},
          lineColor={0,0,0},
          textString="%name")}),                                 Diagram(coordinateSystem(preserveAspectRatio=false)));
end thermOnOff;
