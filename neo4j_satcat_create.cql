// Neo4J satcat and launches - load the data
// -----------------------------------------

// Satellite catalog with satellites, organizations and orbit types
LOAD CSV WITH HEADERS FROM 'file:///satcat.csv' AS srow
WITH srow WHERE NOT srow.orbit_type IS NULL
MERGE (satellite:Satellite {norad_nr: srow.norad_number, cospar_designation: srow.cospar_designation, name: srow.name, alternate_name: srow.alternate_name})
ON CREATE SET satellite.orbital_period_min = TOFLOAT(srow.orbital_period_min)
ON CREATE SET satellite.perigee = TOFLOAT(srow.perigee)
ON CREATE SET satellite.apogee = TOFLOAT(srow.apogee)
ON CREATE SET satellite.inclination = TOFLOAT(srow.inclination)
MERGE (organization:Organization {organization: srow.organization})
MERGE (orbit_type:Orbit_type {orbit_type: srow.orbit_type})
MERGE (organization)-[:OWNS]->(satellite)-[:IN]->(orbit_type)

// Orbital launches with launch vehicles, launch vehicle types and launch sites
LOAD CSV WITH HEADERS FROM 'file:///launchlog_df.csv' AS lrow
WITH lrow WHERE NOT lrow.launch_site IS NULL
MERGE (launchlog:Launchlog {cospar_nr: lrow.cospar_nr, launch: lrow.launch, payload_name: lrow.payload_name, orig_payload_name: lrow.orig_payload_name, outcome: lrow.outcome})
MERGE (launch_vehicle:LaunchVehicle {launchveh_type: lrow.launchveh_type})
MERGE (launch_vehicle_serie:LaunchVehicleSerie {launch_veh_serie: lrow.launch_veh_serie})
MERGE (launch_site:LaunchSite {launch_site: lrow.launch_site})
MERGE (launchlog)-[:LAUNCHED_BY]->(launch_vehicle)-[:PART_OF_SERIE]->(launch_vehicle_serie)
MERGE (launchlog)-[:LAUNCHED_FROM]->(launch_site)


// Relationship between satellites and launches

// Indexes. Not entirely sure they are necessary
CREATE INDEX ON satellite:Satellite(cospar_designation)
CREATE INDEX ON launchlog:Launchlog(cospar_nr)

// Making the match between satellites and launchlog
MATCH (satellite:Satellite), (launchlog:Launchlog)
WHERE satellite.cospar_designation = launchlog.cospar_nr
MERGE (satellite)-[:LAUNCHED_ON]->(launchlog);

