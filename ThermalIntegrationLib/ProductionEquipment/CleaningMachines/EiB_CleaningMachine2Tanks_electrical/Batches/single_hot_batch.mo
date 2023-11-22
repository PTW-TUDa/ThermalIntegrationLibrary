within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.Batches;
model single_hot_batch
  parameter Modelica.SIunits.Mass m_batch "Mass of batch";
  parameter Modelica.SIunits.HeatCapacity c_batch "Heat capacity of batch";
  parameter Modelica.SIunits.Mass m_rack "Mass of batching rack";
  parameter Modelica.SIunits.HeatCapacity c_rack "Heat capacity of batching rack";
  parameter Modelica.SIunits.Temperature T_req "Working temperature of cleaning fluid";
  parameter Integer batch_number;
  Real T(start=T_req);
  Modelica.Blocks.Interfaces.IntegerInput batch_nr
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}}),iconTransformation(extent={{-140,
            -70},{-100,-30}})));
  Modelica.Blocks.Interfaces.RealInput T_hall
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealOutput Q_dot_single_hot_batch
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  when batch_nr == batch_number then
    reinit(T, T_req);
  end when;

  if batch_nr == batch_number then
    Q_dot_single_hot_batch = 0.06*(T-T_hall);
    (c_batch*m_batch+c_rack*m_rack)*der(T) = Q_dot_single_hot_batch;
  else
    der(T) = 0;
    Q_dot_single_hot_batch = 0;
  end if;

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
