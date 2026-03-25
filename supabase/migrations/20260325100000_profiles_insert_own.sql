-- Lets a signed-in user create their own user_profiles row (employee_id must equal auth.uid()).
-- Needed when a user exists in auth.users but user_profiles was never inserted.

drop policy if exists "profiles_insert_own" on public.user_profiles;

create policy "profiles_insert_own"
  on public.user_profiles for insert
  with check (auth.uid() = employee_id);
