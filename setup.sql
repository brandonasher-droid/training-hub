-- Training Tracker — Supabase Schema
-- Run this in Supabase → SQL Editor → New query

create table if not exists trainees (
  id          bigserial primary key,
  associate_name text not null,
  role        text not null default '',
  home_store  text not null default '',
  training_store text not null default '',
  training_area  text not null default '',
  walmart_week   text not null default '',
  completed   boolean not null default false,
  notes       text not null default '',
  created_at  timestamptz not null default now()
);

create table if not exists comments (
  id          bigserial primary key,
  trainee_id  bigint not null references trainees(id) on delete cascade,
  author      text not null default '',
  body        text not null,
  created_at  timestamptz not null default now()
);

-- Allow anyone with the anon key to read/write (no login required)
alter table trainees enable row level security;
alter table comments  enable row level security;

create policy "public read trainees"  on trainees for select using (true);
create policy "public insert trainees" on trainees for insert with check (true);
create policy "public update trainees" on trainees for update using (true);
create policy "public delete trainees" on trainees for delete using (true);

create policy "public read comments"   on comments for select using (true);
create policy "public insert comments" on comments for insert with check (true);
create policy "public delete comments" on comments for delete using (true);
