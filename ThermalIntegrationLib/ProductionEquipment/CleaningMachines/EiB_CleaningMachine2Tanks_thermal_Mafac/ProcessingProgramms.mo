within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_thermal_Mafac;
package ProcessingProgramms

  model stateController
    parameter Modelica.SIunits.Temperature T_req "Working temperature of cleaning fluid";
    parameter Modelica.SIunits.Temperature T_lim "Minimum temperature of cleaning fluid";
  parameter Integer stateTable[:,2]=fill(0,1,2) "first col state, sec col duration in s";
    Integer rows = size(stateTable,1),
            j=1,
            i;
    Real t_in_state;
    Boolean ready;
    Modelica.Blocks.Interfaces.RealOutput processTime annotation (Placement(transformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.IntegerOutput state annotation (Placement(transformation(extent={{100,-10},
              {120,10}})));
    Modelica.Blocks.Interfaces.BooleanOutput new_batch annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

    Modelica.Blocks.Interfaces.IntegerInput opMode annotation (Placement(transformation(extent={{-120,-10},
              {-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
    Modelica.Blocks.Interfaces.RealInput T_mt1 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={40,-110}),  iconTransformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={40,-110})));
    Modelica.Blocks.Interfaces.RealInput T_mt2 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-40,-110}),iconTransformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-40,-110})));
  algorithm
    // Add process time without MT1-active-time for oil seperator control
    processTime := 0;
     for j in 1:rows loop
       if stateTable[j,1] < 5 or stateTable[j,1] > 7 then
        processTime := processTime + stateTable[j, 2];
       else
        processTime := processTime + 0;
       end if;
     end for;

  initial equation
    i = rows;
    t_in_state = stateTable[1, 2];

  equation

    if der(T_mt1)>0 then // tank1 is heating
      ready = T_mt1>=T_req or i<rows; // heating done if T_req is reached
    elseif der(T_mt2)>0 then // tank2 is heating
      ready = T_mt2>=T_req or i<rows;// heating done if T_req is reached
    else // no heating active
      ready = T_mt1>T_lim and T_mt2>T_lim or i<rows; // machine remains ready until the temperature of one tank flals below T_lim
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
end ProcessingProgramms;
