// Neo4J satcat and launches - delete nodes and relationships
// -----------------------------------------------------------------------


// With relations
// -----------------

MATCH (launchlog:Launchlog)-[rel]-()
DELETE launchlog, rel

MATCH (launch_vehicle:LaunchVehicle)-[rel]-()
DELETE launch_vehicle, rel

MATCH (launch_vehicle_serie:LaunchVehicleSerie)-[rel]-()
DELETE launch_vehicle_serie, rel

MATCH (launch_site:LaunchSite)-[rel]-()
DELETE launch_site, rel


MATCH (sat:Satellite)-[rel]-()
DELETE sat, rel


// Without relations
// -----------------
MATCH (launch_vehicle:LaunchVehicle)
DELETE launch_vehicle

MATCH (launch_vehicle_serie:LaunchVehicleSerie)
DELETE launch_vehicle_serie

MATCH (launch_site:LaunchSite)
DELETE launch_site

MATCH (outcome:Outcome)
DELETE outcome


MATCH (org:Organization)
DELETE org

MATCH (ob:Orbit_type)
DELETE ob
