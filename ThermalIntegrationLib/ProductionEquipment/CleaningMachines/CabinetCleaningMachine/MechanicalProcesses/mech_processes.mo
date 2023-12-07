within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.CabinetCleaningMachine.MechanicalProcesses;
model mech_processes
  parameter Real CustomStateTable[:,2]=fill(0,2,2) "Custom state definition(washing mode = first column, el. Power [kW] = second column)";
  Integer rows = size(CustomStateTable,1);
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.IntegerInput state
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
algorithm
  for i in 1:rows loop
//     when state == CustomStateTable[i,1] then
//       P_el := CustomStateTable[i,2];
//     end when;
    if state == CustomStateTable[i,1] then
      P_el := CustomStateTable[i,2];
    else
      P_el := 0;
    end if;
  end for;

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
