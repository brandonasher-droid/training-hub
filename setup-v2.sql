-- Training Hub v2 — run in Supabase SQL Editor

create table if not exists training_areas (
  id          bigserial primary key,
  name        text not null,
  description text not null default '',
  icon        text not null default '📋',
  order_index integer not null default 0
);

create table if not exists area_links (
  id          bigserial primary key,
  area_id     bigint not null references training_areas(id) on delete cascade,
  title       text not null,
  url         text not null default '',
  notes       text not null default '',
  order_index integer not null default 0
);

create table if not exists hub_assignments (
  id          bigserial primary key,
  section     text not null,
  role_name   text not null,
  order_index integer not null default 0
);

create table if not exists hub_stores (
  id           bigserial primary key,
  hub_id       bigint not null references hub_assignments(id) on delete cascade,
  store_number text not null,
  trainer_name text not null default '',
  trainee_name text not null default '',
  order_index  integer not null default 0
);

-- RLS
alter table training_areas  enable row level security;
alter table area_links       enable row level security;
alter table hub_assignments  enable row level security;
alter table hub_stores       enable row level security;

create policy "pub read areas"   on training_areas  for select using (true);
create policy "pub write areas"  on training_areas  for all    using (true) with check (true);
create policy "pub read links"   on area_links      for select using (true);
create policy "pub write links"  on area_links      for all    using (true) with check (true);
create policy "pub read hubs"    on hub_assignments for select using (true);
create policy "pub write hubs"   on hub_assignments for all    using (true) with check (true);
create policy "pub read stores"  on hub_stores      for select using (true);
create policy "pub write stores" on hub_stores      for all    using (true) with check (true);

-- Seed training areas
insert into training_areas (name, description, icon, order_index) values
('Front End',           'Opening/closing, routines, and store execution.',                               '💰', 1),
('General Merchandise', 'Planograms, modular execution, and product flow.',                              '🛒', 2),
('Asset Protection',    'Shrink reduction, safety compliance, and theft prevention.',                    '🔒', 3),
('Food & Consumables',  'Food safety, cold chain, and department standards.',                            '🥦', 4),
('Store Fulfillment',   'Online order picking, staging, and delivery workflows.',                        '📱', 5),
('Stocking',            'Replenishment, backroom organization, and freight management.',                  '📦', 6),
('Fashion',             'Apparel merchandising, sizing standards, and visual presentation.',             '👔', 7),
('Auto Care Center',    'Vehicle services, work order flow, and safety compliance.',                     '🚗', 8),
('People',              'Hiring, associate engagement, training, and retention.',                        '📋', 9);

-- Seed hub assignments
insert into hub_assignments (id, section, role_name, order_index) values
(1,  'Coach',     'Fashion',              0),
(2,  'Coach',     'General Merchandise',  1),
(3,  'Coach',     'Food/Fresh',           2),
(4,  'Coach',     'Front End',            3),
(5,  'Coach',     'AP Ops',               4),
(6,  'Coach',     'Stocking Day',         5),
(7,  'Coach',     'Stocking O/N',         6),
(8,  'Coach',     'Digital',              7),
(9,  'Coach',     'ACC',                  8),
(10, 'Team Lead', 'Fashion',              0),
(11, 'Team Lead', 'Meat/Produce',         0),
(12, 'Team Lead', 'Entertainment',        1),
(13, 'Team Lead', 'Deli',                 1),
(14, 'Team Lead', 'Hardlines',            2),
(15, 'Team Lead', 'Bakery',               2),
(16, 'Team Lead', 'ACC',                  3),
(17, 'Team Lead', 'Dry Grocery',          3),
(18, 'Team Lead', 'Seasonal',             4),
(19, 'Team Lead', 'Frozen/Dairy',         4),
(20, 'Team Lead', 'Home',                 5),
(21, 'Team Lead', 'HBA',                  5),
(22, 'Team Lead', 'Front End',            6),
(23, 'Team Lead', 'AP TL',                7),
(24, 'Team Lead', 'Overnight',            7),
(25, 'Team Lead', 'Stocking 1',           8),
(26, 'Team Lead', 'Digital',              9),
(27, 'Team Lead', 'Stocking 2',           9);

-- Seed hub stores
insert into hub_stores (hub_id, store_number, trainer_name, order_index) values
(1,'65','Becca',0),(1,'89','Allison',1),
(2,'65','Becca',0),(2,'89','Angela',1),(2,'99','John',2),(2,'815','Dana',3),
(3,'354','Lynn',0),(3,'357','Miriam',1),(3,'815','Brandy',2),
(4,'65','Ursula',0),(4,'101','Rich',1),(4,'219','Jennifer',2),
(5,'29','Dustin',0),(5,'65','Izzi',1),(5,'815','Kevin',2),
(6,'89','Scott',0),(6,'99','Seth',1),
(7,'65','Larry',0),(7,'89','Adam',1),
(8,'29','Ann',0),(8,'99','Travis',1),(8,'219','Amber',2),(8,'357','Justy',3),
(9,'65','Jimmy',0),(9,'89','David',1),(9,'5477','Tirrell',2),
(10,'65','Kim',0),(10,'89','Rita',1),
(11,'354','Katrina',0),
(12,'219','Debbie',0),
(13,'354','Sonia',0),
(14,'101','Skylar',0),(14,'357','Heather',1),
(15,'65','Sam',0),(15,'89','Luis',1),(15,'815','Alexis',2),
(16,'89','Davis',0),
(17,'89','Sam',0),(17,'354','Becky',1),(17,'815','Pat',2),
(18,'65','Kevin',0),(18,'357','Casey',1),(18,'815','William',2),
(19,'89','Sam',0),(19,'99','Krysta',1),(19,'354','Becky',2),
(20,'65','Paige',0),(20,'89','Tina',1),(20,'895','Susan',2),
(21,'89','Taylor',0),(21,'99','Caitryn',1),(21,'357','Melinda',2),(21,'815','Luke',3),
(22,'65','Alyssa',0),(22,'89','',1),(22,'101','Anna & James',2),
(23,'29','Belinda',0),(23,'44','Scott',1),(23,'815','Michael',2),
(24,'65','Andrew',0),(24,'89','Angela',1),(24,'5477','Rachel',2),
(25,'29','Dru',0),(25,'219','Amanda',1),(25,'354','John',2),(25,'357','Renae',3),
(26,'89','Alex',0),(26,'99','Destiny & Keaten',1),(26,'357','Lora',2),
(27,'65','Lee & Lee',0),(27,'89','Arron & Clinton',1),(27,'101','Ben & Keith',2);
