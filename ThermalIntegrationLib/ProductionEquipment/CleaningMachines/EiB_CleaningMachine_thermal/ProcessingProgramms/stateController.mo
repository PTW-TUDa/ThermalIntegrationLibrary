within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.ProcessingProgramms;
model stateController
parameter Integer stateTable[:,2]=fill(0,1,2) "first col state, sec col duration in s";
  Integer rows = size(stateTable,1),
          j=1,
          i;
  Real t_in_state;
  Modelica.Blocks.Interfaces.RealOutput dur_t1 annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.IntegerOutput state annotation (Placement(transformation(extent={{100,-10},
            {120,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput new_batch annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

  Modelica.Blocks.Interfaces.IntegerInput opMode annotation (Placement(transformation(extent={{-120,-10},
            {-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
algorithm
  // Add time for cleaning with MT1 for oil seperator control
   dur_t1 := 0;
   for j in 1:rows loop
     if stateTable[j,1] >= 5 and stateTable[j,1] <= 7 then
       dur_t1 := dur_t1 + stateTable[j,2];
     else
       dur_t1 := dur_t1 + 0;
     end if;
   end for;

initial equation
  i = 1;
  t_in_state = stateTable[1, 2];

equation

  when time >= pre(t_in_state) and opMode == 3 then // next state reached
   if pre(i) >= rows or opMode > pre(opMode) then // if cleaning programm is finished or if operation mode is changing to 'working', start over again
     i = 1;
     new_batch = true; // (problem to fix) stays true for duration of first state
   else // else go to next state
     i = pre(i) + 1;
     new_batch = false;
   end if;
   t_in_state= time + stateTable[i, 2];
  end when;

  if opMode == 1 then // Operation mode is 'off'
    state = 1;
  elseif opMode == 2 then // Operation mode is 'standby'
    state = 2;
  else // Operation mode is 'working'
    state = stateTable[i, 1];
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-80,40},{-20,10}},
          lineThickness=0.5,
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,-30}}, color={0,0,0}),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-80,40},{-20,-80}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-50,40},{-50,-80}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-80,10},{-20,10}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-80,-20},{-20,-20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-80,-50},{-20,-50}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-48,34},{-22,16}},
          lineColor={0,0,0},
          textString="state"),
        Text(
          extent={{-78,34},{-52,16}},
          lineColor={0,0,0},
          textString="t"),
        Line(
          points={{-20,-20},{20,-20},{20,40},{60,40}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{-20,-20},{20,-20},{20,-80},{60,-80}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{60,46},{60,34},{72,40},{60,46}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{60,-14},{60,-26},{72,-20},{60,-14}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{60,-74},{60,-86},{72,-80},{60,-74}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-60,100},{60,60}},
          lineColor={0,0,0},
          textString="stc"),
        Line(
          points={{0,-20},{60,-20}},
          color={0,0,0},
          thickness=0.5)}),   Diagram(coordinateSystem(preserveAspectRatio=false)));
end stateController;
