within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical.ProcessingProgramms;
model stateController
  parameter Modelica.Units.SI.Temperature T_req "Working temperature of cleaning fluid";
  parameter Modelica.Units.SI.Temperature T_lim "Minimum temperature of cleaning fluid";
  parameter Integer stateTable[:,2]=fill(0,1,2) "first col state, sec col duration in s";
  parameter Integer washingTable_T1[:,1]=fill(0,1,1);
  parameter Integer washingTable_T2[:,1]=fill(0,1,1);
  Integer rows = size(stateTable,1),
          rows2 = size(washingTable_T1,1),
          rows3 = size(washingTable_T2,1),
          i;
  Real dur_mt1,
       dur_mt2,
       t_in_state;
  Boolean ready;
  Modelica.Blocks.Interfaces.IntegerOutput state annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput tank_time annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput new_batch annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.IntegerInput opMode
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput T_mt1 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-80,-120})));
  Modelica.Blocks.Interfaces.RealInput T_mt2 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={80,-120})));
  Modelica.Blocks.Interfaces.BooleanInput heating_t1 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-30,-120})));
  Modelica.Blocks.Interfaces.BooleanInput heating_t2 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={30,-120})));
protected
  Modelica.Units.SI.Time startTime;
       Boolean washing;

algorithm
   dur_mt1 := 0;
   dur_mt2 := 0;
   for j in 1:rows loop
     if stateTable[i,1] >= washingTable_T1[1,1] and stateTable[i,1] <= washingTable_T1[rows2,1] then // Add time for cleaning with MT1
       dur_mt1 := dur_mt1 + stateTable[j,2];
     elseif stateTable[i,1] >= washingTable_T2[1,1] and stateTable[i,1] <= washingTable_T2[rows3,1] then // Add time for cleaning with MT2
       dur_mt2 := dur_mt2 + stateTable[j,2];
     else
       dur_mt1 := dur_mt1 + 0;
       dur_mt2 := dur_mt2 + 0;
     end if;
   end for;

initial equation
  i = 1;
  t_in_state = stateTable[1,2];

equation

  if heating_t1 then // tank1 is heating
    ready = T_mt1>=T_req or i<rows; // heating done if T_req is reached
  elseif heating_t2 then // tank2 is heating
    ready = T_mt2>=T_req or i<rows;// heating done if T_req is reached
  else // no heating active
    ready = T_mt1>T_lim and T_mt2>T_lim or i<rows; // machine remains ready until the temperature of one tank falls below T_lim
  end if; // the condition 'i<rows' ensures that the washing cycle is not interrupted

  when time >= pre(t_in_state) and opMode == 3 and pre(ready) then // next state reached
   if pre(i) >= rows or opMode > pre(opMode) then // if cleaning programm is finished or if operation mode is changing to 'working', start over again
     i = 1;
     new_batch = true; // (problem to fix) stays true for duration of first state
   else // else go to next state
     i = pre(i) + 1;
     new_batch = false;
   end if;
   t_in_state= time + stateTable[i, 2];
  end when;

  if stateTable[i,1] == washingTable_T1[1,1] or stateTable[i,1] == washingTable_T2[1,1] then // cleaning process with any MT is running
    washing = true;
  else
    washing = false;
  end if;

  when edge(washing) then // set startTime to actuall sim-time when cleaning process startet
    startTime = time;
  end when;

  if stateTable[i,1] >= washingTable_T1[1,1] and stateTable[i,1] <= washingTable_T1[rows2,1] and pre(ready) then // if cleaning with MT1 is running, set tank_time to remaining time in cleaning
    tank_time = dur_mt1 - (time-startTime) + 0.000001;
  elseif stateTable[i,1] >= washingTable_T2[1,1] and stateTable[i,1] <= washingTable_T2[rows3,1] then // if cleaning with MT2 is running, set tank_time to remaining time in cleaning
    tank_time = dur_mt2 - (time-startTime) + 0.000001;
  else
    tank_time = 1;
  end if;

  if opMode == 1 then // Operation mode is 'off'
    state = 1;
  elseif opMode == 2 then // Operation mode is 'standby'
    state = 2;
  else // Operation mode is 'working'
    if ready then
      state = stateTable[i, 1];
    else
      state = 2;
    end if;
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
          points={{60,-34},{60,-46},{72,-40},{60,-34}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{60,-74},{60,-86},{72,-80},{60,-74}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{60,6},{60,-6},{72,0},{60,6}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-20,-20},{20,-20},{30,-40},{60,-40}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Line(
          points={{-20,-20},{20,-20},{30,0},{60,0}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Text(
          extent={{-60,100},{60,60}},
          lineColor={0,0,0},
          textString="stc")}),Diagram(coordinateSystem(preserveAspectRatio=false)));
end stateController;
