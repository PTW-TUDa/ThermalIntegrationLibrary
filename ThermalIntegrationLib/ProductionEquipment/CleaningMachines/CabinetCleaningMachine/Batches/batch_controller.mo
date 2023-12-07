within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.CabinetCleaningMachine.Batches;
model batch_controller
  Integer counter;
  Modelica.Blocks.Interfaces.BooleanInput new_batch
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput batch_number annotation (Placement(transformation(extent={{100,-10},{120,10}})));
initial algorithm
  counter :=0;

algorithm
  when edge(new_batch) then
    if counter >= 5 then
      counter :=1;
    else
      counter :=counter + 1;
    end if;
  end when;

  batch_number :=counter;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5), Text(
          extent={{-80,100},{80,-100}},
          lineColor={0,0,0},
          textString="batch
ctrl")}),                                                        Diagram(coordinateSystem(preserveAspectRatio=false)));
end batch_controller;
