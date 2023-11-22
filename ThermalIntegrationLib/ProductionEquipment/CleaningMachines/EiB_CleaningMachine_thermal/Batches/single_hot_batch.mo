within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.Batches;
model single_hot_batch
  extends
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TechnicalConfiguration.TechnicalConfiguration_a;
  parameter Integer batch_number;
  Modelica.Blocks.Interfaces.IntegerInput batch_nr
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_hall annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  TankHeating.thermOnOff thermOnOff
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,0})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=c_batch*m_batch, T(fixed=true, start=T_req))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-76})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=0.1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-40})));
  TriggeredBooleanStep triggeredBooleanStep(batch=batch_number) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  when batch_number == batch_nr then
    reinit(heatCapacitor.T, 343.15);
  end when;
  connect(port_hall, thermOnOff.port_in) annotation (Line(points={{100,0},{60,0},{60,20},{0,20},{0,10}}, color={191,0,0}));
  connect(heatCapacitor.port, thermalConductor.port_b) annotation (Line(points={{1.22125e-15,-66},{0,
          -66},{0,-50}},                                                                                            color={191,0,0}));
  connect(thermOnOff.port_out, thermalConductor.port_a) annotation (Line(points={{-1.77636e-15,-10},{0,-10},{0,-30}}, color={191,0,0}));
  connect(batch_nr, triggeredBooleanStep.batch_nr) annotation (Line(points={{-110,0},{-62,0}}, color={255,127,0}));
  connect(thermOnOff.u, triggeredBooleanStep.y)
    annotation (Line(points={{-12,2.22045e-15},{-26,2.22045e-15},{-26,0},{-39,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Polygon(
          points={{0,-18},{-60,-38},{0,-58},{60,-38},{0,-18}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-30,-48},{-60,-58},{0,-78},{60,-58},{30,-48}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-30,-68},{-60,-78},{0,-98},{60,-78},{30,-68}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-80,100},{80,40}},
          lineColor={0,0,0},
          textString="hot batch"),
        Line(
          points={{-40,-12}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{0,46},{-10,24},{10,4},{0,-14}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-30,46},{-40,24},{-20,4},{-30,-14}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{30,46},{20,24},{40,4},{30,-14}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None})}),                    Diagram(coordinateSystem(preserveAspectRatio=false)));
end single_hot_batch;
