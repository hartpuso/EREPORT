-- Rename tickets table to employee_complaints
-- This migration safely renames the table and all associated policies

-- Drop existing policies before renaming
DROP POLICY IF EXISTS "Tickets select own" ON public.tickets;
DROP POLICY IF EXISTS "Tickets insert own" ON public.tickets;
DROP POLICY IF EXISTS "Tickets select hr admin it" ON public.tickets;
DROP POLICY IF EXISTS "Tickets update hr admin it" ON public.tickets;

-- Rename the table
ALTER TABLE public.tickets RENAME TO employee_complaints;

-- Recreate the RLS policies with new names
create policy "Employee complaints select own"
  on public.employee_complaints for select
  using (auth.uid() = author_id);

create policy "Employee complaints insert own"
  on public.employee_complaints for insert
  with check (auth.uid() = author_id);

create policy "Employee complaints select hr admin it"
  on public.employee_complaints for select
  using (
    exists (
      select 1 from public.user_profiles
      where employee_id = auth.uid() and role::text in ('admin', 'hr', 'it')
    )
  );

create policy "Employee complaints update hr admin it"
  on public.employee_complaints for update
  using (
    exists (
      select 1 from public.user_profiles
      where employee_id = auth.uid() and role::text in ('admin', 'hr', 'it')
    )
  );
