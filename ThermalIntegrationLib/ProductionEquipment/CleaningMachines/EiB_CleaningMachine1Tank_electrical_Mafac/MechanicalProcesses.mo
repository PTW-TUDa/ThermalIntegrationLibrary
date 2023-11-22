within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical_Mafac;
package MechanicalProcesses
  model mech_processes
    Modelica.Blocks.Interfaces.RealOutput P_el
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  equation
    if state == 1 then
      P_el = 0;
    elseif state == 5 or state == 6 then
      P_el = 7.5;
    elseif state == 7 then
      P_el = 1.5;
    elseif state == 8 then
      P_el = 1.85;
    elseif state == 11 then
      P_el = 0.5;
    else
      P_el = 0;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Rectangle(
            extent={{-70,50},{-10,-10}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={0,0,0},
            fillPattern=FillPattern.None),
          Ellipse(
            extent={{-70,-30},{-10,-90}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={0,0,0},
            fillPattern=FillPattern.None),
          Polygon(
            points={{10,-10},{40,50},{70,-10},{10,-10}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={0,0,0},
            fillPattern=FillPattern.None),
          Polygon(
            points={{58,-90},{22,-90},{10,-60},{40,-30},{70,-60},{58,-90}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={0,0,0},
            fillPattern=FillPattern.None),
          Text(
            extent={{-80,100},{80,60}},
            lineColor={0,0,0},
            textString="mech proc")}),
                                   Diagram(coordinateSystem(preserveAspectRatio=false)));
  end mech_processes;

  model oil_separator
    Modelica.Blocks.Interfaces.BooleanInput state_T1
      annotation (Placement(transformation(extent={{-120,-50},{-100,-30}}),iconTransformation(extent={{-120,
              -50},{-100,-30}})));
    Modelica.Blocks.Interfaces.RealOutput P_el annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput dur_t1 annotation (Placement(transformation(extent={{-120,30},{-100,
              50}}), iconTransformation(extent={{-120,30},{-100,50}})));
  protected
    Modelica.SIunits.Time timer;
  initial equation
    pre(timer) = 0;
  equation
    when not state_T1 then
      timer = time + dur_t1/2;
    end when;
    if not state_T1 and timer >= time then
      P_el = 0.2;
    else
      P_el = 0;
    end if;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
            extent={{-80,100},{80,0}},
            lineColor={0,0,0},
            textString="oil sep"),
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{-80,-38},{-40,-8},{0,-34},{40,-62},{80,-42}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Line(
            points={{-80,-38},{-40,-18},{0,-44},{40,-72},{80,-42}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier)}),                               Diagram(coordinateSystem(preserveAspectRatio=false)));
  end oil_separator;

  model ah
    Modelica.Blocks.Interfaces.RealOutput P_el
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  equation

    if state == 13 or state == 14 then
      P_el = 3;
    else
      P_el = 0;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{16,40},{-24,0},{16,-40},{-26,-94},{26,-40},{-14,0},{16,40}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Line(
            points={{62,40},{22,0},{62,-40},{20,-94},{72,-40},{32,0},{62,40}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Line(
            points={{-30,40},{-70,0},{-30,-40},{-72,-94},{-20,-40},{-60,0},{-30,40}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Text(
            extent={{-80,100},{80,40}},
            lineColor={0,0,0},
            textString="air heater")}),
                                   Diagram(coordinateSystem(preserveAspectRatio=false)));
  end ah;

  model scc
    Modelica.Blocks.Interfaces.RealOutput P_el
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  equation

    if state <= 14 and state >=12 then
      P_el = 5.5;
    else
      P_el = 0;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Ellipse(
            extent={{-70,50},{70,-90}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{68,-2},{-54,24}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{68,-38},{-54,-64}},
            color={0,0,0},
            thickness=0.5),
          Text(
            extent={{-60,100},{60,60}},
            lineColor={0,0,0},
            textString="scc")}),   Diagram(coordinateSystem(preserveAspectRatio=false)));
  end scc;

  model dummy
    Modelica.Blocks.Interfaces.RealOutput P_el
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  equation
      if state == 1 then
      P_el = 0;
    elseif state == 5 or state == 6 then
      P_el = 7.5;
    elseif state == 7 then
      P_el = 1.5;
    elseif state == 8 then
      P_el = 1.85;
    elseif state == 11 then
      P_el = 0.5;
    else
      P_el = 0;
    end if;
  end dummy;
end MechanicalProcesses;
