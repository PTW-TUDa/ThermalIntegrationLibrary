within ThermalIntegrationLib.FactoryBuildings.Utilities;
model WeekDayToInt "Output is a number from 0 to 6 for the day of the week starting with Monday"
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
        transformation(rotation=0, extent={{100,-10},{120,10}})));
  parameter Types.Weekday day=Types.Weekday.Monday annotation (dialogue(choicesAllMatching=true));
equation
  y =if day == Types.Weekday.Monday then 0 else if day == Types.Weekday.Tuesday then 1 else if day == Types.Weekday.Wednesday then 2 else if day == Types.Weekday.Thursday then 3 else if day == Types.Weekday.Friday then 4 else if day == Types.Weekday.Saturday then 5 else 6;
  annotation ();
end WeekDayToInt;
