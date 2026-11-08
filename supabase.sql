-- Run this once in Supabase: SQL Editor > New query > paste > Run.
create table if not exists public.subscribers (
  id bigint generated always as identity primary key,
  email text not null unique check (length(email) <= 254 and email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$'),
  consent boolean not null check (consent),
  source text default 'site',
  created_at timestamptz not null default now()
);
create table if not exists public.sparks (
  id bigint generated always as identity primary key,
  device_id uuid not null,
  n int not null check (n between 1 and 100000),
  created_at timestamptz not null default now()
);
create table if not exists public.cards (
  id bigint generated always as identity primary key,
  device_id uuid not null,
  spark_n int not null check (spark_n between 1 and 100000),
  created_at timestamptz not null default now()
);
alter table public.subscribers enable row level security;
alter table public.sparks enable row level security;
alter table public.cards enable row level security;
-- visitors (anon key) may only INSERT; nobody can read these tables from the browser
drop policy if exists "anon insert subscribers" on public.subscribers;
create policy "anon insert subscribers" on public.subscribers for insert to anon with check (true);
drop policy if exists "anon insert sparks" on public.sparks;
create policy "anon insert sparks" on public.sparks for insert to anon with check (true);
-- public total, and card registration that returns the new card number
create or replace function public.spark_count() returns bigint language sql security definer set search_path = public as $$ select count(*) from public.sparks $$;
create or replace function public.register_card(p_device uuid, p_spark int) returns bigint language plpgsql security definer set search_path = public as $$
declare new_id bigint; begin insert into public.cards(device_id, spark_n) values (p_device, p_spark) returning id into new_id; return new_id; end $$;
grant execute on function public.spark_count() to anon;
grant execute on function public.register_card(uuid, int) to anon;
