within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.MechanicalProcesses;
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
  elseif state == 11 then // draining/suction
    P_el = 0.5;
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
