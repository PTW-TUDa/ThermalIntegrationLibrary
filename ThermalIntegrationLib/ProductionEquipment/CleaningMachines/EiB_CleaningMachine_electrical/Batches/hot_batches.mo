within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_electrical.Batches;
model hot_batches
  Modelica.Blocks.Interfaces.BooleanInput new_batch
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),iconTransformation(extent={{-140,
            -60},{-100,-20}})));
  EiB_CleaningMachine2Tanks_thermal.Batches.batch_controller batch_controller1
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  single_hot_batch single_hot_batch1(batch_number=1)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  single_hot_batch single_hot_batch2(batch_number=2)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  single_hot_batch single_hot_batch3(batch_number=3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  single_hot_batch single_hot_batch4(batch_number=4)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  single_hot_batch single_hot_batch5(batch_number=5)
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Modelica.Blocks.Interfaces.RealInput T_hall
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealOutput Q_dot
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=4)
    annotation (Placement(transformation(extent={{54,-6},{66,6}})));
equation
  connect(new_batch, batch_controller1.new_batch) annotation (Line(points={{-120,-40},{-81,-40}},
                                                                                              color={255,0,255}));
  connect(batch_controller1.batch_number, single_hot_batch1.batch_nr)
    annotation (Line(points={{-59,-40},{-40,-40},{-40,75},{-12,75}}, color={255,127,0}));
  connect(single_hot_batch4.batch_nr, single_hot_batch1.batch_nr)
    annotation (Line(points={{-12,-45},{-40,-45},{-40,75},{-12,75}}, color={255,127,0}));
  connect(T_hall, single_hot_batch1.T_hall)
    annotation (Line(points={{-120,40},{-48,40},{-48,84},{-12,84}}, color={0,0,127}));
  connect(single_hot_batch5.T_hall, single_hot_batch1.T_hall)
    annotation (Line(points={{-12,-76},{-48,-76},{-48,84},{-12,84}}, color={0,0,127}));
  connect(single_hot_batch2.T_hall, single_hot_batch1.T_hall)
    annotation (Line(points={{-12,44},{-48,44},{-48,84},{-12,84}}, color={0,0,127}));
  connect(single_hot_batch3.T_hall, single_hot_batch1.T_hall)
    annotation (Line(points={{-12,4},{-48,4},{-48,84},{-12,84}}, color={0,0,127}));
  connect(single_hot_batch4.T_hall, single_hot_batch1.T_hall)
    annotation (Line(points={{-12,-36},{-48,-36},{-48,84},{-12,84}}, color={0,0,127}));
  connect(single_hot_batch2.batch_nr, single_hot_batch1.batch_nr)
    annotation (Line(points={{-12,35},{-40,34},{-40,75},{-12,75}}, color={255,127,0}));
  connect(single_hot_batch3.batch_nr, single_hot_batch1.batch_nr)
    annotation (Line(points={{-12,-5},{-40,-6},{-40,75},{-12,75}}, color={255,127,0}));
  connect(single_hot_batch5.batch_nr, single_hot_batch1.batch_nr)
    annotation (Line(points={{-12,-85},{-40,-85},{-40,75},{-12,75}}, color={255,127,0}));
  connect(Q_dot, multiSum.y) annotation (Line(points={{110,0},{67.02,0}}, color={0,0,127}));
  connect(single_hot_batch1.Q_dot_single_hot_batch, multiSum.u[1])
    annotation (Line(points={{11,80},{40,80},{40,3.15},{54,3.15}}, color={0,0,127}));
  connect(single_hot_batch2.Q_dot_single_hot_batch, multiSum.u[2])
    annotation (Line(points={{11,40},{40,40},{40,1.05},{54,1.05}}, color={0,0,127}));
  connect(single_hot_batch3.Q_dot_single_hot_batch, multiSum.u[3])
    annotation (Line(points={{11,0},{32,0},{32,-1.05},{54,-1.05}}, color={0,0,127}));
  connect(single_hot_batch4.Q_dot_single_hot_batch, multiSum.u[4])
    annotation (Line(points={{11,-40},{40,-40},{40,-3.15},{54,-3.15}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-60,-52},{-80,-58},{-60,-64},{-40,-58},{-60,-52}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-68,-62},{-80,-66},{-60,-72},{-40,-66},{-52,-62}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-80,100},{80,40}},
          lineColor={0,0,0},
          textString="hot batches"),
        Line(
          points={{-60,-22},{-64,-34},{-56,-42},{-60,-50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-68,-70},{-80,-74},{-60,-80},{-40,-74},{-52,-70}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-50,-22},{-54,-34},{-46,-42},{-50,-50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-70,-22},{-74,-34},{-66,-42},{-70,-50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Polygon(
          points={{60,-52},{40,-58},{60,-64},{80,-58},{60,-52}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{52,-62},{40,-66},{60,-72},{80,-66},{68,-62}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{60,-22},{56,-34},{64,-42},{60,-50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{52,-70},{40,-74},{60,-80},{80,-74},{68,-70}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{70,-22},{66,-34},{74,-42},{70,-50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{50,-22},{46,-34},{54,-42},{50,-50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Polygon(
          points={{0,-52},{-20,-58},{0,-64},{20,-58},{0,-52}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-8,-62},{-20,-66},{0,-72},{20,-66},{8,-62}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{0,-22},{-4,-34},{4,-42},{0,-50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-8,-70},{-20,-74},{0,-80},{20,-74},{8,-70}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{10,-22},{6,-34},{14,-42},{10,-50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-10,-22},{-14,-34},{-6,-42},{-10,-50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Polygon(
          points={{-30,18},{-50,12},{-30,6},{-10,12},{-30,18}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-38,8},{-50,4},{-30,-2},{-10,4},{-22,8}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-30,48},{-34,36},{-26,28},{-30,20}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-38,0},{-50,-4},{-30,-10},{-10,-4},{-22,0}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-20,48},{-24,36},{-16,28},{-20,20}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{-40,48},{-44,36},{-36,28},{-40,20}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Polygon(
          points={{30,18},{10,12},{30,6},{50,12},{30,18}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{22,8},{10,4},{30,-2},{50,4},{38,8}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{30,48},{26,36},{34,28},{30,20}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{22,0},{10,-4},{30,-10},{50,-4},{38,0}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{40,48},{36,36},{44,28},{40,20}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{20,48},{16,36},{24,28},{20,20}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None}),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end hot_batches;
