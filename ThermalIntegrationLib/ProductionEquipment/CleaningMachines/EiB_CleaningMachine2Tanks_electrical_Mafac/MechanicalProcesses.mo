within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical_Mafac;
package MechanicalProcesses
  model mech_processes
    Modelica.Blocks.Interfaces.RealOutput P_el
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  equation
    if state == 1 then // system off
      P_el = 0;
    elseif state == 5 or state == 6 then // spraying MT1
      P_el = 7.5;
    elseif state == 7 then // ultrasonic cleaning MT1
      P_el = 1.5;
    elseif state == 8 then // spraying MT2
      P_el = 1.85;
    elseif state == 11 or state == 13 then // draining/suction
      P_el = 0.5;
    elseif state == 12 then // impulse blowing
      P_el = 0.1;
    elseif state == 15 then // vaccum drying
      P_el = 7.5;
    else // other processes
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
    parameter Real pct;
    Modelica.Blocks.Interfaces.BooleanInput state_T1
      annotation (Placement(transformation(extent={{-120,-50},{-100,-30}}),iconTransformation(extent={{-120,
              -50},{-100,-30}})));
    Modelica.Blocks.Interfaces.RealOutput P_el annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput processTime annotation (Placement(transformation(extent={{-120,30},{-100,
              50}}), iconTransformation(extent={{-120,30},{-100,50}})));
  protected
    Modelica.SIunits.Time timer;
  initial equation
    pre(timer) = 0;
  equation
    when not state_T1 then
      timer = time + processTime*pct + 30; // about 30s break until all fluid is back in Tank
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
      annotation (Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  equation
    if state == 13 or state == 14 then // hot blowing / impulse hot blowing
      P_el = 3;
    else // other processes
      P_el = 0;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Text(
            extent={{-80,100},{80,40}},
            lineColor={0,0,0},
            textString="air heater"),
          Ellipse(
            extent={{-24,-34},{24,-80}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-12,26},{12,-40}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-12,38},{12,14}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-14,-44},{14,-72}},
            lineColor={255,255,255},
            lineThickness=1,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-4,4},{4,-46}},
            lineColor={255,255,255},
            lineThickness=1,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-4,8},{4,0}},
            lineColor={255,255,255},
            lineThickness=1,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-2,-32},{2,-32}},
            color={255,255,255},
            thickness=1)}),        Diagram(coordinateSystem(preserveAspectRatio=false)));
  end ah;

  model scc
    Modelica.Blocks.Interfaces.RealOutput P_el
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  equation
    if state == 13 then // side channel compressor active (hot blowing)
      P_el = 5.5;
    elseif state == 14 then // side channel compressor active (impulse hot blowing)
      P_el = 6.1;
    else // other processes
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

  model units_waste_heat
    parameter Real Q_waste_heat;
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
    Modelica.Blocks.Interfaces.RealOutput Q_waste annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    if state > 4 then
      Q_waste = Q_waste_heat;
    else
      Q_waste = 0;
    end if;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Text(
            extent={{-80,100},{80,40}},
            lineColor={0,0,0},
            textString="units waste heat"),
          Line(
            points={{-40,40},{-60,0},{-20,-40},{-40,-80}},
            color={0,0,0},
            smooth=Smooth.Bezier,
            thickness=1,
            arrow={Arrow.Filled,Arrow.None}),
          Line(
            points={{-60,-88},{60,-88}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier),
          Line(
            points={{0,40},{-20,0},{20,-40},{0,-80}},
            color={0,0,0},
            smooth=Smooth.Bezier,
            thickness=1,
            arrow={Arrow.Filled,Arrow.None}),
          Line(
            points={{40,40},{20,0},{60,-40},{40,-80}},
            color={0,0,0},
            smooth=Smooth.Bezier,
            thickness=1,
            arrow={Arrow.Filled,Arrow.None})}), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end units_waste_heat;
end MechanicalProcesses;
