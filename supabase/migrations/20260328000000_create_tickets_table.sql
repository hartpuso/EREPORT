-- Add IT role to app_role ENUM (if it exists)
-- If this line errors because public.app_role doesn't exist, you can safely remove it!
ALTER TYPE public.app_role ADD VALUE IF NOT EXISTS 'it';

-- Create tickets table
create table if not exists public.tickets (
  id uuid primary key default gen_random_uuid(),
  author_id uuid references public.user_profiles(employee_id) on delete cascade not null,
  is_anonymous boolean not null default true,
  complaint_type text not null,
  complaint_text text not null,
  evidence_url text,
  status text not null default 'pending' check (status in ('pending', 'in_progress', 'resolved', 'rejected')),
  resolution text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.tickets enable row level security;

create policy "Tickets select own"
  on public.tickets for select
  using (auth.uid() = author_id);

create policy "Tickets insert own"
  on public.tickets for insert
  with check (auth.uid() = author_id);

create policy "Tickets select hr admin it"
  on public.tickets for select
  using (
    exists (
      select 1 from public.user_profiles
      where employee_id = auth.uid() and role::text in ('admin', 'hr', 'it')
    )
  );

create policy "Tickets update hr admin it"
  on public.tickets for update
  using (
    exists (
      select 1 from public.user_profiles
      where employee_id = auth.uid() and role::text in ('admin', 'hr', 'it')
    )
  );

-- Create storage bucket for evidence
insert into storage.buckets (id, name, public) 
values ('evidence', 'evidence', true)
on conflict (id) do nothing;

create policy "Evidence select"
  on storage.objects for select
  using (bucket_id = 'evidence');

create policy "Evidence insert authed"
  on storage.objects for insert
  to authenticated
  with check (bucket_id = 'evidence');
