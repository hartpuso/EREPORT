-- Fix infinite recursion: policies on public.user_profiles must NOT subquery public.user_profiles
-- directly. Use a SECURITY DEFINER helper so the inner read bypasses RLS.

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

comment on function public.ereport_profile_is_admin() is
  'True if the current user is an admin. SECURITY DEFINER avoids RLS recursion on user_profiles.';

grant execute on function public.ereport_profile_is_admin() to authenticated;

drop policy if exists "profiles_select_admin" on public.user_profiles;

create policy "profiles_select_admin"
  on public.user_profiles for select
  using (public.ereport_profile_is_admin());
