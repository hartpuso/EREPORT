-- Run in Supabase SQL Editor or via `supabase db push` if you use the CLI.
-- Links app users to auth.users and stores password-change workflow flags.

create table if not exists public.user_profiles (
  employee_id uuid primary key references auth.users (id) on delete cascade,
  email text,
  full_name text,
  role text not null default 'employee' check (role in ('admin', 'employee')),
  must_change_password boolean not null default true,
  password_changed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.user_profiles enable row level security;

-- Admin check must not subquery user_profiles inside a policy (causes infinite RLS recursion).
create or replace function public.ereport_profile_is_admin()
returns boolean
language sql
security definer
stable
set search_path = public
as $$
  select exists (
    select 1
    from public.user_profiles p
    where p.employee_id = auth.uid()
      and p.role = 'admin'
  );
$$;

grant execute on function public.ereport_profile_is_admin() to authenticated;

create policy "profiles_select_own"
  on public.user_profiles for select
  using (auth.uid() = employee_id);

create policy "profiles_update_own"
  on public.user_profiles for update
  using (auth.uid() = employee_id);

create policy "profiles_select_admin"
  on public.user_profiles for select
  using (public.ereport_profile_is_admin());
