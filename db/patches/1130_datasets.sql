/* platform, instrument, sensor, and how they relate to datasets. */

create table platform (
    identifier varchar not null primary key,
    name varchar not null,
    description varchar,
    url varchar,
    CHECK (identifier similar to '[a-z0-9_-]+')
);

comment on table platform is 'A platform is an entity to which instruments may be attached.';

create table instrument (
    identifier varchar not null primary key,
    name varchar not null,
    description varchar,
    CHECK (identifier similar to '[a-z0-9_-]+')
);

/* Affixing an instrument to a platform creates an instrument instance. */
create table instrument_instance (
    platform_identifier varchar not null references platform(identifier) on update cascade on delete cascade,
    instrument_identifier varchar not null references instrument(identifier) on update cascade on delete cascade,
    location varchar,
    primary key (platform_identifier, instrument_identifier)
);

/* An instrument instance may be associated with a dataset. */
create table instrument_measurement (
    platform_identifier varchar not null references platform(identifier) on update cascade on delete cascade,
    instrument_identifier varchar not null references instrument(identifier) on update cascade on delete cascade,
    dataset_identifier varchar not null references dataset(identifier) on update cascade on delete cascade,
      foreign key (instrument_identifier, platform_identifier)
            references instrument_instance (instrument_identifier, platform_identifier) on delete cascade on update cascade,
      primary key (platform_identifier, instrument_identifier, dataset_identifier)
);

/* XXX audit */
/* 
also sensor, sensor_measurement
*/


